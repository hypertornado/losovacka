

class Losovacka

  constructor: ->

    poradi: 0

    @prepare_table()
    $("#losuj").click(
      =>
        @losovani_start()
    )

  set_text: (text) =>
    $("#item").text(text)

  losovani_start: =>
    @losovaci_pole = @get_table_values()
    if (@losovaci_pole.length == 0)
      alert "Nejsou zadány žádné položky."
      return
    @poradi = 0
    $("#table").hide()
    $("#losuj").hide()
    @los()

  los: =>
    @last_set = @losovaci_pole[Math.floor(@losovaci_pole.length * Math.random())]
    @set_text(@last_set)

    maximum = 5

    if @poradi < maximum
      @poradi += 1
      callback = =>
        @los()
      time = @poradi + 100
      setTimeout(callback, time)
    else
      @losovani_stop()

  losovani_stop: =>
    el = {}
    for val in @losovaci_pole
      if val == @last_set
        @last_set = null
      else
        if el[val] == undefined
          el[val] = 1
        else
          el[val] += 1
    @set_table_values(el)
    @poradi = 0
    $("#table").show()
    $("#losuj").show()

  set_table_values: (values) =>
    pocet = $(".pocet")
    jmena = $(".jmeno")
    pocet.val(0)
    jmena.val("")

    i = 0
    for name in Object.getOwnPropertyNames(values)
      if name != undefined
        $(pocet[i]).val(values[name])
        $(jmena[i]).val(name)
        i +=1

  get_table_values: =>
    data = []
    pocty = $(".pocet")
    jmena = $(".jmeno")

    for i in [0..(pocty.length - 1)]
      number = parseInt($(pocty.get(i)).val())
      text = $(jmena.get(i)).val()
      if number > 0 and text.length > 0
        for j in [0..(number - 1)]
          data.push(text)

    return data


  prepare_table: =>
    for i in [1..100]
      $("#table").append("<tr class='real'><td><input type='number' class='pocet' value='0'></td><td><input class='jmeno' style='width: 300px;'></td>")


$(document).ready(
  ->
    new Losovacka()
)