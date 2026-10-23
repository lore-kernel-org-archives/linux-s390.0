Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792715050;
	b=JehGnMocDtR5ZiqnyHoEwd2SymW2otp4JrkITmQuJmcTFUpV5SNStMnkpqtqr9RRBD0x
	 Y7hzGWqr3ndX9Jbxj2Q5KLLFl+5gzDheaYzKHkMOqw73AKnsTnaBunvxIfFJ2EsYxSTUY
	 WFfoVvCQtaUQF0HioUNVSkw7QFl7HZZjAdKDIvqb97zIvnBiPSvT5H8Ksau93meG70Zyj
	 leuw/EZrKFjtB1ZusQ+/2jbVU+LTFCqh9p/92irJ3csZM4DdI8mYs9yKJMNIuOX69YGUl
	 rJxscecZmLw091td6D0PB7o2IRfhP44LS8LM75KUrKif8Lx64aQuxLAff8bJ/CBf4jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792715050;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:CC:
	 Subject:User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=sewWTjP+M6E94TwmQI+LvxiP3Dgk+UiInUJ1sYqPvjE=;
	b=kR2CrW7/hkAfxZW3cHeIT4RoXyK7nQWiqdFq13pZhWIcIfxUr/T5/oAMjrAhRkFaTRwC
	 M//jmNwbhkwd87XRtxr9KAd6zQcuJ7nbsAA7YJ2XjR8CQn7i8rAWpVtJcZESSThiTOPhI
	 GqUKBye1vGqUjRhwQqx7KiN5ooRXPfvdi4c2cOWIDxah/gDIGcHF/FiNXFX3clAubYPM9
	 viBh7Iv08T62//sz0D8ep/1E6LAvuzOC6shVJ+21DlKbdu1Xng5bCEuCMvWdLUdgRm11G
	 lNMxRMzZjok3rCVZPYW/S1HjIzIQ2SPA2d21Pz8VARQ6MG/Ur2p2WDPEdPGMthJHHIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zytor.com;
	spf=pass smtp.mailfrom=zytor.com;
	dkim=pass header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026092801 header.b=B0iR0guj;
	arc=none smtp.remote-ip=198.137.202.136
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B2E606A31D;
	Fri, 23 Oct 2026 00:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71B2E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026092801 header.b=B0iR0guj
Received: from ehlo.thunderbird.net (ENVISION-AE.edge1.SanJose1.Level3.net [4.79.220.182])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 69N0MTYe1497671
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 22 Oct 2026 17:22:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 69N0MTYe1497671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026092801; t=1792714955;
	bh=sewWTjP+M6E94TwmQI+LvxiP3Dgk+UiInUJ1sYqPvjE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=B0iR0gujNC7PBahAQGPELPfOvA7wFnm4aVgauSDh6Mr2eGjg9f2sjLSQ7t78E+yy1
	 f8bIVvq6KYitlu1MNVZc3rKXjku7b5th05mhKR3968auNM3tY5s5Ser+GgoQNITSum
	 ZADmFoGGs0IzvcRHHbEEE6rPcUpxXrq+3jB2dvktUZRlLHRQfdXJNzBfWoR9LWTL/0
	 Vfr9nrAF6Af+MSU3LPirKQDCQPLvyBm4AXAwcmc36BGcccEuO+/ctQAGEZb2pFmtOB
	 9hRTTHAao28lytaVTDSTMgSi2sQxwQH+82H9bDetNn7xdIGgwxNjxXV+Ny1OiYpDe8
	 //k9lsYxpZvPw==
Date: Thu, 22 Oct 2026 17:22:24 -0700
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
In-Reply-To: <87cxt11ktr.ffs@fw13>
References: <20260707181957.433213175@kernel.org> <20260707190254.493733289@kernel.org> <20261022142425.3Wx-RrU5@linutronix.de> <87fqxx1r80.ffs@fw13> <87cxt11ktr.ffs@fw13>
Message-ID: <1149A39E-BEBA-46EA-94F4-4DFFC4733EF5@zytor.com>
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

