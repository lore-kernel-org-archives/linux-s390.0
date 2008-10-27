Return-Path: <linux-kernel-owner+w=401wt.eu-S1753483AbYJ0Thx@vger.kernel.org>
Date: Mon, 27 Oct 2008 15:36:53 -0400
From: Theodore Tso <tytso@mit.edu>
Subject: Re: [GIT PULL/RESEND] kernel message catalog patches
Message-ID: <20081027193653.GC23111@mit.edu>
References: <20081021092148.GB4980@osiris.boeblingen.de.ibm.com> <alpine.LFD.2.00.0810230835150.3287@nehalem.linux-foundation.org> <20081023210446.GA12003@osiris.boeblingen.de.ibm.com> <alpine.LFD.2.00.0810231433380.3287@nehalem.linux-foundation.org> <1225049195.14057.72.camel@localhost> <alpine.LFD.2.00.0810261212290.5200@nehalem.linux-foundation.org> <1225101688.15777.6.camel@localhost> <alpine.LFD.2.00.0810270750100.3386@nehalem.linux-foundation.org> <20081027160359.37db885c@lxorguk.ukuu.org.uk> <alpine.LFD.2.00.0810270906520.3386@nehalem.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810270906520.3386@nehalem.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Oct 27, 2008 at 09:10:56AM -0700, Linus Torvalds wrote:
> 
> I do agree. Another issue is that quite often the actual line to be 
> printed is likely fairly short, and often in an error path (so it's 
> indented and in an inconvenient place), but the explanation - even for a 
> _single_ language - may well be pretty involved and long.

It's likely that the explanation would need to be just outside the
containing function, and not in-line where it might need to be deeply
indented. 

And I think we do need separate out the question of multiple langauges
from the explanation in a single canonical language (i.e., English).
Does keeping the explanation just before the containing function mean
that it's "so far away" that it might as well be kept completely
outside of the kernel?  I don't think so, but it's probably not worth
a huge amount of effort debating it; tools for keeping an external
database in sync is a pain, but they've certainly been done before for
related problems (especially in the case of translations, where they
would have to be done that way anyway).

     	  	  	      	   	    - Ted
