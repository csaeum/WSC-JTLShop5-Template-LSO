{extends file="{$parent_template_path}/basket/cart_items.tpl"}


{block name='basket-cart-items-product-data'}
    <ul class="list-unstyled">
        {if $Einstellungen.kaufabwicklung.bestellvorgang_artikelkurzbeschreibung == 'Y' && $oPosition->Artikel->cKurzBeschreibung|strlen > 0}
            {block name='basket-cart-items-product-data-short-desc'}
{* WSC cKurzBeschreibung ausblenden START *}
                <li class="shortdescription d-none">{$oPosition->Artikel->cKurzBeschreibung}</li>
{* WSC cKurzBeschreibung ausblenden ENDE*}
            {/block}
        {/if}
        {block name='basket-cart-items-product-data-sku'}
            <li class="sku"><strong>{lang key='productNo'}:</strong> {$oPosition->Artikel->cArtNr}</li>
        {/block}
        {if isset($oPosition->Artikel->dMHD) && isset($oPosition->Artikel->dMHD_de) && $oPosition->Artikel->dMHD_de !== null}
            {block name='basket-cart-items-product-data-mhd'}
                <li title="{lang key='productMHDTool'}" class="best-before">
                    <strong>{lang key='productMHD'}:</strong> {$oPosition->Artikel->dMHD_de}
                </li>
            {/block}
        {/if}
        {if $oPosition->Artikel->cLocalizedVPE
            && $oPosition->Artikel->cVPE !== 'N'
            && $oPosition->nPosTyp != $C_WARENKORBPOS_TYP_GRATISGESCHENK
        }
            {block name='basket-cart-items-product-data-base-price'}
                <li class="baseprice"><strong>{lang key='basePrice'}:</strong> {$oPosition->Artikel->cLocalizedVPE[$NettoPreise]}</li>
            {/block}
        {/if}
        {if $Einstellungen.kaufabwicklung.warenkorb_varianten_varikombi_anzeigen === 'Y' && isset($oPosition->WarenkorbPosEigenschaftArr) && !empty($oPosition->WarenkorbPosEigenschaftArr)}
            {foreach $oPosition->WarenkorbPosEigenschaftArr as $Variation}
                {block name='basket-cart-items-product-data-variations'}
                    <li class="variation">
                        <strong>{$Variation->cEigenschaftName|trans}:</strong> {$Variation->cEigenschaftWertName|trans}
                    </li>
                {/block}
            {/foreach}
        {/if}
        {if $Einstellungen.kaufabwicklung.bestellvorgang_lieferstatus_anzeigen === 'Y' && $oPosition->cLieferstatus|trans}
            {block name='basket-cart-items-product-data-delivery-status'}
                <li class="delivery-status"><strong>{lang key='deliveryStatus'}:</strong> {$oPosition->cLieferstatus|trans}</li>
            {/block}
        {/if}

{* WSC Produktionsdauer START *}
            {if $oPosition->Artikel->cVersandklasse === 'Paket Fertigung'}
                <li class="delivery-status"><strong>Produktionsdauer:</strong> {$Warenkorb->cEstimatedDelivery}</li>
            {/if}
{* WSC Produktionsdauer ENDE *}

        {if !empty($oPosition->cHinweis)}
            {block name='basket-cart-items-product-data-notice'}
                <li class="text-info notice">{$oPosition->cHinweis}</li>
            {/block}
        {/if}

        {* Buttonloesung eindeutige Merkmale *}
        {if $oPosition->Artikel->cHersteller && $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen != "N"}
            {block name='basket-cart-items-product-data-manufacturers'}
{* WSC Manufacturer ausblenden START *}
                <li class="manufacturer d-none">
                    <strong>{lang key='manufacturer' section='productDetails'}</strong>:
                    <span class="values">
                       {$oPosition->Artikel->cHersteller}
                    </span>
                </li>
{* WSC Manufacturer ausblenden ENDE *}
            {/block}
        {/if}

        {if $Einstellungen.kaufabwicklung.bestellvorgang_artikelmerkmale == 'Y' && !empty($oPosition->Artikel->oMerkmale_arr)}
            {foreach $oPosition->Artikel->oMerkmale_arr as $oMerkmale_arr}
                {block name='basket-cart-items-product-data-attributes'}
{* WSC Merkmale ausblenden START *}
                    <li class="characteristic d-none">
                        <strong>{$oMerkmale_arr->cName}</strong>:
                        <span class="values">
                            {foreach $oMerkmale_arr->oMerkmalWert_arr as $oWert}
                                {if !$oWert@first}, {/if}
                                {$oWert->cWert}
                            {/foreach}
                        </span>
                    </li>
{* WSC Merkmale ausblenden ENDE *}
                {/block}
            {/foreach}
        {/if}

        {if $Einstellungen.kaufabwicklung.bestellvorgang_artikelattribute == 'Y' && !empty($oPosition->Artikel->Attribute)}
            {foreach $oPosition->Artikel->Attribute as $oAttribute_arr}
                {block name='basket-cart-items-product-data-attributes-attributes'}
                    <li class="attribute">
                        <strong>{$oAttribute_arr->cName}</strong>:
                        <span class="values">
                            {$oAttribute_arr->cWert}
                        </span>
                    </li>
                {/block}
            {/foreach}
        {/if}

        {if isset($oPosition->Artikel->cGewicht) && $Einstellungen.artikeldetails.artikeldetails_gewicht_anzeigen === 'Y' && $oPosition->Artikel->fGewicht > 0}
            {block name='basket-cart-items-product-data-weight'}
{* WSC Gewicht ausblenden START *}
                <li class="weight d-none">
                    <strong>{lang key='shippingWeight'}: </strong>
                    <span class="value">{$oPosition->Artikel->cGewicht} {lang key='weightUnit'}</span>
                </li>
{* WSC Gewicht ausblenden ENDE *}
            {/block}
        {/if}
    </ul>
{/block}


