Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE9F2F7445;
	Fri, 10 Apr 2026 09:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775813877; cv=none; b=Nu+Y14keDsKxndDL4Dkk6zqScUE6OQqQZR8TlKJH2aUFEJp5hqgUtSOw9G06kcyPGNnBT1W3JvAlNzz1d1EOaIs3qtGsv+FdCsa9aU22oRU6+SNUwbnWPBKTBeq2XzVVaonjGBQp3hygda+tDw0gfG88TeJYNxVbKbBBAVdqKbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775813877; c=relaxed/simple;
	bh=SmJwPkp0nb0Ve3Bz5iCXglHNYcVEz5wLti0b0rFKeWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCfINdeZ27kxybHJkOoFVnJABA3kmFZ2i3sPK1NeC/i64o40FWUd9WygUeqdwNwuRsJVqpJsZ59P0VaNz6MImHP736yFkw3KezvUlHbnAIbmfjDNAD5csTl+CPthG7iq+mhg015FJdAO/p+Xiy04SGu868C9/N3ljU0tYXIWJ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PUJ88Z+u; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PUJ88Z+u"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 425421D13;
	Fri, 10 Apr 2026 02:37:48 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0DF23F632;
	Fri, 10 Apr 2026 02:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775813873; bh=SmJwPkp0nb0Ve3Bz5iCXglHNYcVEz5wLti0b0rFKeWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PUJ88Z+upicQXln8DFiBGfr96f2uBf2ASbYsH8rM72E+kuoFdvMKH8bmio9mMf+wb
	 j+mfu+vJDOcyJELgIoXve3XDH3vaB3z32C0emUTZgdFAbaHMq8yuRQbb8rDHnpvndX
	 V6i42ghipdzWWaTAT1RnY+E1nPwJ++8YUgVHWHM4=
Date: Fri, 10 Apr 2026 10:37:45 +0100
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
Message-ID: <adjE6WzFM7NogzlU@arm.com>
References: <20260402112250.2138-1-kprateek.nayak@amd.com>
 <20260402112250.2138-3-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402112250.2138-3-kprateek.nayak@amd.com>

On Thu, Apr 02, 2026 at 11:22:45AM +0000, K Prateek Nayak wrote:
> diff --git a/arch/arm64/include/asm/runtime-const.h b/arch/arm64/include/asm/runtime-const.h
> index c3dbd3ae68f6..a3106f80912b 100644
> --- a/arch/arm64/include/asm/runtime-const.h
> +++ b/arch/arm64/include/asm/runtime-const.h
> @@ -7,6 +7,7 @@
>  #endif
>  
>  #include <asm/cacheflush.h>
> +#include <asm/text-patching.h>
>  
>  /* Sigh. You can still run arm64 in BE mode */
>  #include <asm/byteorder.h>
> @@ -50,13 +51,7 @@ static inline void __runtime_fixup_16(__le32 *p, unsigned int val)
>  	u32 insn = le32_to_cpu(*p);
>  	insn &= 0xffe0001f;
>  	insn |= (val & 0xffff) << 5;
> -	*p = cpu_to_le32(insn);
> -}
> -
> -static inline void __runtime_fixup_caches(void *where, unsigned int insns)
> -{
> -	unsigned long va = (unsigned long)where;
> -	caches_clean_inval_pou(va, va + 4*insns);
> +	aarch64_insn_patch_text_nosync(p, insn);
>  }

Sashiko has some good points here:

https://sashiko.dev/#/patchset/20260402112250.2138-1-kprateek.nayak@amd.com

In short, aarch64_insn_patch_text_nosync() does not expect a linear map
address but rather a kernel text one (or vmalloc/modules). The other
valid point is on aliasing I-caches.

I think dropping the lm_alias() and just use 'where' directly would do
but I haven't tried.

-- 
Catalin
