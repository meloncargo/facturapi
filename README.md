# Facturapi

Esta gema facilita la integración con el servicio SOAP de facturacion.cl para
aplicaciones Ruby on Rails.

## Instalación

Agrega a tu Gemfile:

```ruby
gem 'facturapi'
```

Y luego ejecuta

    $ bundle

## Configuración

Agrega a tu archivo `config/initializers/facturapi.rb`:

```ruby
Facturapi.configure do |config|
  config.fact_rut '1-9'
  config.fact_user 'usuario'
  config.fact_password '12345'
  config.fact_port 9350
end
```

o también puedes definir variables de entorno en tu sistema:

```
FACTURACION_USER=1-9
FACTURACION_RUT=usuario
FACTURACION_PASSWORD=12345
FACTURACION_PORT=9350
```

## Uso

Ejemplo mínimo de envío de boleta:

```ruby
include Facturapi::Helpers

detalle = [
  Detalle.new(
    vlr_codigo: '17409',
    nmb_item: 'Reloj',
    qty_item: '1',
    prc_item: 20_500
  )
]

dte = Dte.new(
  encabezado: Encabezado.new(
    id_doc: IdDoc.new(
      fch_emis: Date.new(2016, 11, 14),
      ind_servicio: 3
    ),
    emisor: Emisor.new(
      rut_emisor: '1-9',
      rzn_soc_emisor: 'SUPER EMPRESA',
      giro_emisor: 'VENDEMOS COSAS',
      dir_origen: 'Luis Thayer Ojeda Nº1525',
      cmna_origen: 'Providencia',
      ciudad_origen: 'Santiago'
    ),
    receptor: Receptor.new(
      cdg_int_recep: '1000215-220',
      rzn_soc_recep: 'Juan Perez',
      contacto: 'juan@perez.com',
      dir_recep: 'CALLE A 50',
      cmna_recep: 'SANTIAGO',
      ciudad_recep: 'SANTIAGO'
    )
  ),
  detalle: detalle
)
# Realiza cálculos automáticos de totales, ademas de rellenar datos de
dte.autocomplete!

procesar = Facturapi::Service::Procesar.new(dte)
response = procesar.send


response.valid? # true
response.error # ''
response.folio # 4666638667
response.tipo_dte # 39
response.fecha # 2017-02-20 19:01:36 -0300
puts response
# <?xml version="1.0"?>
# <WSPLANO>
#   <Resultado>True</Resultado>
#   <Mensaje>Proceso exitoso.</Mensaje>
#   <Detalle>
#     <Documento>
#       <Folio>4666638667</Folio>
#       <TipoDte>39</TipoDte>
#       <Operacion>VENTA</Operacion>
#       <Fecha>2017-02-20T19:01:36</Fecha>
#       <Resultado>True</Resultado>
#     </Documento>
#   </Detalle>
# </WSPLANO>

```

Obtención de link para descargar documento tributario

```ruby
obtener_link = Facturapi::Services::ObtenerLink.new(folio: '123')
response = obtener_link.send

response.url # http://www.facturacion.cl/plano/descargar.php?...
```

Mas información sobre los atributos aceptados por los helpers, revisa [la
documentación](https://github.com/meloncargo/facturapi/tree/master/lib/facturapi/helpers)
contenida en los mismos.

## Why tanto spanglish?

Ya que esta gema sería usada principalmente por desarrolladores chilenos y para
facilidad de uso, toda la documentación irá en español. Además los nombres de
clases y variables seguirán la misma nomenclatura usada en el servicio web, la
cual es en español. Todo lo que escape a el ámbito descrito, será en inglés.

## Aviso Legal

Esta gema no está desarrollada, soportada ni avalada de ninguna manera por
Desis Ltda. y es el resultado de ingeniería inversa al servicio de integración
de facturacion.cl con fines de interoperabilidad, como lo permite la [ley chilena
20.435, artículo 71 Ñ, sección b.](http://www.leychile.cl/Navegar?idNorma=1012827)
