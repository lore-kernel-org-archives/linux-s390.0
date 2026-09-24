Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE840345CCA;
	Thu, 24 Sep 2026 11:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248571; cv=none; b=fWQfoEOwQTnOYT/BvxdKPhgb3WNbTyaIKqJpC82NKIVT3ZhjFT7mFH5aNIi7lQAWNuH1Q2PYulHPYFzBHVtxOFqcBTQTyN+v9BB1fR2J4cZ+DmaNEpfWeLQMYZ+FOG8kMk8n5zhgyuuemkCPuffDukIfOGAsSZ6PxvTS8brechA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248571; c=relaxed/simple;
	bh=7sO2xew4LdZE0YMPbrOUBH2ya2roc+0/I1rdDvLsWGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTNao5sRsQbAV+Wr8GZTFHjz2Bu9lYtTxLJUfVcL5B0KssY0H/9vFCSKYWLkfUUeK2mtMWk6TCMyc0AYNcdWoDWCX4qpx2+qUhzwPo4WykiGNUATezidVm8PRIAuh/kai2PEZfp+6FXZxKoZ6GKJdE2kUV+5If9zlPqz2s+pjGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TiyK92WB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TiyK92WB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=gHiDQ7HWXcZShppku6mAcXzNHEI2Xpwr5xmcNWbMy1M=; b=TiyK92WBOnCu1fWO0Z4cSNHVSd
	Mj8PXqr4/HhutFB2ojMrKICILUnBnS4eqhR0AMmOxXGmjL4S91AliFtOmH9Eer5YntsyAB/x4AKze
	fjT7npvpCLhoKOtTRRGEFqlv/VLi37lyt5oAaJKmfc6RforL6bCcKz1OK121z4RkpdlZBm6gvCrtF
	1lB1nmH9hGCAcDm6f6x5INXv/tuJtYFmT/ZvCVh6C8e0JhN+Zyey3XlE+f3D3oLXxOEPOZToiUXDi
	KJ2TkcrnEgtVqHSSODBhH8NPCRreQWhadpv53WL0YAzTlI0/Iatayi0tl9oOR4O5GphjKwUAad29M
	izhpZmgQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x9hQl-0000000FtJU-1am7;
	Thu, 24 Sep 2026 11:15:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F3EDA300756; Thu, 24 Sep 2026 13:15:57 +0200 (CEST)
Date: Thu, 24 Sep 2026 13:15:57 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
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
Message-ID: <20260924111557.GP1837346@noisy.programming.kicks-ass.net>
References: <20260922054959.955093-2-mkchauras@gmail.com>
 <20260922064735.GS4121339@noisy.programming.kicks-ass.net>
 <arNxAn7I7NCVWmD1@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arNxAn7I7NCVWmD1@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>

