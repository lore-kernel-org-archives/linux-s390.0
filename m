From: David Hildenbrand <david@redhat.com>
Date: Tue, 16 Oct 2018 08:57:29 +0000
Subject: Re: [RFC 08/14] s390/mm: Make gmap_read_table EDAT1 compatible
Message-Id: <cd5a4668-b5ec-beec-c6cb-60f6fbc9ec78@redhat.com>
In-Reply-To: <979ea4cc-8a85-479c-a03d-9f8b9a9b3487@linux.ibm.com>
References: <979ea4cc-8a85-479c-a03d-9f8b9a9b3487@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

>>>  	while (1) {
>>>  		rc = -EAGAIN;
>>> -		ptep = gmap_pte_op_walk(gmap, gaddr, &ptl);
>>> -		if (ptep) {
>>> -			pte = *ptep;
>>> -			if (pte_present(pte) && (pte_val(pte) & _PAGE_READ)) {
>>> -				address = pte_val(pte) & PAGE_MASK;
>>> -				address += gaddr & ~PAGE_MASK;
>>> +		vmaddr = __gmap_translate(gmap, gaddr);
>>> +		if (IS_ERR_VALUE(vmaddr))
>>> +			return vmaddr;
>>> +		pmdp = gmap_pmd_op_walk(gmap, gaddr, vmaddr, &ptl_pmd);
>>> +		if (pmdp && !(pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)) {
>>> +			if (!pmd_large(*pmdp)) {
>>> +				ptep = gmap_pte_from_pmd(gmap, pmdp, vmaddr, &ptl_pte);
>>> +				if (ptep) {
>>> +					pte = *ptep;
>>> +					if (pte_present(pte) && (pte_val(pte) & _PAGE_READ)) {
>>> +						address = pte_val(pte) & PAGE_MASK;
>>> +						address += gaddr & ~PAGE_MASK;
>>> +						*val = *(unsigned long *) address;
>>> +						pte_val(*ptep) |= _PAGE_YOUNG;
>>> +						/* Do *NOT* clear the _PAGE_INVALID bit! */
>>> +						rc = 0;
>>> +					}
>>> +				}
>>> +				gmap_pte_op_end(ptl_pte);
>>
>> I'm confused that we have a gmap_pte_op_end() followed by a
>> gmap_pmd_op_end() although we never started a gmap_pte_op_walk() ... I
>> assume this is due to gmap_pte_from_pmd() ? We should find better names
>> for these functions otherwise this is pure magic.
>>
>> e.g. gmap_pte_op_walk_pmd() instead of gmap_pte_from_pmd()
> 
> Hrm, in my opinion pte_from_pmd is very specific, although it lacks the
> op part. How about gmap_pte_op_map, that would be closer to the
> pte_alloc/offset_map from the kernel side?

Yes, as long as there is "op" in there one can see in the code how it
all plays together.

> 
>>
>> ... and shouldn't "gmap_pte_op_end(ptl_pte)" be inside of the "if(ptep)" ?
> 
> It doesn't matter as we check the ptl for NULL in op_end functions.
> I have that scheme everywhere where it's nicer to read, like in the gmap
> protection functions.
> 
> I'll have a look if I can make that consistent either way.

Yes, as long as it's consistent it's fine for me.


-- 

Thanks,

David / dhildenb
