Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 28 Nov 2016 17:31:36 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] net/iucv: use explicit clean up labels in iucv_init()
In-Reply-To: <20161128.112433.295947046706527102.davem@davemloft.net>
Message-ID: <alpine.DEB.2.20.1611281731110.3512@nanos>
References: <20161124091046.hixy3j4ibt7xzezr@linutronix.de> <20161124141415.llqki5vo7nqdusqv@linutronix.de> <20161124161013.dukr42y2nwscosk6@linutronix.de> <20161128.112433.295947046706527102.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: bigeasy@linutronix.de, ubraun@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, rt@linutronix.de, linux-s390@vger.kernel.org, netdev@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 28 Nov 2016, David Miller wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date: Thu, 24 Nov 2016 17:10:13 +0100
> 
> > Ursula suggested to use explicit labels for clean up in the error path
> > instead of one `out_free' label which handles multiple exits.
> > Since the previous patch got already applied, here is a follow up patch.
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> "Previous patch" doesn't tell readers anything specific enough to identify
> the change you are referring to.  This will be even more true years down
> the line if someone tries to read this commit and figure out what you
> are referring to.
> 
> We have a standard mechanism to refer to commits, via SHA1_ID and commit
> header line text, please use it.

I amended the commit message.

Thanks,

	tglx
