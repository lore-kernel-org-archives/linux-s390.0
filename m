From: Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH v3 0/7] Remove errors building drivers/DRIVERNAME
Date: Thu, 4 Oct 2018 09:27:16 +1000 (AEST)
Message-ID: <alpine.LNX.2.21.1810040915040.8@nippy.intranet>
References: <20180928020816.11251-1-leobras.c@gmail.com> <20181001075607.GA3776@rric.localdomain> <CADvQ+rETmm2Ag4sijXG-0Aya7B0oww7LkLgijAC+nznyWskkvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADvQ+rETmm2Ag4sijXG-0Aya7B0oww7LkLgijAC+nznyWskkvg@mail.gmail.com>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: Leonardo Bras <leobras.c@gmail.com>
Cc: Robert Richter <rric@kernel.org>, lkcamp@lists.libreplanetbr.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 3 Oct 2018, Leonardo Bras wrote:

> 
> Sorry, I was not very clear at my reasons why this change is important, 
> I will try to briefly explain the whole story.
> 
> Some weeks ago I was trying to solve a task that needed to change some 
> compiling options, build the whole kernel (allyesconfig) and look for 
> errors. The problem was: It would take a long time to build everything 
> in my computer. And many friends with slimmer laptops would take much 
> longer.
> 

It seems to me that you shouldn't need expensive optimization for 
continuous integration. In theory that could make a big difference though 
I admit to no experience of build farms.

Have you looked at ccache? It will save you from having to recompile any 
files not changed.

You could also leverage all of your laptops together using distcc.

HTH.

-- 
