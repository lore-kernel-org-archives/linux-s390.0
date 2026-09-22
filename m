Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B104EC64E;
	Tue, 22 Sep 2026 06:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059669; cv=none; b=GNKbiHPzkDfuyEd2Bqvr37dR5XBjdhf/jKndixUzXxlbcRRbLfhyjF8YRgDhYwhr50DD8/zOXt/oeXhKS7auEtFrxuK81a1Jc5w5wvdV/e9l9PmXOgbE8Vtx9Yrc+mxYCje2LEYoJpLDsfBEgVdn0/6XQdStsESxulfox+hgT2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059669; c=relaxed/simple;
	bh=cBb7S2vU0uTz3yHUlgmdE8S5TNXufYnkydIn7OHVD5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPYClZ+9FjDXJAKN6kB95xDILq4RT12A8TkXpaXFLK35vU48E2XKs4PywMzCI+h7QOWR6kzgZ+cjhTCRDzpZVA2b8XUa0Qrdh7VP2UvINhM4S++O9fS+Mfo1YgOmZHHOJKppr+uBlaKsd0C7hPfUj1g0m1YBX8rkfftodyiKDTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=diWLFtbz; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="diWLFtbz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=R3byElr0T5dtebr3WUNax1uHYhmo+4Ucoy9qEsJjVkM=; b=diWLFtbzOXpr4O03lPozg42MX4
	NNSwNYNjpY4mOCJ1dLlYekkFK8Q/ifjXKrNOXrSiwRN9YRnPQY2k/6IkCBOT96iH9BGf7UpMJ+3rj
	oWezQNHeYsbIwdBHp5NleTRIU5tCj7xMtLPYSOkL9s7B9GU8eXDGM1HmbewYnHuCKbydg0ibiCYBj
	KWYLlyzarJVtgPGe1EYdcy/XAhXH6FHQC/Rb6UpvQOBAVPqlPNzPao4MbB3s34dc8XDGcgTn5IrJs
	dRQxz7E/dYpeG983Zpg1XGIOSoJz3UbC6LgXcDZlY1voy1mfaC/HgqVejn1zJ8Z2/z1S67IrvLxlY
	gGB/Ng7Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x8uHw-0000000DAeP-4A3i;
	Tue, 22 Sep 2026 06:47:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9CCD9300708; Tue, 22 Sep 2026 08:47:35 +0200 (CEST)
Date: Tue, 22 Sep 2026 08:47:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, hca@linux.ibm.com, gor@linux.ibm.com,
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
	svens@linux.ibm.com, tglx@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
	daniel.almeida@collabora.com, tamird@kernel.org,
	acourbot@nvidia.com, work@onurozkan.dev, nathan@kernel.org,
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
	jszhang@kernel.org, japo@linux.ibm.com, jpoimboe@kernel.org,
	seanjc@google.com, pmladek@suse.com, thuth@redhat.com,
	ynorov@nvidia.com, joelagnelf@nvidia.com, david@davidgow.net,
	fujita.tomonori@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [RFC] rust: kernel: Add KUnit tests for ARCH_WARN_ASM bug table
 emission
Message-ID: <20260922064735.GS4121339@noisy.programming.kicks-ass.net>
References: <20260922054959.955093-2-mkchauras@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922054959.955093-2-mkchauras@gmail.com>

On Tue, Sep 22, 2026 at 11:20:00AM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> Verify that the __bug_table entry emitted by ARCH_WARN_ASM has a correct
> bug_addr displacement — i.e. the arch's trap label reference resolves to
> the trap instruction — by calling find_bug() with the exact virtual address
> of the trap, mirroring what the real trap handler does.
> 
> To support all architectures, each arch that implements ARCH_WARN_ASM now
> defines ARCH_WARN_ASM_TRAP_LABEL, a string constant naming the local label
> at which the trap instruction is placed:
> 
>   x86       "1"     (ud2 at label 1:)
>   powerpc   "1"     (twi at label 1:)
>   riscv     "1"     (ebreak at label 1:)
>   arm64     "14471" (brk placed at 14471: by __BUG_ENTRY_END)
>   s390      "0"     (mc at label 0:)
> 
> The label is used consistently: in ARCH_WARN_ASM itself, in the
> bug_addr back-reference inside __BUG_ENTRY / _EMIT_BUG_ENTRY, 


> diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
> index 23ab05438269..6cca8880660e 100644
> --- a/arch/x86/include/asm/bug.h
> +++ b/arch/x86/include/asm/bug.h
> @@ -62,8 +62,9 @@ extern void __WARN_trap(struct bug_entry *bug, ...);
>  #define HAVE_ARCH_BUG_FORMAT_ARGS
>  #endif
>  
> +#define ARCH_WARN_ASM_TRAP_LABEL "1"
>  #define __BUG_ENTRY(format, file, line, flags)				\
> -	"\t.long 1b - ."	"\t# bug_entry::bug_addr\n"		\
> +	"\t.long " ARCH_WARN_ASM_TRAP_LABEL "b - ." "\t# bug_entry::bug_addr\n" \
>  	__BUG_ENTRY_FORMAT(format)					\
>  	__BUG_ENTRY_VERBOSE(file, line)					\
>  	"\t.word " flags	"\t# bug_entry::flags\n"
> @@ -101,7 +102,7 @@ do {									\
>  	"99:\n"								\
>  	"\t.string \"\"\n"						\
>  	".popsection\n"							\
> -	"1:\t " ASM_UD2 "\n"						\
> +	ARCH_WARN_ASM_TRAP_LABEL ":\t " ASM_UD2 "\n"			\
>  	_BUG_FLAGS_ASM("99b", file, line, flags, size, "")
>  
>  #else

Not really a fan of that. And I can't really tell what you're doing with
it either. The kunit is in Rust and thus unreadable :-(

I would rather you fix up is_valid_bugaddr(), some architectures seem to
have an always true stub because of the callchains always being from the
break instruction.
