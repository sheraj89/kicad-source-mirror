/*
 * This program source code file is part of KiCad, a free EDA CAD application.
 *
 * Copyright (C) 2012 Miguel Angel Ajo <miguelangel@nbee.es>
 * Copyright (C) 1992-2012 KiCad Developers, see AUTHORS.txt for contributors.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, you may find one here:
 * http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
 * or you may search the http://www.gnu.org website for the version 2 license,
 * or you may write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA
 */

/**
 * @file board_item.i
 * @brief board_item helpers, mainly for casting down to all derived classes
 */




%include class_board_item.h         // generate code for this interface

%rename(Get) operator       BOARD_ITEM*;

%{
#include <class_board_item.h>
%}


%inline
{
    /// Cast down from EDA_ITEM/BOARD_ITEM to child
    BOARD_ITEM*   Cast_to_BOARD_ITEM(EDA_ITEM* base)    {  return dynamic_cast<BOARD_ITEM*>(base);    }
}


%{
class TEXTE_PCB;
class ALIGNED_DIMENSION;
class ORTHOGONAL_DIMENSION;
class LEADER;
class CENTER_DIMENSION;
class MODULE;
class PCB_GROUP;
class TEXTE_MODULE;
class DRAWSEGMENT;
class MARKER_PCB;
class BOARD;
class EDGE_MODULE;
class D_PAD;
class TRACK;
class VIA;
class ZONE_CONTAINER;
class PCB_TARGET;

// Anthing targeted to the %wrapper section is extern "C" whereas code targeted
// to %header section is C++.
#ifdef __cplusplus
extern "C" {
#endif

static PCB_TEXT*             Cast_to_PCB_TEXT( BOARD_ITEM* );
static ALIGNED_DIMENSION*    Cast_to_ALIGNED_DIMENSION( BOARD_ITEM* );
static ORTHOGONAL_DIMENSION* Cast_to_ORTHOGONAL_DIMENSION( BOARD_ITEM* );
static LEADER*               Cast_to_LEADER( BOARD_ITEM* );
static CENTER_DIMENSION*     Cast_to_CENTER_DIMENSION( BOARD_ITEM* );
static MODULE*               Cast_to_MODULE( BOARD_ITEM* );
static PCB_GROUP*            Cast_to_PCB_GROUP( BOARD_ITEM* );
static FP_TEXT*              Cast_to_FP_TEXT( BOARD_ITEM* );
static PCB_SHAPE*            Cast_to_PCB_SHAPE( BOARD_ITEM* );
static MARKER_PCB*           Cast_to_MARKER_PCB( BOARD_ITEM* );
static BOARD*                Cast_to_BOARD( BOARD_ITEM* );
static FP_SHAPE*             Cast_to_FP_SHAPE( BOARD_ITEM* );
static D_PAD*                Cast_to_D_PAD( BOARD_ITEM* );
static TRACK*                Cast_to_TRACK( BOARD_ITEM* );
static VIA*                  Cast_to_VIA( BOARD_ITEM* );
static ZONE_CONTAINER*       Cast_to_ZONE_CONTAINER( BOARD_ITEM* );
static PCB_TARGET*           Cast_to_PCB_TARGET( BOARD_ITEM* );

#ifdef __cplusplus
}   // extern "C"
#endif
%}


static PCB_TEXT*             Cast_to_PCB_TEXT( BOARD_ITEM* );
static ALIGNED_DIMENSION*    Cast_to_ALIGNED_DIMENSION( BOARD_ITEM* );
static ORTHOGONAL_DIMENSION* Cast_to_ORTHOGONAL_DIMENSION( BOARD_ITEM* );
static LEADER*               Cast_to_LEADER( BOARD_ITEM* );
static CENTER_DIMENSION*     Cast_to_CENTER_DIMENSION( BOARD_ITEM* );
static MODULE*               Cast_to_MODULE( BOARD_ITEM* );
static PCB_GROUP*            Cast_to_PCB_GROUP( BOARD_ITEM* );
static FP_TEXT*              Cast_to_FP_TEXT( BOARD_ITEM* );
static PCB_SHAPE*            Cast_to_PCB_SHAPE( BOARD_ITEM* );
static MARKER_PCB*           Cast_to_MARKER_PCB( BOARD_ITEM* );
static BOARD*                Cast_to_BOARD( BOARD_ITEM* );
static FP_SHAPE*             Cast_to_FP_SHAPE( BOARD_ITEM* );
static D_PAD*                Cast_to_D_PAD( BOARD_ITEM* );
static TRACK*                Cast_to_TRACK( BOARD_ITEM* );
static VIA*                  Cast_to_VIA( BOARD_ITEM* );
static ZONE_CONTAINER*       Cast_to_ZONE_CONTAINER( BOARD_ITEM* );
static PCB_TARGET*           Cast_to_PCB_TARGET( BOARD_ITEM* );


