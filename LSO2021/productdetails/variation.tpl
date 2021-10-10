{extends file="{$parent_template_path}/productdetails/variation.tpl"}

{* WSC Spalten START *}

{block name='productdetails-variation-variation'}
    {row class="variations {if $simple}simple{else}switch{/if}-variations"}
    {* WSC wenn Konfigurator *}
    {if $Artikel->bHasKonfig}
        <div class="col-12 col-md-6 order-1 d-block d-md-none">
            <h3 class="h3 text-center"><u>{lang key='wsc_KonfiguratorUeberschrift' section='productDetails'}</u></h3>
            <ol>
                <li>{lang key='wsc_Konfigurator_LI1_unten' section='productDetails'}</li>
                <li>{lang key='wsc_Konfigurator_LI2' section='productDetails'}</li>
                <li>{lang key='wsc_Konfigurator_LI3' section='productDetails'}</li>
                <li>{lang key='wsc_Konfigurator_LI4' section='productDetails'}</li>
                <li>{lang key='wsc_Konfigurator_LI5' section='productDetails'}</li>
                <li>{lang key='wsc_Konfigurator_LI6' section='productDetails'}</li>
            </ol>
        </div>
    {/if}
    {* WSC wenn Konfigurator *}
        <div class="col-12 {if $Artikel->bHasKonfig}col-md-6 order-2{/if}">
            <dl>
            {foreach name=Variationen from=$Artikel->$VariationsSource key=i item=Variation}

            {strip}
                <dt>{$Variation->cName}&nbsp;
                    {if $Variation->cTyp === 'IMGSWATCHES'}
                        <span class="swatches-selected text-success" data-id="{$Variation->kEigenschaft}">
                        {foreach $Variation->Werte as $variationValue}
                            {if isset($oVariationKombi_arr[$variationValue->kEigenschaft])
                                && in_array($variationValue->kEigenschaftWert, $oVariationKombi_arr[$variationValue->kEigenschaft])}
                                {$variationValue->cName}
                                {break}
                            {/if}
                        {/foreach}
                        </span>
                    {/if}
                </dt>
                <dd class="form-group text-left-util">
                    {if $Variation->cTyp === 'SELECTBOX'}
                        {block name='productdetails-variation-select-outer'}
					                  {$smarty.block.parent}
                        {/block}
                    {elseif $Variation->cTyp === 'RADIO'}
                        {block name='productdetails-variation-radio-outer'}
                          	{$smarty.block.parent}
                        {/block}
                    {elseif $Variation->cTyp === 'IMGSWATCHES'}
                        {block name='productdetails-variation-swatch-outer'}
                            {formrow class="swatches {$Variation->cTyp|lower}"}
                                {foreach name=Variationswerte from=$Variation->Werte key=y item=Variationswert}
                                    {assign var=bSelected value=false}
                                    {assign var=hasImage value=!empty($Variationswert->getImage(\JTL\Media\Image::SIZE_XS))
                                        && $Variationswert->getImage(\JTL\Media\Image::SIZE_XS)|strpos:$smarty.const.BILD_KEIN_ARTIKELBILD_VORHANDEN === false}
                                    {if isset($oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                        {assign var=bSelected value=in_array($Variationswert->kEigenschaftWert, $oVariationKombi_arr[$Variationswert->kEigenschaft])}
                                    {/if}
                                    {if isset($oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft])}
                                        {assign var=bSelected value=($Variationswert->kEigenschaftWert == $oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft]->kEigenschaftWert)}
                                    {/if}
                                    {if ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1) && $Artikel->nVariationOhneFreifeldAnzahl == 1 &&
                                    $Einstellungen.global.artikeldetails_variationswertlager == 3 &&
                                    !empty($Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar) && $Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar == 1}
                                        {* /do nothing *}
                                    {else}
                                        {block name='productdetails-variation-swatch-inner'}
                                        {col class='col-auto'}
                                            <label class="variation swatches {if $hasImage}swatches-image{else}swatches-text{/if} {if $bSelected}active{/if} {if $Variationswert->notExists}swatches-not-in-stock not-available{elseif !$Variationswert->inStock}swatches-sold-out not-available{/if}"
                                                    data-type="swatch"
                                                    data-original="{$Variationswert->cName}"
                                                    data-key="{$Variationswert->kEigenschaft}"
                                                    data-value="{$Variationswert->kEigenschaftWert}"
                                                    for="{if isset($smallView) && $smallView}a-{$Artikel->kArtikel}{/if}vt{$Variationswert->kEigenschaftWert}"
                                                    {if !empty($Variationswert->cBildPfadMini)}
                                                        data-list='{prepare_image_details item=$Variationswert json=true}'
                                                    {/if}
                                                    {if $Variationswert->notExists}
                                                        title="{lang key='notAvailableInSelection'}"
                                                        data-title="{$Variationswert->cName} - {lang key='notAvailableInSelection'}"
                                                        data-toggle="tooltip"
                                                    {elseif $Variationswert->inStock}
                                                        data-title="{$Variationswert->cName}"
                                                    {else}
                                                        title="{lang key='ampelRot'}"
                                                        data-title="{$Variationswert->cName} - {lang key='ampelRot'}"
                                                        data-toggle="tooltip"
                                                        data-stock="out-of-stock"
                                                    {/if}
                                                    {if isset($Variationswert->oVariationsKombi)}
                                                        data-ref="{$Variationswert->oVariationsKombi->kArtikel}"
                                                    {/if}>
                                                <input type="radio"
                                                       class="control-hidden"
                                                       name="eigenschaftwert[{$Variation->kEigenschaft}]"
                                                       id="{if isset($smallView) && $smallView}a-{$Artikel->kArtikel}{/if}vt{$Variationswert->kEigenschaftWert}"
                                                       value="{$Variationswert->kEigenschaftWert}"
                                                       {if $bSelected}checked="checked"{/if}
                                                       {if $smarty.foreach.Variationswerte.index === 0 && !$showMatrix} required{/if}
                                                       />
                                                    {if $hasImage}
                                                        {include file='snippets/image.tpl' sizes='90px' item=$Variationswert srcSize='xs'}
                                                    {else}
                                                        {$Variationswert->cName}
                                                    {/if}
                                                {block name='productdetails-variation-swatch-include-variation-value'}
                                                    {include file='productdetails/variation_value.tpl' hideVariationValue=true}
                                                {/block}
                                            </label>
                                        {/col}
                                        {/block}
                                    {/if}
                                {/foreach}
                            {/formrow}
                        {/block}
                    {elseif $Variation->cTyp === 'TEXTSWATCHES'}
                        {block name='productdetails-variation-textswatch-outer'}
                            {$smarty.block.parent}
                        {/block}
                    {elseif $Variation->cTyp === 'FREIFELD' || $Variation->cTyp === 'PFLICHT-FREIFELD'}
                        {block name='productdetails-variation-info-variation-text'}
                            <label for="vari-{$Variation->kEigenschaft}" class="sr-only">{$Variation->cName}</label>
                            {input id="vari-{$Variation->kEigenschaft}" name='eigenschaftwert['|cat:$Variation->kEigenschaft|cat:']'
                               value=$oEigenschaftWertEdit_arr[$Variation->kEigenschaft]->cEigenschaftWertNameLocalized|default:''
                               data=['key' => $Variation->kEigenschaft] required=$Variation->cTyp === 'PFLICHT-FREIFELD'
                               maxlength=255}
                        {/block}
                    {/if}
                </dd>
            {/strip}
            {/foreach}
            </dl>
        </div>
    {* WSC wenn Konfigurator *}
    {if $Artikel->bHasKonfig}
        <div class="col-12 col-md-6 order-3 d-none d-md-block">
            <h3 class="h3 text-center"><u>{lang key='wsc_KonfiguratorUeberschrift' section='productDetails'}</u></h3>
            <ol>
                <li>{lang key='wsc_Konfigurator_LI1_links' section='productDetails'}</li>
                <li>{lang key='wsc_Konfigurator_LI2' section='productDetails'}</li>
                <li>{lang key='wsc_Konfigurator_LI3' section='productDetails'}</li>
                <li>{lang key='wsc_Konfigurator_LI4' section='productDetails'}</li>
                <li>{lang key='wsc_Konfigurator_LI5' section='productDetails'}</li>
                <li>{lang key='wsc_Konfigurator_LI6' section='productDetails'}</li>
            </ol>
        </div>
    {/if}
    {* WSC wenn Konfigurator *}
    {/row}
{/block}

