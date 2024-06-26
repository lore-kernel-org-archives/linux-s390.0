Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1F7161314;
	Wed, 26 Jun 2024 22:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719439813; cv=none; b=PVAIeO16zbtXdaHc8/Na4+F4YQysPCtQ6wnNI+nxuYYRTyHUOAGmb9d5zXLklYRcyvwqr9GcC62yoaXYB4h0iA/m3s8fwFkCgHxd1chhUYuuEXSQhQceIKNzT+71bGzWVX6dEH0MeU8cWLrUL+2bgIGVCihq0GJX2Ymbym6LzsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719439813; c=relaxed/simple;
	bh=FoMa2hdhI1oPIQ40kb5ipFDpW8RBfUV8Ix2rN3TmQ1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqTJFGtmY4dV/Vi6DmaeMjXbXMdWrDqUGXZvnlWPNtEV4iQn/MrlUySNYcR7jW13TcrCvv656I+b4R+93ZrrAtr8g0nqJnrCqET2+cUDe34fMI8bQdg9aKKaGfI19uL60EvdGHeKnyFuYNd2wcLGBhXQLKUgFVmfW/ucPa7Q1Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aR90lTVg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aR90lTVg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F9BC116B1;
	Wed, 26 Jun 2024 22:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719439813;
	bh=FoMa2hdhI1oPIQ40kb5ipFDpW8RBfUV8Ix2rN3TmQ1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aR90lTVgPYndoXHzrWf6IcHoE7CXVXu38jggpET05UGSL10FBFk/QMweV08LZKhlM
	 s4biMs8rWeMfR9jte3XfSgdFtKbX0wj4DAuAsf9bc3UKH8INFKqZPcirIMkYbHsOaG
	 Y3lUCQJnL5J9xHGC3fDsBCk2E8MrCYFABjV1q+vKyzV6jWS85k6y3LplDIDV64Tcw6
	 oSi0z4N3LbeMh2AlkhSxE7VBIqus2h6fyEr4IYaaHi8TsaYnvEQ2cVHz0Nr6IMvFzu
	 hsnsYhMaPLgVafOvDQlsVIVcs2Hd0/c9oIrcFRd+/yo83VjQUkplV0H25JZYmh1Fus
	 2rmGkTio9J8Cw==
Date: Wed, 26 Jun 2024 15:10:12 -0700
From: Kees Cook <kees@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: "liuyuntao (F)" <liuyuntao12@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Leonardo Bras <leobras@redhat.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] randomize_kstack: Remove non-functional per-arch entropy
 filtering
Message-ID: <202406261506.1516191F72@keescook>
References: <20240619214711.work.953-kees@kernel.org>
 <98381dbf-f14e-4b6c-8c96-fb6b97ed46e1@huawei.com>
 <202406201127.17CE526F0@keescook>
 <ZnVfOnIuFl2kNWkT@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnVfOnIuFl2kNWkT@J2N7QTR9R3>

