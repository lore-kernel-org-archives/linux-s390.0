Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726178AbgD0FEt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 27 Apr 2020 01:04:49 -0400
Subject: Re: [PATCH v3 2/4] hugetlbfs: move hugepagesz= parsing to arch
 independent code
References: <20200417185049.275845-1-mike.kravetz@oracle.com>
 <20200417185049.275845-3-mike.kravetz@oracle.com>
From: Sandipan Das <sandipan.osd@gmail.com>
Message-ID: <7583dfcc-62d8-2a54-6eef-bcb4e01129b3@gmail.com>
Date: Mon, 27 Apr 2020 10:34:36 +0530
MIME-Version: 1.0
In-Reply-To: <20200417185049.275845-3-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Longpeng <longpeng2@huawei.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Randy Dunlap <rdunlap@infradead.org>, Mina Almasry <almasrymina@google.com>, Peter Xu <peterx@redhat.com>, Nitesh Narayan Lal <nitesh@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

Hi Mike,

On 18/04/20 12:20 am, Mike Kravetz wrote:
> Now that architectures provide arch_hugetlb_valid_size(), parsing
> of "hugepagesz=" can be done in architecture independent code.
> Create a single routine to handle hugepagesz= parsing and remove
> all arch specific routines.  We can also remove the interface
> hugetlb_bad_size() as this is no longer used outside arch independent
> code.
> 
> This also provides consistent behavior of hugetlbfs command line
> options.  The hugepagesz= option should only be specified once for
> a specific size, but some architectures allow multiple instances.
> This appears to be more of an oversight when code was added by some
> architectures to set up ALL huge pages sizes.
> 
> [...]
> 
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index de54d2a37830..2c3fa0a7787b 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -589,21 +589,6 @@ static int __init add_huge_page_size(unsigned long long size)
>  	return 0;
>  }
>  
> -static int __init hugepage_setup_sz(char *str)
> -{
> -	unsigned long long size;
> -
> -	size = memparse(str, &str);
> -
> -	if (add_huge_page_size(size) != 0) {
> -		hugetlb_bad_size();
> -		pr_err("Invalid huge page size specified(%llu)\n", size);
> -	}
> -
> -	return 1;
> -}
> -__setup("hugepagesz=", hugepage_setup_sz);
> -
> [...]

This isn't working as expected on powerpc64.

  [    0.000000] Kernel command line: root=UUID=dc7b49cf-95a2-4996-8e7d-7c64ddc7a6ff hugepagesz=16G hugepages=2 
  [    0.000000] HugeTLB: huge pages not supported, ignoring hugepagesz = 16G
  [    0.000000] HugeTLB: huge pages not supported, ignoring hugepages = 2
  [    0.284177] HugeTLB registered 16.0 MiB page size, pre-allocated 0 pages
  [    0.284182] HugeTLB registered 16.0 GiB page size, pre-allocated 0 pages
  [    2.585062]     hugepagesz=16G
  [    2.585063]     hugepages=2

The "huge pages not supported" messages are under a !hugepages_supported()
condition which checks if HPAGE_SHIFT is non-zero. On powerpc64, HPAGE_SHIFT
comes from the hpage_shift variable. At this point, it is still zero and yet
to be set. Hence the check fails. The reason being hugetlbpage_init_default(),
which sets hpage_shift, it now called after hugepage_setup_sz().


- Sandipan
