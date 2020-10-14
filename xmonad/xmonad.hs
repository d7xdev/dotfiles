-- Build Requirements for most basic configuration:
--
--  * ghc                   (Haskell compiler)
--  * ghc-xmonad
--  * ghc-xmonad-devel      (Xmonad development library)
--
-- But most configuration also require additional 3rd party extensions:
--
--  * ghc-xmonad-contrib
--  * ghc-xmonad-contrib-devel
--
-- `Mod-q` to recompile and restart XMonad

import XMonad

-- Fix fullscreen video games [bigeekfan]_.
-- .. [bigeekfan] https://www.bigeekfan.com/post/20181124_xmonad_config/
-- https://hackage.haskell.org/package/xmonad-contrib-0.15/docs/XMonad-Hooks-EwmhDesktops.html
import XMonad.Hooks.EwmhDesktops(fullscreenEventHook,ewmh)


-- Save the pixels, remove unused borders
-- http://hackage.haskell.org/package/xmonad-contrib-0.15/docs/XMonad-Layout-NoBorders.html
import XMonad.Layout.NoBorders(noBorders,smartBorders)


------------------------------------------------------------------------
-- My Basic Stuff
------------------------------------------------------------------------

myTerminal          = "alacritty"
myBorderWidth       = 4
myNormalBorderColor = "#606060" -- Granite Gray
myFocusedBorderColor= "#800080" -- Purple
myFocusFollowsMouse = False     -- Click-to-Focus avoids accidental focus lost
myClickJustFocuses  = False     -- Click URL focuses browser and go there


------------------------------------------------------------------------
-- My Layout
------------------------------------------------------------------------

-- * Remove default "Wide" layout. Horizonal space is too scarce resource.
-- * Remove borders when layout only contains one window.
-- * Remove borders when layout is Fullcreen.
--
-- https://hackage.haskell.org/package/xmonad-0.15/docs/XMonad-Layout.html
myLayout = smartBorders tiled ||| noBorders Full
  where
    tiled = Tall nmain delta ratio
    nmain = 1       -- initial number of windows in main pane
    delta = 3/100   -- percentage to increment/decrement when resizing panes
    ratio = 1/2     -- initial ratio screen size of main pane


------------------------------------------------------------------------
-- My ManageHook
------------------------------------------------------------------------

-- Known Issue:
--
--  VLC does not remember its original window size when switching back
--  from Fullscreen to floating window. Solution may requires custom code
--  for listening to VLC X11 events and record the original window size
--  before switching to Fullscreen.
--
-- How to Reproduce:
--
--  * Play video media from terminal using VLC. Window size properly matches
--    video media resolution. Window is also properly floating.
--
--  * Switch VLC to Fullscreen (shortcut ``f``). Playback window
--    properly switches to Fullscreen, without border!
--
--  * Switch VLC back to Window (shortcut ``ESC``). Playback window
--    switches to Floating Window, but window size is "Tall" layout.
--
-- See ``XMonad/Config.hs`` default implementation.
-- https://hackage.haskell.org/package/xmonad-0.15/docs/XMonad-ManageHook.html
myManageHook = composeAll
                [ className =? "vlc"    --> doFloat
                , className =? "Gimp"   --> doFloat ]

------------------------------------------------------------------------
-- Main
------------------------------------------------------------------------

main :: IO ()
main = do
    xmonad $ ewmh $ def -- ewmh is used for fullscreen games
      {
        -- Basic stuff
        terminal            = myTerminal
      , borderWidth         = myBorderWidth
      , normalBorderColor   = myNormalBorderColor
      , focusedBorderColor  = myFocusedBorderColor
      , focusFollowsMouse   = myFocusFollowsMouse
      , clickJustFocuses    = myClickJustFocuses

        -- Hooks, Layouts
      , handleEventHook     = fullscreenEventHook   -- handle fullscreen games
      , layoutHook          = myLayout
      , manageHook          = myManageHook
      }

