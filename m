From: Bastian Blank <bastian@waldi.eu.org>
Subject: Re: [patch 2/2] introduce vdso on s390
Date: Fri, 17 Oct 2008 17:34:36 +0200
Message-ID: <20081017153436.GA17116@wavehammer.waldi.eu.org>
References: <20081015174506.107691579@de.ibm.com> <20081015175305.332585239@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081015175305.332585239@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Oct 15, 2008 at 07:45:08PM +0200, Martin Schwidefsky wrote:
> +void update_vsyscall(struct timespec *wall_time, struct clocksource *clock)
> +{
> +	if (clock != &clocksource_tod)
> +		return;
> +
> +	/* Make userspace gettimeofday spin until we're done. */
> +	++vdso_data->tb_update_count;
> +	smp_mb();
> +	vdso_data->xtime_tod_stamp = clock->cycle_last;
> +	vdso_data->xtime_clock_sec = xtime.tv_sec;
> +	vdso_data->xtime_clock_nsec = xtime.tv_nsec;
> +	vdso_data->wtom_clock_sec = wall_to_monotonic.tv_sec;
> +	vdso_data->wtom_clock_nsec = wall_to_monotonic.tv_nsec;
> +	smp_wmb();

Different barriers?

> +	++(vdso_data->tb_update_count);

Why ++(...)?

Bastian

-- 
Either one of us, by himself, is expendable.  Both of us are not.
		-- Kirk, "The Devil in the Dark", stardate 3196.1
