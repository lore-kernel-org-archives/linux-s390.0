Return-Path: <hch@lst.de>
Date: Thu, 18 May 2017 10:27:03 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: RFC: better timer interface
Message-ID: <20170518082703.GD3812@lst.de>
References: <20170516114812.10660-1-hch@lst.de>
 <CAK8P3a1FoR_usw7du3ZRMF+PPhJ712EpArL_e1bLVNs7BYBu-w@mail.gmail.com>
 <20170516155132.GA1494@lst.de>
 <CAK8P3a3_Rjz9gTmayN1w8HrFHWY+wakeFgQSYRTAADJzF6zKJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAK8P3a3_Rjz9gTmayN1w8HrFHWY+wakeFgQSYRTAADJzF6zKJA@mail.gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Mark Gross <mark.gross@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, May 16, 2017 at 10:26:39PM +0200, Arnd Bergmann wrote:
> If we keep the unusual *_timer() naming (rather than timer_*() as hrtimer
> has), we could use one of
> 
> a) start_timer(struct timer_list *timer, unsigned long ms);
> b) restart_timer(struct timer_list *timer, unsigned long ms);
> c) mod_timer_ms(struct timer_list *timer, unsigned long ms);
>     mod_timer_sec(struct timer_list *timer, unsigned long sec);
> 
> The first is slightly shorter but conflicts with three files that use
> the same name for a local function name. The third one fits
> well with the existing interfaces and provides both millisecond
> and second versions, I'd probably go with that.

Yeah, I'd take c) as well.  I'll give it a spin.

> We could consider even passing a default interval as another
> argument to prepare_timer(), and using that in add_timer(),
> but that would in those cases that have a constant interval
> (maybe about half of the users from) and would be a bit surprising
> to readers that are only familiar with the existing interfaces.

That seems rather ugly to me.

> One final option would be a larger-scale replacement of
> the API by mirroring the hrtimer style where possible while
> staying compatible with the existing calls, e.g. timer_prepare(),
> timer_add_expires(), timer_start(), ...

I'd chose timer_* for an entirely new API, but at this point this
seems a bit too much churn to me.