{* WSC Spalten ENDE*}

{block name='productdetails-variation-select-outer'}
{* WSC einfügen von "{$Variation->cName} {lang key='choosevariation' section='global'}" START *}
{select data=["size"=>"10"] class='custom-select selectpicker' title="{lang key='pleaseChooseVariation' section='productDetails'} {$Variation->cName} {lang key='choosevariation' section='global'}" name="eigenschaftwert[{$Variation->kEigenschaft}]" required=!$showMatrix}
{* WSC einfügen von "{$Variation->cName} {lang key='choosevariation' section='global'}" ENDE *}
    {foreach name=Variationswerte from=$Variation->Werte key=y item=Variationswert}
        {assign var=bSelected value=false}
        {if isset($oVariationKombi_arr[$Variationswert->kEigenschaft])}
            {assign var=bSelected value=in_array($Variationswert->kEigenschaftWert, $oVariationKombi_arr[$Variationswert->kEigenschaft])}
        {/if}
        {if isset($oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft])}
            {assign var=bSelected value=$Variationswert->kEigenschaftWert == $oEigenschaftWertEdit_arr[$Variationswert->kEigenschaft]->kEigenschaftWert}
        {/if}
        {if ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1) && $Artikel->nVariationOhneFreifeldAnzahl == 1 &&
        $Einstellungen.global.artikeldetails_variationswertlager == 3 &&
        !empty($Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar) && $Artikel->VariationenOhneFreifeld[$i]->Werte[$y]->nNichtLieferbar == 1}
        {else}
            {block name='productdetails-variation-select-inner'}
                {block name='productdetails-variation-select-include-variation-value'}
                    {include file='productdetails/variation_value.tpl' assign='cVariationsWert'}
                {/block}
                <option value="{$Variationswert->kEigenschaftWert}" class="variation"
                        data-content="<span data-value='{$Variationswert->kEigenschaftWert}'>{$cVariationsWert|trim|escape:'html'}
                    {if $Variationswert->notExists} <span class='badge badge-danger badge-not-available'>{lang key='notAvailableInSelection'}</span>
                    {elseif !$Variationswert->inStock}<span class='badge badge-danger badge-not-available'>{lang key='ampelRot'}</span>{/if}</span>"
                        data-type="option"
                        data-original="{$Variationswert->cName}"
                        data-key="{$Variationswert->kEigenschaft}"
                        data-value="{$Variationswert->kEigenschaftWert}"
                        {if !empty($Variationswert->cBildPfadMini)}
                            data-list='{prepare_image_details item=$Variationswert json=true}'
                            data-title='{$Variationswert->cName}'
                        {/if}
                        {if isset($Variationswert->oVariationsKombi)}
                            data-ref="{$Variationswert->oVariationsKombi->kArtikel}"
                        {/if}
                        {if $bSelected} selected="selected"{/if}>
                    {$cVariationsWert|trim|escape:'html'}
                </option>
            {/block}
        {/if}
    {/foreach}
{/select}
{/block}

