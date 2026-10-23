Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792791838;
	b=r32Jrd/M9lZcaK7lN03w6UTjBoDPL/J4KEH6CrTLxLFayDXMI5ro5PKKxQo0EmOHo0RV
	 dVUFCULBggzSmpRjHmXHYJKBoDIDB9oAe1j7xAkTGbVWzaSUsy59Fn2bnutF1Ffijamk6
	 rQmoElbok/YWTpbHaCaUfawnTOLMbVET/H6As/hgP/HKDTtVc98WN/Bx/8XKHBTCEh7fg
	 QdZhohTHHA5iTG2be696BLONWbKG42L47xXo1bXDObwbn9EcaDffeztFnU4GPgc7TwB1S
	 h2QL3rTLh+HSn5CUjEMtdeYFy6CtNPOuYqOZi4p+kAFfDTglfIkmE1+JMWVd078/Rmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792791838;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=rBYqzhjRmnws8Rm/5IL7e+PRpdOctdJtXb4xboAMWSA=;
	b=pS5RM2Ww289PLDgyM4bM+aq3w+A5rk/vYgG8CTP6Y3iMu7mjuTBwarVfU7R1Q7z1+IMf
	 hL3GuFMkxMSZGOdxxJx8v5fOlcpWvthwDCCD/fW3iX7ezXWuOIU8IL0xba8EzrM8at9D6
	 buuorBb+9rkg/Z536Rv1nMPlA4lyGJW8Ok7VhsmKMI2PeKqd7OEtS4sTpgWVogmG4XLOp
	 12h4UdRXljPlm5czQ4btcmz7HGlHZWgLphOWWq0JqUro/0dzsQ5mXKN2NOoRoAoQmbOf2
	 wot4EOUErBhmaGJAznWjRxkSLe8TYEV+zmdgQQsq/Enq/E+QYUYD81GwzCb8kCFw39w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="hwASE/IL";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=z943ERBm;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0854F606A31A;
	Fri, 23 Oct 2026 21:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0854F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=hwASE/IL;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=z943ERBm
Date: Fri, 23 Oct 2026 23:43:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792791835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rBYqzhjRmnws8Rm/5IL7e+PRpdOctdJtXb4xboAMWSA=;
	b=hwASE/ILIfvsagU4ja9zJyp6NCW7nhDXBrLgESHYvZc9OlC/GQdmV72Hfw8lCHeCcJDiIT
	xFBb+eSpeLzJx+wG16eGrTDnCizzsAb6w+YXHutGNF3HFzHQkD8tsZ70QSbXCrE553aTtc
	FyBITEp8ynQwIVKmsTH4edb2ELcKOcjRqPKGeu5zad/jr9HszyeKdSGpYIGAdGmjIg04RH
	fcQJvL7izNOg661T28mb7TFw7IIiiiTlruIEDWxOW6votoei6lPtMgLjCAwFAfW1s9CXqg
	i8k5N81Ek/SnmSCRgWHVGbIsWAsCZb3iRBPHtLu5gtarfP+kYufKyE0FptRrgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792791835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rBYqzhjRmnws8Rm/5IL7e+PRpdOctdJtXb4xboAMWSA=;
	b=z943ERBmz9863Xr+14sVUMFBonUecgHEkMzxOZxtguvVf4IgWnapYNfN7FD67wKQCXc4NS
	csUXXgLT71khc6BQ==
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
Subject: Re: [patch 16/18] x86/entry: Get rid of the sys_ni_syscall()
 indirection
Message-ID: <20261023214353.Q3pZID23@linutronix.de>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.493733289@kernel.org>
 <20261022142425.3Wx-RrU5@linutronix.de>
 <87fqxx1r80.ffs@fw13>
 <87cxt11ktr.ffs@fw13>
 <1149A39E-BEBA-46EA-94F4-4DFFC4733EF5@zytor.com>
 <871p9g1s3w.ffs@fw13>
 <87y0boze95.ffs@fw13>
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
In-Reply-To: <87y0boze95.ffs@fw13>

On 2026-10-23 16:24:22 [+0200], Thomas Gleixner wrote:
> IOW, a tracer modification of regs->ax is not overwritten when the
> syscall number is out of range.
> 
> Between 2.6.19-rc2 and -rc3 x86_64 was changed to _always_ overwrite
> regs->ax when the syscall number is out of range.
> 
> In the 3.8 merge window seccomp introduced the -1 == skip bogosity which
> got fixed up and made "consistent" in several changes afterwards. Just
> that it never reached a state of consistency due to the overloading.
> 
> So are we stuck with this behavior or do we sit down and define what the
> correct behavior should be?

I wouldn't say we are stuck. The test did reassemble the status we had
at the moment. As you wrote yourself the behaviour changed a few times
and not on purpose.
I would say we define what correct behaviour should be and make sure it
is consistent across all the architectures.

> Thanks,
> 
>         tglx

Sebastian
