From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC/PATCH v3 04/16] s390/mm: add gmap PMD invalidation
 notification
Date: Wed, 14 Feb 2018 11:42:14 +0100
Message-ID: <dbaf7c40-928c-c535-db70-67e7d284a22b@redhat.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1518168864-147803-5-git-send-email-frankja@linux.vnet.ibm.com>
 <38c32f80-9225-8e71-7a8a-aa759cdbbfc7@redhat.com>
 <e9024cdf-7f44-cae3-c839-96eb2e9a6f37@linux.vnet.ibm.com>
 <dd0b270b-cefe-00ad-0020-b7eb125b683f@redhat.com>
 <5fb02c01-bbda-bdd7-eb54-8e8ee525093c@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <5fb02c01-bbda-bdd7-eb54-8e8ee525093c@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


>>>> That's interesting, because the SIE can now suddenly work on these
>>>> PGSTEs, e.g. not leading to intercepts on certain events (like setting
>>>> storage keys).
>>>>
>>>> How is that intended to be handled? I assume we would somehow have to
>>>> forbid the SIE from making use of the PGSTE. But that involves clearing
>>>> certain interception controls, which might be problematic.
>>>
>>> Well, cmma is disabled and storage keys should only be a problem, when
>>> the pte is invalid without the pgste lock, which should never be the
>>> case for split pmds.
>>>
>>
>> Are you sure? Because the SIE would suddenly stark working on guest
>> storage keys stored in the PGSTE if I am not mistaking? So I would
>> assume that there would have to be some kind of a sync.
>>
>> But I don't have any documentation at hand, so i can't tell :)
>>
> 
> The pgste lock is that sync and as the gmap is the only way to get to
> the pte, we don't have any ptes invalid without the lock. Also
> set_guest_storage_keys will find a (userspace) pmd and do a hardware
> sske, like it is supposed to.

What happens according to the documentation in the following cases:

The HW has the storage-key facility enabled and a SKEY operation (ISKE,
RRBE, SSKE) hits a huge page:

a) Generates an intercept
b) Uses the real machine storage key (as there are no pgste)

-- 

Thanks,

David / dhildenb
