-- DEMO ONLY: one shared state across all visitors, no authentication or secure roles.
-- DO NOT use with real customer, financial, identity or private data.
create table if not exists public.demo_state (
 id integer primary key check (id=1),
 state jsonb not null,
 updated_at timestamptz not null default now()
);
alter table public.demo_state enable row level security;
grant select, insert, update on public.demo_state to anon;
drop policy if exists "demo_public_read" on public.demo_state;
drop policy if exists "demo_public_insert" on public.demo_state;
drop policy if exists "demo_public_update" on public.demo_state;
create policy "demo_public_read" on public.demo_state for select to anon using (true);
create policy "demo_public_insert" on public.demo_state for insert to anon with check (id=1);
create policy "demo_public_update" on public.demo_state for update to anon using (id=1) with check (id=1);
