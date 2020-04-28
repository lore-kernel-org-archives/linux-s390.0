Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] hugetlbfs: move hugepagesz= parsing to arch
 independent code
References: <20200417185049.275845-1-mike.kravetz@oracle.com>
 <20200417185049.275845-3-mike.kravetz@oracle.com>
 <7583dfcc-62d8-2a54-6eef-bcb4e01129b3@gmail.com>
 <5a380060-38db-b690-1003-678ca0f28f07@oracle.com>
 <b1f04f9f-fa46-c2a0-7693-4a0679d2a1ee@oracle.com>
From: Sandipan Das <sandipan@linux.ibm.com>
Message-ID: <9c82a0b1-db0e-9b34-88a1-bc810d6b5eec@linux.ibm.com>
Date: Tue, 28 Apr 2020 09:47:13 +0530
MIME-Version: 1.0
In-Reply-To: <b1f04f9f-fa46-c2a0-7693-4a0679d2a1ee@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "David S.Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Longpeng <longpeng2@huawei.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Randy Dunlap <rdunlap@infradead.org>, Mina Almasry <almasrymina@google.com>, Peter Xu <peterx@redhat.com>, Nitesh Narayan Lal <nitesh@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

Hi Mike,

On 28/04/20 12:39 am, Mike Kravetz wrote:
> On 4/27/20 10:25 AM, Mike Kravetz wrote:
>> On 4/26/20 10:04 PM, Sandipan Das wrote:
>>> On 18/04/20 12:20 am, Mike Kravetz wrote:
>>>> Now that architectures provide arch_hugetlb_valid_size(), parsing
>>>> of "hugepagesz=" can be done in architecture independent code.
>>>
>>> This isn't working as expected on powerpc64.
>>>
>>>   [    0.000000] Kernel command line: root=UUID=dc7b49cf-95a2-4996-8e7d-7c64ddc7a6ff hugepagesz=16G hugepages=2 
>>>   [    0.000000] HugeTLB: huge pages not supported, ignoring hugepagesz = 16G
>>>   [    0.000000] HugeTLB: huge pages not supported, ignoring hugepages = 2
>>>   [    0.284177] HugeTLB registered 16.0 MiB page size, pre-allocated 0 pages
>>>   [    0.284182] HugeTLB registered 16.0 GiB page size, pre-allocated 0 pages
>>>   [    2.585062]     hugepagesz=16G
>>>   [    2.585063]     hugepages=2
>>>
>>
>> In the new arch independent version of hugepages_setup, I added the following
>> code in patch 4 off this series:
>>
>>> +	if (!hugepages_supported()) {
>>> +		pr_warn("HugeTLB: huge pages not supported, ignoring hugepages = %s\n", s);
>>> +		return 0;
>>> +	}
>>> +
>>
>> The easy solution is to remove all the hugepages_supported() checks from
>> command line parsing routines and rely on the later check in hugetlb_init().
> 
> Here is a patch to address the issue.  Sorry, as my series breaks all hugetlb
> command line processing on powerpc.
> 
> Sandipan, can you test the following patch?
> 

The following patch does fix the issue. Thanks.

Tested-by: Sandipan Das <sandipan@linux.ibm.com>


> From 480fe2847361e2a85aeec1fb39fe643bb7100a07 Mon Sep 17 00:00:00 2001
> From: Mike Kravetz <mike.kravetz@oracle.com>
> Date: Mon, 27 Apr 2020 11:37:30 -0700
> Subject: [PATCH] hugetlbfs: fix changes to command line processing
> 
> Previously, a check for hugepages_supported was added before processing
> hugetlb command line parameters.  On some architectures such as powerpc,
> hugepages_supported() is not set to true until after command line
> processing.  Therefore, no hugetlb command line parameters would be
> accepted.
> 
> Remove the additional checks for hugepages_supported.  In hugetlb_init,
> print a warning if !hugepages_supported and command line parameters were
> specified.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 1075abdb5717..5548e8851b93 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3212,8 +3212,11 @@ static int __init hugetlb_init(void)
>  {
>  	int i;
>  
> -	if (!hugepages_supported())
> +	if (!hugepages_supported()) {
> +		if (hugetlb_max_hstate || default_hstate_max_huge_pages)
> +			pr_warn("HugeTLB: huge pages not supported, ignoring associated command-line parameters\n");
>  		return 0;
> +	}
>  
>  	/*
>  	 * Make sure HPAGE_SIZE (HUGETLB_PAGE_ORDER) hstate exists.  Some
> @@ -3315,11 +3318,6 @@ static int __init hugepages_setup(char *s)
>  	unsigned long *mhp;
>  	static unsigned long *last_mhp;
>  
> -	if (!hugepages_supported()) {
> -		pr_warn("HugeTLB: huge pages not supported, ignoring hugepages = %s\n", s);
> -		return 0;
> -	}
> -
>  	if (!parsed_valid_hugepagesz) {
>  		pr_warn("HugeTLB: hugepages=%s does not follow a valid hugepagesz, ignoring\n", s);
>  		parsed_valid_hugepagesz = true;
> @@ -3372,11 +3370,6 @@ static int __init hugepagesz_setup(char *s)
>  	struct hstate *h;
>  
>  	parsed_valid_hugepagesz = false;
> -	if (!hugepages_supported()) {
> -		pr_warn("HugeTLB: huge pages not supported, ignoring hugepagesz = %s\n", s);
> -		return 0;
> -	}
> -
>  	size = (unsigned long)memparse(s, NULL);
>  
>  	if (!arch_hugetlb_valid_size(size)) {
> @@ -3424,11 +3417,6 @@ static int __init default_hugepagesz_setup(char *s)
>  	unsigned long size;
>  
>  	parsed_valid_hugepagesz = false;
> -	if (!hugepages_supported()) {
> -		pr_warn("HugeTLB: huge pages not supported, ignoring default_hugepagesz = %s\n", s);
> -		return 0;
> -	}
> -
>  	if (parsed_default_hugepagesz) {
>  		pr_err("HugeTLB: default_hugepagesz previously specified, ignoring %s\n", s);
>  		return 0;
> 
