Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41414 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726657AbgIAGXc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Sep 2020 02:23:32 -0400
Subject: Re: [PATCH v3 06/13] mm/debug_vm_pgtable/THP: Mark the pte entry huge
 before using set_pmd/pud_at
References: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
 <20200827080438.315345-7-aneesh.kumar@linux.ibm.com>
 <37558832-9cb6-9a11-0009-e268ad51c1f3@arm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <60857a9f-0df2-ff19-d857-8e8582e85099@linux.ibm.com>
Date: Tue, 1 Sep 2020 11:53:02 +0530
MIME-Version: 1.0
In-Reply-To: <37558832-9cb6-9a11-0009-e268ad51c1f3@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org, akpm@linux-foundation.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org, x86@kernel.org, linux-arch@vger.kernel.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Vineet Gupta <vgupta@synopsys.com>, Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>

On 9/1/20 8:51 AM, Anshuman Khandual wrote:
> 
> 
> On 08/27/2020 01:34 PM, Aneesh Kumar K.V wrote:
>> kernel expects entries to be marked huge before we use set_pmd_at()/set_pud_at().
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>   mm/debug_vm_pgtable.c | 21 ++++++++++++---------
>>   1 file changed, 12 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>> index 5c0680836fe9..de83a20c1b30 100644
>> --- a/mm/debug_vm_pgtable.c
>> +++ b/mm/debug_vm_pgtable.c
>> @@ -155,7 +155,7 @@ static void __init pmd_advanced_tests(struct mm_struct *mm,
>>   				      unsigned long pfn, unsigned long vaddr,
>>   				      pgprot_t prot)
>>   {
>> -	pmd_t pmd = pfn_pmd(pfn, prot);
>> +	pmd_t pmd;
>>   
>>   	if (!has_transparent_hugepage())
>>   		return;
>> @@ -164,19 +164,19 @@ static void __init pmd_advanced_tests(struct mm_struct *mm,
>>   	/* Align the address wrt HPAGE_PMD_SIZE */
>>   	vaddr = (vaddr & HPAGE_PMD_MASK) + HPAGE_PMD_SIZE;
>>   
>> -	pmd = pfn_pmd(pfn, prot);
>> +	pmd = pmd_mkhuge(pfn_pmd(pfn, prot));
>>   	set_pmd_at(mm, vaddr, pmdp, pmd);
>>   	pmdp_set_wrprotect(mm, vaddr, pmdp);
>>   	pmd = READ_ONCE(*pmdp);
>>   	WARN_ON(pmd_write(pmd));
>>   
>> -	pmd = pfn_pmd(pfn, prot);
>> +	pmd = pmd_mkhuge(pfn_pmd(pfn, prot));
>>   	set_pmd_at(mm, vaddr, pmdp, pmd);
>>   	pmdp_huge_get_and_clear(mm, vaddr, pmdp);
>>   	pmd = READ_ONCE(*pmdp);
>>   	WARN_ON(!pmd_none(pmd));
>>   
>> -	pmd = pfn_pmd(pfn, prot);
>> +	pmd = pmd_mkhuge(pfn_pmd(pfn, prot));
>>   	pmd = pmd_wrprotect(pmd);
>>   	pmd = pmd_mkclean(pmd);
>>   	set_pmd_at(mm, vaddr, pmdp, pmd);
>> @@ -237,7 +237,7 @@ static void __init pmd_huge_tests(pmd_t *pmdp, unsigned long pfn, pgprot_t prot)
>>   
>>   static void __init pmd_savedwrite_tests(unsigned long pfn, pgprot_t prot)
>>   {
>> -	pmd_t pmd = pfn_pmd(pfn, prot);
>> +	pmd_t pmd = pmd_mkhuge(pfn_pmd(pfn, prot));
> 
> There is no set_pmd_at() in this particular test, why change ?


because if you are building a hugepage you should use pmd_mkhuge(). That 
is what is setting _PAGE_PTE with this series. We don't make pfn_pmd set 
_PAGE_PTE


-aneesh
