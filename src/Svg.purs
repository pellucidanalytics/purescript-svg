module Svg where

import Prelude (($), (<$>))
import Data.Semigroup ((<>))
import Data.Show (show)
import Xml (XmlAttribute(..), XmlElement(..))

data Document = Document Header (Array Element)
data Header = Header String String Number Number Number -- xmlns, baseProfile, version, width, height
data Element = Rectangle Number Number Number Number Style -- x,  y, width, height
             | Circle Number Number Number Style
data Color = Color Number Number Number Number -- r g b alpha
data Style = Style Color

tinyHeader :: Number -> Number -> Header
tinyHeader width height =
  Header "http://www.w3.org/2000/svg" "tiny" 1.2 width height

document2xml :: Document -> XmlElement
document2xml (Document (Header xmlns baseProfile version width height) elements) =
  XmlElement
    "svg"
    [
      XmlAttribute "xmlns" xmlns,
      XmlAttribute "baseProfile" baseProfile,
      XmlAttribute "version" $ show version,
      XmlAttribute "width" $ show width,
      XmlAttribute "height" $ show height
    ]
    (element2xml <$> elements)

element2xml :: Element -> XmlElement
element2xml (Rectangle x y width height style) =
  XmlElement
    "rect"
    [
      XmlAttribute "x" $ show x,
      XmlAttribute "y" $ show y,
      XmlAttribute "width" $ show width,
      XmlAttribute "height" $ show height
    ]
    []
element2xml (Circle x y radius style) =
  XmlElement
    "circle"
    [
      XmlAttribute "cx" $ show x,
      XmlAttribute "cy" $ show y,
      XmlAttribute "r" $ show radius
    ]
    []
