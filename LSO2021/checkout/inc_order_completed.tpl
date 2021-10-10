{extends file="{$parent_template_path}/checkout/inc_order_completed.tpl"}

{block name='checkout-inc-order-completed'}
	  {$smarty.block.parent}

    <script>
        window._mtm = window._mtm || [];
        window._mtm.push({
        'event': 'purchase',
        'ecommerce': {
            'purchase': {
                'id': '{$Bestellung->cBestellNr}',
                'revenue': '{$Bestellung->fGesamtsumme}',
                'orderSubTotal': '{$Bestellung->fWarensummeNetto}',
                'tax': '{$Bestellung->fSteuern}',
                'shipping': '{$Bestellung->fVersandNetto}',
                'discount': 'dynamic_value',
                }
            }
        });
    </script>

{/block}