On Wed, Sep 23, 2026 at 11:58:13AM +0530, Mukesh Kumar Chaurasiya wrote:
> On Tue, Sep 22, 2026 at 08:47:35AM +0200, Peter Zijlstra wrote:
> > On Tue, Sep 22, 2026 at 11:20:00AM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> > > Verify that the __bug_table entry emitted by ARCH_WARN_ASM has a correct
> > > bug_addr displacement — i.e. the arch's trap label reference resolves to
> > > the trap instruction — by calling find_bug() with the exact virtual address
> > > of the trap, mirroring what the real trap handler does.
> > > 
> > > To support all architectures, each arch that implements ARCH_WARN_ASM now
> > > defines ARCH_WARN_ASM_TRAP_LABEL, a string constant naming the local label
> > > at which the trap instruction is placed:
> > > 
> > >   x86       "1"     (ud2 at label 1:)
> > >   powerpc   "1"     (twi at label 1:)
> > >   riscv     "1"     (ebreak at label 1:)
> > >   arm64     "14471" (brk placed at 14471: by __BUG_ENTRY_END)
> > >   s390      "0"     (mc at label 0:)
> > > 
> > > The label is used consistently: in ARCH_WARN_ASM itself, in the
> > > bug_addr back-reference inside __BUG_ENTRY / _EMIT_BUG_ENTRY, 
> > 
> > 
> > > diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
> > > index 23ab05438269..6cca8880660e 100644
> > > --- a/arch/x86/include/asm/bug.h
> > > +++ b/arch/x86/include/asm/bug.h
> > > @@ -62,8 +62,9 @@ extern void __WARN_trap(struct bug_entry *bug, ...);
> > >  #define HAVE_ARCH_BUG_FORMAT_ARGS
> > >  #endif
> > >  
> > > +#define ARCH_WARN_ASM_TRAP_LABEL "1"
> > >  #define __BUG_ENTRY(format, file, line, flags)				\
> > > -	"\t.long 1b - ."	"\t# bug_entry::bug_addr\n"		\
> > > +	"\t.long " ARCH_WARN_ASM_TRAP_LABEL "b - ." "\t# bug_entry::bug_addr\n" \
> > >  	__BUG_ENTRY_FORMAT(format)					\
> > >  	__BUG_ENTRY_VERBOSE(file, line)					\
> > >  	"\t.word " flags	"\t# bug_entry::flags\n"
> > > @@ -101,7 +102,7 @@ do {									\
> > >  	"99:\n"								\
> > >  	"\t.string \"\"\n"						\
> > >  	".popsection\n"							\
> > > -	"1:\t " ASM_UD2 "\n"						\
> > > +	ARCH_WARN_ASM_TRAP_LABEL ":\t " ASM_UD2 "\n"			\
> > >  	_BUG_FLAGS_ASM("99b", file, line, flags, size, "")
> > >  
> > >  #else
> > 
> > Not really a fan of that. And I can't really tell what you're doing with
> > it either. The kunit is in Rust and thus unreadable :-(
> > 
> > I would rather you fix up is_valid_bugaddr(), some architectures seem to
> > have an always true stub because of the callchains always being from the
> > break instruction.
> 
> Hey Peter,
> 
> thanks for the suggestion. I will fix up the is_valid_bugaddr for
> powerpc. I am not very good with other archs asm but i can do it for
> ppc32 and ppc64.

Untested thingies for arm64 and s390x.

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 914282016069..3d8a969eab5f 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -987,14 +987,13 @@ void do_serror(struct pt_regs *regs, unsigned long esr)
 #ifdef CONFIG_GENERIC_BUG
 int is_valid_bugaddr(unsigned long addr)
 {
-	/*
-	 * bug_brk_handler() only called for BRK #BUG_BRK_IMM.
-	 * So the answer is trivial -- any spurious instances with no
-	 * bug table entry will be rejected by report_bug() and passed
-	 * back to the debug-monitors code and handled as a fatal
-	 * unexpected debug exception.
-	 */
-	return 1;
+	u32 insn;
+
+	if (aarch64_insn_read((u32 *)addr, &insn))
+		return 0;
+
+	/* Match ASM_BUG_FLAGS() / BUG() instructions. */
+	return insn == (0xd4200000 | (BUG_BRK_IMM << 5));
 }
 #endif
 
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index b6ba4465f59d..8bbb082fd5e3 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -26,6 +26,7 @@
 #include <linux/entry-common.h>
 #include <linux/kmsan.h>
 #include <linux/bug.h>
+#include <linux/uaccess.h>
 #include <asm/entry-percpu.h>
 #include <asm/asm-extable.h>
 #include <asm/irqflags.h>
@@ -55,7 +56,12 @@ static inline void __user *get_trap_ip(struct pt_regs *regs)
 #ifdef CONFIG_GENERIC_BUG
 int is_valid_bugaddr(unsigned long addr)
 {
-	return 1;
+	u16 insn;
+
+	if (get_kernel_nofault(insn, (u16 *)addr))
+		return 0;
+
+	return insn == 0x0001 || insn == 0x000e;
 }
 #endif
 
