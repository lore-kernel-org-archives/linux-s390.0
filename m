Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:47808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgDASz1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 1 Apr 2020 14:55:27 -0400
Subject: Re: [PATCH v2 4/4] hugetlbfs: clean up command line processing
References: <20200401183819.20647-1-mike.kravetz@oracle.com>
 <20200401183819.20647-5-mike.kravetz@oracle.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a80f530d-e803-3952-e714-705a8589f50a@infradead.org>
Date: Wed, 1 Apr 2020 11:55:01 -0700
MIME-Version: 1.0
In-Reply-To: <20200401183819.20647-5-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Longpeng <longpeng2@huawei.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Mina Almasry <almasrymina@google.com>, Andrew Morton <akpm@linux-foundation.org>

On 4/1/20 11:38 AM, Mike Kravetz wrote:
> With all hugetlb page processing done in a single file clean up code.
> - Make code match desired semantics
>   - Update documentation with semantics
> - Make all warnings and errors messages start with 'HugeTLB:'.
> - Consistently name command line parsing routines.
> - Check for hugepages_supported() before processing parameters.
> - Add comments to code
>   - Describe some of the subtle interactions
>   - Describe semantics of command line arguments
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---

Hi Mike,
One nit, please see below:

>  .../admin-guide/kernel-parameters.txt         | 35 ++++---
>  Documentation/admin-guide/mm/hugetlbpage.rst  | 44 +++++++++
>  mm/hugetlb.c                                  | 96 +++++++++++++++----
>  3 files changed, 142 insertions(+), 33 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 1bd5454b5e5f..de653cfe1726 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -832,12 +832,15 @@
>  			See also Documentation/networking/decnet.txt.
>  
>  	default_hugepagesz=
> -			[same as hugepagesz=] The size of the default
> -			HugeTLB page size. This is the size represented by
> -			the legacy /proc/ hugepages APIs, used for SHM, and
> -			default size when mounting hugetlbfs filesystems.
> -			Defaults to the default architecture's huge page size
> -			if not specified.
> +			[HW] The size of the default HugeTLB page size. This

			Drop one "size" above?

> +			is the size represented by the legacy /proc/ hugepages
> +			APIs.  In addition, this is the default hugetlb size
> +			used for shmget(), mmap() and mounting hugetlbfs
> +			filesystems.  If not specified, defaults to the
> +			architecture's default huge page size.  Huge page
> +			sizes are architecture dependent.  See also
> +			Documentation/admin-guide/mm/hugetlbpage.rst.
> +			Format: size[KMG]



-- 
~Randy
