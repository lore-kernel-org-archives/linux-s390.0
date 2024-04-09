Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAF51EA90
	for <linux-s390@vger.kernel.org>; Tue,  9 Apr 2024 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712653017; cv=none; b=XFzyNi1Z5WtBVOVynYpFbw4a7ymCRjjnsxemjg4fz6XCUXRQJFU+DNkjT/6MjpTkJ6O5OhXYEodpS6Pcy0av0lZf5FVc3R6RJjOUiknu4e5lqo6wCDME9QqDi0/jcqBx93qSUQjF99S3HEI08FN4Yn1nIVw0kkQt2aRqbn6ootI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712653017; c=relaxed/simple;
	bh=QLJUCNWHDBqU7BMUyIsvvUvi46+KcCuF+2GXinRrpDM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kdb3h+6NLQSELrP1gkileff8UIbqR3NR+A5z2+kTLrRFFHM9I9aOOnghErCdpnswoPo7Qrxy+c6vW/K39BPfHwl0K2FNd87f7bC7ebg7Uepm5r3N4hQV8ULjHTZueY/FAHFYiwCc6e1QHoEW5ThIYtFLtr1BATCPjtuxUCXOyKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=msOkz6Vj; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="msOkz6Vj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1712653012;
	bh=rA9AK049F3IGs47StGGKCr+FtqU4g3CoryIwwmMomeM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=msOkz6VjlCQK6oln6GUJUGTDCSBfzOeZfQi9EsVwNoLRa5ix9kExqStoAQ5AprBqk
	 34LTS1WhqXj3hftPvoUBI1x1Zp/u3pVOJDpZPQbXLnKGX2vomfk1kAqaFpQo8cRhPE
	 stQOnXX7nAI0w9OrzO3M5ey4vEF08V5p2tARnvjjWvFF+jrya8UqrwRzTnxYKU7da3
	 Rm2vrdr/se1lJ6uQvcH5wFGlTbFEnrSPqjZu0rfJ3o8U7jBvaQRGYxGwYHE5cunhCX
	 lCI7cehVn6h6m3BvJLCepBZ4OYS8I/Nfcl0L6KVmZN5ybtAGzhS1vIWQB5uyF52/bT
	 a76+x/QpVimEA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VDKZp4Mb0z4wnr;
	Tue,  9 Apr 2024 18:56:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kefeng Wang <wangkefeng.wang@huawei.com>, akpm@linux-foundation.org
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 surenb@google.com, linux-mm@kvack.org, Kefeng Wang
 <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2 4/7] powerpc: mm: accelerate pagefault when badaccess
In-Reply-To: <20240403083805.1818160-5-wangkefeng.wang@huawei.com>
References: <20240403083805.1818160-1-wangkefeng.wang@huawei.com>
 <20240403083805.1818160-5-wangkefeng.wang@huawei.com>
Date: Tue, 09 Apr 2024 18:56:49 +1000
Message-ID: <871q7ec3se.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kefeng Wang <wangkefeng.wang@huawei.com> writes:
> The access_[pkey]_error() of vma already checked under per-VMA lock, if
> it is a bad access, directly handle error, no need to retry with mmap_lock
> again. In order to release the correct lock, pass the mm_struct into
> bad_access_pkey()/bad_access(), if mm is NULL, release vma lock, or
> release mmap_lock. Since the page faut is handled under per-VMA lock,
> count it as a vma lock event with VMA_LOCK_SUCCESS.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/powerpc/mm/fault.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)

I thought there might be a nicer way to do this, plumbing the mm and vma
down through all those levels is a bit of a pain (vma->vm_mm exists
after all).

But I couldn't come up with anything obviously better, without doing
lots of refactoring first, which would be a pain to integrate into this
series.

So anyway, if the series goes ahead:

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 53335ae21a40..215690452495 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -71,23 +71,26 @@ static noinline int bad_area_nosemaphore(struct pt_regs *regs, unsigned long add
>  	return __bad_area_nosemaphore(regs, address, SEGV_MAPERR);
>  }
>  
> -static int __bad_area(struct pt_regs *regs, unsigned long address, int si_code)
> +static int __bad_area(struct pt_regs *regs, unsigned long address, int si_code,
> +		      struct mm_struct *mm, struct vm_area_struct *vma)
>  {
> -	struct mm_struct *mm = current->mm;
>  
>  	/*
>  	 * Something tried to access memory that isn't in our memory map..
>  	 * Fix it, but check if it's kernel or user first..
>  	 */
> -	mmap_read_unlock(mm);
> +	if (mm)
> +		mmap_read_unlock(mm);
> +	else
> +		vma_end_read(vma);
>  
>  	return __bad_area_nosemaphore(regs, address, si_code);
>  }
>  
>  static noinline int bad_access_pkey(struct pt_regs *regs, unsigned long address,
> +				    struct mm_struct *mm,
>  				    struct vm_area_struct *vma)
>  {
> -	struct mm_struct *mm = current->mm;
>  	int pkey;
>  
>  	/*
> @@ -109,7 +112,10 @@ static noinline int bad_access_pkey(struct pt_regs *regs, unsigned long address,
>  	 */
>  	pkey = vma_pkey(vma);
>  
> -	mmap_read_unlock(mm);
> +	if (mm)
> +		mmap_read_unlock(mm);
> +	else
> +		vma_end_read(vma);
>  
>  	/*
>  	 * If we are in kernel mode, bail out with a SEGV, this will
> @@ -124,9 +130,10 @@ static noinline int bad_access_pkey(struct pt_regs *regs, unsigned long address,
>  	return 0;
>  }
>  
> -static noinline int bad_access(struct pt_regs *regs, unsigned long address)
> +static noinline int bad_access(struct pt_regs *regs, unsigned long address,
> +			       struct mm_struct *mm, struct vm_area_struct *vma)
>  {
> -	return __bad_area(regs, address, SEGV_ACCERR);
> +	return __bad_area(regs, address, SEGV_ACCERR, mm, vma);
>  }
>  
>  static int do_sigbus(struct pt_regs *regs, unsigned long address,
> @@ -479,13 +486,13 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
>  
>  	if (unlikely(access_pkey_error(is_write, is_exec,
>  				       (error_code & DSISR_KEYFAULT), vma))) {
> -		vma_end_read(vma);
> -		goto lock_mmap;
> +		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> +		return bad_access_pkey(regs, address, NULL, vma);
>  	}
>  
>  	if (unlikely(access_error(is_write, is_exec, vma))) {
> -		vma_end_read(vma);
> -		goto lock_mmap;
> +		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> +		return bad_access(regs, address, NULL, vma);
>  	}
>  
>  	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);
> @@ -521,10 +528,10 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
>  
>  	if (unlikely(access_pkey_error(is_write, is_exec,
>  				       (error_code & DSISR_KEYFAULT), vma)))
> -		return bad_access_pkey(regs, address, vma);
> +		return bad_access_pkey(regs, address, mm, vma);
>  
>  	if (unlikely(access_error(is_write, is_exec, vma)))
> -		return bad_access(regs, address);
> +		return bad_access(regs, address, mm, vma);
>  
>  	/*
>  	 * If for any reason at all we couldn't handle the fault,
> -- 
> 2.27.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
