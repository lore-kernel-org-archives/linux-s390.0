Return-Path: <arndbergmann@gmail.com>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20170516155132.GA1494@lst.de>
References: <20170516114812.10660-1-hch@lst.de>
 <CAK8P3a1FoR_usw7du3ZRMF+PPhJ712EpArL_e1bLVNs7BYBu-w@mail.gmail.com>
 <20170516155132.GA1494@lst.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 16 May 2017 22:26:39 +0200
Message-ID: <CAK8P3a3_Rjz9gTmayN1w8HrFHWY+wakeFgQSYRTAADJzF6zKJA@mail.gmail.com>
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
To: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Mark Gross <mark.gross@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, May 16, 2017 at 5:51 PM, Christoph Hellwig <hch@lst.de> wrote:
> On Tue, May 16, 2017 at 05:45:07PM +0200, Arnd Bergmann wrote:
>> This looks really nice, but what is the long-term plan for the interface?
>> Do you expect that we will eventually change all 700+ users of timer_list
>> to the new type, or do we keep both variants around indefinitely to avoid
>> having to do mass-conversions?
>
> I think we should eventually move everyone over, but it might take
> some time.

Ok.

>> If we are going to touch them all in the end, we might want to think
>> about other changes that could be useful here. The main one I have
>> in mind would be moving away from 'jiffies + timeout' as the interface,
>> and instead passing a relative number of milliseconds (or seconds)
>> into a mod_timer() variant. This is what most drivers want anyway,
>> and if we have both changes (callback argument and expiration
>> time) in place, we modernize the API one driver at a time with both
>> changes at once.
>
> Yes, that sounds useful to me as well.  As you said it's an independent
> but somewhat related change.  I can add it to my series, but I'll
> need a suggestions for a good and short name.  That already was the
> hardest part for the setup side :)

If we keep the unusual *_timer() naming (rather than timer_*() as hrtimer
has), we could use one of

a) start_timer(struct timer_list *timer, unsigned long ms);
b) restart_timer(struct timer_list *timer, unsigned long ms);
c) mod_timer_ms(struct timer_list *timer, unsigned long ms);
    mod_timer_sec(struct timer_list *timer, unsigned long sec);

The first is slightly shorter but conflicts with three files that use
the same name for a local function name. The third one fits
well with the existing interfaces and provides both millisecond
and second versions, I'd probably go with that.

We could consider even passing a default interval as another
argument to prepare_timer(), and using that in add_timer(),
but that would in those cases that have a constant interval
(maybe about half of the users from) and would be a bit surprising
to readers that are only familiar with the existing interfaces.

One final option would be a larger-scale replacement of
the API by mirroring the hrtimer style where possible while
staying compatible with the existing calls, e.g. timer_prepare(),
timer_add_expires(), timer_start(), ...

       Arnd
