From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC/PATCH v3 04/16] s390/mm: add gmap PMD invalidation
 notification
Date: Wed, 14 Feb 2018 15:18:46 +0100
Message-ID: <7009cdd4-bbf1-2802-b9a8-03c238ec8ae2@redhat.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1518168864-147803-5-git-send-email-frankja@linux.vnet.ibm.com>
 <38c32f80-9225-8e71-7a8a-aa759cdbbfc7@redhat.com>
 <e9024cdf-7f44-cae3-c839-96eb2e9a6f37@linux.vnet.ibm.com>
 <dd0b270b-cefe-00ad-0020-b7eb125b683f@redhat.com>
 <5fb02c01-bbda-bdd7-eb54-8e8ee525093c@linux.vnet.ibm.com>
 <dbaf7c40-928c-c535-db70-67e7d284a22b@redhat.com>
 <6e6d3053-1526-230c-0fb3-6d57168f47c7@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <6e6d3053-1526-230c-0fb3-6d57168f47c7@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 14.02.2018 12:19, Janosch Frank wrote:
> On 14.02.2018 11:42, David Hildenbrand wrote:
>>
>>>>>> That's interesting, because the SIE can now suddenly work on these
>>>>>> PGSTEs, e.g. not leading to intercepts on certain events (like setting
>>>>>> storage keys).
>>>>>>
>>>>>> How is that intended to be handled? I assume we would somehow have to
>>>>>> forbid the SIE from making use of the PGSTE. But that involves clearing
>>>>>> certain interception controls, which might be problematic.
>>>>>
>>>>> Well, cmma is disabled and storage keys should only be a problem, when
>>>>> the pte is invalid without the pgste lock, which should never be the
>>>>> case for split pmds.
>>>>>
>>>>
>>>> Are you sure? Because the SIE would suddenly stark working on guest
>>>> storage keys stored in the PGSTE if I am not mistaking? So I would
>>>> assume that there would have to be some kind of a sync.
>>>>
>>>> But I don't have any documentation at hand, so i can't tell :)
>>>>
>>>
>>> The pgste lock is that sync and as the gmap is the only way to get to
>>> the pte, we don't have any ptes invalid without the lock. Also
>>> set_guest_storage_keys will find a (userspace) pmd and do a hardware
>>> sske, like it is supposed to.
>>
>> What happens according to the documentation in the following cases:
>>
>> The HW has the storage-key facility enabled and a SKEY operation (ISKE,
>> RRBE, SSKE) hits a huge page:
>>
>> a) Generates an intercept
>> b) Uses the real machine storage key (as there are no pgste)
>>
> 
> b, this is an implicit RCP bypass (same goes for fc=1 r3 entries). This
> might be even independent of the SKF if I'm not mistaken.
> 

SKF implements interpretation of these 3 instructions, without it, they
lead to an intercept (e.g. what we force when inside vSIE).

Alright, so that means that we have two cases:

1. A SKEY operation hits a huge PMD. Everything is fine, the real
storage key is used. This is also what get_guest_storage_key() /
set_guest_storage_key() implement now.

2. A SKEY operation hits a split PMD. It will work on the PGSTE values.

As I don't have access to documentation, looking at set_guest_storage_key():

a) The real storage key is read.
b) The _PAGE_ACC_BITS and _PAGE_FP_BIT are written into the real storage key
c) The _PAGE_CHANGED and  _PAGE_REFERENCED are cleared from the real
storage key. They are managed in the PGSTE.

This means, that the requested _PAGE_CHANGED and _PAGE_REFERENCED bits
part of the storage key are not updated in the real storage key.


So what can happen is (please correct me if I'm wrong)

a) PMD is split. SSKE writes storage key with _PAGE_CHANGED, ends up in
PGSTE. The real storage key doesn't match the requested storage key.
b) Split PMD is replaced, triggers a removal of the split PMD ->
gmap_pmd_split_free(pmdp). The requested storage key is partially lost
(pgste removed).
c) PMD is mapped in again. If the guest reads the storage key now, the
value is wrong.


-- 

Thanks,

David / dhildenb
