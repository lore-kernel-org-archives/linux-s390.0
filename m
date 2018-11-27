Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 27 Nov 2018 08:39:41 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390: Remove obsolete bust_spinlock() implementation
In-Reply-To: <20181123070212.GA3300@osiris>
References: <20181122141529.14933-1-pmladek@suse.com>
        <20181123021748.GB1582@jagdpanzerIV>
        <20181123070212.GA3300@osiris>
MIME-Version: 1.0
Message-Id: <20181127083941.3bebcf13@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 23 Nov 2018 08:02:12 +0100
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> On Fri, Nov 23, 2018 at 11:17:48AM +0900, Sergey Senozhatsky wrote:
> > On (11/22/18 15:15), Petr Mladek wrote:  
> > > The commit cefc8be82403cf ("Consolidate bust_spinlocks()") kept
> > > the s390-specific implementation because of the absence of CONFIG_VT.
> > > In fact, the only difference was calling console_unblank() instead of
> > > unblank_screen().
> > > 
> > > The common implementation in lib/bust_spinlocks.c started to call
> > > unblank_screen() explicitly since the commit b61312d353da187
> > > ("oops handling: ensure that any oops is flushed to the mtdoops
> > > console").
> > > 
> > > As a result, the custom implementation is not longer necessary.
> > > And we could get all the other improvements of the common
> > > implementation for free.  
> > 
> > I believe I sent a similar patch several weeks ago and it's
> > in s390 patch queue as of now, waiting for the next merge
> > window.
> > 
> > lkml.kernel.org/r/20181025081108.GB26561@osiris  
> 
> Yes, it will be added soon to the features branch of the
> s390/linux.git repository on kernel.org and then hit linux-next.

The patch is now queued for the next merge window.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
