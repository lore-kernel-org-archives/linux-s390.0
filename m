Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BB4314A95;
	Mon, 19 Jan 2026 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841060; cv=none; b=bvSJ/KszOCdT6r8ICJEDnEso3ReKZ7lg+aYHi8gIdgZUXz0i4LGT384+CtD6achCkQZ++wdCBeBc4gz42TfSwoltxvkQmnkuDCJmbsmYDnPLIR4/fdl8OU6pzSgLQcbqHPXe7mfcloop1Th24NU50ETFODMyqyOBds8S2kIefKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841060; c=relaxed/simple;
	bh=16FGOoiet4+IrVT+FcqrHcvY6YUTC0QcugfuzrxpDdk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=lhwdOT42hY318Mb87rgRlbHXno6nkfKSYUCCBv6nsYsgVVg+KzaPLURLLgblRa0hf2Zi/JxeFTzro6KdgDFMCobjXllY5y3FpTY3uwmqTMjjmVnCtc4fegHzs+ixuZVS/EX6jkGMsGaloAIzQUw15WRj1SLOzGMluiCbr1MAtYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0tAOJQS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0tAOJQS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80FAC116C6;
	Mon, 19 Jan 2026 16:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768841059;
	bh=16FGOoiet4+IrVT+FcqrHcvY6YUTC0QcugfuzrxpDdk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=q0tAOJQSpR4lAPo9D9a0ZLzj9fmk4VEFSuwyHRGgr6m2/2bnlj2msqm1OK35ZA72i
	 BsoEW2Hi1Kd0mpXDYPCuFTDERjp9sFatntALxM7RaexoblAcWHEgiVDgn5GR/Cfhs5
	 lJ+7nmPuUhjsYr7LMg0JLovICzoM9fTlHD0eazCWxNpHY+vxS6kc8rz0ZKG0d1VEWg
	 IIhlCXiVHIe0pBTCOoVEENtJxJ+QEakuwJKi7yA2fm+eSBFbxX2gEsdDI8+DoA1Vyk
	 WSTb5IyXokPQcIaRg69SRVfbN0PLcfWUE2soFEJxCYrdO9X8LHmJmpvUejzzI3uzi8
	 2/W6/Js/SDGRw==
Date: Mon, 19 Jan 2026 08:44:17 -0800
From: Kees Cook <kees@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Mark Rutland <mark.rutland@arm.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Ard Biesheuvel <ardb@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
 David Laight <david.laight.linux@gmail.com>
CC: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_0/3=5D_Fix_bugs_and_perfo?=
 =?US-ASCII?Q?rmance_of_kstack_offset_randomisation?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20fb97f1-7e50-485a-bdfd-a2901d20ec84@intel.com>
References: <20260119130122.1283821-1-ryan.roberts@arm.com> <20fb97f1-7e50-485a-bdfd-a2901d20ec84@intel.com>
Message-ID: <C502BCE6-2FB2-4A06-93A8-E8DEDFC22914@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On January 19, 2026 8:00:00 AM PST, Dave Hansen <dave=2Ehansen@intel=2Ecom=
> wrote:
>On 1/19/26 05:01, Ryan Roberts wrote:
>> x86 (AWS Sapphire Rapids):
>> +-----------------+--------------+-------------+---------------+
>> | Benchmark       | Result Class |   v6=2E18-rc5 | per-task-prng |
>> |                 |              | rndstack-on |               |
>> |                 |              |             |               |
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
>> | syscall/getpid  | mean (ns)    |  (R) 13=2E32% |     (R) 4=2E60% |
>> |                 | p99 (ns)     |  (R) 13=2E38% |    (R) 18=2E08% |
>> |                 | p99=2E9 (ns)   |      16=2E26% |    (R) 19=2E38% |
>
>Like you noted, this is surprising=2E This would be a good thing to make
>sure it goes in very early after -rc1 and gets plenty of wide testing=2E

Right, we are pretty late in the dev cycle (rc6)=2E It would be prudent to=
 get this into -next after the coming rc1 (1 month from now)=2E

On the other hand, the changes are pretty "binary" in the sense that mista=
kes should be VERY visible right away=2E Would it be better to take this in=
to -next immediately instead?

>But I don't see any problems with the approach, and the move to common
>code looks like a big win as well:

Agreed; I think it's looking great=2E

--=20
Kees Cook
