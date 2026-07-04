Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0CF35E1B1;
	Sat,  4 Jul 2026 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783186601; cv=none; b=B+3mp6MISNcNXHPpamlb9ox9fr91BJZbbWkO26WnRHXh672bdaIrAtlaVJCj/N8d/cLygzLDrl06HaDrEOQNrzrnebGawQNtq4tAYGKoYlbiHDTsQESIRgwOKpfo3Xpgz+UylPqX0tHnDrtLU+PJ2ZWHDvJGQaPPzOHi7YEkYP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783186601; c=relaxed/simple;
	bh=dTFud6IYNn4nvyg1znQWrkcJonRufF/qiM6XZzzUK0c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=b7CTBvpxeFqPcZ3YmE0g8a2g/0p6vXjSxDQ1e6NHBf5crSLjsxKf5YV1KH2nQNCYN4rcidX6LwOnimdKTlNArWGJQVSOipTAJ4644WATcW5cHOAK4ZxJdFMzb3DxKsIxu81VFuyXM32MpZELeiklnYO4l8F3Cp6oj2j/W3D3t1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=CJF5CAKR; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CJF5CAKR"
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 664HJ3VH1732288
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 4 Jul 2026 10:19:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 664HJ3VH1732288
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026062701; t=1783185548;
	bh=dTFud6IYNn4nvyg1znQWrkcJonRufF/qiM6XZzzUK0c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=CJF5CAKRz4eNOPyR8kG0iAzsmyc+IwhntrZI2+KNzBcxTwm4Pcp7ISaY7lclR6A+T
	 R6iud2HrZonYFu7Ng8lIZ2Zy+h6YMeauv3txYKWEhoUf4+sfZRGAxFauHe9YYLo4uT
	 C6dgcvSiTqEU+iIkY6G3PGqbNZPx4bFWNID7VQM3t0H3q9hYfHNBXSLVMX7VMkyGoT
	 AchFenE1pkrCZJeaXw8wK9l7BRpqKAAfu9aoRxmSUBXrsCED1ggSW/SS3uws8TW93A
	 TkiqPgvXsUI43KFbqW08LGibZW5bbrWgmswEj6zjL2nzb2J1On7jMSJi4qiHbO8w3j
	 5g1n/GjjLwl9A==
Date: Sat, 04 Jul 2026 10:18:58 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Sven Schnelle <svens@linux.ibm.com>,
        =?ISO-8859-1?Q?Michal_Such=E1nek?= <msuchanek@suse.de>
CC: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
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
        Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
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
In-Reply-To: <yt9dtsqg480p.fsf@linux.ibm.com>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz> <BA7CD91D-C0E5-47A1-B49C-BC6AF6604182@zytor.com> <87h5mhnjsr.ffs@fw13> <yt9dwlvca8rn.fsf@linux.ibm.com> <87ldbsmnie.ffs@fw13> <yt9d5x2w5r84.fsf@linux.ibm.com> <20260703105718.GO751831@noisy.programming.kicks-ass.net> <akecJWAJP-e5CYP_@kunlun.suse.cz> <yt9dtsqg480p.fsf@linux.ibm.com>
Message-ID: <69ACC6A7-7845-41B4-B0D0-2E6FCDA7443D@zytor.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 3, 2026 4:39:18 AM PDT, Sven Schnelle <svens@linux=2Eibm=2Ecom> wro=
te:
>Michal Such=C3=A1nek <msuchanek@suse=2Ede> writes:
>
>> The same could be asked of syscall_enter_from_user_mode=2E I find it ve=
ry
>> odd=2E Why does it conflate the syscall number with its return value?
>>
>> It never uses the syscall number passed in except when returning it
>> unchanged=2E When it pokes the registers it reads the syscall number fr=
om
>> them=2E
>>
>> If the caller of syscall_enter_from_user_mode only read the syscall
>> number from the registers when syscall_enter_from_user_mode returns and
>> indicates the syscall should be still executed this whole shenigan woul=
d
>
>I agree=2E The fact that if (nr < NR_syscall) just works because -1 gets
>casted to 0xffffffff and is therefore out of bounds is very odd=2E
>

Not at all strange=2E It is an *extremely* common construct in C, especial=
ly for range checking values into [0, n)=2E

In addition to being idiomatic, keep in mind that this is one of the absol=
utely most performance critical paths in the entire kernel=2E One of the fu=
ndamental cornerstones behind Unix is to keep system calls cheap so that th=
ey can be simple building blocks for more complex operations=2E It is not t=
he only possible design philosophy, but it is the one we chose to adopt, qu=
ite successfully=2E

The downside? Squeezing every possible cycle out of the system call path b=
ecomes one of the most essential tuning tasks=2E The good part is that keep=
ing the system call path clean also makes it maintainable, even when there =
are quirks=2E
