Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:50512 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgCRWjt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 18 Mar 2020 18:39:49 -0400
Subject: Re: [PATCH 1/4] hugetlbfs: add arch_hugetlb_valid_size
References: <20200318220634.32100-1-mike.kravetz@oracle.com>
 <20200318220634.32100-2-mike.kravetz@oracle.com>
 <20200318220954.GD8477@willie-the-truck>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <43735ae0-f5f6-1e7b-2d0f-a46f9af1627e@oracle.com>
Date: Wed, 18 Mar 2020 15:38:53 -0700
MIME-Version: 1.0
In-Reply-To: <20200318220954.GD8477@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "David S.Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Longpeng <longpeng2@huawei.com>, Andrew Morton <akpm@linux-foundation.org>

On 3/18/20 3:09 PM, Will Deacon wrote:
> On Wed, Mar 18, 2020 at 03:06:31PM -0700, Mike Kravetz wrote:
>> The architecture independent routine hugetlb_default_setup sets up
>> the default huge pages size.  It has no way to verify if the passed
>> value is valid, so it accepts it and attempts to validate at a later
>> time.  This requires undocumented cooperation between the arch specific
>> and arch independent code.
>>
>> For architectures that support more than one huge page size, provide
>> a routine arch_hugetlb_valid_size to validate a huge page size.
>> hugetlb_default_setup can use this to validate passed values.
>>
>> arch_hugetlb_valid_size will also be used in a subsequent patch to
>> move processing of the "hugepagesz=" in arch specific code to a common
>> routine in arch independent code.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  arch/arm64/include/asm/hugetlb.h   |  2 ++
>>  arch/arm64/mm/hugetlbpage.c        | 19 ++++++++++++++-----
>>  arch/powerpc/include/asm/hugetlb.h |  3 +++
>>  arch/powerpc/mm/hugetlbpage.c      | 20 +++++++++++++-------
>>  arch/riscv/include/asm/hugetlb.h   |  3 +++
>>  arch/riscv/mm/hugetlbpage.c        | 28 ++++++++++++++++++----------
>>  arch/s390/include/asm/hugetlb.h    |  3 +++
>>  arch/s390/mm/hugetlbpage.c         | 18 +++++++++++++-----
>>  arch/sparc/include/asm/hugetlb.h   |  3 +++
>>  arch/sparc/mm/init_64.c            | 23 ++++++++++++++++-------
>>  arch/x86/include/asm/hugetlb.h     |  3 +++
>>  arch/x86/mm/hugetlbpage.c          | 21 +++++++++++++++------
>>  include/linux/hugetlb.h            |  7 +++++++
>>  mm/hugetlb.c                       | 16 +++++++++++++---
>>  14 files changed, 126 insertions(+), 43 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
>> index 2eb6c234d594..3248f35213ee 100644
>> --- a/arch/arm64/include/asm/hugetlb.h
>> +++ b/arch/arm64/include/asm/hugetlb.h
<snip>
>> +
>> +static __init int setup_hugepagesz(char *opt)
>> +{
>> +	unsigned long long ps = memparse(opt, &opt);
>> +
>> +	if arch_hugetlb_valid_size(ps)) {
> 
> Please compile your changes if you're touching multiple architectures. You
> can get cross-compiler binaries from:
> 

My apologies.  I only cross compiled the result of the series on each
architecture.  The above code is obviously bad.

-- 
Mike Kravetz
