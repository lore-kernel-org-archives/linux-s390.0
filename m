Return-Path: <tglx@linutronix.de>
Date: Sun, 21 May 2017 20:14:45 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: RFC: better timer interface
In-Reply-To: <alpine.DEB.2.20.1705211859410.3023@nanos>
Message-ID: <alpine.DEB.2.20.1705211959370.3023@nanos>
References: <20170516114812.10660-1-hch@lst.de>
 <CAK8P3a1FoR_usw7du3ZRMF+PPhJ712EpArL_e1bLVNs7BYBu-w@mail.gmail.com>
 <20170516155132.GA1494@lst.de>
 <CAK8P3a3_Rjz9gTmayN1w8HrFHWY+wakeFgQSYRTAADJzF6zKJA@mail.gmail.com>
 <alpine.DEB.2.20.1705211859410.3023@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Mark Gross <mark.gross@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sun, 21 May 2017, Thomas Gleixner wrote:
> On Tue, 16 May 2017, Arnd Bergmann wrote:
> > On Tue, May 16, 2017 at 5:51 PM, Christoph Hellwig <hch@lst.de> wrote:
> > > Yes, that sounds useful to me as well.  As you said it's an independent
> > > but somewhat related change.  I can add it to my series, but I'll
> > > need a suggestions for a good and short name.  That already was the
> > > hardest part for the setup side :)
> > 
> > If we keep the unusual *_timer() naming (rather than timer_*() as hrtimer
> > has), we could use one of
> > 
> > a) start_timer(struct timer_list *timer, unsigned long ms);
> > b) restart_timer(struct timer_list *timer, unsigned long ms);
> > c) mod_timer_ms(struct timer_list *timer, unsigned long ms);
> >     mod_timer_sec(struct timer_list *timer, unsigned long sec);
> 
> Please make new functions prefixed with timer_ and get rid of that old
> interface completely. It's horrible.
>  
> timer_init()
> timer_start(timer, ms, abs)

I'm not even sure, whether we need absolute timer wheel timers at
all, because most use cases are relative to now.

But it's easy enough to provide them. All we need for that is something
like

	unsigned long time_msec;	

which gets incremented every tick by the appropriate amount of
milliseconds.

Having that would also allow to replace all the

       end = jiffies + msec_to_jiffies(xxx);

       while (time_before(jiffies, end))
       	     ....

constructs with a milliseconds based machinery. So we can remove all
*_to_jiffies() interfaces over time.

Thanks,

	tglx