On Fri, Jun 21, 2024 at 12:08:42PM +0100, Mark Rutland wrote:
> On Thu, Jun 20, 2024 at 11:34:22AM -0700, Kees Cook wrote:
> > On Thu, Jun 20, 2024 at 11:47:58AM +0800, liuyuntao (F) wrote:
> > > 
> > > 
> > > On 2024/6/20 5:47, Kees Cook wrote:
> > > > An unintended consequence of commit 9c573cd31343 ("randomize_kstack:
> > > > Improve entropy diffusion") was that the per-architecture entropy size
> > > > filtering reduced how many bits were being added to the mix, rather than
> > > > how many bits were being used during the offsetting. All architectures
> > > > fell back to the existing default of 0x3FF (10 bits), which will consume
> > > > at most 1KiB of stack space. It seems that this is working just fine,
> > > > so let's avoid the confusion and update everything to use the default.
> > > > 
> > > 
> > > My original intent was indeed to do this, but I regret that not being more
> > > explicit in the commit log..
> > > 
> > > Additionally, I've tested the stack entropy by applying the following patch,
> > > the result was `Bits of stack entropy: 7` on arm64, too. It does not seem to
> > > affect the entropy value, maybe removing it is OK, or there may be some
> > > nuances of your intentions that I've overlooked.
> > > 
> > > --- a/include/linux/randomize_kstack.h
> > > +++ b/include/linux/randomize_kstack.h
> > > @@ -79,9 +79,7 @@ DECLARE_PER_CPU(u32, kstack_offset);
> > >  #define choose_random_kstack_offset(rand) do {                         \
> > >         if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT, \
> > >                                 &randomize_kstack_offset)) {            \
> > > -               u32 offset = raw_cpu_read(kstack_offset);               \
> > > -               offset = ror32(offset, 5) ^ (rand);                     \
> > > -               raw_cpu_write(kstack_offset, offset);                   \
> > > +               raw_cpu_write(kstack_offset, rand);                     \
> > >         }                                                               \
> > >  } while (0)
> > >  #else /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
> > 
> > I blame the multiple applications of the word "entropy" in this feature. :)
> > 
> > So, there's both:
> > 
> > - "how many bits CAN be randomized?" (i.e. within what range can all
> >   possible stack offsets be?)
> > 
> > and
> > 
> > - "is the randomization predictable?" (i.e. is the distribution of
> >   selected positions with the above range evenly distributed?)
> > 
> > Commit 9c573cd31343 ("randomize_kstack: Improve entropy diffusion") was
> > trying to improve the latter, but accidentally also grew the former.
> > This patch is just trying to clean all this up now.
> > 
> > Thanks for testing! And I'm curious as to why arm64's stack offset
> > entropy is 7 for you when we're expecting it to be 6. Anyway, that's not
> > a problem I don't think. Just a greater offset range than expected.
> 
> Hmm....
> 
> I think this is due to the way the compiler aligns the stack in alloca(); it
> rounds up the value of KSTACK_OFFSET_MAX(offset) and ends up spilling over an
> additional bit (e.g. 0x3f1 to 0x3ff round up to 0x400).
> 
> Looking at v6.10-rc4 defconfig + CONFIG_RANDOMIZE_STACKOFFSET=y, the
> disassembly for arm64's invoke_syscall() looks like:
> 
> 	// offset = raw_cpu_read(kstack_offset)
> 	mov     x4, sp
> 	adrp    x0, kstack_offset
> 	mrs     x5, tpidr_el1
> 	add     x0, x0, #:lo12:kstack_offset
> 	ldr     w0, [x0, x5]
> 
> 	// offset = KSTACK_OFFSET_MAX(offset)
> 	and     x0, x0, #0x3ff
> 
> 	// alloca(offset)
> 	add     x0, x0, #0xf
> 	and     x0, x0, #0x7f0
> 	sub     sp, x4, x0
> 
> ... which in C would be:
> 
> 	offset = raw_cpu_read(kstack_offset)
> 	offset &= 0x3ff;			// [0x0, 0x3ff]
> 	offset += 0xf;				// [0xf, 0x40e]
> 	offset &= 0x7f0;			// [0x0,
> 
> ... so when *all* bits [3:0] are 0, they'll have no impact, and when *any* of
> bits [3:0] are 1 they'll trigger a carry into bit 4, which could ripple all the
> way up and spill into bit 10.
> 
> I have no idea whether that's important. Kees, does that introduce a bias, and
> if so do we need to care?
> 
> If I change the mask to discard the low bits:
> 
> 	#define KSTACK_OFFSET_MAX(x)   ((x) & 0x3F0)
> 
> ... then the assembly avoids the rounding:
> 
> 	mov     x4, sp
> 	adrp    x0, 0 <kstack_offset>
> 	mrs     x5, tpidr_el1
> 	add     x0, x0, #:lo12:kstack_offset
> 	ldr     w0, [x0, x5]
> 	and     x0, x0, #0x3f0
> 	sub     sp, x4, x0

Ah, interesting! I'd prefer to avoid the bias (or at least, the
weirdness). How about this as a solution?


diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
index 6d92b68efbf6..1d982dbdd0d0 100644
--- a/include/linux/randomize_kstack.h
+++ b/include/linux/randomize_kstack.h
@@ -32,13 +32,19 @@ DECLARE_PER_CPU(u32, kstack_offset);
 #endif
 
 /*
- * Use, at most, 10 bits of entropy. We explicitly cap this to keep the
- * "VLA" from being unbounded (see above). 10 bits leaves enough room for
- * per-arch offset masks to reduce entropy (by removing higher bits, since
- * high entropy may overly constrain usable stack space), and for
- * compiler/arch-specific stack alignment to remove the lower bits.
+ * Use, at most, 6 bits of entropy (on 64-bit; 8 on 32-bit). This cap is
+ * to keep the "VLA" from being unbounded (see above). Additionally clear
+ * the bottom 4 bits (on 64-bit systems, 2 for 32-bit), since stack
+ * alignment will always be at least word size. This makes the compiler
+ * code gen better when it is applying the actual per-arch alignment to
+ * the final offset. The resulting randomness is reasonable without overly
+ * constraining usable stack space.
  */
-#define KSTACK_OFFSET_MAX(x)	((x) & 0x3FF)
+#ifdef CONFIG_64BIT
+#define KSTACK_OFFSET_MAX(x)	((x) & 0b1111110000)
+#else
+#define KSTACK_OFFSET_MAX(x)	((x) & 0b1111111100)
+#endif
 
 /**
  * add_random_kstack_offset - Increase stack utilization by previously


-- 
Kees Cook
