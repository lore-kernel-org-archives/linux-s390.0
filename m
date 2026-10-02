Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781D3480DD8;
	Fri,  2 Oct 2026 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790938960; cv=none; b=XSImznvPJKhYp3u2arjN0zpWR672MOtdVT4A+NONNr3p2igtOey3d6CJ+wcHNDhWYO6AsHOaRFnrqtP22Icl+HwJw4ADyWdc8ww58NUjjpwBpzWlGfRiNiM7Q7GmaQBJpQzL6znRbcaISGhCyqYZhGftBc8SAyVMrlMOMsF4T7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790938960; c=relaxed/simple;
	bh=k5q4/fAvZf1yqdlBhCsRb4tEDXSewhSKZjGR4g4Quuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DpG7VmdzaC/o7reSXMCeZ80Pt+Ewa6mVc94V5s7cUfpA8AXu94lPAYqpfYpRf9YKqy+yeEl1mQh/iUs0jofPiBrlrj/ThiVwqmEzVGUP4fPzDgclhGmxzWBXEwv4iHgVnPbNWNdThOyXzzmQuG6GhgX0dvtbmnafc1/CFF3tDZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSA8KOPc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSA8KOPc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0031F000FF;
	Fri,  2 Oct 2026 11:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790938955;
	bh=hKu1k8kGP5SDfYzTUe6BEg1Rh9OEx1S7cLJzvwkIo8E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fSA8KOPcMfD4nTuoQwZ65dnTEvIIcs8MuGlPn8Fs/+3fC7NLGpsaO+RpN1IgsIBZu
	 AUxBtepWGjjVI3M99anax4EK04p2VnA9VIFZGzrlLQlbKdH3xKIuLyNNV+nBS2gK+K
	 5MooxFs6WNfBX0ph/LCjwbFGsD5J8aN8q3nq6gL6dt66NTeVQTiBN3PJLVIx5KOpvx
	 kE87mNLRWpd4R0tmXsVbWwfvfFM0lYN5bAuwZWdHMhEK58ZB7SZ2YSx28z9+Nwg3HW
	 ESud0bA/Itaq1CPRhVc11wMDE18rRr2PF7dQo3epBifa0/5Uf6eMwX7MZUn8/gFQ9j
	 MDkdSwxtvaqxw==
Message-ID: <c39d7d50-e527-4a72-a89f-da4a9ac3cc97@kernel.org>
Date: Fri, 2 Oct 2026 13:02:26 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Nathan Chancellor <nathan@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 llvm@lists.linux.dev
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
 <179093852073.149722.832232613857480812.b4-ty@kernel.org>
 <CAHmME9pDcYh5OVSqnju8VfgEXt3YBToDBbFNz_OguKA23r6stg@mail.gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <CAHmME9pDcYh5OVSqnju8VfgEXt3YBToDBbFNz_OguKA23r6stg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 02/10/2026 à 12:58, Jason A. Donenfeld a écrit :
> On Fri, Oct 2, 2026 at 12:57 PM Christophe Leroy (CS GROUP)
> <chleroy@kernel.org> wrote:
>>
>>
>> On Fri, 25 Sep 2026 22:46:32 +0100, Nathan Chancellor wrote:
>>> After a recent change in LLVM [1], builds with the random vDSO
>>> implementation, such as PowerPC and RISC-V, fail when checking the vDSO:
>>>
>>>    arch/powerpc/kernel/vdso/vdso32.so.dbg: dynamic relocations are not supported
>>>    arch/riscv/kernel/vdso/vdso.so.dbg: dynamic relocations are not supported
>>>
>>> memset() is now generated when zeroing params->reserved for some builds
>>> because LLVM has an optimization (now run in more instances) that can
>>> recognize at compile time when it is assigning a static value to a
>>> contiguous area of memory and turn that into a call to memset(). Both
>>> clang and GCC assume memset() is always available [2].
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/1] random: vDSO: Avoid call to memset() when zeroing reserved in __cvdso_getrandom_data()
>>        (no commit info)
> 
> That's not for you to apply. I'm sending this through my random tree,
> along with a handful of other things I need to fix. But I wanted to
> let this cook a bit more. I can add your reviewed-by line, though.

Sorry I messed up with 'b4 ty', I do not intent to take this patch in my 
tree.
