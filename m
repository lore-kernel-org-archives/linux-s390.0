Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00BB3D6B;
	Wed,  4 Sep 2024 04:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725423242; cv=none; b=VzxKpdsBIbZOJUnyC9kHqM38CBKHeLm1jAis/mZEKb67iU8jYglnxoOnK+QqWFKD+67gfrnE/kSHgpVRaTMPxQ4xtvOqzvl82f20YmueQArOdO80ZQXYkhusGYHG/81NogTmHpdqt3d8Oq+l0CL2mxRbx/ogrOGOsZvMhfa/mr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725423242; c=relaxed/simple;
	bh=BLJDIM+UhFjsEpA2gm+jsKfoSlgXOmwgzm0WXa5YV/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=itL54jqwsB48te3WRGyqZSmCgt131o370ekvM8IRESaRIShNtkfkX9nUNy2+ZoJzmJ4msoEfeWFxKrkFSH3AK11Xm/y2oku/jxDBmOpOMU2AoZTzeuFjKRu5mM/2c4ARQFO6jhFLqbXd2yeReW5Y7jiyXblNwaHe0hvFbzq6aQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=Atgw5p+o; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Atgw5p+o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1725423237;
	bh=eMgOBDwTX8trwBbhMUy1qHUpMDhdRlVDIssPJb8Gsmo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Atgw5p+ous8ponaujRBR9zeHm87YGXlWFJw/APeKvwTJfN+vDA+MA/XCf729+PnVA
	 yIoWrvR8Tg01Q4kTrqjbf+6l9UmkC2+E2eKeM0lpnBzHzQLZr6WfUF+RwlGDv9na7Y
	 VJ6SDLZrN5hF4Pw9qE+168Zj3QWww8gocoC1nJ966vxltqaxwrFOfSbul6kyFfi2d0
	 JlXz4kSSwijD4hHUrXsf8IlpvudZE3CIHAEjc3DtzlAKa/tvrIdpfiNxgF0xas/YL4
	 mHLB2qUie8SKPjqF5MpzhdViqlVcFcXog5f66aL4m0C5o/rSTOnJ5fJzWnRTdDtt9J
	 XaxynAPBdZR7w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wz8Hv4YYPz4wb7;
	Wed,  4 Sep 2024 14:13:47 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mark Brown <broonie@kernel.org>, Richard Henderson
 <richard.henderson@linaro.org>, Ivan Kokshaysky
 <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Vineet Gupta
 <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Guo Ren
 <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max
 Filippov <jcmvbkbc@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Deepak Gupta <debug@rivosinc.com>,
 linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 loongarch@lists.linux.dev, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org,
 Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] mm: Pass vm_flags to generic_get_unmapped_area()
In-Reply-To: <20240902-mm-generic-shadow-stack-guard-v1-2-9acda38b3dd3@kernel.org>
References: <20240902-mm-generic-shadow-stack-guard-v1-0-9acda38b3dd3@kernel.org>
 <20240902-mm-generic-shadow-stack-guard-v1-2-9acda38b3dd3@kernel.org>
Date: Wed, 04 Sep 2024 14:13:47 +1000
Message-ID: <87plpk5a4k.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Brown <broonie@kernel.org> writes:
> In preparation for using vm_flags to ensure guard pages for shadow stacks
> supply them as an argument to generic_get_unmapped_area(). The only user
> outside of the core code is the PowerPC book3s64 implementation which is
> trivially wrapping the generic implementation in the radix_enabled() case.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/powerpc/mm/book3s64/slice.c |  4 ++--
>  include/linux/sched/mm.h         |  4 ++--
>  mm/mmap.c                        | 10 ++++++----
>  3 files changed, 10 insertions(+), 8 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/arch/powerpc/mm/book3s64/slice.c b/arch/powerpc/mm/book3s64/slice.c
> index ada6bf896ef8..87307d0fc3b8 100644
> --- a/arch/powerpc/mm/book3s64/slice.c
> +++ b/arch/powerpc/mm/book3s64/slice.c
> @@ -641,7 +641,7 @@ unsigned long arch_get_unmapped_area(struct file *filp,
>  				     vm_flags_t vm_flags)
>  {
>  	if (radix_enabled())
> -		return generic_get_unmapped_area(filp, addr, len, pgoff, flags);
> +		return generic_get_unmapped_area(filp, addr, len, pgoff, flags, vm_flags);
>  
>  	return slice_get_unmapped_area(addr, len, flags,
>  				       mm_ctx_user_psize(&current->mm->context), 0);
> @@ -655,7 +655,7 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp,
>  					     vm_flags_t vm_flags)
>  {
>  	if (radix_enabled())
> -		return generic_get_unmapped_area_topdown(filp, addr0, len, pgoff, flags);
> +		return generic_get_unmapped_area_topdown(filp, addr0, len, pgoff, flags, vm_flags);
>  
>  	return slice_get_unmapped_area(addr0, len, flags,
>  				       mm_ctx_user_psize(&current->mm->context), 1);
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index c4d34abc45d4..07bb8d4181d7 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -204,11 +204,11 @@ unsigned long mm_get_unmapped_area_vmflags(struct mm_struct *mm,
>  unsigned long
>  generic_get_unmapped_area(struct file *filp, unsigned long addr,
>  			  unsigned long len, unsigned long pgoff,
> -			  unsigned long flags);
> +			  unsigned long flags, vm_flags_t vm_flags);
>  unsigned long
>  generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
>  				  unsigned long len, unsigned long pgoff,
> -				  unsigned long flags);
> +				  unsigned long flags, vm_flags_t vm_flags);
>  #else
>  static inline void arch_pick_mmap_layout(struct mm_struct *mm,
>  					 struct rlimit *rlim_stack) {}
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 7528146f886f..b06ba847c96e 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1789,7 +1789,7 @@ unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info)
>  unsigned long
>  generic_get_unmapped_area(struct file *filp, unsigned long addr,
>  			  unsigned long len, unsigned long pgoff,
> -			  unsigned long flags)
> +			  unsigned long flags, vm_flags_t vm_flags)
>  {
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma, *prev;
> @@ -1823,7 +1823,8 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
>  		       unsigned long len, unsigned long pgoff,
>  		       unsigned long flags, vm_flags_t vm_flags)
>  {
> -	return generic_get_unmapped_area(filp, addr, len, pgoff, flags);
> +	return generic_get_unmapped_area(filp, addr, len, pgoff, flags,
> +					 vm_flags);
>  }
>  #endif
>  
> @@ -1834,7 +1835,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
>  unsigned long
>  generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
>  				  unsigned long len, unsigned long pgoff,
> -				  unsigned long flags)
> +				  unsigned long flags, vm_flags_t vm_flags)
>  {
>  	struct vm_area_struct *vma, *prev;
>  	struct mm_struct *mm = current->mm;
> @@ -1887,7 +1888,8 @@ arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
>  			       unsigned long len, unsigned long pgoff,
>  			       unsigned long flags, vm_flags_t vm_flags)
>  {
> -	return generic_get_unmapped_area_topdown(filp, addr, len, pgoff, flags);
> +	return generic_get_unmapped_area_topdown(filp, addr, len, pgoff, flags,
> +						 vm_flags);
>  }
>  #endif
>  
>
> -- 
> 2.39.2
