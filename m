From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC/PATCH v2 01/22] s390/mm: make gmap_protect_range more
 modular
Date: Mon, 22 Jan 2018 13:50:06 +0100
Message-ID: <66bd80bc-841a-39f2-9e51-6961e2da1330@redhat.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-2-git-send-email-frankja@linux.vnet.ibm.com>
 <f8fe917b-a95f-406c-fa6b-b12b2dae6e61@redhat.com>
 <2a4094a9-aee5-adad-f543-3bfe1ca9d440@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <2a4094a9-aee5-adad-f543-3bfe1ca9d440@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


>>
>>> +	if (!pmdp || pmd_none(*pmdp)) {
>>> +		spin_unlock(&gmap->guest_table_lock);
>>> +		return NULL;
>>> +	}
>>> +	/*
>>> +	 * For plain 4k guests that do not run under the vsie it
>>> +	 * suffices to take the pte lock later on. Thus we can unlock
>>> +	 * the guest_table_lock here.
>>> +	 */
>>
>> As discussed, the gmap_is_shadow() check is not needed. The comment
>> should be something like
> 
> IFF we'll never use this function to walk shadow tables, then you are
> right. We can make it a policy and throw in a BUG_ON.

Right. We never protect anything on a shadow gmap. We only mirror the
access tights requested by the guest (which are then valid in the host).

> 
> [...]
>>> +static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
>>> +			    pmd_t *pmdp, int prot, unsigned long bits)
>>> +{
>>> +	int rc;
>>> +	pte_t *ptep;
>>> +	spinlock_t *ptl = NULL;
>>> +
>>> +	/* We have no upper segment, let's go back and fix this up. */
>>> +	if (pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)
>>> +		return -EAGAIN;
>>
>> This is essentially pmd_none(*pmdp), which you already verified in
>> gmap_pmd_op_walk().
> 
> Well, not really pmd_none is entry == ENTRY_EMPTY (only I bit set) not
> entry & I.
> Is there a path where we have an I bit on a pmd entry which has a valid pto?
> 

Thing idte only sets the invalid bit. But can this check than go into
gmap_pmd_op_walk? (replacing pmd_none() ?)

-- 

Thanks,

David / dhildenb
