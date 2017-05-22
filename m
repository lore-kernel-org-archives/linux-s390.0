Return-Path: <arndbergmann@gmail.com>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <alpine.DEB.2.20.1705211959370.3023@nanos>
References: <20170516114812.10660-1-hch@lst.de>
 <CAK8P3a1FoR_usw7du3ZRMF+PPhJ712EpArL_e1bLVNs7BYBu-w@mail.gmail.com>
 <20170516155132.GA1494@lst.de>
 <CAK8P3a3_Rjz9gTmayN1w8HrFHWY+wakeFgQSYRTAADJzF6zKJA@mail.gmail.com>
 <alpine.DEB.2.20.1705211859410.3023@nanos>
 <alpine.DEB.2.20.1705211959370.3023@nanos>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 22 May 2017 13:26:33 +0200
Message-ID: <CAK8P3a1YWvZ-mN06eH=p0N01CWkw9=_u8PFH0xyMzyOxLm7pDA@mail.gmail.com>
Subject: Re: RFC: better timer interface
Content-Type: text/plain; charset="UTF-8"
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Mark Gross <mark.gross@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sun, May 21, 2017 at 8:14 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Sun, 21 May 2017, Thomas Gleixner wrote:
>> On Tue, 16 May 2017, Arnd Bergmann wrote:
>> > On Tue, May 16, 2017 at 5:51 PM, Christoph Hellwig <hch@lst.de> wrote:
>> > > Yes, that sounds useful to me as well.  As you said it's an independent
>> > > but somewhat related change.  I can add it to my series, but I'll
>> > > need a suggestions for a good and short name.  That already was the
>> > > hardest part for the setup side :)
>> >
>> > If we keep the unusual *_timer() naming (rather than timer_*() as hrtimer
>> > has), we could use one of
>> >
>> > a) start_timer(struct timer_list *timer, unsigned long ms);
>> > b) restart_timer(struct timer_list *timer, unsigned long ms);
>> > c) mod_timer_ms(struct timer_list *timer, unsigned long ms);
>> >     mod_timer_sec(struct timer_list *timer, unsigned long sec);
>>
>> Please make new functions prefixed with timer_ and get rid of that old
>> interface completely. It's horrible.
>>
>> timer_init()
>> timer_start(timer, ms, abs)
>
> I'm not even sure, whether we need absolute timer wheel timers at
> all, because most use cases are relative to now.
>
> But it's easy enough to provide them. All we need for that is something
> like
>
>         unsigned long time_msec;
>
> which gets incremented every tick by the appropriate amount of
> milliseconds.
>
> Having that would also allow to replace all the
>
>        end = jiffies + msec_to_jiffies(xxx);
>
>        while (time_before(jiffies, end))
>              ....
>
> constructs with a milliseconds based machinery. So we can remove all
> *_to_jiffies() interfaces over time.

A lot of those users could probably just ktime_get()/ktime_before() here,
as they would by definition not be performance critical.

I don't see a way to just tk->tkr_mono.base but with a ktime_get_coarse()
we could just return the ktime_t of the last tick and not even need a seqlock
on 64-bit architectures, or have to introduce a new API.

        Arnd
