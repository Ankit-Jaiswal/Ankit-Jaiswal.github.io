package supermarket

import org.scalajs.dom
import dom.html
import scala.scalajs.js.annotation.JSExportTopLevel
import scala.scalajs.js.annotation.JSExport
import scalatags.JsDom.all._

@JSExportTopLevel("shopping")
case object shopping {
  import shop._

  val colgate = Item("Colgate Toothpaste","200gm","./pics/colgate.jpg",74.50,70.00)
  val maggie = Item("Nestle Maggie","pack of 4","./pics/namaste.jpg",96,94.5)
  val amulGold = Item("Amul Gold milk","500ml","./pics/namaste.jpg",25,24)
  val glucose = Item("GluconD","Orange","./pics/paneer.jpg",64,60)
  val chini = Item("Sugar","2kg","./pics/sugar.jpg",56,53.50)
  val tataNamak = Item("Tata Salt","1Kg","./pics/namaste.jpg",15,10)
  val tataChaiPrem = Item("Tata Tea Premium","250gm","./pics/bru.jpg",132,129)

  val itmlst = Vector(colgate,maggie,amulGold,glucose,chini,tataNamak,tataChaiPrem)
  def showItems = itmlst.foreach { println }


  @JSExport
  def loadItems(target: html.Div) : Unit = {
    def createItmbox(itm: Item) = target.appendChild(
      div(
        table(
          td(width:="200px")(img(src:=itm.imgname)),
          td(width:="350px")(h3(itm.name),p(itm.spec)),
          td(width:="300px")(
            select(option("Seller 1"),option("Seller 2"),option("Seller 3")),
            br,br,br,
            del(" Rs. ", itm.mrp),
            h4(" Rs. ", itm.price)
          ),
          td(width:="150px",style:="vertical-align: middle;text-align:center")(
            h5(button(" - ")," 0 ",button(" + ")),
            h6("Subtotal: Rs. 0"))
        )
      ).render
    )

    createItmbox(tataChaiPrem)
  }


  def billedCart = cart.map(x => (x -> x._1.price * x._2))
//  def showBill = billedCart foreach {case (itm,value) => println(itm._1 + " -> " + itm._2 + " -> " + value)}
  def subtotal = billedCart.values
  def total: Double = if (cart.isEmpty) {0.0} else { subtotal.reduceLeft(_+_) }
  //  def clearCart: Cart = cart.clear()


  def main(args: Array[String]): Unit = {

  }

}
