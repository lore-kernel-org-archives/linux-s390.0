Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647CD3DEADC;
	Wed,  1 Jul 2026 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895317; cv=none; b=sHlJxGUtW4EATXNDjCx/4K5Fjmu2LtHptZ8lr8utyUJ6zC+/+QjYUV0cEpqTU8SLYaUL5Lerk/JzCuoIei2dMbTfT6GFl32F2/K5wh9bSPWgUg9Uw3OWFSS2epy7FbsKb7WDrwf2+o6fuHjHyQvzOFutJSqgOGYpynxT9YGRwPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895317; c=relaxed/simple;
	bh=hIW/bfoVhF6C8YrHlddSaYp+8+PB2sPCZ1uwcJ1svP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shuX5TnDrDJcVuGwtavDgj63VuKsrMprpgyH+mInnwem2DMZrDcyaGyU+2k2iolXxb8SlGlg/XpeOeMasio1g6QrF6R/CFabMDIWWaAEYXKBG4Qjuz5oMDTHvLNm5HBAr/zYmkS3zLc1ZI25b+uWpYmXaqW8O8IhVX2oeoP9zw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WlkVgNkT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i5WUD6yc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WlkVgNkT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i5WUD6yc"
Date: Wed, 1 Jul 2026 10:41:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782895312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hIW/bfoVhF6C8YrHlddSaYp+8+PB2sPCZ1uwcJ1svP8=;
	b=WlkVgNkTFIYNtIj5qhELBYQd+AxKqlkZG3TrLGwri5qEahI5i2Iq5DPX1nRgw4bnbyacTw
	G6IG8Qy3NuzNrCDMtIbAL5uMpEgdi1pIXIqiIyZJuvq+UJQxYzRGJrpiwLWtT4av1uVvlD
	RGAbzJcyGPtwci6yrymLNTmaiULCn8ET6Tnkm2/7TuvhZos5optOP0cIInMD0X64zBibOX
	wlFtEzmKWPN5JwVjZUwN0LY1fw2+Qpa9cS/QY9chuZM14XdjrlPKAF/CfWpGQWzlVWB5Cy
	hjsnfyncyhqRk3d2cx8c1W7hUUH3sjBIOm/jrY9WePU3JRRm9ynzK2e7bJ681w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782895312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hIW/bfoVhF6C8YrHlddSaYp+8+PB2sPCZ1uwcJ1svP8=;
	b=i5WUD6yceXQe3x8TOrF2eWaGcrFDsh2T9jch8rsli5FTanCRAoIUsTybzMrCtoXwtD6xPq
	deJ2Wb7rO9Vu+lAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Charlie Jenkins <thecharlesjenkins@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Huth <thuth@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Jisheng Zhang <jszhang@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v5 8/8] futex: Use runtime constants for __futex_hash()
 hot path
Message-ID: <20260701084150.GNOeboLw@linutronix.de>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
 <20260630045531.3939-9-kprateek.nayak@amd.com>
 <20260701075714.GP48970@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701075714.GP48970@noisy.programming.kicks-ass.net>

On 2026-07-01 09:57:14 [+0200], Peter Zijlstra wrote:
> The big $1M question: does it actually make it go faster? The whole
> point here was performance, right? But I'm not seeing numbers showing
> how awesome these patches are.

I did complain about the about the size of __futex_data which is blown
on distro kernels due to CONFIG_NODES_SHIFT=10 on Debian for instance.
This makes it go away at no extra price but yeah let me boot a big box
and see.
If the performance remains unchanged it is still worth considering due
to size savings on the average box with 1 node. The biggest box I have
access to has four nodes. If I remember correctly, Prateek was saying
that AMD has "normal" boxes which would require =9 for normal operation
and they do run distro kernels so lowering that value is not an option.

Sebastian
