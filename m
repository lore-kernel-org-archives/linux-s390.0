Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5915F312806;
	Fri, 14 Nov 2025 20:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763150448; cv=none; b=WRPp8yg7oarTZPw/tzJzUii90xUQlObRXeracW2qPmkaDSCWRVF2ZjRXBhVSt5bMDeh2Vjgq/RdPj8ySyRlePkOHkN2lrYpNQ7OIHGqEVQFkuPpkfVxc6GCZExp67MJxqy8PzWKmtcNpVsOdcLkrlAUNbXc5g7n/WpcDN+hMDLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763150448; c=relaxed/simple;
	bh=dht/PGPorqjSFpzriJGUBa6gRctfI59zdeSD54mt9uI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WXuk89DA4AAdL3MByk7ztEZFht+3sI7xtNB6yHS7oVIPy8ZT6Bj8N8N1EEzTxyh3rE4iE7zdjNDqw0mmG1j+c/LszGlpCmDVauD3fZymsQ+7isz5pWIMSiRYeFWznuRhvJm6yX7xDmeT12nOtm4XsS7r7K1RqQzv3ALtzOcx+xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0kgK4Qip; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tlnHCyf+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0kgK4Qip";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tlnHCyf+"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763150445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xDw+Bdt1Z2l9pBavkXEn0jsVYHruaBcdQyUPevKqzy4=;
	b=0kgK4QipB+mbrtzwq9kh5xX3Hr+d7JvraQXYboZ1ICbRXFk5J8XXxp4HbvZPhwQbXkb49u
	Js/Ak6qOZ4eFR9DhVVNZg0Mcl617x5NBaCdR4tI+Lz7rAq9Gg/yZ7XSQ+f3ZcuXTqunOZS
	yZdXZ2wFvti2+oxZCRjelsfTmiIOUs1y81k6XPVXunW2sSg4PzRSyZM8k96XgZZwNMGfJy
	HRlLDfMXcyKclt2SyaYMi8V9+tdp6BtHJ0GCAYAi1tZ8XIV7OtRYQA0OHkKLwDiRbZyaQu
	xnFHzSOu0KDabw2w7amR5F9ejIfNpLRJMd3Lw1KWl+4v4QDWM/iQdmae6QWHdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763150445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xDw+Bdt1Z2l9pBavkXEn0jsVYHruaBcdQyUPevKqzy4=;
	b=tlnHCyf+mgcY02876mNDlgdhfkQctuiHGs4zXqCYzxEk4w+OxAX0c70R6/x4Hi+6AZ4AH0
	eZ72jJYcZPSoj6AQ==
To: Xie Yuanbin <qq570070308@gmail.com>, riel@surriel.com,
 segher@kernel.crashing.org, david@redhat.com, peterz@infradead.org,
 hpa@zytor.com, osalvador@suse.de, linux@armlinux.org.uk,
 mathieu.desnoyers@efficios.com, paulmck@kernel.org, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net,
 andreas@gaisler.com, luto@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
 james.clark@linaro.org, anna-maria@linutronix.de, frederic@kernel.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 qq570070308@gmail.com, thuth@redhat.com, brauner@kernel.org,
 arnd@arndb.de, sforshee@kernel.org, mhiramat@kernel.org,
 andrii@kernel.org, oleg@redhat.com, jlayton@kernel.org,
 aalbersh@redhat.com, akpm@linux-foundation.org, david@kernel.org,
 lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com,
 max.kellermann@ionos.com, ryan.roberts@arm.com, nysal@linux.ibm.com,
 urezki@gmail.com
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, will@kernel.org
Subject: Re: [PATCH v3 3/3] Make finish_task_switch and its subfuncs inline
 in context switching
In-Reply-To: <20251113105227.57650-4-qq570070308@gmail.com>
References: <20251113105227.57650-1-qq570070308@gmail.com>
 <20251113105227.57650-4-qq570070308@gmail.com>
Date: Fri, 14 Nov 2025 21:00:43 +0100
Message-ID: <87346gbd04.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 13 2025 at 18:52, Xie Yuanbin wrote:

What are subfuncs? This is not a SMS service. Use proper words and not
made up abbreviations.

> `finish_task_switch` is a hot path in context switching, and due to

Same comment as before about functions....

> possible mitigations inside switch_mm, performance here is greatly
> affected by function calls and branch jumps. Make it inline to optimize
> the performance.

Again you mark them __always_inline and not inline. Most of them are
already 'inline'. Can you please precise in your wording?

> After `finish_task_switch` is changed to an inline function, the number of
> calls to the subfunctions (called by `finish_task_switch`) increases in
> this translation unit due to the inline expansion of `finish_task_switch`.
> Due to compiler optimization strategies, these functions may transition
> from inline functions to non inline functions, which can actually lead to
> performance degradation.

I'm having a hard time to understand this word salad.

> Make the subfunctions of finish_task_stwitch inline to prevent
> degradation.
>
> Perf test:
> Time spent on calling finish_task_switch (rdtsc):

What means (rdtsc)? 

>  | compiler && appended cmdline | without patch   | with patch    |
>  | gcc + NA                     | 13.93 - 13.94   | 12.39 - 12.44 |

What is NA and what are the time units of this?

>  | gcc + "spectre_v2_user=on"   | 24.69 - 24.85   | 13.68 - 13.73 |
>  | clang + NA                   | 13.89 - 13.90   | 12.70 - 12.73 |
>  | clang + "spectre_v2_user=on" | 29.00 - 29.02   | 18.88 - 18.97 |

So the real benefit is observable when spectre_v2_user mitigations are
enabled. You completely fail to explain that.

> Perf test info:
> 1. kernel source:
> linux-next
> commit 9c0826a5d9aa4d52206d ("Add linux-next specific files for 20251107")
> 2. compiler:
> gcc: gcc version 15.2.0 (Debian 15.2.0-7) with
> GNU ld (GNU Binutils for Debian) 2.45
> clang: Debian clang version 21.1.4 (8) with
> Debian LLD 21.1.4 (compatible with GNU linkers)
> 3. config:
> base on default x86_64_defconfig, and setting:
> CONFIG_HZ=100
> CONFIG_DEBUG_ENTRY=n
> CONFIG_X86_DEBUG_FPU=n
> CONFIG_EXPERT=y
> CONFIG_MODIFY_LDT_SYSCALL=n
> CONFIG_CGROUPS=n
> CONFIG_BLK_DEV_NVME=y

This really can go into the comment section below the first '---'
separator. No point in having this in the change log.

> Size test:
> bzImage size:
>  | compiler | without patches | with patches  |
>  | clang    | 13722624        | 13722624      |
>  | gcc      | 12596224        | 12596224      |

bzImage size is completely irrelevant. What's interesting is how the
size of the actual function changes.

> Size test info:
> 1. kernel source && compiler: same as above
> 2. config:
> base on default x86_64_defconfig, and setting:
> CONFIG_SCHED_CORE=y
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> CONFIG_NO_HZ_FULL=y

And again, we all know how to build a kernel.

