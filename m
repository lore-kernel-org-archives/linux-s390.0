Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792769958;
	b=EuDv/ohzLT8Pz7NwsgoeIS0eIATtjWcXbU+WceowZ6mmIM+O05H9CVRQEizNx1YxAWGj
	 foI2qPkwg/6oS1JnAf4PfNbUiUlGoMJ0gPILoNDf6Jt7MWiIdIrxmq11+ryw4OFgRw/K9
	 m6GCaLFUyiaByFTBv9sq6iWfDUmtIcjZnWI1RUNIoyze19BIsHAS544dqBpH08PXYlo0g
	 5bbJ81HwXJZ9K1NrFFZok9FqKIqaNjd+nX0NTLPShNH+//Ou2jHKdpvkcVpdazYI93Cny
	 aP836XzkwaQVeFH40sYbSOPlMa0RZnfiMjNIewVVWmXMsG6rUWg0kpC1kkjbTL6UPTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792769958;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:CC:
	 Subject:User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=z2qBUDb/HEVpnZ0AdLrT9xxIZXcyNTPm5i0euSKeI8A=;
	b=v8/9qYGJfLc+1UDRIPPW11ZVrGMQ71hPIWDnbFgo80h+mr4e9ocMCLSQt1SkxUTJNg8C
	 qura5xUCq62SbBt8eqBbRhgHr4EQ9Gtb6K31+VsuB/c0GUa1yHXZbIXHkwPAlpSHwNLpt
	 /Zs1QJl2MDmgBy++KMW7YNcdJlmXQFuy4lm57M65lOfiqnz/6vtBmSMDezuAhyIdLMbmh
	 KR0A4gRyk7ucfNBuu7Cm5vu6Ff7CIHhy+0vk/kTKQrFe+PnLL54cOP+9kPRjSa0aPs4jn
	 uh5915+9SxcGrDAOVrp8L3qWA3LVRpHskiHx18K5sBtDgnzBLRqA/3UnTiSkGJ3ElkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zytor.com;
	spf=pass smtp.mailfrom=zytor.com;
	dkim=pass header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026092801 header.b=O8Iixtg2;
	arc=none smtp.remote-ip=198.137.202.136
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4970A606A31A;
	Fri, 23 Oct 2026 15:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4970A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026092801 header.b=O8Iixtg2
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 69NFc9VP3102952
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 23 Oct 2026 08:38:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 69NFc9VP3102952
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026092801; t=1792769891;
	bh=z2qBUDb/HEVpnZ0AdLrT9xxIZXcyNTPm5i0euSKeI8A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=O8Iixtg27nerxz4pv3MPQ79Qbkly3Qzdhjb7iI4+o56x6i8BSeIR1xQGCwnY7KKaQ
	 QA0Qg7pDBg5vVmC4UggSsNd6S8W3qav0zjBwEGselkJ0VJy5I7ZrNewKIutUb7AfVm
	 MdkVett81Uf9k7w/9M6Vs9Qyoxeec92PLSHDc6Cl9fwDnysLHD8N+1Ef2Jj1dB1Bez
	 Q/DmdOARJu1F614hVTT4HTy48AJ8iHcZSQvZDYXV0Cb5RUaF6zX8Iqu24NZ3rB/QHw
	 a/FnYpSSLXQYPrCSxXHH5/8CUI5QKVmOH3JXCGBKbQtNNmTk/ivswwNpvRE42ECOtx
	 l5XmL1xVvuk2g==
Date: Fri, 23 Oct 2026 08:38:03 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Thomas Gleixner <tglx@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
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
        Helge Deller <deller@gmx.de>,
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
        =?ISO-8859-1?Q?Michal_Such=E1nek?= <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Bpatch_16/18=5D_x86/entry=3A_Get_rid?=
 =?US-ASCII?Q?_of_the_sys=5Fni=5Fsyscall=28=29_indirection?=
User-Agent: K-9 Mail for Android
In-Reply-To: <87y0boze95.ffs@fw13>
References: <20260707181957.433213175@kernel.org> <20260707190254.493733289@kernel.org> <20261022142425.3Wx-RrU5@linutronix.de> <87fqxx1r80.ffs@fw13> <87cxt11ktr.ffs@fw13> <1149A39E-BEBA-46EA-94F4-4DFFC4733EF5@zytor.com> <871p9g1s3w.ffs@fw13> <87y0boze95.ffs@fw13>
Message-ID: <C6D7BF04-4CF7-48D1-93B5-E80D52C2617D@zytor.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 23, 2026 7:24:22 AM PDT, Thomas Gleixner <tglx@kernel=2Eorg> wro=
te:
>On Fri, Oct 23 2026 at 15:09, Thomas Gleixner wrote:
>> On Thu, Oct 22 2026 at 17:22, H=2E Peter Anvin wrote:
>> Tired brain misread the test output:
>>
>> [RUN]   Running tests under ptrace: modifying the default return
>> [RUN]       Checking system calls with msb =3D 0 (0x0)
>> [OK]                x32 syscalls 0:-64=2E=2E-2 returned -ENOSYS as expe=
cted
>> [OK]                x32 syscall 0:-1 returned MODIFIED_BY_PTRACE as exp=
ected
>> [OK]                x64 syscalls 0:-64=2E=2E-1 returned -ENOSYS as expe=
cted
>>
>> But that's because the "-1" on x32 is actually 0xFFFFFFFF while on x64
>> it's 0x7FFFFFFF=2E
>>
>> The whole mess comes from using -1 as indicator for syscall abort which
>> is undistinguishable from a syscall(nr=3D-1)=2E
>>
>> Bah=2E Let me restore this nonsense=2E
>
>The real question is how we ended up there=2E By design or as an
>implementation detail which got later set in stone and the selftest was
>written to test the implementation instead of testing against a
>specification=2E
>
>I went back in history and in 2=2E6=2E12 the behavior was for both i386 a=
nd
>x86_64:
>
>  regs->ax =3D -ENOSYS;
>  syscall_trace_enter();
>  if (syscall_nr < MAX)
>  	do_syscall();
>  =2E=2E=2E=2E
>
>IOW, a tracer modification of regs->ax is not overwritten when the
>syscall number is out of range=2E
>
>Between 2=2E6=2E19-rc2 and -rc3 x86_64 was changed to _always_ overwrite
>regs->ax when the syscall number is out of range=2E
>
>In the 3=2E8 merge window seccomp introduced the -1 =3D=3D skip bogosity =
which
>got fixed up and made "consistent" in several changes afterwards=2E Just
>that it never reached a state of consistency due to the overloading=2E
>
>So are we stuck with this behavior or do we sit down and define what the
>correct behavior should be?
>
>Thanks,
>
>        tglx
>
>

Going back on something from 3=2E8 that is actively used seems unwise=2E I=
 fear that that ship sailed a long time ago, even though I hate it just as =
much as you do=2E
