Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E957522156C;
	Mon, 13 Apr 2026 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776078073; cv=none; b=EYcpClWenur3saZrqZ3poIprpuc2Nwm80d6I9+lEBlHr54JH8mKQ6OcOFTS+LXDXFXXgw4YThjsyaQMV3nNQqjlYzEa2VscpsEUPZiYMAfiSXGwf9fjnMCW3BiOYNjspJyhNMa3HCR7gmpxE3gITSXOoYLhVktnzZx6MF76QJ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776078073; c=relaxed/simple;
	bh=P5560RAnvZN21+y42j1UNU3zw/F77/WG44SpxSSnyqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOCYSUWQaIStzXWImb3Ty2Ojair6inAJYce7lzeJDHFAIqQ3xYeLAUQdOWknfu5axvHhs7XDCi6Ecv1GZaJL9ml812rPPS4e3S6gZJ2QHxXKKLMRRRJP/kBgnUM72dWHaA/9pTIwGy3Oqsqd/628zaVSvYUb57C+Of6nuYbSPf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NgLb3FOb; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NgLb3FOb"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8493C3581;
	Mon, 13 Apr 2026 04:01:05 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BACD83F641;
	Mon, 13 Apr 2026 04:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776078071; bh=P5560RAnvZN21+y42j1UNU3zw/F77/WG44SpxSSnyqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NgLb3FObr2jCRDXSLm8COFWaQdrrXHeryVHOrr+La3FNXGfYu/NTKqn8Qwma5HnOj
	 jPUSYrOfKWA6U4R1W121xjN1n7pfjokpsNwPc6rXIbPZf7zgREg5R3M/N35h90VOP/
	 zt8JyZ/FWVvEXZhvjQy9D8u/7u8vulPNvFJcA5CA=
Date: Mon, 13 Apr 2026 12:01:05 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Will Deacon <will@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH v3 2/7] arm64/runtime-const: Use
 aarch64_insn_patch_text_nosync() for patching
Message-ID: <adzM8RtjbOy0kLOC@arm.com>
References: <20260402112250.2138-1-kprateek.nayak@amd.com>
 <20260402112250.2138-3-kprateek.nayak@amd.com>
 <adjE6WzFM7NogzlU@arm.com>
 <c45ede13-f8d0-4b6a-b2ed-f06af4882ebc@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c45ede13-f8d0-4b6a-b2ed-f06af4882ebc@amd.com>

On Sun, Apr 12, 2026 at 01:24:45AM +0530, K Prateek Nayak wrote:
> On 4/10/2026 3:07 PM, Catalin Marinas wrote:
> > https://sashiko.dev/#/patchset/20260402112250.2138-1-kprateek.nayak@amd.com
> > 
> > In short, aarch64_insn_patch_text_nosync() does not expect a linear map
> > address but rather a kernel text one (or vmalloc/modules). The other
> > valid point is on aliasing I-caches.
> > 
> > I think dropping the lm_alias() and just use 'where' directly would do
> > but I haven't tried.
> 
> Ack! I completely missed that subtlety of passing "where" to
> caches_clean_inval_pou(). I'm still surprised that it didn't
> blow up in my testing.

For the first part (passing a linear map address), I suspect we get away
with this in vmalloc_to_page() as it just walks the page tables and
VIRTUAL_BUG_ON() is a no-op with defconfig.

For the I-cache aliasing, you may not have the right hardware but even
if you did, it's harder to hit.

> Anyhow, following diff, on top of the full series builds and
> tests fine and has been blessed by review-prompts:
> 
> diff --git a/arch/arm64/include/asm/runtime-const.h b/arch/arm64/include/asm/runtime-const.h
> index 21f817eb5951..d3f0dfa7ced0 100644
> --- a/arch/arm64/include/asm/runtime-const.h
> +++ b/arch/arm64/include/asm/runtime-const.h
> @@ -57,21 +57,21 @@
>  } while (0)
>  
>  /* 16-bit immediate for wide move (movz and movk) in bits 5..20 */
> -static inline void __runtime_fixup_16(__le32 *p, unsigned int val)
> +static inline void __runtime_fixup_16(void *where, unsigned int val)
>  {
> +	__le32 *p = lm_alias(where);
>  	u32 insn = le32_to_cpu(*p);
>  	insn &= 0xffe0001f;
>  	insn |= (val & 0xffff) << 5;
> -	aarch64_insn_patch_text_nosync(p, insn);
> +	aarch64_insn_patch_text_nosync(where, insn);
>  }

You might as well keep the __le32 *p argument and just dereference it
directly, no need for lm_alias(). The kernel text is readable and you
avoid having to change all the other functions.

>  static inline void __runtime_fixup_ptr(void *where, unsigned long val)
>  {
> -	__le32 *p = lm_alias(where);
> -	__runtime_fixup_16(p, val);
> -	__runtime_fixup_16(p+1, val >> 16);
> -	__runtime_fixup_16(p+2, val >> 32);
> -	__runtime_fixup_16(p+3, val >> 48);
> +	__runtime_fixup_16(where, val);
> +	__runtime_fixup_16(where + 4, val >> 16);
> +	__runtime_fixup_16(where + 8, val >> 32);
> +	__runtime_fixup_16(where + 12, val >> 48);
>  }

And here change the argument to '__le32 *p' (and in other places where
you changed p to where + 4 etc.).

-- 
Catalin