{block name='productdetails-variation-swatch-inner'}
{col class='col-auto'}
    <label class="variation swatches {if $hasImage}swatches-image{else}swatches-text{/if} {if $bSelected}active{/if} {if $Variationswert->notExists}swatches-not-in-stock not-available{elseif !$Variationswert->inStock}swatches-sold-out not-available{/if}"
            data-type="swatch"
            data-original="{$Variationswert->cName}"
            data-key="{$Variationswert->kEigenschaft}"
            data-value="{$Variationswert->kEigenschaftWert}"
            for="{if isset($smallView) && $smallView}a-{$Artikel->kArtikel}{/if}vt{$Variationswert->kEigenschaftWert}"
            {if !empty($Variationswert->cBildPfadMini)}
                data-list='{prepare_image_details item=$Variationswert json=true}'
            {/if}
            {if $Variationswert->notExists}
                title="{lang key='notAvailableInSelection'}"
                data-title="{$Variationswert->cName} - {lang key='notAvailableInSelection'}"
                data-toggle="tooltip"
            {elseif $Variationswert->inStock}
                data-title="{$Variationswert->cName}"
            {else}
                title="{lang key='ampelRot'}"
                data-title="{$Variationswert->cName} - {lang key='ampelRot'}"
                data-toggle="tooltip"
                data-stock="out-of-stock"
            {/if}
            {if isset($Variationswert->oVariationsKombi)}
                data-ref="{$Variationswert->oVariationsKombi->kArtikel}"
            {/if}>
        <input type="radio"
               class="control-hidden"
               name="eigenschaftwert[{$Variation->kEigenschaft}]"
               id="{if isset($smallView) && $smallView}a-{$Artikel->kArtikel}{/if}vt{$Variationswert->kEigenschaftWert}"
               value="{$Variationswert->kEigenschaftWert}"
               {if $bSelected}checked="checked"{/if}
               {if $smarty.foreach.Variationswerte.index === 0 && !$showMatrix} required{/if}
               />
{* WSC Badge einblendung des Namens START *}
              <span class="badge badge-pill badge-light">{$Variationswert->cName}</span>
{* WSC Badge einblendung des Namens ENDE *}
{* WSC Einblenden des Bildes als POPOVER START *}
               <button type="button" class="btn btn-outline-dark btn-light btn-sm varLupe" data-toggle="popover" data-trigger="focus" title="{$Variationswert->cName}" data-content="<img src={$Variationswert->cPfadNormal} class=img-fluid />"><i class="fas fa-search"></i></button>
{* WSC Einblenden des Bildes als POPOVER ENDE *}
            {if $hasImage}
                {include file='snippets/image.tpl' sizes='90px' item=$Variationswert srcSize='xs'}
            {else}
                {$Variationswert->cName}
            {/if}
        {block name='productdetails-variation-swatch-include-variation-value'}
            {include file='productdetails/variation_value.tpl' hideVariationValue=true}
        {/block}
    </label>
{/col}
{/block}
