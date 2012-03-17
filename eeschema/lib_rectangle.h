/*
 * This program source code file is part of KiCad, a free EDA CAD application.
 *
 * Copyright (C) 2004 Jean-Pierre Charras, jaen-pierre.charras@gipsa-lab.inpg.com
 * Copyright (C) 2004-2011 KiCad Developers, see change_log.txt for contributors.
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
 * @file lib_rectangle.h
 */

#ifndef _LIB_RECTANGLE_H_
#define _LIB_RECTANGLE_H_

#include <lib_draw_item.h>


class LIB_RECTANGLE  : public LIB_ITEM
{
    wxPoint m_End;                  // Rectangle end point.
    wxPoint m_Pos;                  // Rectangle start point.
    int     m_Width;                // Line width
    bool    m_isWidthLocked;        // Flag: Keep width locked
    bool    m_isHeightLocked;       // Flag: Keep height locked
    bool    m_isStartPointSelected; // Flag: is the upper left edge selected?

    /**
     * Draw the rectangle.
     */
    void drawGraphic( EDA_DRAW_PANEL* aPanel, wxDC* aDC, const wxPoint& aOffset,
                      int aColor, int aDrawMode, void* aData, const TRANSFORM& aTransform );

    /**
     * Calculate the rectangle attributes relative to \a aPosition while editing.
     *
     * @param aPosition - Edit position in drawing units.
     */
    void calcEdit( const wxPoint& aPosition );

public:
    LIB_RECTANGLE( LIB_COMPONENT * aParent );

    // Do not create a copy constructor.  The one generated by the compiler is adequate.

    ~LIB_RECTANGLE() { }

    virtual wxString GetClass() const
    {
        return wxT( "LIB_RECTANGLE" );
    }

    void SetEndPosition( const wxPoint& aPosition ) { m_End = aPosition; }

    /**
     * Write rectangle object out to a FILE in "*.lib" format.
     *
     * @param aFormatter A reference to an OUTPUTFORMATTER to write the component library
     *                   rectangle to.
     * @return True if success writing else false.
     */
    virtual bool Save( OUTPUTFORMATTER& aFormatter );

    virtual bool Load( LINE_READER& aLineReader, wxString& aErrorMsg );

    /** @copydoc EDA_ITEM::HitTest(const wxPoint&) */
    virtual bool HitTest( const wxPoint& aPosition );

    /**
     * @param aPosRef - a wxPoint to test
     * @param aThreshold - max distance to this object (usually the half
     *                     thickness of a line)
     * @param aTransform - the transform matrix
     * @return true if the point aPosRef is near this object
     */
    virtual bool HitTest( wxPoint aPosRef, int aThreshold, const TRANSFORM& aTransform );

    /**
     * Function GetPenSize
     * @return the size of the "pen" that be used to draw or plot this item
     */
    virtual int GetPenSize( ) const;

    virtual EDA_RECT GetBoundingBox() const;

    virtual void DisplayInfo( EDA_DRAW_FRAME* aFrame );

    /**
     * See LIB_ITEM::BeginEdit().
     */
    void BeginEdit( int aEditMode, const wxPoint aStartPoint = wxPoint( 0, 0 ) );

    /**
     * See LIB_ITEM::ContinueEdit().
     */
    bool ContinueEdit( const wxPoint aNextPoint );

    /**
     * See LIB_ITEM::AbortEdit().
     */
    void EndEdit( const wxPoint& aPosition, bool aAbort = false );

    /**
     * @copydoc LIB_ITEM::SetOffset(const wxPoint&)
     */
    virtual void SetOffset( const wxPoint& aOffset );

    /**
     * @copydoc LIB_ITEM::Inside()
     */
    virtual bool Inside( EDA_RECT& aRect ) const;

    /**
     * @copydoc LIB_ITEM::Move()
     */
    virtual void Move( const wxPoint& aPosition );

    /**
     * @copydoc LIB_ITEM::GetPosition()
     */
    virtual wxPoint GetPosition() const { return m_Pos; }

    /**
     * @copydoc LIB_ITEM::MirrorHorizontal()
     */
    virtual void MirrorHorizontal( const wxPoint& aCenter );

    /**
     * @copydoc LIB_ITEM::MirrorVertical()
     */
    virtual void MirrorVertical( const wxPoint& aCenter );

    /**
     * @copydoc LIB_ITEM::Rotate(const wxPoint&,bool)
     */
    virtual void Rotate( const wxPoint& aCenter, bool aRotateCCW = true );

    /**
     * @copydoc LIB_ITEM::Plot()
     */
    virtual void Plot( PLOTTER* aPlotter, const wxPoint& aOffset, bool aFill,
                       const TRANSFORM& aTransform );

    /**
     * @copydoc LIB_ITEM::GetWidth()
     */
    virtual int GetWidth() const { return m_Width; }

    /**
     * @copydoc LIB_ITEM::SetWidth()
     */
    virtual void SetWidth( int aWidth ) { m_Width = aWidth; }

    /** @copydoc EDA_ITEM::GetSelectMenuText() */
    virtual wxString GetSelectMenuText() const;

    /** @copydoc EDA_ITEM::GetMenuImage() */
    virtual BITMAP_DEF GetMenuImage() const { return  add_rectangle_xpm; }

    /** @copydoc EDA_ITEM::Clone() */
    virtual EDA_ITEM* Clone() const;

private:

    /**
     * Function compare
     * provides the rectangle draw object specific comparison.
     *
     * The sort order is as follows:
     *      - Rectangle horizontal (X) start position.
     *      - Rectangle vertical (Y) start position.
     *      - Rectangle horizontal (X) end position.
     *      - Rectangle vertical (Y) end position.
     *
     * @param aOther A reference to the other #LIB_ITEM to compare the rectangle against.
     * @return An integer value less than 0 if the rectangle is less than \a aOther, zero
     *         if the rectangle is equal to \a aOther, or greater than 0 if the rectangle
     *         is greater than \a aOther.
     */
    virtual int compare( const LIB_ITEM& aOther ) const;
};


#endif    // _LIB_RECTANGLE_H_
