Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F2F47ECD3;
	Thu, 24 Sep 2026 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254030; cv=none; b=W8e7lxRBYr8BY8iecVla91iFu/edlWzCyFyyzF9dj8k7t2EUKNJ9xY5AFGHVQdqqlz6psU8w+13Vo7cKzoOtQE3FYwtt62k9LGRHhcn4Ej1wIl7D0f5tQVwnCRl2AWoKUqNKUhEkBDjp0y06xwakWR+rDhP+6yAfNo1Osdi1Ubw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254030; c=relaxed/simple;
	bh=aLsBzLjrp1DcDn6DWeVaafFM2AupnjMYo0e+qs0lkyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSjwz2TngtWLulBU+R9kztt81/A5H21r1/vF/KIxTEvQzR8aOWAU6EBZ/5SuZ2rh/I25wDuz//eWras/MgSUM0+ShGA3KXpuc8baBxZ8BWR8YxI4k1dLGhoVSZx4rqdJf9QgEXSh8UhwrsKp/fjkf+pm6KCDHaeCPCCfbAbUJ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qS3yws8A; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qS3yws8A"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57DFE1570;
	Thu, 24 Sep 2026 05:47:04 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F7A03F86C;
	Thu, 24 Sep 2026 05:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790254027; bh=aLsBzLjrp1DcDn6DWeVaafFM2AupnjMYo0e+qs0lkyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qS3yws8ARWxyQ1+ftpRPaMpKdtTTqu44bLMcI+dQ5YtFKmjLG0C1X4YEq9s7GpDps
	 QgQoCK7B8qUrIu+1Q7wIkRxMaXhUEFpkXZltly9wUzAAbIRJPgRBC8r5ZJRrcXrM5P
	 giKPrhw3skc7Z/BVVwLCIIOEY3xT3cPCUtPBhDbQ=
Date: Thu, 24 Sep 2026 13:46:59 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, catalin.marinas@arm.com,
	will@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
	sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, ojeda@kernel.org, boqun@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org,
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
Message-ID: <arUbw_TIA0Uj7oXT@J2N7QTR9R3>
References: <20260922054959.955093-2-mkchauras@gmail.com>
 <20260922064735.GS4121339@noisy.programming.kicks-ass.net>
 <arNxAn7I7NCVWmD1@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <20260924111557.GP1837346@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260924111557.GP1837346@noisy.programming.kicks-ass.net>

On Thu, Sep 24, 2026 at 01:15:57PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 23, 2026 at 11:58:13AM +0530, Mukesh Kumar Chaurasiya wrote:
> > On Tue, Sep 22, 2026 at 08:47:35AM +0200, Peter Zijlstra wrote:
> > > On Tue, Sep 22, 2026 at 11:20:00AM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> > > > Verify that the __bug_table entry emitted by ARCH_WARN_ASM has a correct
> > > > bug_addr displacement — i.e. the arch's trap label reference resolves to
> > > > the trap instruction — by calling find_bug() with the exact virtual address
> > > > of the trap, mirroring what the real trap handler does.
> > > > 
> > > > To support all architectures, each arch that implements ARCH_WARN_ASM now
> > > > defines ARCH_WARN_ASM_TRAP_LABEL, a string constant naming the local label
> > > > at which the trap instruction is placed:
> > > > 
> > > >   x86       "1"     (ud2 at label 1:)
> > > >   powerpc   "1"     (twi at label 1:)
> > > >   riscv     "1"     (ebreak at label 1:)
> > > >   arm64     "14471" (brk placed at 14471: by __BUG_ENTRY_END)
> > > >   s390      "0"     (mc at label 0:)
> > > > 
> > > > The label is used consistently: in ARCH_WARN_ASM itself, in the
> > > > bug_addr back-reference inside __BUG_ENTRY / _EMIT_BUG_ENTRY, 

> > > Not really a fan of that. And I can't really tell what you're doing with
> > > it either. The kunit is in Rust and thus unreadable :-(
> > > 
> > > I would rather you fix up is_valid_bugaddr(), some architectures seem to
> > > have an always true stub because of the callchains always being from the
> > > break instruction.
> > 
> > Hey Peter,
> > 
> > thanks for the suggestion. I will fix up the is_valid_bugaddr for
> > powerpc. I am not very good with other archs asm but i can do it for
> > ppc32 and ppc64.
> 
> Untested thingies for arm64 and s390x.
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 914282016069..3d8a969eab5f 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -987,14 +987,13 @@ void do_serror(struct pt_regs *regs, unsigned long esr)
>  #ifdef CONFIG_GENERIC_BUG
>  int is_valid_bugaddr(unsigned long addr)
>  {
> -	/*
> -	 * bug_brk_handler() only called for BRK #BUG_BRK_IMM.
> -	 * So the answer is trivial -- any spurious instances with no
> -	 * bug table entry will be rejected by report_bug() and passed
> -	 * back to the debug-monitors code and handled as a fatal
> -	 * unexpected debug exception.
> -	 */
> -	return 1;
> +	u32 insn;
> +
> +	if (aarch64_insn_read((u32 *)addr, &insn))
> +		return 0;
> +
> +	/* Match ASM_BUG_FLAGS() / BUG() instructions. */
> +	return insn == (0xd4200000 | (BUG_BRK_IMM << 5));
>  }
>  #endif

What problem is this trying to solve?

Mukesh's original patch seems to be trying to check whether we compiled
things correctly (such that the bug_table entry points at the expected
insturction), and I don't think that warrants a runtime check, but (as
per my reply to him) I don't understand why that's a thing to check in
the first place.

On arm64 we only call is_valid_bugaddr() under do_el1_brk64() ->
call_el1_break_hook() -> bug_brk_handler(). We only call
bug_brk_handler() when HW has taken a BRK exception with the BUG_BRK_IMM
immediate, and that can only be triggered by executing the right
instruction (BRK #BUG_BRK_IMM), which we ONLY use for BUG(). and WARN().

So I don't see why any change is necessary here.

If the HW has somehow taken a BRK exception from any other instruction
(which would presumably be a HW bug), there won't be a bug_table entry,
and so __report_bug() will fail to find an entry, and will return
BUG_TRAP_TYPE_NONE, same as for the !is_valid_bugaddr() case.

Mark.  
