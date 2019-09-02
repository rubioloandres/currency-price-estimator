import Text.CSV
import Text.Parsec.Error
import Text.Tabular.AsciiArt
import System.Process
import Procesador.Procesar

main :: IO ()
main = do
  system "cls"
  putStrLn "-------------------------------------------------------------------------"
  putStrLn "Ingrese un mes en formato MMM: "
  nombreMes <- getLine
  putStrLn "Ingrese un año en formato AA: "
  año <- getLine

  let nombreDeArchivo1 = "cotizacionesDolar.csv"
  let nombreDeArchivo2 = "cotizacionesReal.csv"
  let nombreDeArchivo3 = "cotizacionesEuro.csv"
  let nombreDeArchivo4 = "cotizacionesBitcoin.csv"
  let nombreDeArchivo5 = "cotizacionesBolivar.csv"
  entrada  <- readFile nombreDeArchivo1
  entrada2 <- readFile nombreDeArchivo2
  entrada3 <- readFile nombreDeArchivo3
  entrada4 <- readFile nombreDeArchivo4
  entrada5 <- readFile nombreDeArchivo5

  let datosCSV1 = parseCSV nombreDeArchivo1 entrada
  let datosCSV2 = parseCSV nombreDeArchivo2 entrada2
  let datosCSV3 = parseCSV nombreDeArchivo3 entrada3
  let datosCSV4 = parseCSV nombreDeArchivo4 entrada4
  let datosCSV5 = parseCSV nombreDeArchivo4 entrada5

  let datos = [datosCSV1,datosCSV2,datosCSV3,datosCSV4,datosCSV5]
  let monedas = ["Dolar", "Real","Euro","Bitcoin","Bolivar"]
  let monedasDatos = zip monedas datos
  let monedasProcesadas = procesarMonedas nombreMes año monedasDatos

  mostrarTablaCotizaciones monedasProcesadas
  mostrarGraficoMonedas monedasProcesadas

  let monedasOrdenadas = ordenarVariacionesDeCotizaciones monedasProcesadas
  mostrarTablaVariacionCotizaciones monedasOrdenadas

