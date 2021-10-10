{extends file="{$parent_template_path}/basket/index.tpl"}









                {block name='basket-index-main'}
{* WSC umstellung auf 8 - START *}
                    {col cols=12 lg="{if ($Warenkorb->PositionenArr|@count > 0)}8{else}12{/if}"}
{* WSC umstellung auf 8 - ENDE *}
                    {opcMountPoint id='opc_before_heading'}
                    {block name='basket-index-heading'}
                        <h1 class="h2 basket-heading">{lang key='basket'} ({count($smarty.session.Warenkorb->PositionenArr)} {lang key='products'})</h1>
                    {/block}
                    {block name='basket-index-include-extension'}
                        {include file='snippets/extension.tpl'}
                    {/block}

                    {if ($Warenkorb->PositionenArr|@count > 0)}
                        {block name='basket-index-basket'}
                            {opcMountPoint id='opc_before_basket'}
                            <div class="basket_wrapper">
                                {block name='basket-index-basket-items'}
                                    {block name='basket-index-form-cart'}
                                        {form id="cart-form" method="post" action="{get_static_route id='warenkorb.php'}" class="jtl-validate" slide=true}
                                            {input type="hidden" name="wka" value="1"}
                                            <div class="basket-items">
                                                {block name='basket-index-include-order-items'}
                                                    {include file='basket/cart_items.tpl'}
                                                {/block}
                                            </div>
                                            {block name='basket-index-include-uploads'}
                                                {include file='snippets/uploads.tpl' tplscope='basket'}
                                            {/block}
                                        {/form}
                                    {/block}

                                    {if $Einstellungen.kaufabwicklung.warenkorb_versandermittlung_anzeigen === 'Y'}
                                        {block name='basket-index-form-shipping-calc'}
                                            {opcMountPoint id='opc_before_shipping_calculator'}
                                            {form id="basket-shipping-estimate-form" class="shipping-calculator-form" method="post" action="{get_static_route id='warenkorb.php'}#basket-shipping-estimate-form" slide=true}
                                                {block name='basket-index-include-shipping-calculator'}
                                                    {include file='snippets/shipping_calculator.tpl' checkout=true hrAtEnd=false}
                                                {/block}
                                            {/form}
                                        {/block}
                                    {/if}
                                    {if $oArtikelGeschenk_arr|@count > 0}
                                        {block name='basket-index-freegifts-content'}
                                            {$selectedFreegift=0}
                                            {foreach $smarty.session.Warenkorb->PositionenArr as $oPosition}
                                                {if $oPosition->nPosTyp == $C_WARENKORBPOS_TYP_GRATISGESCHENK}
                                                    {$selectedFreegift=$oPosition->Artikel->kArtikel}
                                                {/if}
                                            {/foreach}
                                            {row class="basket-freegift"}
                                                {col cols=12}
                                                    {block name='basket-index-freegifts-heading'}
                                                        <div class="h2 basket-heading hr-sect">{lang key='freeGiftFromOrderValueBasket'}</div>
                                                    {/block}
                                                {/col}
                                                {col cols=12}
                                                    {block name='basket-index-form-freegift'}
                                                        {form method="post" name="freegift" action="{get_static_route id='warenkorb.php'}" class="text-center-util" slide=true}
                                                            {block name='basket-index-freegifts'}
                                                                {row id="freegift"
                                                                     class="slick-smooth-loading carousel carousel-arrows-inside slick-lazy slick-type-half {if $oArtikelGeschenk_arr|count < 3}slider-no-preview{/if}"
                                                                     data=["slick-type"=>"slider-half"]}
                                                                    {include file='snippets/slider_items.tpl' items=$oArtikelGeschenk_arr type='freegift'}
                                                                {/row}
                                                            {/block}
                                                            {block name='basket-index-freegifts-form-submit'}
                                                                {input type="hidden" name="gratis_geschenk" value="1"}
                                                                {input name="gratishinzufuegen" type="hidden" value="{lang key='addToCart'}"}
                                                            {/block}
                                                        {/form}
                                                    {/block}
                                                {/col}
                                            {/row}
                                        {/block}
                                    {/if}
                                {/block}

                                {if !empty($xselling->Kauf) && count($xselling->Kauf->Artikel) > 0}
                                    {block name='basket-index-basket-xsell'}
                                        {lang key='basketCustomerWhoBoughtXBoughtAlsoY' assign='panelTitle'}
                                        {block name='basket-index-include-product-slider'}
                                            {include file='snippets/product_slider.tpl' productlist=$xselling->Kauf->Artikel title=$panelTitle tplscope='half'}
                                        {/block}
                                    {/block}
                                {/if}
                            </div>
                        {/block}
                    {else}
                        {block name='basket-index-cart-empty'}
                            {row class="basket-empty"}
                                {col}
                                    {block name='basket-index-alert-empty'}
                                        {alert variant="info"}
                                            {badge variant="light" class="bubble"}
                                                <i class="fas fa-shopping-cart"></i>
                                            {/badge}<br/>
                                            {lang key='emptybasket' section='checkout'}
                                        {/alert}
                                    {/block}
                                    {block name='basket-index-empty-continue-shopping'}
                                        {link href=$ShopURL class="btn btn-primary"}{lang key='continueShopping' section='checkout'}{/link}
                                    {/block}
                                {/col}
                            {/row}
                        {/block}
                    {/if}
                {/col}
                {/block}

{* WSC Überschreiben des Blocks - START *}
{block name='basket-index-heading'}
    <h1 class="h2 basket-heading">{lang key='basket'}</h1>
{/block}
{* WSC Überschreiben des Blocks - ENDE *}
