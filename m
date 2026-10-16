Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E77C27AC31
	for <linux-s390@vger.kernel.org>; Fri, 16 Oct 2026 06:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792130478; cv=none; b=tQFtryl1vv6EsfDJvIooihHVSteIFveYHTh5mhGOSYeN8TaYGSa9BglSUae6mk2Cph/IT1h9KLBaqVzva0Z4o+AFI4cjkKFBEveD8L2JKAL779qxrvzMA9oVnXLY11POOFQeyPprqZhz/By6Md0bLk/DRuUsmtKcggq9v8OKnMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792130478; c=relaxed/simple;
	bh=uBLkBYAnSKuFUV79EMpMgXiuISVUYHDZMEe0zvcXtN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8A+RK1+uwlDAfsQP59cbOLSKHAly5+xjEPDELjAwaw0mfE4DxGoJi/bbqr9UpK2/zJrgt2oOt4XqU1H/TbTpFgDoGJZ/VODj8av20ySUo2JOatv+bNkQn6lIbYPqcVptJEvMXSVi7bGfd3Duz5HOqC5rUCkQuBEp60ylGfe67M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gvp5xJFC; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gvp5xJFC"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4887dbe4f2dso644730f8f.3
        for <linux-s390@vger.kernel.org>; Thu, 15 Oct 2026 23:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792130474; x=1792735274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F8ceADCtVim4hSawqefDQ+4n/w2lyt7tKkBi/Vqtw64=;
        b=Gvp5xJFCCfWFSW2+nQagLHXwrNtTEDiXQJuqldlDEXrH47BEo1GOwE1lzfW7/YlXJH
         f7Ofaj4zM9/n+pt5mOMd6OJFSVstfgTFgMenZ/qmEByGkEXdBssXTBMRzDbpRdavdNX2
         r8Jp7Eln5RSaNcFbwKfskBeKOBDibwmVVZG4ti7lTZzPpUZujE2bsqLxbA07ljcFEmiX
         Pk5CrGFZToORAJ0DgUoHQr1aLYxLhSdwfSRHxvMaaRt+ilVgBTTaVNYjVv5HkcfU0r0W
         P8NL29M6yp/Z87pgPqBwvqjlNo8v8W9guskMEBMcckoxv+A4dxd6HhMKFN+g3YL3oY3+
         88AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792130474; x=1792735274;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F8ceADCtVim4hSawqefDQ+4n/w2lyt7tKkBi/Vqtw64=;
        b=kymut9vAhuUlHHfnvXFM7NPQ0VWcJ5ifcwr2c+SJq2XCmsH+apNuq92c9Z8lWD87vZ
         a1I8INUOXZ82u3JwGJmvl0QPxBCIeYuqeNJNk9NEARE8YIKiRQ0D+5mRVHKvqZiYXKci
         v2XdPZqEeAxNG9TXiETzSSDxKzmp0lB2Ch2ypn/dNyiv1RU4MEecyOA1PKd3QsNbRcrG
         lxj8BW9MWTwde7MraV4na0qT4ueyfq5OCYnAvNDso4OzMlau0wyye1s8A5SKjk3SSxrb
         xWz5j0PVuzCo+A4mDNdwkFiIzB71QIbz8YdXYphd+NXE0N/y6XHkJP+1V63bUrtHlJY4
         ZZNw==
X-Forwarded-Encrypted: i=1; AKwUvBxCAmsNChcPxoawxTKkNht/eeMp01Vyi9OwIbz/SCni/QDoBIrXwpcOQIfwyfczCz7lR9SnhwBUCpmq@vger.kernel.org
X-Gm-Message-State: AFq9FYItRiCS3vyE7YVoNcB7WCS7TkxROcJ5/fIUICWZBZ6321Jak77B
	0Ha8hRtSynxw0lPeNAK81r06ZNeMEkyrvyOxq/q1fdCGJnBPnm8kd9Z4
