From: Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH v3 3/7] drivers: parisc: Avoids building driver if
 CONFIG_PARISC is disabled
Date: Fri, 5 Oct 2018 14:10:04 +1000 (AEST)
Message-ID: <alpine.LNX.2.21.1810051332350.33@nippy.intranet>
References: <20180928020816.11251-1-leobras.c@gmail.com> <20180928020816.11251-4-leobras.c@gmail.com> <1538118915.3593.4.camel@HansenPartnership.com> <CADvQ+rGQenkoE0xCRTwjA5BuKZbZ2Upkyx=+qWFUGnUcit-aCQ@mail.gmail.com> <1538628062.18776.5.camel@HansenPartnership.com>
 <CADvQ+rG0WQjFTU=A4tAACvqFevw51DX_-yq2-9j78T8pSrjcXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADvQ+rG0WQjFTU=A4tAACvqFevw51DX_-yq2-9j78T8pSrjcXQ@mail.gmail.com>
List-Archive: <https://lore.kernel.org/linux-parisc/>
List-Post: <mailto:linux-parisc@vger.kernel.org>
To: Leonardo Bras <leobras.c@gmail.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, lkcamp@lists.libreplanetbr.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Robert Richter <rric@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-m68k@lists.linux-m68k.org, oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 4 Oct 2018, Leonardo Bras wrote:

> ... 
> But, why these chosen Makefiles, and not all of them?

I think that inconsistency is untenable. If nothing else, it means your 
changes will get broken by other people who also apply constraints 
inconsistently.

I think you need to consider what happens when you apply this regime 
tree-wide. Either that or explain why it would make sense to build e.g. 
drivers/s390 but not drivers/s390/net.

-- 
