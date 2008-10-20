From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [patch 2/2] introduce vdso on s390
Date: Mon, 20 Oct 2008 15:06:50 +0200
Message-ID: <20081020130650.GA4465@osiris.boeblingen.de.ibm.com>
References: <20081015174506.107691579@de.ibm.com> <20081015175305.332585239@de.ibm.com> <20081017153436.GA17116@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081017153436.GA17116@wavehammer.waldi.eu.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Bastian Blank <bastian@waldi.eu.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Oct 17, 2008 at 05:34:36PM +0200, Bastian Blank wrote:
> On Wed, Oct 15, 2008 at 07:45:08PM +0200, Martin Schwidefsky wrote:
> > +void update_vsyscall(struct timespec *wall_time, struct clocksource *clock)
> > +{
> > +	if (clock != &clocksource_tod)
> > +		return;
> > +
> > +	/* Make userspace gettimeofday spin until we're done. */
> > +	++vdso_data->tb_update_count;
> > +	smp_mb();
> > +	vdso_data->xtime_tod_stamp = clock->cycle_last;
> > +	vdso_data->xtime_clock_sec = xtime.tv_sec;
> > +	vdso_data->xtime_clock_nsec = xtime.tv_nsec;
> > +	vdso_data->wtom_clock_sec = wall_to_monotonic.tv_sec;
> > +	vdso_data->wtom_clock_nsec = wall_to_monotonic.tv_nsec;
> > +	smp_wmb();
> 
> Different barriers?

Doesn't matter. They are all the same anyway on s390. But I changed it to
smp_wmb instead.

> > +	++(vdso_data->tb_update_count);
>
> Why ++(...)?

Removed the braces.