X-Gm-Gg: AYBFou3mf0lz3G6hIWFqKLVvUpe/J37KmOJAcGG6rlZdpPSDAmgy5BllUPCeRWS0EH2
	sYoiIyftya2gU1CP8tlKiLsiA/FyGYICTjGTlBtBt+ojRVQeBHrFii9Ic7XCWkeZdDYuXaAC5I7
	LHgAes54ZQJyTBX5T3MSkh79aKZAvqML0jqk7gHmmljc+5HSLyFz5UeVelaXl+UFIASG7wqDahR
	okNfvwg6f1oMnLZZwxW52tFRU9u/yKMZiuIw8DRPLnCwLF27QQa/6UNF4KYyANWXgDv0JqB5m0R
	O3Ynl0xc5uTbRaP0C1Wh2N9+VxNspVrA0wpv3gSy4vwK2Zuf3ozgJRwDIi19d1FpKwZ/jhqFr2Y
	FaKWWLdesQ53MClBRT7+MCQ35gqzaELE4ThBRp3WlZcUeq2NrTPan4dRTI9IRDB+Yooepk3xNht
	aTaZWGd1CjGNaJ0XqLXlqLHfeLoGbMSg4vtUDB2TzVbKu7mtjAC/0nCVap5AOFp2NtLB3x1Pep7
	bR/CxdqZ/jb4tT7oOZsTU/3lQ==
X-Received: by 2002:a05:6000:4696:b0:48d:f1b3:7e82 with SMTP id ffacd0b85a97d-48df1b3802emr7524330f8f.0.1792130473816;
        Thu, 15 Oct 2026 23:01:13 -0700 (PDT)
Received: from scheduler.schedules ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd471a64sm2962997f8f.6.2026.10.15.23.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:01:13 -0700 (PDT)
Date: Fri, 16 Oct 2026 09:01:09 +0300
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cocci@inria.fr
Subject: Re: [cocci] [PATCHv2] sched: Replace nr_iowait_cpu() with a bool
 accessor
Message-ID: <atG48yxevmlNFT7D@scheduler.schedules>
References: <20261015083317.3733733-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015083317.3733733-1-christian.loehle@arm.com>

On Thu, Oct 15, 2026 at 09:33:17AM +0100, Christian Loehle wrote:
> The menu governor was the last consumer of the per-CPU I/O-wait count
> that needed its magnitude, apart from nr_iowait() summing it globally.
> Commit 38f83090f515 ("cpuidle: menu: Remove iowait influence") removed
> that use. All remaining per-CPU consumers only test for zero/nonzero.
> 
> Replace nr_iowait_cpu() with bool cpu_has_iowait() and update the generic
> and s390 idle accounting callers. Have nr_iowait() read the counters
> directly so that the global total and existing accounting are preserved.
> Replace the stale menu comment with a description of the predicate.

So, this is a cleanup patch? OK.

> 
> The conversion was done with coccinelle:
> 
> @ predicate depends on patch @
> expression cpu;
> @@
> 
> - nr_iowait_cpu(cpu) > 0
> + cpu_has_iowait(cpu)
> 
> @ callers depends on patch @
> expression cpu;
> @@
> 
> - nr_iowait_cpu(cpu)
> + cpu_has_iowait(cpu)

I had to figure out what coccinelle was first.
Well, I still don't know fully what it is but I think
it's an automatic replacement tool.

I also checked Prateek's findings, I couldn't find more than he finds.
With his changes, all of the places would be covered I think.

> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
> v2: Move the cocci excerpt to the commit message (Peter)
> 
> 
>  arch/s390/kernel/idle.c    |  4 ++--
>  include/linux/sched/stat.h |  2 +-
>  kernel/sched/core.c        | 13 +++++--------
>  kernel/sched/cputime.c     | 10 +++++-----
>  4 files changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
> index dd12efb58201..ff9732ef494c 100644
> --- a/arch/s390/kernel/idle.c
> +++ b/arch/s390/kernel/idle.c
> @@ -82,13 +82,13 @@ static u64 arch_cpu_idle_time(int cpu, enum cpu_usage_stat idx, bool compute_del
>  
>  u64 arch_kcpustat_field_idle(int cpu)
>  {
> -	return arch_cpu_idle_time(cpu, CPUTIME_IDLE, !nr_iowait_cpu(cpu));
> +	return arch_cpu_idle_time(cpu, CPUTIME_IDLE, !cpu_has_iowait(cpu));
>  }
>  EXPORT_SYMBOL_GPL(arch_kcpustat_field_idle);
>  
>  u64 arch_kcpustat_field_iowait(int cpu)
>  {
> -	return arch_cpu_idle_time(cpu, CPUTIME_IOWAIT, nr_iowait_cpu(cpu));
> +	return arch_cpu_idle_time(cpu, CPUTIME_IOWAIT, cpu_has_iowait(cpu));
>  }
>  EXPORT_SYMBOL_GPL(arch_kcpustat_field_iowait);
>  
> diff --git a/include/linux/sched/stat.h b/include/linux/sched/stat.h
> index 0108a38bb64d..4810b14d0372 100644
> --- a/include/linux/sched/stat.h
> +++ b/include/linux/sched/stat.h
> @@ -20,7 +20,7 @@ extern int nr_processes(void);
>  extern unsigned int nr_running(void);
>  extern bool single_task_running(void);
>  extern unsigned int nr_iowait(void);
> -extern unsigned int nr_iowait_cpu(int cpu);
> +extern bool cpu_has_iowait(int cpu);
>  
>  static inline int sched_info_on(void)
>  {
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1fe40de6ebe3..1bde5187dafd 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5588,15 +5588,12 @@ unsigned long long nr_context_switches(void)
>  }
>
>  /*
> - * Consumers of these two interfaces, like for example the cpuidle menu
> - * governor, are using nonsensical data. Preferring shallow idle state selection
> - * for a CPU that has IO-wait which might not even end up running the task when
> - * it does become runnable.
> + * Return whether any tasks are accounted as I/O waiters on this CPU.
> + * They may wake up on a different CPU.
>   */
> -
> -unsigned int nr_iowait_cpu(int cpu)
> +bool cpu_has_iowait(int cpu)
>  {
> -	return atomic_read(&cpu_rq(cpu)->nr_iowait);
> +	return atomic_read(&cpu_rq(cpu)->nr_iowait) != 0;
>  }
>  
>  /*
> @@ -5634,7 +5631,7 @@ unsigned int nr_iowait(void)
>  	unsigned int i, sum = 0;
>  
>  	for_each_possible_cpu(i)
> -		sum += nr_iowait_cpu(i);
> +		sum += atomic_read(&cpu_rq(i)->nr_iowait);
>  
>  	return sum;
>  }
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index 06bddaa738e5..1f84a950abed 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -431,7 +431,7 @@ static void kcpustat_idle_stop(struct kernel_cpustat *kc, u64 now)
>  	if (!kc->idle_elapse)
>  		return;
>  
> -	iowait = nr_iowait_cpu(smp_processor_id()) > 0;
> +	iowait = cpu_has_iowait(smp_processor_id());
>  	delta = now - kc->idle_entrytime;
>  	steal = steal_account_process_time(delta);

Yeah, these look way more cleaner to me.

>  
> @@ -544,14 +544,14 @@ static u64 kcpustat_field_dyntick(int cpu, enum cpu_usage_stat idx,
>  u64 kcpustat_field_idle(int cpu)
>  {
>  	return kcpustat_field_dyntick(cpu, CPUTIME_IDLE,
> -				      !nr_iowait_cpu(cpu), ktime_get());
> +				      !cpu_has_iowait(cpu), ktime_get());
>  }
>  EXPORT_SYMBOL_GPL(kcpustat_field_idle);
>  
>  u64 kcpustat_field_iowait(int cpu)
>  {
>  	return kcpustat_field_dyntick(cpu, CPUTIME_IOWAIT,
> -				      nr_iowait_cpu(cpu), ktime_get());
> +				      cpu_has_iowait(cpu), ktime_get());
>  }
>  EXPORT_SYMBOL_GPL(kcpustat_field_iowait);
>  #else
> @@ -601,7 +601,7 @@ static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx,
>  u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
>  {
>  	return get_cpu_sleep_time_us(cpu, CPUTIME_IDLE,
> -				     !nr_iowait_cpu(cpu), last_update_time);
> +				     !cpu_has_iowait(cpu), last_update_time);
>  }
>  EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
>  
> @@ -625,7 +625,7 @@ EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
>  u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
>  {
>  	return get_cpu_sleep_time_us(cpu, CPUTIME_IOWAIT,
> -				     nr_iowait_cpu(cpu), last_update_time);
> +				     cpu_has_iowait(cpu), last_update_time);
>  }
>  EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
>  

BTW, this is tied to counter being correct, if its not...
Well we have problems. I think your other patch was covering that?
But I have a bad memory, so IDK.

Reviewed-by: Kayra Cizmeci <kayracizmeci@gmail.com>

Thanks!

Kayra



> -- 
> 2.34.1
> 
