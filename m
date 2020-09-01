Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18218 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725848AbgIAJ66 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Sep 2020 05:58:58 -0400
Subject: Re: [PATCH v3 13/13] mm/debug_vm_pgtable: populate a pte entry before
 fetching it
References: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
 <20200827080438.315345-14-aneesh.kumar@linux.ibm.com>
 <edc68223-7f8a-13df-68eb-9682f585adb8@arm.com>
 <abef1791-8779-6b34-3178-3bf3ab36d42b@linux.ibm.com>
 <e3140b44-993e-aa4b-130d-ee2230eff2b5@arm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <7ef7c302-e7e6-570e-3100-5dd1bf9551be@linux.ibm.com>
Date: Tue, 1 Sep 2020 15:28:29 +0530
MIME-Version: 1.0
In-Reply-To: <e3140b44-993e-aa4b-130d-ee2230eff2b5@arm.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org, akpm@linux-foundation.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org, x86@kernel.org, linux-arch@vger.kernel.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Vineet Gupta <vgupta@synopsys.com>, Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>

On 9/1/20 1:08 PM, Anshuman Khandual wrote:
> 
> 
> On 09/01/2020 12:07 PM, Aneesh Kumar K.V wrote:
>> On 9/1/20 8:55 AM, Anshuman Khandual wrote:
>>>
>>>
>>> On 08/27/2020 01:34 PM, Aneesh Kumar K.V wrote:
>>>> pte_clear_tests operate on an existing pte entry. Make sure that is not a none
>>>> pte entry.
>>>>
>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>> ---
>>>>    mm/debug_vm_pgtable.c | 6 ++++--
>>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>>>> index 21329c7d672f..8527ebb75f2c 100644
>>>> --- a/mm/debug_vm_pgtable.c
>>>> +++ b/mm/debug_vm_pgtable.c
>>>> @@ -546,7 +546,7 @@ static void __init pgd_populate_tests(struct mm_struct *mm, pgd_t *pgdp,
>>>>    static void __init pte_clear_tests(struct mm_struct *mm, pte_t *ptep,
>>>>                       unsigned long vaddr)
>>>>    {
>>>> -    pte_t pte = ptep_get(ptep);
>>>> +    pte_t pte =  ptep_get_and_clear(mm, vaddr, ptep);
>>>
>>> Seems like ptep_get_and_clear() here just clears the entry in preparation
>>> for a following set_pte_at() which otherwise would have been a problem on
>>> ppc64 as you had pointed out earlier i.e set_pte_at() should not update an
>>> existing valid entry. So the commit message here is bit misleading.
>>>
>>
>> and also fetch the pte value which is used further.
>>
>>
>>>>          pr_debug("Validating PTE clear\n");
>>>>        pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
>>>> @@ -944,7 +944,7 @@ static int __init debug_vm_pgtable(void)
>>>>        p4d_t *p4dp, *saved_p4dp;
>>>>        pud_t *pudp, *saved_pudp;
>>>>        pmd_t *pmdp, *saved_pmdp, pmd;
>>>> -    pte_t *ptep;
>>>> +    pte_t *ptep, pte;
>>>>        pgtable_t saved_ptep;
>>>>        pgprot_t prot, protnone;
>>>>        phys_addr_t paddr;
>>>> @@ -1049,6 +1049,8 @@ static int __init debug_vm_pgtable(void)
>>>>         */
>>>>          ptep = pte_alloc_map_lock(mm, pmdp, vaddr, &ptl);
>>>> +    pte = pfn_pte(pte_aligned, prot);
>>>> +    set_pte_at(mm, vaddr, ptep, pte);
>>>
>>> Not here, creating and populating an entry must be done in respective
>>> test functions itself. Besides, this seems bit redundant as well. The
>>> test pte_clear_tests() with the above change added, already
>>>
>>> - Clears the PTEP entry with ptep_get_and_clear()
>>
>> and fetch the old value set previously.
> 
> In that case, please move above two lines i.e
> 
> pte = pfn_pte(pte_aligned, prot);
> set_pte_at(mm, vaddr, ptep, pte);
> 
> from debug_vm_pgtable() to pte_clear_tests() and update it's arguments
> as required.
> 

Frankly, I don't understand what these tests are testing. It all looks 
like some random clear and set.

static void __init pte_clear_tests(struct mm_struct *mm, pte_t *ptep,
				   unsigned long vaddr, unsigned long pfn,
				   pgprot_t prot)
{

	pte_t pte = pfn_pte(pfn, prot);
	set_pte_at(mm, vaddr, ptep, pte);

	pte =  ptep_get_and_clear(mm, vaddr, ptep);

	pr_debug("Validating PTE clear\n");
	pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
	set_pte_at(mm, vaddr, ptep, pte);
	barrier();
	pte_clear(mm, vaddr, ptep);
	pte = ptep_get(ptep);
	WARN_ON(!pte_none(pte));
}


-aneesh
