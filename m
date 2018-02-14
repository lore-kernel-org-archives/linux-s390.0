From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC/PATCH v3 04/16] s390/mm: add gmap PMD invalidation
 notification
Date: Wed, 14 Feb 2018 16:15:36 +0100
Message-ID: <cd3e5011-ef32-bdc8-6d22-1c128d5c6f40@redhat.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1518168864-147803-5-git-send-email-frankja@linux.vnet.ibm.com>
 <38c32f80-9225-8e71-7a8a-aa759cdbbfc7@redhat.com>
 <e9024cdf-7f44-cae3-c839-96eb2e9a6f37@linux.vnet.ibm.com>
 <dd0b270b-cefe-00ad-0020-b7eb125b683f@redhat.com>
 <5fb02c01-bbda-bdd7-eb54-8e8ee525093c@linux.vnet.ibm.com>
 <dbaf7c40-928c-c535-db70-67e7d284a22b@redhat.com>
 <6e6d3053-1526-230c-0fb3-6d57168f47c7@linux.vnet.ibm.com>
 <7009cdd4-bbf1-2802-b9a8-03c238ec8ae2@redhat.com>
 <da99ceda-9ce3-e8b9-f190-83dbdfed6c68@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <da99ceda-9ce3-e8b9-f190-83dbdfed6c68@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

>> So what can happen is (please correct me if I'm wrong)
>>
>> a) PMD is split. SSKE writes storage key with _PAGE_CHANGED, ends up in
>> PGSTE. The real storage key doesn't match the requested storage key.
>> b) Split PMD is replaced, triggers a removal of the split PMD ->
>> gmap_pmd_split_free(pmdp). The requested storage key is partially lost
>> (pgste removed).
>> c) PMD is mapped in again. If the guest reads the storage key now, the
>> value is wrong.
> 
> Yes, we loose GR and GC.
> Is there a case when the VM is running, where this would happen?

It should already happen when migrating storage keys. The fake PGSTE are
not considered in get_guest_storage_key().

For the other parts, the original user space PMD would have to be
changed. A simply mprotect() should achieve that. Or dirty tracking. But
not sure how that applies to huge pages at all.

-- 

Thanks,

David / dhildenb
