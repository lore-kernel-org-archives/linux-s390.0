Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F4020CCCA;
	Fri, 24 Oct 2025 19:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761335054; cv=none; b=i7Kv8Ku88YphSnad8AyKwP8lZ1vnywJqhz8HCyLhijS8UrDzkctef9btyne2KzxfXS0hBAsl8jl4m4QNz5URxq1Aa0kA+BTwVArx8MvbJPogWdmVDc249TUNK9xBNh2ZmVbkvSOkeE3BOGCk4Hb7ssbv2vFAngIoR708RjZE8VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761335054; c=relaxed/simple;
	bh=Oo6Q5FijZZnFxQ0PMsOVHjkx1Dg6buBWnKtlwko7Emk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a95A9IKpWRInpfDy1A37B74Xf2wxUoynl4czrgajUNsjkJ73KF+7E3Gf4HBn+JFj9oGmPV0AthUPIkaBtoVa1MFoMUwdna5n40xC5I6Yx0Fhc17Uz0dU+VXWWSd8LjRk8a04fAre1tc9fvE44qO9AnCwMceb7KeGcRvDc/phPk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mV9PV9dd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XOTtBc1Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mV9PV9dd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XOTtBc1Y"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761335051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j1tfRYGYM66U+KpSa00BpGxDI+hyT7SSps99obN09Nw=;
	b=mV9PV9ddpcoU02So0SXkS4ZFsu2V7qAr7LEgSfPB2WToEgUpusnbyDadgwVWZmbRTkyXGp
	xvX0UNKOV52ySDi0s+OUqSFEjqwtQ3Fp3XT2KXtNj7xH/noSieu7qQOSb0twLqPsuQdu52
	W2PSv38g55SZ107p2MYvIYFIfSG0AV4Ewb0llS3O3Q67LebNBdkvyw1t5kOWxeQINrrY8B
	C8rRWxdkMOnEatj0FnKC2APzd3PznfAfj8C8OdFbrVF6/FaJX2T9wcnIwKDGZ3u/WFdrfc
	nyEjip3DXjmNs4Vo88BJmJaGYic+FCBz4AXwhPL0pYDclJkETSnxhof/6+A92g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761335051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j1tfRYGYM66U+KpSa00BpGxDI+hyT7SSps99obN09Nw=;
	b=XOTtBc1YJh7Jq5lFhBgh4lK2u78F4KjnvZsO7hd4iln28ghgXC9efMVHBaCCiM8FiD7nn2
	aO4ycaAyDVrtNpDg==
To: Xie Yuanbin <qq570070308@gmail.com>, linux@armlinux.org.uk,
 mathieu.desnoyers@efficios.com, paulmck@kernel.org, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net,
 andreas@gaisler.com, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
 anna-maria@linutronix.de, frederic@kernel.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 qq570070308@gmail.com, thuth@redhat.com, riel@surriel.com,
 akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 segher@kernel.crashing.org, ryan.roberts@arm.com,
 max.kellermann@ionos.com, urezki@gmail.com, nysal@linux.ibm.com
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-perf-users@vger.kernel.org, will@kernel.org
Subject: Re: [PATCH 3/3] Set the subfunctions called by finish_task_switch
 to be inline
In-Reply-To: <20251024183541.68955-2-qq570070308@gmail.com>
References: <20251024182628.68921-1-qq570070308@gmail.com>
 <20251024183541.68955-1-qq570070308@gmail.com>
 <20251024183541.68955-2-qq570070308@gmail.com>
Date: Fri, 24 Oct 2025 21:44:10 +0200
Message-ID: <87placw0dx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Oct 25 2025 at 02:35, Xie Yuanbin wrote:
>  #ifndef MODULE
>  #define finish_arch_post_lock_switch \
>  	finish_arch_post_lock_switch
> -static inline void finish_arch_post_lock_switch(void)
> +static __always_inline void finish_arch_post_lock_switch_ainline(void)
>  {
>  	struct mm_struct *mm = current->mm;
>  
>  	if (mm && mm->context.switch_pending) {
>  		/*
>  		 * Preemption must be disabled during cpu_switch_mm() as we
>  		 * have some stateful cache flush implementations. Check
>  		 * switch_pending again in case we were preempted and the
>  		 * switch to this mm was already done.
>  		 */
>  		preempt_disable();
>  		if (mm->context.switch_pending) {
>  			mm->context.switch_pending = 0;
>  			cpu_switch_mm(mm->pgd, mm);
>  		}
>  		preempt_enable_no_resched();
>  	}
>  }
> +static inline void finish_arch_post_lock_switch(void)
> +{
> +	finish_arch_post_lock_switch_ainline();

What is exactly the point of this indirection. Why can't you just mark
finish_arch_post_lock_switch() __always_inline and be done with it?


