{extends file="{$parent_template_path}/productdetails/details.tpl"}

{if $Artikel->FunktionsAttribute['tpl_artikeldetails'] == 'Konfigurator' || $Artikel->FunktionsAttribute['tpl_artikeldetails'] == 'Variationen' } {* WSC ist Attribute "tpl_artikeldetails" gesetzt *}

    {block name='productdetails-details-form'}
        {opcMountPoint id='opc_before_buy_form' inContainer=false}
        {container class="{if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
            {form id="buy_form" action=$Artikel->cURLFull class="jtl-validate"}
                {row id="product-offer" class="product-detail"}
                    {block name='productdetails-details-include-image'}
                        {col cols=12 lg=6 class="product-gallery"}
                            {opcMountPoint id='opc_before_gallery'}
                            {include file='productdetails/image.tpl'}
                            {opcMountPoint id='opc_after_gallery'}
                        {/col}
                    {/block}
                    {col cols=12 lg=6 class="product-info"}
                        {block name='productdetails-details-info'}
                        <div class="product-info-inner">
                            <div class="product-headline">
                                {block name='productdetails-details-info-product-title'}
                                    {opcMountPoint id='opc_before_headline'}
                                    <h1 class="product-title h2" itemprop="name">{$Artikel->cName}</h1>
                                {/block}
                            </div>
                            {block name='productdetails-details-info-essential-wrapper'}
                            {if ($Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0) || isset($Artikel->cArtNr)}
                                {if ($Einstellungen.bewertung.bewertung_anzeigen === 'Y' && $Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0)}
                                    {block name='productdetails-details-info-rating-wrapper'}
                                        <div class="rating-wrapper" itemprop="aggregateRating" itemscope="true" itemtype="https://schema.org/AggregateRating">
                                            <meta itemprop="ratingValue" content="{$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt}"/>
                                            <meta itemprop="bestRating" content="5"/>
                                            <meta itemprop="worstRating" content="1"/>
                                            <meta itemprop="reviewCount" content="{$Artikel->Bewertungen->oBewertungGesamt->nAnzahl}"/>
                                            {block name='productdetails-details-include-rating'}
                                                {link href="{$Artikel->cURLFull}#tab-votes"
                                                    id="jump-to-votes-tab"
                                                    aria=["label"=>{lang key='Votes'}]
                                                }
                                                    {include file='productdetails/rating.tpl' stars=$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt total=$Artikel->Bewertungen->oBewertungGesamt->nAnzahl}
                                                    ({$Artikel->Bewertungen->oBewertungGesamt->nAnzahl} {lang key='rating'})
                                                {/link}
                                            {/block}
                                        </div>
                                    {/block}
                                {/if}
                                {block name='productdetails-details-info-essential'}
                                    <ul class="info-essential list-unstyled">
                                        {block name='productdetails-details-info-item-id'}
                                            {if isset($Artikel->cArtNr)}
                                                <li class="product-sku">
                                                    <strong>
                                                        {lang key='sortProductno'}:
                                                    </strong>
                                                    <span itemprop="sku">{$Artikel->cArtNr}</span>
                                                </li>
                                            {/if}
                                        {/block}
                                        {block name='productdetails-details-info-mhd'}
                                            {if isset($Artikel->dMHD) && isset($Artikel->dMHD_de)}
                                                <li class="product-mhd">
                                                    <strong title="{lang key='productMHDTool'}">
                                                        {lang key='productMHD'}:
                                                    </strong>
                                                    <span itemprop="best-before">{$Artikel->dMHD_de}</span>
                                                </li>
                                            {/if}
                                        {/block}
                                        {block name='productdetails-details-info-gtin'}
                                            {if !empty($Artikel->cBarcode)
                                            && ($Einstellungen.artikeldetails.gtin_display === 'details'
                                            || $Einstellungen.artikeldetails.gtin_display === 'always')}
                                                <li class="product-ean">
                                                    <strong>{lang key='ean'}:</strong>
                                                    <span itemprop="{if $Artikel->cBarcode|count_characters === 8}gtin8{else}gtin13{/if}">{$Artikel->cBarcode}</span>
                                                </li>
                                            {/if}
                                        {/block}
                                        {block name='productdetails-details-info-isbn'}
                                            {if !empty($Artikel->cISBN)
                                            && ($Einstellungen.artikeldetails.isbn_display === 'D'
                                            || $Einstellungen.artikeldetails.isbn_display === 'DL')}
                                                <li class="product-isbn">
                                                    <strong>{lang key='isbn'}:</strong>
                                                    <span itemprop="gtin13">{$Artikel->cISBN}</span>
                                                </li>
                                            {/if}
                                        {/block}
                                        {block name='productdetails-details-info-category-wrapper'}
                                            {assign var=cidx value=($Brotnavi|@count)-2}
                                            {if $Einstellungen.artikeldetails.artikeldetails_kategorie_anzeigen === 'Y' && isset($Brotnavi[$cidx])}
                                                {block name='productdetails-details-info-category'}
                                                    <li class="product-category word-break">
                                                        <strong>{lang key='category'}: </strong>
                                                        <a href="{$Brotnavi[$cidx]->getURLFull()}" itemprop="category">{$Brotnavi[$cidx]->getName()}</a>
                                                    </li>
                                                {/block}
                                            {/if}
                                        {/block}
                                        {block name='productdetails-details-info-manufacturer-wrapper'}
                                            {if $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen !== 'N' && isset($Artikel->cHersteller)}
                                                {block name='productdetails-details-product-info-manufacturer'}
                                                    <li  class="product-manufacturer" itemprop="brand" itemscope="true" itemtype="https://schema.org/Organization">
                                                        <strong>{lang key='manufacturers'}:</strong>
                                                        {if $Einstellungen.artikeldetails.artikel_weitere_artikel_hersteller_anzeigen === 'Y'}
                                                            <a href="{if !empty($Artikel->cHerstellerHomepage)}{$Artikel->cHerstellerHomepage}{else}{$Artikel->cHerstellerSeo}{/if}"
                                                                {if $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen === 'B'}
                                                                    data-toggle="tooltip"
                                                                    data-placement="left"
                                                                    title="{$Artikel->cHersteller}"
                                                                {/if}
                                                               itemprop="url">
                                                        {/if}
                                                            {if ($Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen === 'B'
                                                                || $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen === 'BT')
                                                                && !empty($Artikel->cHerstellerBildURLKlein)}
                                                                {image lazy=true
                                                                    webp=true
                                                                    src=$Artikel->cHerstellerBildURLKlein
                                                                    alt=$Artikel->cHersteller
                                                                }
                                                                <meta itemprop="image" content="{$Artikel->cHerstellerBildURLKlein}">
                                                            {/if}
                                                            {if $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen !== 'B'}
                                                                <span itemprop="name">{$Artikel->cHersteller}</span>
                                                            {/if}
                                                        {if $Einstellungen.artikeldetails.artikel_weitere_artikel_hersteller_anzeigen === 'Y'}
                                                            </a>
                                                        {/if}
                                                    </li>
                                                {/block}
                                            {/if}
                                        {/block}
                                        {block name='productdetails-details-hazard-info'}
                                            {if !empty($Artikel->cUNNummer) && !empty($Artikel->cGefahrnr)
                                            && ($Einstellungen.artikeldetails.adr_hazard_display === 'D'
                                            || $Einstellungen.artikeldetails.adr_hazard_display === 'DL')}
                                                <li class="product-hazard">
                                                    <strong>{lang key='adrHazardSign'}:</strong>
                                                    <table class="adr-table">
                                                        <tr>
                                                            <td>{$Artikel->cGefahrnr}</td>
                                                        </tr>
                                                        <tr>
                                                            <td>{$Artikel->cUNNummer}</td>
                                                        </tr>
                                                    </table>
                                                </li>
                                            {/if}
                                        {/block}
                                    </ul>
                                {/block}
                            {/if}
                            {/block}

                            {block name='productdetails-details-info-description-wrapper'}
                            {if $Einstellungen.artikeldetails.artikeldetails_kurzbeschreibung_anzeigen === 'Y' && $Artikel->cKurzBeschreibung}
                                {block name='productdetails-details-info-description'}
                                    {opcMountPoint id='opc_before_short_desc'}
                                    <div class="shortdesc" itemprop="description">
                                        {$Artikel->cKurzBeschreibung}
                                    </div>
                                {/block}
                            {/if}
                            {opcMountPoint id='opc_after_short_desc'}
                            {/block}

                            <div class="product-offer"{if !($Artikel->Preise->fVKNetto == 0 && $Einstellungen.global.global_preis0 === 'N')} itemprop="offers" itemscope itemtype="https://schema.org/Offer"{/if}>
                                {block name='productdetails-details-info-hidden'}
                                    {if !($Artikel->Preise->fVKNetto == 0 && $Einstellungen.global.global_preis0 === 'N')}
                                        <meta itemprop="url" content="{$Artikel->cURLFull}">
                                        <link itemprop="businessFunction" href="http://purl.org/goodrelations/v1#Sell" />
                                    {/if}
                                    {input type="hidden" name="inWarenkorb" value="1"}
                                    {if $Artikel->kArtikelVariKombi > 0}
                                        {input type="hidden" name="aK" value=$Artikel->kArtikelVariKombi}
                                    {/if}
                                    {if isset($Artikel->kVariKindArtikel)}
                                        {input type="hidden" name="VariKindArtikel" value=$Artikel->kVariKindArtikel}
                                    {/if}
                                    {if isset($smarty.get.ek)}
                                        {input type="hidden" name="ek" value=$smarty.get.ek|intval}
                                    {/if}
                                    {input type="hidden" name="AktuellerkArtikel" class="current_article" name="a" value=$Artikel->kArtikel}
                                    {input type="hidden" name="wke" value="1"}
                                    {input type="hidden" name="show" value="1"}
                                    {input type="hidden" name="kKundengruppe" value=$smarty.session.Kundengruppe->getID()}
                                    {input type="hidden" name="kSprache" value=$smarty.session.kSprache}
                                {/block}
                                {block name='productdetails-details-include-variation'}
{* WSC VARIATIONEN Block leeren und Inhalt nach unten verschieben Siehe Zeile ca 270 *}
                                {/block}

                                {row}
                                    {block name='productdetails-details-include-price'}
                                        {if !($Artikel->Preise->fVKNetto == 0 && isset($Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_VOUCHER_FLEX]))}
                                            {col}
                                                {include file='productdetails/price.tpl' Artikel=$Artikel tplscope='detail' priceLarge=true}
                                            {/col}
                                        {/if}
                                    {/block}
                                    {block name='productdetails-details-stock'}
                                        {col cols=12}
                                            {row no-gutters=true class="stock-information {if !isset($availability) && !isset($shippingTime)}stock-information-p{/if}"}
                                                {col}
                                                    {block name='productdetails-details-include-stock'}
                                                        {include file='productdetails/stock.tpl'}
                                                    {/block}
                                                {/col}
                                                {col class="question-on-item col-auto"}
                                                    {block name='productdetails-details-question-on-item'}
                                                        {if $Einstellungen.artikeldetails.artikeldetails_fragezumprodukt_anzeigen === 'P'}
                                                            <button type="button" id="z{$Artikel->kArtikel}"
                                                                    class="btn btn-link question"
                                                                    title="{lang key='productQuestion' section='productDetails'}"
                                                                    data-toggle="modal"
                                                                    data-target="#question-popup-{$Artikel->kArtikel}">
                                                                <span class="fa fa-question-circle"></span>
                                                                <span class="hidden-xs hidden-sm">{lang key='productQuestion' section='productDetails'}</span>
                                                            </button>
                                                        {/if}
                                                    {/block}
                                                {/col}
                                            {/row}
                                            {block name='snippets-stock-note-include-warehouse'}
                                                {include file='productdetails/warehouse.tpl'}
                                            {/block}
                                        {/col}
                                    {/block}
                                {/row}
                                {*UPLOADS product-specific files, e.g. for customization*}
                                {block name='productdetails-details-include-uploads'}
                                    {include file="snippets/uploads.tpl" tplscope='product'}
                                {/block}
                            </div>
                        </div>{* /product-info-inner *}
                        {/block}{* productdetails-info *}
                        {opcMountPoint id='opc_after_product_info'}
                    {/col}
              {/row}
                {block name='productdetails-details-include-matrix'}
                    {include file='productdetails/matrix.tpl'}
                {/block}
{* WSC Variationen aus Block productdetails-details-include-variation START *}
                {row}
                    {col cols=12}
                        <!-- VARIATIONEN -->
                        {include file='productdetails/variation.tpl' simple=$Artikel->isSimpleVariation showMatrix=$showMatrix}
                    {/col}
                {/row}
{* WSC Variationen aus Block productdetails-details-include-variation ENDE *}
{* WSC Konfigurator komplette Schleife diese ist unter Block productdetails-details-include-uploads START *}
{*WARENKORB anzeigen wenn keine variationen mehr auf lager sind?!*}
{if $Artikel->bHasKonfig}
    {block name='productdetails-details-config-button'}
        {row}
            {if isset($Artikel->Variationen) && $Artikel->Variationen|@count > 0}
                {block name='productdetails-details-config-button-info'}
                    {col cols=12 class="js-choose-variations-wrapper"}
                        {alert variation="info" class="choose-variations"}
                            {lang key='chooseVariations' section='messages'}
                        {/alert}
                    {/col}
                {/block}
            {/if}
            {block name='productdetails-details-config-button-button'}
{* WSC Konfig Button entfernen *}
            {/block}
        {/row}
    {/block}
    {block name='productdetails-details-include-config-container'}
        {row id="product-configurator"}
            {include file='productdetails/config_container.tpl'}
        {/row}
    {/block}
{else}
    {block name='productdetails-details-include-basket'}
        {include file='productdetails/basket.tpl'}
    {/block}
{/if}
{* WSC Konfigurator komplette Schleife diese ist unter Block productdetails-details-include-uploads ENDE *}
            {/form}
        {/container}
    {/block}

{else} {* WSC ist Attribute "tpl_artikeldetails" nicht gesetzt *}

    {block name='productdetails-details-form'}
        {$smarty.block.parent}
    {/block}

{/if}