%extend BOARD_ITEM
{
    %pythoncode
    %{
    def Cast(self):

        ct = self.GetClass()

        if ct=="PTEXT":
            return Cast_to_PCB_TEXT(self)
        elif ct=="BOARD":
            return Cast_to_BOARD(self)
        elif ct=="ALIGNED_DIMENSION":
            return Cast_to_ALIGNED_DIMENSION(self)
        elif ct=="LEADER":
            return Cast_to_LEADER(self)
        elif ct=="CENTER_DIMENSION":
            return Cast_to_CENTER_DIMENSION(self)
        elif ct=="ORTHOGONAL_DIMENSION":
            return Cast_to_ORTHOGONAL_DIMENSION(self)
        elif ct=="PCB_SHAPE":
            return Cast_to_PCB_SHAPE(self)
        elif ct=="MGRAPHIC":
            return Cast_to_FP_SHAPE(self)
        elif ct=="MODULE":
            return Cast_to_MODULE(self)
        elif ct=="PCB_GROUP":
            return Cast_to_PCB_GROUP(self)
        elif ct=="PAD":
            return Cast_to_D_PAD(self)
        elif ct=="MTEXT":
            return Cast_to_FP_TEXT(self)
        elif ct=="VIA":
            return Cast_to_VIA(self)
        elif ct=="TRACK":
            return Cast_to_TRACK(self)
        elif ct=="PCB_TARGET":
            return Cast_to_PCB_TARGET(self)
        elif ct=="ZONE_CONTAINER":
            return Cast_to_ZONE_CONTAINER(self)
        else:
            raise TypeError("Unsupported drawing class: %s" % ct)

    def Duplicate(self):
        ct = self.GetClass()
        if ct=="BOARD":
            return None
        else:
            return Cast_to_BOARD_ITEM(self.Clone()).Cast()

    def SetPos(self,p):
        self.SetPosition(p)
        self.SetPos0(p)

    def SetStartEnd(self,start,end):
        self.SetStart(start)
        self.SetStart0(start)
        self.SetEnd(end)
        self.SetEnd0(end)
    %}
}



// Use %wrapper code generation section so that this block of C++ comes after all referenced
// classes and therefore will C++ compile due to the respective headers which will go into
// the %header section.  See section 5.6.2 of SWIG 3.0 documentation.
%wrapper %{
static PCB_TEXT*             Cast_to_PCB_TEXT( BOARD_ITEM* self )             { return dynamic_cast<PCB_TEXT *>(self);            }
static ALIGNED_DIMENSION*    Cast_to_ALIGNED_DIMENSION( BOARD_ITEM* self )    { return dynamic_cast<ALIGNED_DIMENSION*>(self);    }
static ORTHOGONAL_DIMENSION* Cast_to_ORTHOGONAL_DIMENSION( BOARD_ITEM* self ) { return dynamic_cast<ORTHOGONAL_DIMENSION*>(self); }
static LEADER*               Cast_to_LEADER( BOARD_ITEM* self )               { return dynamic_cast<LEADER*>(self);               }
static CENTER_DIMENSION*     Cast_to_CENTER_DIMENSION( BOARD_ITEM* self )     { return dynamic_cast<CENTER_DIMENSION*>(self);     }
static MODULE*               Cast_to_MODULE( BOARD_ITEM* self )               { return dynamic_cast<MODULE*>(self);               }
static PCB_GROUP*            Cast_to_PCB_GROUP( BOARD_ITEM* self )            { return dynamic_cast<PCB_GROUP*>(self);            }
static FP_TEXT*              Cast_to_FP_TEXT( BOARD_ITEM* self )              { return dynamic_cast<FP_TEXT *>(self);             }
static PCB_SHAPE*            Cast_to_PCB_SHAPE( BOARD_ITEM* self )            { return dynamic_cast<PCB_SHAPE *>(self);           }
static MARKER_PCB*           Cast_to_MARKER_PCB( BOARD_ITEM* self )           { return dynamic_cast<MARKER_PCB*>(self);           }
static BOARD*                Cast_to_BOARD( BOARD_ITEM* self )                { return dynamic_cast<BOARD*>(self);                }
static FP_SHAPE*             Cast_to_FP_SHAPE( BOARD_ITEM* self )             { return dynamic_cast<FP_SHAPE *>(self);            }
static D_PAD*                Cast_to_D_PAD( BOARD_ITEM* self )                { return dynamic_cast<D_PAD*>(self);                }
static TRACK*                Cast_to_TRACK( BOARD_ITEM* self )                { return dynamic_cast<TRACK*>(self);                }
static VIA*                  Cast_to_VIA( BOARD_ITEM* self )                  { return dynamic_cast<VIA*>(self);                  }
static ZONE_CONTAINER*       Cast_to_ZONE_CONTAINER( BOARD_ITEM* self )       { return dynamic_cast<ZONE_CONTAINER*>(self);       }
static PCB_TARGET*           Cast_to_PCB_TARGET( BOARD_ITEM* self )           { return dynamic_cast<PCB_TARGET*>(self);           }
%}
