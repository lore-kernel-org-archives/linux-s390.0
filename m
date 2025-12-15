Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B8930F941;
	Mon, 15 Dec 2025 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765813338; cv=none; b=aL4mVVZMQYs5j4wogBFzGAjsxhygz9ge1IbmiHvpNn5wYUZ4qI63ElJsZAe6TU0okDShNhfxWScpS6KjCcwd/O0HbJmBpgbzcyZMaL6zYkBFpq0n0o4oHITJs2wDxIxPHMghwhl7vcfRkEY73vaFqbXj03egD75UBfJG3lELNV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765813338; c=relaxed/simple;
	bh=dJS6PDNzy5SX9DFgslkRBMWCk8nU43CN1Eb994NOW2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n9Noq2S+jw0T7r30x4oJZZ1/BJBvUHh8KdJ0o0Pk0w42TkiskEDhphRm/7Q3Bem+O3Oh9zP/72R7dbkGtsHNBsH+QJ3dzYuA60OP5nkToVNKq5Oz7NAL4TBIbvi11F+fG3OzydVYaIhJC2blWMKyc/7ITBrGNVeAIiXZzzT1Y/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l6o1JL8E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5XRdeOdi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l6o1JL8E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5XRdeOdi"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765813335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qNQsIHP9fHBp8xC+0dW3l0G1EY9NhEVbQNXrV3I9Txo=;
	b=l6o1JL8EEW9krcVDf/3SVEqIOq7qu5Lmvn1vrETvn5YQEo8YFjol7JUHrEknz8K6RNgPQN
	FKW7BQUnYRVVDVRlT7YQN4De/Ldapy+1xEp3lgFvjvbu7yu0mQ86emPtfMyk+rHxcwseJ2
	yLvH05FPZoAZ2xsPfmi3wNh0H7OUuLqyE8Mf9Sq1U4GjHn1x4qwrcFfRNiz6jvUow9nbze
	xXyMx8FfgNWS3qnYTsP4fR78CQUG5d8UGl6d1hpq1EImwAXNw8p2lOtrR7clMYG1nDxPHB
	m9QPbt56w6aBOHWkJO359PC+76vqXyJ4Co57cxuMJgJZGqVHpGS3nbScA6/X+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765813335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qNQsIHP9fHBp8xC+0dW3l0G1EY9NhEVbQNXrV3I9Txo=;
	b=5XRdeOdi7Z8jPn2I8e0wJwRxbmi816hPnPyZ//AKwL4kDs/uSE6sqgSXzo/PDUUV+r1rSZ
	B92xvrm4+KVuAcCQ==
To: Xie Yuanbin <qq570070308@gmail.com>, peterz@infradead.org,
 riel@surriel.com, segher@kernel.crashing.org, david@kernel.org,
 hpa@zytor.com, arnd@arndb.de, acme@kernel.org, adrian.hunter@intel.com,
 agordeev@linux.ibm.com, akpm@linux-foundation.org, alex@ghiti.fr,
 alexander.shishkin@linux.intel.com, andreas@gaisler.com,
 anshuman.khandual@arm.com, aou@eecs.berkeley.edu,
 borntraeger@linux.ibm.com, bp@alien8.de, bsegall@google.com,
 dave.hansen@linux.intel.com, davem@davemloft.net,
 dietmar.eggemann@arm.com, frederic@kernel.org, gor@linux.ibm.com,
 hca@linux.ibm.com, irogers@google.com, james.clark@linaro.org,
 jolsa@kernel.org, juri.lelli@redhat.com, justinstitt@google.com,
 lorenzo.stoakes@oracle.com, luto@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, max.kellermann@ionos.com, mgorman@suse.de,
 mingo@redhat.com, morbo@google.com, namhyung@kernel.org,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, nysal@linux.ibm.com,
 palmer@dabbelt.com, paulmck@kernel.org, pjw@kernel.org,
 rostedt@goodmis.org, ryan.roberts@arm.com, svens@linux.ibm.com,
 thuth@redhat.com, urezki@gmail.com, vincent.guittot@linaro.org,
 vschneid@redhat.com, linux@armlinux.org.uk
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v5 1/3] x86/mm/tlb: Make enter_lazy_tlb() always inline
 on x86
In-Reply-To: <20251214190907.184793-2-qq570070308@gmail.com>
References: <20251214190907.184793-1-qq570070308@gmail.com>
 <20251214190907.184793-2-qq570070308@gmail.com>
Date: Mon, 15 Dec 2025 16:42:13 +0100
Message-ID: <87345beoq2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Dec 15 2025 at 03:09, Xie Yuanbin wrote:
> enter_lazy_tlb() on x86 is short enough, and is called in context
> switching, which is the hot code path.
>
> Make enter_lazy_tlb() always inline on x86 to optimize performance.
>
> Signed-off-by: Xie Yuanbin <qq570070308@gmail.com>
> Reviewed-by: Rik van Riel <riel@surriel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202511091959.kfmo9kPB-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202511092219.73aMMES4-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202511100042.ZklpqjOY-lkp@intel.com/

These Reported-by and Closes tags are just wrong. This is a new patch
and the robot reported failures against earlier versions. The robot
report is very clear about that:

  "If you fix the issue in a separate patch/commit (i.e. not just a new version of
   the same patch/commit), kindly add following tags
     Reported-by:...
     Closes:..."

No?

> +/*
> + * Please ignore the name of this function.  It should be called
> + * switch_to_kernel_thread().

And why is it not renamed then?

> + *
> + * enter_lazy_tlb() is a hint from the scheduler that we are entering a

We enter a kernel thread? AFAIK the metaverse has been canceled.

> + * kernel thread or other context without an mm.  Acceptable implementations
> + * include doing nothing whatsoever, switching to init_mm, or various clever
> + * lazy tricks to try to minimize TLB flushes.
> + *
> + * The scheduler reserves the right to call enter_lazy_tlb() several times
> + * in a row.  It will notify us that we're going back to a real mm by

It will notify us by sending email or what?

> + * calling switch_mm_irqs_off().
> + */
>  #define enter_lazy_tlb enter_lazy_tlb
> -extern void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk);
> +#ifndef MODULE
> +static __always_inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
> +{
> +	if (this_cpu_read(cpu_tlbstate.loaded_mm) == &init_mm)
> +		return;
> +
> +	this_cpu_write(cpu_tlbstate_shared.is_lazy, true);
> +}

Please move the '#define enter_....' under the inline function. That's
way simpler to read.

Thanks,

        tglx
