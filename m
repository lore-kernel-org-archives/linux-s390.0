Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E20453A7
	for <linux-s390@vger.kernel.org>; Wed,  3 Apr 2024 18:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712169151; cv=none; b=SpDK8bapnD7Y3OKP3TmXhhy6Oj319wzxSiyRiOZNJ38fgoKTGcmoeIdFkNZg7tRSHHMDQuBAZLqpsxqVC9Ns4EMOhUPY9XdY1+oYiW8p/6Jpsfguuoi/T6D0RhKMUEv4PX2QJs6U5Wwwsvd39h7uMQdymbVrlqgntXegPhLIvMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712169151; c=relaxed/simple;
	bh=oyirPimBJOA8FFF3zedLDMmcJbW6rsNP/gocNStF39o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ON+Gw6rqDz1N2ugu5DaPl8UlYlJ8jx9vH1RZP6pxrCfz3DvFLKBntdEUn4rDU3Zzisb17MXlfrzrF6aJMlw8B4zGYENV3eQJ3y2Ic9m3CL+rKs++vNavUN380X6kffgy5zR7Dlv8UShokBpzH87k9ELFz2C00kqzwSkgs3FtGtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881B8C433C7;
	Wed,  3 Apr 2024 18:32:27 +0000 (UTC)
Date: Wed, 3 Apr 2024 19:32:25 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: akpm@linux-foundation.org, Russell King <linux@armlinux.org.uk>,
	Will Deacon <will@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	surenb@google.com
Subject: Re: [PATCH 2/7] arm64: mm: accelerate pagefault when
 VM_FAULT_BADACCESS
Message-ID: <Zg2guRk4hTIdf_Tm@arm.com>
References: <20240402075142.196265-1-wangkefeng.wang@huawei.com>
 <20240402075142.196265-3-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402075142.196265-3-wangkefeng.wang@huawei.com>

On Tue, Apr 02, 2024 at 03:51:37PM +0800, Kefeng Wang wrote:
> The vm_flags of vma already checked under per-VMA lock, if it is a
> bad access, directly set fault to VM_FAULT_BADACCESS and handle error,
> no need to lock_mm_and_find_vma() and check vm_flags again, the latency
> time reduce 34% in lmbench 'lat_sig -P 1 prot lat_sig'.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arm64/mm/fault.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 9bb9f395351a..405f9aa831bd 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -572,7 +572,9 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>  
>  	if (!(vma->vm_flags & vm_flags)) {
>  		vma_end_read(vma);
> -		goto lock_mmap;
> +		fault = VM_FAULT_BADACCESS;
> +		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
> +		goto done;
>  	}
>  	fault = handle_mm_fault(vma, addr, mm_flags | FAULT_FLAG_VMA_LOCK, regs);
>  	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))

I think this makes sense. A concurrent modification of vma->vm_flags
(e.g. mprotect()) would do a vma_start_write(), so no need to recheck
again with the mmap lock held.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
