Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20344 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726142AbgDJTQU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 Apr 2020 15:16:20 -0400
Received: by mail-qv1-f69.google.com with SMTP id v88so2390745qvv.6
        for <linux-s390@vger.kernel.org>; Fri, 10 Apr 2020 12:16:17 -0700 (PDT)
Date: Fri, 10 Apr 2020 15:16:13 -0400
From: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2 1/4] hugetlbfs: add arch_hugetlb_valid_size
Message-ID: <20200410191613.GD3172@xz-x1>
References: <20200401183819.20647-1-mike.kravetz@oracle.com>
 <20200401183819.20647-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200401183819.20647-2-mike.kravetz@oracle.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Longpeng <longpeng2@huawei.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Mina Almasry <almasrymina@google.com>, Andrew Morton <akpm@linux-foundation.org>

On Wed, Apr 01, 2020 at 11:38:16AM -0700, Mike Kravetz wrote:
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index 2eb6c234d594..81606223494f 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -59,6 +59,8 @@ extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
>  extern void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
>  				 pte_t *ptep, pte_t pte, unsigned long sz);
>  #define set_huge_swap_pte_at set_huge_swap_pte_at
> +bool __init arch_hugetlb_valid_size(unsigned long size);
> +#define arch_hugetlb_valid_size arch_hugetlb_valid_size

Sorry for chimming in late.

Since we're working on removing arch-dependent codes after all.. I'm
thinking whether we can define arch_hugetlb_valid_size() once in the
common header (e.g. linux/hugetlb.h), then in mm/hugetlb.c:

bool __init __attribute((weak)) arch_hugetlb_valid_size(unsigned long size)
{
	return size == HPAGE_SIZE;
}

We can simply redefine arch_hugetlb_valid_size() in arch specific C
files where we want to override the default.  Would that be slightly
cleaner?

Thanks,

-- 
Peter Xu
