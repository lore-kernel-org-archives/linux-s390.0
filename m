Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC19495E5;
	Fri, 21 Jun 2024 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718968132; cv=none; b=of0F/bUxJ0GzS7Zx3zs5QAzttKYvm053EQ6/sJG1h7sTvuU3Y9NsOjlRxvuVhxZWrWijUAHh+xKxLQosrDY3WZtEIUbmFOMCVpvfQ+RQAij5lzSi7IYLf8xZNNQ8Rddpv0Pt1YXWSaTJuw8pPl7RDWrUP4LdlNRVsf+NDwnT5Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718968132; c=relaxed/simple;
	bh=e9KZC2wJrvvAHjEOaRFoTQrElwaohbuI1Ox7UdSgKos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laFpNEFIi0y31Ixb4DHSHvXKsBA803eKw2TU5UXs0sZGjWm4Q94aWAe2q/aG/kQSkdLIUnxVGuPL6R7Klehrg9TICjgUFxl6h3yNQeOpylc8ZEAjnAUWNO0WgtiejluBqGRs8342+HsBbkXFk7MTMR4/Vwo2V+ZNbD0WPAojzAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11B64DA7;
	Fri, 21 Jun 2024 04:09:14 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73E0B3F6A8;
	Fri, 21 Jun 2024 04:08:45 -0700 (PDT)
Date: Fri, 21 Jun 2024 12:08:42 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Kees Cook <kees@kernel.org>
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
Message-ID: <ZnVfOnIuFl2kNWkT@J2N7QTR9R3>
References: <20240619214711.work.953-kees@kernel.org>
 <98381dbf-f14e-4b6c-8c96-fb6b97ed46e1@huawei.com>
 <202406201127.17CE526F0@keescook>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202406201127.17CE526F0@keescook>

On Thu, Jun 20, 2024 at 11:34:22AM -0700, Kees Cook wrote:
> On Thu, Jun 20, 2024 at 11:47:58AM +0800, liuyuntao (F) wrote:
> > 
> > 
> > On 2024/6/20 5:47, Kees Cook wrote:
> > > An unintended consequence of commit 9c573cd31343 ("randomize_kstack:
> > > Improve entropy diffusion") was that the per-architecture entropy size
> > > filtering reduced how many bits were being added to the mix, rather than
> > > how many bits were being used during the offsetting. All architectures
> > > fell back to the existing default of 0x3FF (10 bits), which will consume
> > > at most 1KiB of stack space. It seems that this is working just fine,
> > > so let's avoid the confusion and update everything to use the default.
> > > 
> > 
> > My original intent was indeed to do this, but I regret that not being more
> > explicit in the commit log..
> > 
> > Additionally, I've tested the stack entropy by applying the following patch,
> > the result was `Bits of stack entropy: 7` on arm64, too. It does not seem to
> > affect the entropy value, maybe removing it is OK, or there may be some
> > nuances of your intentions that I've overlooked.
> > 
> > --- a/include/linux/randomize_kstack.h
> > +++ b/include/linux/randomize_kstack.h
> > @@ -79,9 +79,7 @@ DECLARE_PER_CPU(u32, kstack_offset);
> >  #define choose_random_kstack_offset(rand) do {                         \
> >         if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT, \
> >                                 &randomize_kstack_offset)) {            \
> > -               u32 offset = raw_cpu_read(kstack_offset);               \
> > -               offset = ror32(offset, 5) ^ (rand);                     \
> > -               raw_cpu_write(kstack_offset, offset);                   \
> > +               raw_cpu_write(kstack_offset, rand);                     \
> >         }                                                               \
> >  } while (0)
> >  #else /* CONFIG_RANDOMIZE_KSTACK_OFFSET */
> 
> I blame the multiple applications of the word "entropy" in this feature. :)
> 
> So, there's both:
> 
> - "how many bits CAN be randomized?" (i.e. within what range can all
>   possible stack offsets be?)
> 
> and
> 
> - "is the randomization predictable?" (i.e. is the distribution of
>   selected positions with the above range evenly distributed?)
> 
> Commit 9c573cd31343 ("randomize_kstack: Improve entropy diffusion") was
> trying to improve the latter, but accidentally also grew the former.
> This patch is just trying to clean all this up now.
> 
> Thanks for testing! And I'm curious as to why arm64's stack offset
> entropy is 7 for you when we're expecting it to be 6. Anyway, that's not
> a problem I don't think. Just a greater offset range than expected.

Hmm....

I think this is due to the way the compiler aligns the stack in alloca(); it
rounds up the value of KSTACK_OFFSET_MAX(offset) and ends up spilling over an
additional bit (e.g. 0x3f1 to 0x3ff round up to 0x400).

Looking at v6.10-rc4 defconfig + CONFIG_RANDOMIZE_STACKOFFSET=y, the
disassembly for arm64's invoke_syscall() looks like:

	// offset = raw_cpu_read(kstack_offset)
	mov     x4, sp
	adrp    x0, kstack_offset
	mrs     x5, tpidr_el1
	add     x0, x0, #:lo12:kstack_offset
	ldr     w0, [x0, x5]

	// offset = KSTACK_OFFSET_MAX(offset)
	and     x0, x0, #0x3ff

	// alloca(offset)
	add     x0, x0, #0xf
	and     x0, x0, #0x7f0
	sub     sp, x4, x0

... which in C would be:

	offset = raw_cpu_read(kstack_offset)
	offset &= 0x3ff;			// [0x0, 0x3ff]
	offset += 0xf;				// [0xf, 0x40e]
	offset &= 0x7f0;			// [0x0,

... so when *all* bits [3:0] are 0, they'll have no impact, and when *any* of
bits [3:0] are 1 they'll trigger a carry into bit 4, which could ripple all the
way up and spill into bit 10.

I have no idea whether that's important. Kees, does that introduce a bias, and
if so do we need to care?

If I change the mask to discard the low bits:

	#define KSTACK_OFFSET_MAX(x)   ((x) & 0x3F0)

... then the assembly avoids the rounding:

	mov     x4, sp
	adrp    x0, 0 <kstack_offset>
	mrs     x5, tpidr_el1
	add     x0, x0, #:lo12:kstack_offset
	ldr     w0, [x0, x5]
	and     x0, x0, #0x3f0
	sub     sp, x4, x0

Mark.
