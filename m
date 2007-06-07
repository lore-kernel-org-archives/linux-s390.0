Return-Path: <linux-kernel-owner+w=401wt.eu-S1759583AbXFGIRT@vger.kernel.org>
Subject: Re: [RFC] [Patch 4/4] lock contention tracking slimmed down
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1181165656.7133.23.camel@dix>
References: <1181165656.7133.23.camel@dix>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 10:17:01 +0200
Message-Id: <1181204221.7348.238.camel@twins>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, jbaron@redhat.com, rostedt@goodmis.org, billh@gnuppy.monkey.org, mingo@elte.hu, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2007-06-06 at 23:34 +0200, Martin Peschke wrote:

> +#ifdef CONFIG_LOCK_STAT
> +enum lock_stat_enum {
> +	LOCK_STAT_CONT,
> +	LOCK_STAT_WAIT_READ,
> +	LOCK_STAT_WAIT_WRITE,
> +	LOCK_STAT_HOLD_READ,
> +	LOCK_STAT_HOLD_WRITE,
> +	_LOCK_STAT_NUMBER
> +};
> +#endif
> +
>  /*
>   * The lock-class itself:
>   */
> @@ -117,30 +129,11 @@ struct lock_class {
>  	int				name_version;
>  
>  #ifdef CONFIG_LOCK_STAT
> -	unsigned long			contention_point[4];
> +	struct statistic		stat[_LOCK_STAT_NUMBER];
> +	struct statistic_coll		stat_coll;
>  #endif
>  };


sizeof(struct statistic_coll) = 16+64+8+8+4+8+8 = 116
sizeof(struct statistic) = 4+4+8+8+8+8+8+4+8+4+4 = 68
                         + 8*NR_CPUS
			 + kmalloc_size(obj)*nr_cpu_ids


4 objs with size 40, gives 4*64 = 256 * nr_cpu_ids
1 obj with size 32 + more


for 2048 total classes this gives:

2048 * (116+68) = 376832

for each active class this adds per cpu:

  8+256+32+some = 296+

we have around 1400 locks in the kernel, this would give 414400 per cpu.

vs the old code:

2048*(4*8) = 65536
+
2048*(4*4*8 + 4*8) = 327680 per cpu

worst case

I'm not convinced 300 lines less code is worth that extra bloat.
