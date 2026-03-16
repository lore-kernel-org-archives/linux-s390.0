Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A432327C0D;
	Mon, 16 Mar 2026 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773648874; cv=none; b=R7j4gVY+xyza6MxPsUQl4sFtjwKaIZlsYSvpljiOnGyN7q9jubCPurb4BwCoColjsB6ELi0TXA13V4tnEIr0awlJaSQED+kI6+IRxgT3EWpSp26hJmRFHztBFdDFhc98FgRKRttxxCErEhjo6GLWnhXBYyueZ4x5rFDJjBjEApc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773648874; c=relaxed/simple;
	bh=jf701U+Q2FqpfqOqvYcNF9sitTRZjVy9pp4tzXpXTUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fu0ZXblKVWOge9IeVdciPY/t9Sb4HicrRQD0lLo/vzNmIQljGadgDbxrlemZ2TCoEeqEpvDkgJSunKzpF2GXNkKoO4XVsWSwy6wN3Hp12qMjCS0MiDR2KNzHz5DB4DLWC9Vr98Vn+ozVu3t2pDSXfuXEuIJ5uEYX0trzrFr4UrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CVK/Gctd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j04c+glp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CVK/Gctd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j04c+glp"
Date: Mon, 16 Mar 2026 09:14:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773648871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WSOPBOtCZR55Ppkhd+kncZ0Q+IGD3weYA3vhslBMT/Y=;
	b=CVK/GctdHbhsaGBNaVTaF50Q5G6KNGhhw7ZYsF6Tg60uwAtwluqyIUnt5sfiX3FQPdNp++
	9ftUjLk73zaDoY/GFGBVlmgKa8sDFpBPMElWy0Y1hBtf29KoUxuYpjIIfhHoi/hp5hWWdU
	DoARQ9l95JmKBa9DuH9ufdwFrMD0p+YmGNZUj69kR43tykpqr+tM30nGe6qypYCxW/3URc
	ccBL46oJ5Ejv42YiL/WpO4WBZvGSSZ1IoCx6hPbjrqCJToZApjeSbDFKAPz4w6f9tNWP1y
	2VH4i7sS/kPKFbnUlqEaqERt7Gb4XxdVQzOefyMEzBa70l54wj54qFfhAExx8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773648871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WSOPBOtCZR55Ppkhd+kncZ0Q+IGD3weYA3vhslBMT/Y=;
	b=j04c+glpv7gTiC/XCliL9gSVLB2FiG0kUaIanPNt8Ydr4fgPeTFUKO7d+YS9SSq9HJm7FY
	A/Gakj70E7toT3Ag==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>, Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>, "H. Peter Anvin" <hpa@zytor.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Charles Mirabile <cmirabil@redhat.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
	Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [RFC PATCH v2 7/7] futex: Use runtime constants for
 __futex_hash() hot path
Message-ID: <20260316081429.FJx4fnNl@linutronix.de>
References: <20260316052401.18910-1-kprateek.nayak@amd.com>
 <20260316052401.18910-8-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260316052401.18910-8-kprateek.nayak@amd.com>

On 2026-03-16 05:24:01 [+0000], K Prateek Nayak wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Runtime constify the read-only after init data  __futex_shift(shift_32),
> __futex_mask(mask_32), and __futex_queues(ptr) used in __futex_hash()
> hot path to avoid referencing global variable.
> 
> This also allows __futex_queues to be allocated dynamically to
> "nr_node_ids" slots instead of reserving config dependent MAX_NUMNODES
> (1 << CONFIG_NODES_SHIFT) worth of slots upfront.
> 
> No functional chages intended.
> 
>   [ prateek: Dynamically allocate __futex_queues, mark the global data
>     __ro_after_init since they are constified after futex_init(). ]
> 
> Link: https://patch.msgid.link/20260227161841.GH606826@noisy.programming.kicks-ass.net
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de> # MAX_NUMNODES bloat
> Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

This all looks nice. Let me look later at the resulting code. Thank you
so far ;)

Sebastian
