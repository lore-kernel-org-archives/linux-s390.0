Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D192D41A8F;
	Wed,  9 Sep 2026 19:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982449; cv=none; b=t+O2FbQ3bJJ+Jq8pstv/VlRyF8hxQhWFmsKsVu5g1LEXqcsw3pTe9BfzyLZyneRl7/4Av4LhTGxO3kwDrFLRPjS1YFzLdXzCaqXjtPuUTHuWhNXnWqEZmKhujB8IIy9N1zeZ3Vw5qQ+lidXRLoi0OQXXysVLozLPEX1UUKtK7K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982449; c=relaxed/simple;
	bh=t6WvPZKDUa+XIMc5MJIp9UjPq4fgZb3FxkTKoMvc1Bo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=L/9BfTpBkMIpFe0Ovn38VkG3UXnfJeupZYhO6H+QjccorE2cpZfiOPg1kuDuc3mAeYljphkZ4r7sqqwDT7QLBE+Gbmty+/GWJNIFtDdh/ghHzhAPnfwC/WjDzXvHe6SCRg4tSKKEXPm3pmzBD3WyUc9hnwy1yqDu7IHTwzaylcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=gofX7hrQ; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gofX7hrQ"
Received: from ehlo.thunderbird.net ([172.59.163.39])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 689JW0Ri241996
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 9 Sep 2026 12:32:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 689JW0Ri241996
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026082801; t=1788982324;
	bh=+dGDqKIiorLm4PMRWZf+lcjSymk+duftPVKL8h3BRa8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=gofX7hrQMbsXkfAGKbIB5EEVBWalAWuw926LqzLEOVYYNLyZUfbWEzWPGDLj9bbmQ
	 WFie+ve7lUQ9pYuRVmVYjV+EqzzAArpgHRWshxY1qKfnMcxxPUBe/xs1MmeSmnGIOJ
	 dPgyxNew5qsHsjhQOA41SlBB/MQHD0m+r1YFZE3wLCs3umtpLH2oSsE4iYDyt3+j/i
	 rnjM7tEna8nBlg7YqDxC5Ptjf5+Rcrbt1/0XzPeibvb/+oRmhKO1xpHus1ynWSXLJ8
	 MI9bdFysgi5uqG5wVEpJJTL/7pSn2oMlC1a/K6We8WFSaRVoteYLUt+37PBgC/p1jC
	 eVbxDJsilqYjA==
Date: Wed, 09 Sep 2026 12:31:53 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Peter Zijlstra <peterz@infradead.org>,
        =?ISO-8859-1?Q?Thomas_Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
CC: Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?ISO-8859-1?Q?Bj=F6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Christophe Leroy <chleroy@kernel.org>, Boqun Feng <boqun@kernel.org>,
        Nicolas Schier <nsc@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-mm@kvack.org,
        linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-mips@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Jan Stancek <jstancek@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v5 12/24] vdso: Add the vdsocheck tool
User-Agent: K-9 Mail for Android
In-Reply-To: <20260908071911.GU4120091@noisy.programming.kicks-ass.net>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de> <20260908-vdso-absolute-reloc-v5-12-3a93791af1cf@linutronix.de> <20260908071911.GU4120091@noisy.programming.kicks-ass.net>
Message-ID: <ABBC0C50-847F-406A-B426-55D0C2BE15EA@zytor.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On September 8, 2026 12:19:11 AM PDT, Peter Zijlstra <peterz@infradead=2Eor=
g> wrote:
>On Tue, Sep 08, 2026 at 08:33:46AM +0200, Thomas Wei=C3=9Fschuh wrote:
>> All vDSO code needs to be completely position independent=2E Symbol
>> references are marked as hidden so the compiler emits PC-relative
>> relocations=2E However there are cases where the compiler may still
>> emit absolute relocations, as they are valid in regular PIC DSO code=2E
>> These would be resolved by the linker and will break at runtime=2E
>> This has been observed on arm64, see commit 0c314cda9325 ("arm64: vdso:
>> Work around invalid absolute relocations from GCC")
>>=20
>> Introduce a tool to check for absolute relocations during the build,
>> as the current inline-shell logic is not expressive enough=2E
>> The check is done on the object files as the relocations will not exist
>> anymore in the final DSO=2E As there is no extension point for the
>> compilation of each object file, perform the validation in vdso_check=
=2E
>>=20
>> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas=2Eweissschuh@linutronix=2E=
de>
>> ---
>>  Makefile                    |  19 ++
>>  lib/vdso/Kconfig            |   5 +
>>  lib/vdso/Makefile           |   2 +
>>  lib/vdso/Makefile=2Einclude   |  14 ++
>>  lib/vdso/check/=2Egitignore   |   3 +
>>  lib/vdso/check/Makefile     |  34 +++
>>  lib/vdso/check/elf=2Ers       | 498 ++++++++++++++++++++++++++++++++++=
++++++++++
>>  lib/vdso/check/vdsocheck=2Ers | 154 ++++++++++++++
>>  8 files changed, 729 insertions(+)
>
>Urgh, does this mean I have to have rust installed just to build a
>kernel now?

It was going to happen, and now we'll have to suffer the instability of ru=
st=2E=2E=2E