{block name='basket-cart-items-product-cofig-items'}
    <ul class="config-items text-muted-util small">
        {$labeled=false}
        {foreach $smarty.session.Warenkorb->PositionenArr as $KonfigPos}
            {block name='product-config-item'}
                {if $oPosition->cUnique == $KonfigPos->cUnique && $KonfigPos->kKonfigitem > 0
                && !$KonfigPos->isIgnoreMultiplier()}
                    <li>
{* WSC Anpassung Menge und Pfeile START *}
                        {* WSC Menge ausblenden START *}
                        <span class="qty d-none">{if !$KonfigPos->istKonfigVater()}{$KonfigPos->nAnzahlEinzel}{else}1{/if}x</span>
                        {* WSC Menge ausblenden START *}
                        {$KonfigPos->cName|trans}
                        {* WSC Bild einblenden START *}
                        <img src="{$KonfigPos->Artikel->cVorschaubildURL}" class="img-fluid" />
                        {* WSC Bild einblenden ENDE *}
                        {* WSC Preis ausblenden START *}
                        <span class="price_value d-none">
                            {$KonfigPos->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                            {lang key='pricePerUnit' section='checkout'}
                        </span>
                        {* WSC Preis ausblenden ENDE *}
                    </li>
                {elseif $oPosition->cUnique == $KonfigPos->cUnique && $KonfigPos->kKonfigitem > 0
                && $KonfigPos->isIgnoreMultiplier()}
                    {if !$labeled}
                        {* WSC labeled ausblenden START *}
                        <strong class="d-none">{lang key='one-off' section='checkout'}</strong>
                        {* WSC labeled ausblenden ENDE *}
                        {$labeled=true}
                    {/if}
                    <li>
                        {* WSC Menge ausblenden START *}
                        <span class="qty d-none">{if !$KonfigPos->istKonfigVater()}{$KonfigPos->nAnzahlEinzel}{else}1{/if}x</span>
                        {* WSC Menge ausblenden ENDE *}
                        {$KonfigPos->cName|trans}
                        {* WSC Bild einblenden START *}
                        <img src="{$KonfigPos->Artikel->cVorschaubildURL}" class="img-fluid" />
                        {* WSC Bild einblenden ENDE *}
                        {* WSC Preis ausblenden START *}
                        <span class="price_value d-none">
                            {$KonfigPos->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                            {lang key='pricePerUnit' section='checkout'}
                        </span>
                        {* WSC Preis ausblenden ENDE *}
{* WSC Anpassung Menge und Pfeile ENDE *}
                    </li>
                {/if}
            {/block}
        {/foreach}
    </ul>
{/block}


{block name='basket-cart-items-quantity'}
    {if $oPosition->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL}
        {if $oPosition->istKonfigVater()}
            <div class="qty-wrapper max-w-sm">
{* WSC Fett und Umbruch START *}
                <strong>{$oPosition->nAnzahl|replace_delim}
                    {if !empty($oPosition->Artikel->cEinheit)}{$oPosition->Artikel->cEinheit}{/if}
                <br /><br /></strong>
                {link class="btn btn-outline-secondary configurepos btn-block btn-sm ml-3"
                href="{get_static_route id='index.php'}?a={$oPosition->kArtikel}&ek={$oPosition@index}"}
                    <i class="fa fa-cogs icon-mr-2"></i><span class="ml-1"> <i class="fas fa-edit"></i></span><br />
                    <span>{lang key='product' section='global'} {lang key='edit' section='global'}</span> <span class="d-none">{lang key='configure'}</span>
                {/link}
{* WSC Fett und Umbruch ENDE *}
            </div>
        {else}
            <div class="qty-wrapper dropdown max-w-sm">
                {inputgroup id="quantity-grp{$oPosition@index}" class="form-counter choose_quantity"}
                    {inputgroupprepend}
                        {button variant="" class="btn-decrement"
                            data=["count-down"=>""]
                            aria=["label"=>{lang key='decreaseQuantity' section='aria'}]}
                            <span class="fas fa-minus"></span>
                        {/button}
                    {/inputgroupprepend}
                    {input type="number"
                        min="{if $oPosition->Artikel->fMindestbestellmenge}{$oPosition->Artikel->fMindestbestellmenge}{else}0{/if}"
                        max=$oPosition->Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_MAXBESTELLMENGE]|default:''
                        required=($oPosition->Artikel->fAbnahmeintervall > 0)
                        step="{if $oPosition->Artikel->cTeilbar === 'Y' && $oPosition->Artikel->fAbnahmeintervall == 0}any{elseif $oPosition->Artikel->fAbnahmeintervall > 0}{$oPosition->Artikel->fAbnahmeintervall}{else}1{/if}"
                        id="quantity[{$oPosition@index}]" class="quantity" name="anzahl[{$oPosition@index}]"
                        aria=["label"=>"{lang key='quantity'}"]
                        value=$oPosition->nAnzahl
                        data=["decimals"=>{getDecimalLength quantity=$oPosition->Artikel->fAbnahmeintervall}]
                    }
                    {inputgroupappend}
                        {button variant="" class="btn-increment"
                            data=["count-up"=>""]
                            aria=["label"=>{lang key='increaseQuantity' section='aria'}]}
                            <span class="fas fa-plus"></span>
                        {/button}
                    {/inputgroupappend}
                {/inputgroup}
            </div>
        {/if}
    {elseif $oPosition->nPosTyp == $C_WARENKORBPOS_TYP_GRATISGESCHENK}
        {input name="anzahl[{$oPosition@index}]" type="hidden" value="1"}
    {/if}
{/block}
