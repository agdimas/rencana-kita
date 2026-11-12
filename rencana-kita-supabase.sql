-- Rencana Kita: one private planner row per signed-in owner.
-- Run this once in Supabase SQL Editor after checking the project name.
create table if not exists public.wedding_planner_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.wedding_planner_state enable row level security;
revoke all on public.wedding_planner_state from anon;
grant select, insert, update on public.wedding_planner_state to authenticated;

drop policy if exists "owner reads own wedding planner" on public.wedding_planner_state;
create policy "owner reads own wedding planner"
  on public.wedding_planner_state for select to authenticated
  using ((select auth.uid()) = user_id);

drop policy if exists "owner creates own wedding planner" on public.wedding_planner_state;
create policy "owner creates own wedding planner"
  on public.wedding_planner_state for insert to authenticated
  with check ((select auth.uid()) = user_id);

drop policy if exists "owner updates own wedding planner" on public.wedding_planner_state;
create policy "owner updates own wedding planner"
  on public.wedding_planner_state for update to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

do $$
begin
  if exists (select 1 from pg_publication where pubname = 'supabase_realtime')
     and not exists (
       select 1 from pg_publication_tables
       where pubname = 'supabase_realtime'
         and schemaname = 'public'
         and tablename = 'wedding_planner_state'
     ) then
    alter publication supabase_realtime add table public.wedding_planner_state;
  end if;
end $$;