On October 22, 2026 2:34:08 PM PDT, Thomas Gleixner <tglx@kernel=2Eorg> wro=
te:
>On Thu, Oct 22 2026 at 21:15, Thomas Gleixner wrote:
>> On Thu, Oct 22 2026 at 16:24, Sebastian Andrzej Siewior wrote:
>>> On 2026-07-07 21:07:01 [+0200], Thomas Gleixner wrote:
>>> |[RUN]           Checking out of range system calls
>>> |[FAIL]                  x32 syscall 1:-64 returned -9999, but it shou=
ld have returned -ENOSYS
>>> |[FAIL]              x32 syscalls 1:-64=2E=2E-2 had 63 failure
>>> |[OK]                x32 syscall 1:-1 returned MODIFIED_BY_PTRACE as e=
xpected
>>> |[FAIL]                  x64 syscall 1:1073741760 returned -9999, but =
it should have returned -ENOSYS
>>> =E2=80=A6
>>>
>>> and so on=E2=80=A6 The test has
>>>
>>> | #define MODIFIED_BY_PTRACE      -9999
>>>
>>> and the ptracer modifies the return code=2E However not always=2E Not =
sure
>>> if this was indeed a pointless exercise or not=2E
>>
>> Hrmm=2E That's weird=2E Let me have a look=2E
>
>So I clearly failed to decode the overloading of the -1L return value
>correctly and then failed to run the stupid test=2E
>
>TBH, this whole thing was a horrid and inconsistent mess=2E
>
>The logic in the original code was:
>
>    When the entry work code returned an invalid syscall number then the
>    return value in regs->ax was set to -ENOSYS, except when the
>    returned syscall number was -1=2E Syscall number "-1" indicated that
>    the syscall has to be aborted=2E
>
>     regs->ax =3D -ENOSYS;
>     syscall =3D enter_work(regs, syscall);
>     if (syscall_in_range(syscall))
>        regs->ax =3D do_syscall(syscall);
>     else if (syscall !=3D -1)
>        regs->ax =3D -ENOSYS;
>
>So if the ptrace check in enter_work() overwrote regs->ax and the
>syscall number (either as supplied by user space or rewritten) was out
>of range and not -1 then the x86 entry code overwrote regs->ax to
>-ENOSYS again=2E IOW, there is no distinction between a check induced
>abort and a syscall with syscall number -1=2E
>
>The rework changed the return value to boolean, which is true when the
>syscall should be invoked and false when one of the checks requests to
>abort the syscall=2E In that case the return code does not touch the
>return value in regs->ax=2E
>
>If the eventually modified syscall number is out of range then the code
>relies on the fact that regs->ax was preset with -ENOSYS, i=2Ee=2E:
>
>     regs->ax =3D -ENOSYS;
>     // True indicates to proceed
>     if (enter_work(regs, &syscall)) {
>         if (syscall_in_range(syscall))
>            regs->ax =3D do_syscall(syscall);
>     }
>
>That seems to be equivalent, but it is not when ptrace() modifies
>the return value in regs->ax and also rewrites the syscall number to an
>invalid value or leaves the user supplied invalid value intact and does
>_NOT_ abort the syscall=2E
>
>So the reworked code does not overwrite the tracer modified return value
>with -ENOSYS in that case and returns whatever the tracer decided to put
>into it=2E
>
>TBH, that makes a lot more sense than the original behavior=2E If the
>tracer decides to fiddle with the default return value then that's what
>the tracer intended=2E
>
>That makes the behavior consistent vs=2E other abort scenarios:
>
>    ptrace()
>      regs->ax =3D MAGIC;
>      return true;            // Allow syscall
>
>    seccomp()
>      return false;          // Abort syscall
>
>So when the tracer modified the return value and seccomp aborts the
>syscall then the tracer induced value is preserved=2E That was the case i=
n
>the original code as well because seccomp() indicated the abort by
>returning -1 as the modified syscall number=2E Similar effects when ftrac=
e
>(BPF, kprobe) decided to overwrite the syscall number)=2E
>
>Bringing the original behaviour back is trivial enough, but I'm not
>convinced that it makes any sense and is worth it=2E At least this
>confines the x32 specific insanity of treating -1 special to x32=2E=2E=2E
>
>Thanks,
>
>        tglx
>---
>--- a/arch/x86/entry/syscall_32=2Ec
>+++ b/arch/x86/entry/syscall_32=2Ec
>@@ -77,6 +77,8 @@ static __always_inline void do_syscall_3
> 	if (likely(nr < IA32_NR_syscalls)) {
> 		nr =3D array_index_nospec(nr, IA32_NR_syscalls);
> 		regs->ax =3D ia32_sys_call(regs, (unsigned int)nr);
>+	} else {
>+		regs->ax =3D -ENOSYS;
> 	}
> }
>=20
>--- a/arch/x86/entry/syscall_64=2Ec
>+++ b/arch/x86/entry/syscall_64=2Ec
>@@ -64,15 +64,24 @@ static __always_inline bool do_syscall_x
> 	return false;
> }
>=20
>-static __always_inline void do_syscall_x32(struct pt_regs *regs, unsigne=
d long nr)
>+static __always_inline bool do_syscall_x32(struct pt_regs *regs, unsigne=
d long nr)
> {
>+	if (!IS_ENABLED(CONFIG_X86_X32_ABI))
>+		return false;
>+
>+	/* Preserve the historic insanity of treating -1 special on x32 */
>+	if (nr =3D=3D ULONG_MAX)
>+		return true;
>+
> 	/* Adjust the starting offset of the table */
> 	nr -=3D __X32_SYSCALL_BIT;
>=20
>-	if (IS_ENABLED(CONFIG_X86_X32_ABI) && likely(nr < X32_NR_syscalls)) {
>+	if (likely(nr < X32_NR_syscalls)) {
> 		nr =3D array_index_nospec(nr, X32_NR_syscalls);
> 		regs->ax =3D x32_sys_call(regs, (unsigned int)nr);
>+		return true;
> 	}
>+	return false;
> }
>=20
> /* Returns true to return using SYSRET, or false to use IRET */
>@@ -81,8 +90,10 @@ static __always_inline void do_syscall_x
> 	if (likely(syscall_enter_from_user_mode_randomize_stack(regs, &nr))) {
> 		instrumentation_begin();
>=20
>-		if (!do_syscall_x64(regs, nr))
>-			do_syscall_x32(regs, nr);
>+		if (unlikely(!do_syscall_x64(regs, nr))) {
>+			if (!do_syscall_x32(regs, nr))
>+				regs->ax =3D -ENOSYS;
>+		}
>=20
> 		instrumentation_end();
> 	}
>
>
>
>
>
>
>
>
>
>
>

It was never limited to x32=2E=2E=2E
