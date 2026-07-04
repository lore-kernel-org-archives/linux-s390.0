Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C388C37475E;
	Sat,  4 Jul 2026 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783185902; cv=none; b=Pk+GvMg32ER9HAOfKLrhK5LjnDxS4c1667r6SXd/G8J3a/iqeHEZp0pVqASftdf6aQ2b3X3hPNV1cQuVqEmwmyMbwObfqcWJHcBdVVCscrwAkj5I/CRPvEljD2iY8QbVKip8jhTySi9BCCm9BUNJ/AQnf8R/wsdMVvexu5lpCGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783185902; c=relaxed/simple;
	bh=GlbrVZfffgmCmrnHeZOxQiX+KuR8ARx7J8bnFp/Vd90=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=aSDT9kJGEk4lc/V8kDo6fZDRfxdbolJJP8JjkBgdI/3O74moYr4dAz+rcNgx62jiO8DoO0pNO7QT5OFh3ZQVPYSSMPKeZAcC64OQbB/ct5RrHjYbz8QuwMGmuUzfJcdkB5sY4q8D4OmT2i01e+c+BV0xmNqPfo0U01JoRF3aqkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=ddFVpaRA; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ddFVpaRA"
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 664HNJRr1739853
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 4 Jul 2026 10:23:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 664HNJRr1739853
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026062701; t=1783185802;
	bh=laVgWzETVzPyfy8TL8hiLjbkrz+X11MaGvxM78c56UQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ddFVpaRAV0DC0OsSpEM1RIGHdBDJycmv5PNIh79X6gjmuMgZhFXuXaEyZMuGKQziN
	 OXk7biHUDHT0id4zqijW2S9+E1K2MG3eQgRHESaRXSn6bOYCiocdts3lN+RepzSoZw
	 TOOQ7IFrPKYiQXilVte+NFU7pH4AfLGwtMm+BT8IuAwsfOXlg8V88nAoWj3ssgp7L8
	 ugiLZlzclplOyDd/yAEDi+QXxhgXjjoy3ynstiJ/KRiwHjrTYdeKJ88yjtqBF39aRs
	 qeK/eeXW2dOUDGPSJXmYE43L0c6Vl+pbFzkWgHwreiQ+kRpM4ZyEWkWN2b5QpPTl1+
	 hYinKg61do8cg==
Date: Sat, 04 Jul 2026 10:23:14 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Thomas Gleixner <tglx@kernel.org>,
        =?ISO-8859-1?Q?Michal_Such=E1nek?= <msuchanek@suse.de>,
        Peter Zijlstra <peterz@infradead.org>
CC: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Andrew Donnellan <andrew+kernel@donnellan.id.au>,
        Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, Zong Li <zong.li@sifive.com>,
        Nam Cao <namcao@linutronix.de>, Deepak Gupta <debug@rivosinc.com>,
        Lukas Gerlach <lukas.gerlach@cispa.de>,
        Rui Qi <qirui.001@bytedance.com>, Kees Cook <kees@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BRFC=5D_entry=3A_Untangle_the_return_value_of?=
 =?US-ASCII?Q?_syscall=5Fenter=5Ffrom=5Fuser=5Fmode_from_syscall_NR?=
