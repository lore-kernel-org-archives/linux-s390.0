Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793636479;
	b=l6ZGJcJj8o7YWTS+Ehxlrwfn+wpYr1ZPoVFjN9MVpDn0eehgJBZY/wEn36oDjCBf+msY
	 U9n4GZTgAR+eQ+GtPL9Nw4BJLs/YU15r2vwTmGcz1Az4pkol7VgnjaFoNUf5kFfdAkxr4
	 ldJ2Ku2I/E0EwTXqL2IYL/VSn14YRkHqg7qqw87Vpm3yVA6yeuNwSoClmpjCDsNzo0XfC
	 yJ7UgLROT2k4AT/SEg6lSYTaYC8erHjsDOIJUI9xhNn9gxt02jY6Cv8ruvajh04OJjeXM
	 myFlJ1MfCku3pu/Jx6b/TBTVOe6aCyscefIak1LJRgOb9S2Pz0v6L4ETMAi6aKTVIeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636479;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=CAbnxO0/qUW9BHgq0s5afN/fwZolzjrBJaRnSuaEmAo=;
	b=0Cusf0XnW+shSFcHbBPfz4IzSUYm7AQSVQFq7lZ39KIOlrDeT/t84flHjrnrSnE5HW/B
	 IPH6XsSR5ENwdMAfvrOgwQ6OW1OX37PW4OV6IAv7DLAaSUaitPFrscFgcdVJJDJg8FP3l
	 EMBiiUMvPZt4UqzC2eYznkTtDkJvc8afIoOVqu7O4O4aZtlPiOCV35NXrZvra3JfOZpsI
	 KvVOgJFJGYXSCcLRuWnQePW6xG8O8K9ESLCEBtcv9VWjunrxcB39RfBzjP6F5JiR82Zr1
	 2avQymkMBsp8vihNum3JPWMxAzaMuCC/7fRv1deTbV1Z75HaFuo1HI/6zQPARy/cQEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Bkvlc9Uh;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=no3DkXB1;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBBF606ABA6;
	Mon,  2 Nov 2026 16:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FBBF606ABA6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Bkvlc9Uh;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=no3DkXB1
Date: Mon, 2 Nov 2026 17:21:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793636476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CAbnxO0/qUW9BHgq0s5afN/fwZolzjrBJaRnSuaEmAo=;
	b=Bkvlc9UhhyCv5ZdWUMU6G9Li+R2BVAADYWwZuoqUAyqvUjCoGYGxXIn4ALH8UCKwa4wXF8
	oraU/gZ8eujvwMvYkEcPGl9LoaQ4y8L5gTwgvEqTaLIOKyYpw0Vt21vSoLNR9nGu5XUZGy
	Ei+jDbIPpRtvYxUN3n40OXfMZKwhjOcptRjzclaFhqfaMjZ4DnPJp2kIUEARXrDA2lfCj7
	Xc9td9/O5azqjpJ09IA+6VHzOt3kgO7Q3tW3z+AQm8NXUA0NJY3SKFbPnSH3MoCGBJlCpq
	9SKkxdgYMHfQI6T9cHJ58WWsIb3edmk7YJmf4hhOdiwEorZM3Pu5QhcHBVRk7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793636476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CAbnxO0/qUW9BHgq0s5afN/fwZolzjrBJaRnSuaEmAo=;
	b=no3DkXB1ZRbLOBdX8Sfg5H+HK/netv5lLDsnHm2NNe1d6SMQE1Lawcr4U1D9QbHBAGIkXh
	QAa36tqetUjJ21Dw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guo Ren <guoren@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Helge Deller <deller@gmx.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Richard Weinberger <richard@nod.at>,
	Chris Zankel <chris@zankel.net>,
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-m68k@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH V2] x86/entry: Fix ptrace regression
Message-ID: <20261102162113.LEAhpzer@linutronix.de>
References: <20261022142425.3Wx-RrU5@linutronix.de>
 <87fqxx1r80.ffs@fw13>
 <87cxt11ktr.ffs@fw13>
 <1149A39E-BEBA-46EA-94F4-4DFFC4733EF5@zytor.com>
 <871p9g1s3w.ffs@fw13>
 <87y0boze95.ffs@fw13>
 <C6D7BF04-4CF7-48D1-93B5-E80D52C2617D@zytor.com>
 <87se1wyvs8.ffs@fw13>
 <87mrrvxaty.ffs@fw13>
 <87ecd4xwlr.ffs@fw13>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ecd4xwlr.ffs@fw13>

On 2026-11-01 18:58:08 [+0100], Thomas Gleixner wrote:
> --- a/arch/x86/entry/syscall_32.c
> +++ b/arch/x86/entry/syscall_32.c
> @@ -77,6 +77,10 @@ static __always_inline void do_syscall_3
>  	if (likely(nr < IA32_NR_syscalls)) {
>  		nr = array_index_nospec(nr, IA32_NR_syscalls);
>  		regs->ax = ia32_sys_call(regs, (unsigned int)nr);
> +	} else {
> +		/* See comment in do_syscall_64() */
> +		if (nr != -1UL) {
> +			regs->ax = -ENOSYS;

A curly closing bracket here and then it compiles for me. Or remove the
one in the "if" line.

>  	}
>  }

With either of the suggested changes:
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
