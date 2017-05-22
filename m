Return-Path: <tglx@linutronix.de>
Date: Mon, 22 May 2017 21:24:48 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: RFC: better timer interface
In-Reply-To: <CAK8P3a1YWvZ-mN06eH=p0N01CWkw9=_u8PFH0xyMzyOxLm7pDA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1705222114480.2407@nanos>
References: <20170516114812.10660-1-hch@lst.de>
 <CAK8P3a1FoR_usw7du3ZRMF+PPhJ712EpArL_e1bLVNs7BYBu-w@mail.gmail.com>
 <20170516155132.GA1494@lst.de>
 <CAK8P3a3_Rjz9gTmayN1w8HrFHWY+wakeFgQSYRTAADJzF6zKJA@mail.gmail.com>
 <alpine.DEB.2.20.1705211859410.3023@nanos>
 <alpine.DEB.2.20.1705211959370.3023@nanos>
 <CAK8P3a1YWvZ-mN06eH=p0N01CWkw9=_u8PFH0xyMzyOxLm7pDA@mail.gmail.com>
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

On Mon, 22 May 2017, Arnd Bergmann wrote:
> On Sun, May 21, 2017 at 8:14 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > But it's easy enough to provide them. All we need for that is something
> > like
> >
> >         unsigned long time_msec;
> >
> > which gets incremented every tick by the appropriate amount of
> > milliseconds.
> >
> > Having that would also allow to replace all the
> >
> >        end = jiffies + msec_to_jiffies(xxx);
> >
> >        while (time_before(jiffies, end))
> >              ....
> >
> > constructs with a milliseconds based machinery. So we can remove all
> > *_to_jiffies() interfaces over time.
> 
> A lot of those users could probably just ktime_get()/ktime_before() here,
> as they would by definition not be performance critical.

Right.

> I don't see a way to just tk->tkr_mono.base but with a ktime_get_coarse()
> we could just return the ktime_t of the last tick and not even need a seqlock
> on 64-bit architectures, or have to introduce a new API.

Yeah, that would be possible, but OTOH, for those loop thingies it probably
does not matter at all whether you have the overhead of ktime_get() or
not. We need to look at that stuff deeper.

Thanks,

	tglx
