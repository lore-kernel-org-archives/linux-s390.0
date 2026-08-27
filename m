Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D5C36B92B;
	Thu, 27 Aug 2026 22:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787871051; cv=none; b=uDPTU1K8LnIHB0ZH1ceDWgRHJ6PRov4LgNLifb47KSS1HrXkuPuzag/Gf0cWQasWXlb97ZLm4GkJlvekCkI/ck7yfvny10aYlnGNMJfyyTju5+DfrJJtdeptncnWkltqiJRrvO5GkDz2OcI1OECwL7QdgkVrZ1eUIXF4jpP1gIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787871051; c=relaxed/simple;
	bh=oVpn3Y3xe4yNSLPISH532HiWMGCaPXfViMVpomdHH3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pIfSA6qgSEAwqzJZJ4t+0qFTutk8n50r0czjVO03hiWGFha/Ag/jz7uSejyo9GvhWUzE4Sa1YNsmxUi0aiu5Pcc/h69dcCDQ+mIei1wHuxC+/31h1OwDxg5nV8dO6HF3U7z/4jnuIAjA4VxqQjKB5pwqkfj+UC1DPw0qvM393Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=GymOd4Rk; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="GymOd4Rk"
Received: from [IPV6:2601:646:8081:8d71:8c93:dacb:e5fa:49aa] ([IPv6:2601:646:8081:8d71:8c93:dacb:e5fa:49aa])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 67RMl4Qn1836438
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 27 Aug 2026 15:47:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 67RMl4Qn1836438
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026072801; t=1787870834;
	bh=EXQuytFudEdgp91C+uFz8aeu/WW15G7DgPzpxtGKF4M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GymOd4RkxGi8njVCQCfisvKP39Bb44ZVOGqd2ZqhsM67DzFyYn8S/jMXCU8Rma33W
	 PEelxL7L8kBY+qk5qAEjpsMwfkxEwjrDmJEsL+fSa6zkpR+h5d+MOwPtTLVMwwm0lZ
	 bCPemLIjQYuVaQEQRjl132J4YP0xzX54ej4JFh90v2xhqZFikkHSFSnGkczichDoFv
	 sZK/qGKEclFkhvxq+v2kMkmJ4o1BjYqiHVTd5aGLm7HyH0fkUCbFxhX7p3xCNzPfY0
	 gzR1rveeuo2MbtEx3KqfD+thNsEFw5il2Dad3o6axDhdFmbVxxjrh2OwAc/diiyN8G
	 nWKtXnX6xx8pw==
Message-ID: <995a61ef-ce8c-4c8b-bea8-77f375076a39@zytor.com>
Date: Thu, 27 Aug 2026 15:46:58 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 03/18] entry: Provide
 [syscall_]enter_from_user_mode_randomize_stack()
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>, Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller
 <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>,
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
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20260707181957.433213175@kernel.org>
 <20260707190253.816918647@kernel.org>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260707190253.816918647@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-07-07 12:06, Thomas Gleixner wrote:
> Randomizing the syscall stack can only happen after state is established
> via enter_from_user_mode() or syscall_enter_from_user_mode(). The earlier
> it happens the better.
> 
> Provide two new macros to consolidate that:
> 
>   - enter_from_user_mode_randomize_stack()
> 	enter_from_user_mode();
> 	add_random_kstack_offset_irqsoff();
> 
>   - syscall_enter_from_user_mode_randomize_stack()
> 	enter_from_user_mode_randomize_stack();
> 	syscall_enter_from_user_mode_work();
>     
> to reduce boiler plate code.
> 
> Those are macros and not inline functions as the latter would limit the
> stack randomization scope to the inline function itself.
> 
Not directly related to this patchset, but still:

Can anyone *please* find out what the actual security requirements are for the
syscall randomization offset?

The original checkin, 39218ff4c625 ("stack: Optionally randomize kernel stack
offset each syscall") indicates that it is fundamental that the stack offset
is applied *after* pt_regs pushing, but that isn't documented anywhere in the
kernel sources as far as I can tell.

However, I have also come to understand that there are further, undocumented
constraints; at least at one point I was told that "the offset should not be
stored in memory while running in the kernel", which seems more than a bit odd.

This matters, because it creates a data dependency on exit. The original
checkin does call out that RDTSC timing is inappropriate if the user could
control it, but using a hardware CSPRNG like RDRAND (or its equivalent for
other architectures) would be feasible if it isn't in the critical path. If an
RDRAND - store sequence can be executed on entry, *after* the stack
adjustment, then the high latency of RDRAND can hopefully be very effectively
hidden by an OO CPU.

Incidentally, in case you are wondering "why doesn't each core get a dedicated
CSPRNG and hardware randomness generator, to avoid high latency", the answer
is pretty simple: a hardware random number source, regardless of the specifics
of the design, almost by definition violates the hardware design rules of any
digital design; after all, the design rules are designed to *eliminate* noise
(making the circuit behave as closely as physically possible to a realization
of the abstract digital circuit), whereas the very goal of a HWRNG source is
to *extract and amplify* quantum thermal noise. This means that considerable
chip area is consumed by a "keep-out zone", a designated "no man's land"
keeping the digital logic away from the noise source. This keep-out zone is
typically much, much larger than the noise source itself.

	-hpa