User-Agent: K-9 Mail for Android
In-Reply-To: <87h5mhnjsr.ffs@fw13>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz> <BA7CD91D-C0E5-47A1-B49C-BC6AF6604182@zytor.com> <87h5mhnjsr.ffs@fw13>
Message-ID: <3DD62076-5420-4D2B-8E7E-9FE0446BD8A0@zytor.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 2, 2026 2:49:56 PM PDT, Thomas Gleixner <tglx@kernel=2Eorg> wrote:
>On Wed, Jul 01 2026 at 11:29, H=2E Peter Anvin wrote:
>
>Can you please trim your replies? Scrolling through hundred lines of
>useless quoted text is just annoying=2E
>
>> On July 1, 2026 10:42:08 AM PDT, "Michal Such=C3=A1nek" <msuchanek@suse=
=2Ede> wrote:
>>>-static __always_inline long syscall_enter_from_user_mode(struct pt_reg=
s *regs, long syscall)
>>>+static __always_inline long syscall_enter_from_user_mode(struct pt_reg=
s *regs, long *syscall)
>>> {
>>> 	long ret;
>>>
>
>> 1=2E The type for a system call is int=2E
>
>That ship has sailed long ago=2E man syscall =2E=2E=2E
>
>> 2=2E A valid system call number is always going to be positive=2E
>
>That's true today=2E
>
>> 3=2E Bits [30:24] are available for architecture ABI use=2E The
>>    "architecture independent" part of the system call number is therefo=
re
>>    24 bits wide=2E
>>
>> 4=2E The exact ABI is platform-specific, obviously, but as a general
>>    guideline (especially for new platforms/ABIs) should follow the rule=
s
>>    for a platform "int" if practical=2E Notably, when passing a value i=
n a
>>    register larger than 32 bits, which side of the calling interface is
>>    responsible for sign-extending a value passed in a register=2E If ca=
ller
>>    side, the kernel should validate, if callee side the kernel should
>>    ignore the additional bits and do the extension=2E
>
>The kernel sign expands today already, i=2Ee=2E for compat syscalls=2E
>
>> 5=2E A negative system call number is guaranteed to return -ENOSYS
>>    (unless intercepted by seccomp, ptrace, or another mechanism under
>>    user space control=2E)
>
>That's true today=2E
>
>ASM entry:
>       regs->eax =3D -ENOSYS;
>
>C entry:
>       nr =3D syscall_enter_from_user_mode(regs, nr);
>
>       if ((unsigned)nr < SYSCALL_MAX)
>       	    regs->eax =3D handle_syscall();
>       else if (nr !=3D -1)
>       	    regs->eax =3D -ENOSYS;
>
>       =2E=2E=2E=2E
>
>If seccomp overwrites regs->eax and aborts any syscall (including -1) by
>returning -1, then the value seccomp wrote into regs->eax is preserved
>and returned to user space=2E
>
>The same applies for syscall_user_dispatch() and ptrace=2E=2E=2E() if the=
y
>decide to overwrite regs->eax _and_ abort the syscall by letting
>syscall_enter_from_user_mode() return -1=2E
>
>trace_syscall_enter() is not any different=2E If the magic BPF in there
>rewrites the syscall number to -1 then either the original -ENOSYS or
>the BPF induced overwrite is returned to user space=2E
>
>It's less than obvious and I have no objections to clean that up and
>make it more intuitive, but I still fail to see what Michal is actually
>trying to solve and what the magic flag is for=2E If s390 requires it,
>then that's an s390 problem, but definitely x86 does not=2E
>
>> 6=2E If the platform needs to algorithmically modify the system call
>>    number due to platform-specific concerns (say, the platform uses a
>>    16-bit special purpose register for the syscall number, or it has
>>    multiple kernel entry points with different behavior), it should if =
at
>>    all possible transcode the system call number as necessary to match
>>    this convention in APIs that are exposed to general kernel code=2E
>>
>> For example, in the future I could very much see the IA32 code in the
>> x86 kernel using bit 29 internally to indicate an ia32 system call,
>> simplifying the is_compat implementation on x86=2E
>
>I don't see how that makes it simpler=2E Those are two different entry
>code paths and magic bits wont make that go away=2E
>
>> It should not mean that passing bit 29 to either the syscall
>> instruction or int $0x80 will be accepted=2E
>
>Your proposal looks even more like a solution in search of a problem
>than the original one=2E
>
>Thanks,
>
>        tglx
>
>

The type in syscall(3) is irrelevant=2E The argument passed to the kernel =
is treated as an int and sign-extended from 32 bits=2E=20

I'm explicitly not trying to invent things; I'm trying to document the sta=
tus quo to avoid further confusion and to create mistakes=2E=20

I'm sorry I muddled the waters with what was intended to be a hypothetical=
 example=2E
