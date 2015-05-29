Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 29 May 2015 14:01:51 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC] s390/sclp: pass timeout as HZ independent value
Message-ID: <20150529140151.2846c257@holzheu>
In-Reply-To: <20150529114936.GA21897@opentech.at>
References: <1432746283-8068-1-git-send-email-hofrat@osadl.org>
	<20150529090715.GA4169@osiris>
	<20150529095154.GB9952@opentech.at>
	<20150529103523.GB4169@osiris>
	<20150529114936.GA21897@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Nicholas Mc Guire <der.herr@hofr.at>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Nicholas Mc Guire <hofrat@osadl.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 29 May 2015 13:49:36 +0200
Nicholas Mc Guire <der.herr@hofr.at> wrote:

> On Fri, 29 May 2015, Heiko Carstens wrote:
> 
> > On Fri, May 29, 2015 at 11:51:54AM +0200, Nicholas Mc Guire wrote:
> > > On Fri, 29 May 2015, Heiko Carstens wrote:
> > > > Yes, the orginal code seems to be broken. Since I've no idea what the intended
> > > > timeout value should be, let's simply ask Michael, who wrote this code eight
> > > > years ago ;)
> > > > While these lines get touched anyway, it would make sense to use
> > > > schedule_timeout_interruptible() instead, and get rid of set_current_state().
> > > >
> > > Well that is not really equivalent
> > > schedule_timeout_interruptible() is doing
> > > __set_current_state not set_current_state
> > > so that would drop the mb() and no WRITE_ONCE()
> > 
> > And how does that matter in this case?
> >
> I do not know - did not look into it - in any case
> its not a 1:1 API consolidation that all I wanted to point out
> before changing anything.

I agree, 1:1 consolidation is better here.

But I would like to remove the SDIAS_SLEEP_TICKS define and just
use HZ / 2 in schedule_timeout(). Could you please resend the
updated patch? We will then add it to our tree.

Thanks
Michael
