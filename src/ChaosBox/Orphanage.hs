{-# OPTIONS_GHC -fno-warn-orphans #-}
module ChaosBox.Orphanage
  ()
where

import           Control.Monad.Base
import           Data.Random                    ( Distribution
                                                , Distribution(..)
                                                , Normal
                                                , Normal(..)
                                                , StdUniform(..)
                                                )
import           Linear.V2
import           GI.Cairo.Render

-- These orphan instances do not leak to the end-user, since they're only used
-- in wrapper functions.

instance Distribution Normal a => Distribution Normal (V2 a) where
  rvarT StdNormal = V2 <$> rvarT StdNormal <*> rvarT StdNormal
  rvarT (Normal (V2 mx my) (V2 sx sy)) =
    V2 <$> rvarT (Normal mx sx) <*> rvarT (Normal my sy)

instance Distribution StdUniform a => Distribution StdUniform (V2 a) where
  rvarT StdUniform = V2 <$> rvarT StdUniform <*> rvarT StdUniform

instance MonadBase Render Render where
  liftBase = id
