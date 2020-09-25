/*
 * This program source code file is part of KiCad, a free EDA CAD application.
 *
 * Copyright (C) 2004-2020 KiCad Developers.
 *
 * This program is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation, either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef __FROM_TO_CACHE_H
#define __FROM_TO_CACHE_H

#include <set>

#include <common.h>

class D_PAD;
class BOARD_CONNECTED_ITEM;

class FROM_TO_CACHE
{
public:

    struct FT_ENDPOINT
    {
        wxString name;
        D_PAD* parent;
    };

    struct FT_PATH
    {
        int net;
        D_PAD *from;
        D_PAD *to;
        wxString fromName, toName;
        wxString fromWildcard, toWildcard;
        bool isUnique;
        std::set<BOARD_CONNECTED_ITEM*> pathItems;
    };

    FROM_TO_CACHE( BOARD* aBoard = nullptr ) :
        m_board( aBoard )
    {
    }

    ~FROM_TO_CACHE()
    {
    }

    void Rebuild( BOARD* aBoard );
    bool IsOnFromToPath( BOARD_CONNECTED_ITEM* aItem, const wxString& aFrom, const wxString& aTo );

private:

    int cacheFromToPaths( const wxString& aFrom, const wxString& aTo );
    void buildEndpointList();

    std::vector<FT_ENDPOINT> m_ftEndpoints;
    std::vector<FT_PATH> m_ftPaths;

    BOARD* m_board;
};

#endif
