-- Recherche publique par numéro exact ; aucun listing des expéditions n'est exposé.
create or replace function public.get_public_shipment_tracking(p_tracking_number text)
returns jsonb language plpgsql security definer set search_path = '' as $$
declare v_shipment jsonb; v_events jsonb;
begin
 if p_tracking_number is null or length(btrim(p_tracking_number)) < 8 or length(p_tracking_number) > 100 then return jsonb_build_object('shipment',null,'events','[]'::jsonb); end if;
 select jsonb_build_object('id',s.id,'tracking_number',s.tracking_number,'mode',s.mode,'status',s.status,'origin',s.origin,'destination',s.destination,'carrier',s.carrier,'created_at',s.created_at,'updated_at',s.updated_at) into v_shipment from public.shipments s where s.tracking_number=btrim(p_tracking_number) limit 1;
 if v_shipment is null then return jsonb_build_object('shipment',null,'events','[]'::jsonb); end if;
 select coalesce(jsonb_agg(jsonb_build_object('status',e.status,'description',e.description,'location',e.location,'occurred_at',e.occurred_at) order by e.occurred_at asc),'[]'::jsonb) into v_events from public.shipment_events e where e.shipment_id=(v_shipment->>'id')::uuid;
 return jsonb_build_object('shipment',v_shipment-'id','events',v_events);
end; $$;
revoke all on function public.get_public_shipment_tracking(text) from public;
grant execute on function public.get_public_shipment_tracking(text) to anon, authenticated;
