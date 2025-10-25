Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AA22F83DB;
	Sat, 25 Oct 2025 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761395233; cv=none; b=FRmRqKLq/ALm5vaNA2gMjLES6XjCgkaqk8D7mRBq8sy9HHqKJhKkJSYbZ/uStyjemNSrJltPaBfYx3+EUh4t6pytoxwx5lDQSkAtY8/ampgEh/vr9cz95vKBFa3mQS/WNsnsqJV6kgN5zZwRs7ZIBZIddo7mcE5lxz8ggYswJ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761395233; c=relaxed/simple;
	bh=+xvzT8p7XaGwEOS/Dv2QmbA2zQYWwNXG5H1jWmjioEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQSWmMTy1TbQ6h94OTrcsgD3SEtWRdWf7e1ssi9GJbkxiwVxrJ0giw4gxmAgXczVslzqx3GCQa2AYcfQffnBPhd0MxXXWl8kPy4HIhihe3tZzsN3jPPxzLfRTEXN1xcT6GfE6jhYd6X0L9tcJ9Hqzj7q+I5tHwqhFfvjqi5h5Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DXW8S2qJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DXW8S2qJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h4Hv3culHhtyyL1gbJRN5A5//DVcH55czATegss/m5o=; b=DXW8S2qJVowTkjTnDkxWNLSUmv
	OdTQmloYte0xiWQej+bz2CsoZsHFFDLvrHoDWfo332fV4FvGY7l9PPsER/ftMaXELgoGvomf8rPxb
	Az+TAIPncLhfcDzIzkUJD1AehAC/iy36eMbTsc/KDuoJ/yOAOeoOvvnwhPFrcERl9O+e4U+TZp0vb
	YV498D0zV6J695u35cgUxrWIQDRNwl9grza29BeUAfdv5e+ea8FnnLEZNOq/dT17eE2DV0/ed2xQR
	yo0ByPYblAstx7lo9QHU/rZ8Ekl3GquP/tZdxqoR4OoLAQTH3un+zr1leM16EAGMb4sHpyYtkUKn2
	rdc8Uwyw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCdMI-0000000C2tQ-2ODU;
	Sat, 25 Oct 2025 12:26:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4A76230277A; Sat, 25 Oct 2025 14:26:59 +0200 (CEST)
Date: Sat, 25 Oct 2025 14:26:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Xie Yuanbin <qq570070308@gmail.com>
Cc: linux@armlinux.org.uk, mathieu.desnoyers@efficios.com,
	paulmck@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net,
	andreas@gaisler.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	luto@kernel.org, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	anna-maria@linutronix.de, frederic@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, thuth@redhat.com,
	riel@surriel.com, akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, segher@kernel.crashing.org,
	ryan.roberts@arm.com, max.kellermann@ionos.com, urezki@gmail.com,
	nysal@linux.ibm.com, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-perf-users@vger.kernel.org,
	will@kernel.org
Subject: Re: [PATCH 0/3] Optimize code generation during context switching
Message-ID: <20251025122659.GA2352457@noisy.programming.kicks-ass.net>
References: <20251024182628.68921-1-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024182628.68921-1-qq570070308@gmail.com>

On Sat, Oct 25, 2025 at 02:26:25AM +0800, Xie Yuanbin wrote:
> The purpose of this series of patches is to optimize the performance of
> context switching. It does not change the code logic, but only modifies
> the inline attributes of some functions.
> 
> The original reason for writing this patch is that, when debugging a
> schedule performance problem, I discovered that the finish_task_switch
> function was not inlined, even in the O2 level optimization. This may
> affect performance for the following reasons:

Not sure what compiler you're running, but it is on the one random
compile I just checked.

> 1. It is in the context switching code, and is called frequently.
> 2. Because of the modern CPU mitigations for vulnerabilities, inside
> switch_mm, the instruction pipeline and cache may be cleared, and the
> branch and cache miss may increase. finish_task_switch is right after
> that, so this may cause greater performance degradation.

That patch really is one of the ugliest things I've seen in a while; and
you have no performance numbers included or any other justification for
any of this ugly.

> 3. The __schedule function has __sched attribute, which makes it be
> placed in the ".sched.text" section, while finish_task_switch does not,
> which causes their distance to be very far in binary, aggravating the
> above performance degradation.

How? If it doesn't get inlined it will be a direct call, in which case
the prefetcher should have no trouble.

