From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH-tip v2 1/6] locking/osq: Make lock/unlock proper
 acquire/release barrier
Date: Mon, 20 Jun 2016 08:59:00 +0100
Message-ID: <20160620075900.GB29165@arm.com>
References: <1465944489-43440-2-git-send-email-Waiman.Long@hpe.com>
 <20160615080446.GA28443@insomnia>
 <5761A5FF.5070703@hpe.com>
 <20160616021951.GA16918@insomnia>
 <57631BBA.9070505@hpe.com>
 <20160617004837.GB16918@insomnia>
 <576416B1.6020006@hpe.com>
 <20160617154536.GB1284@arm.com>
 <57643EB7.6030600@hpe.com>
 <20160618084620.GA24424@insomnia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160618084620.GA24424@insomnia>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Waiman Long <waiman.long@hpe.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, Jason Low <jason.low2@hp.com>, Dave Chinner <david@fromorbit.com>, Scott J Norton <scott.norton@hpe.com>, Douglas Hatch <doug.hatch@hpe.com>
List-ID: <linux-s390.vger.kernel.org>

On Sat, Jun 18, 2016 at 04:46:20PM +0800, Boqun Feng wrote:
> On Fri, Jun 17, 2016 at 02:17:27PM -0400, Waiman Long wrote:
> > keep the xchg() function as it is or use smp_store_release(&next->locked,
> > 1). So which one is a better alternative for ARM or PPC?
> > 
> 
> For PPC, I think xchg_release() + smp_store_release() is better than the 
> current code, because the former has two lwsync while the latter has two
> sync, and sync is quite expensive than lwsync on PPC.
> 
> I need to leave the ARM part to Will ;-)

I doubt there's much in it, but xchg() has DMB + release, so xchg_release +
smp_store_release is probably slightly better for us too.

Will
