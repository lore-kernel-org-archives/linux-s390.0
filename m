From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC/PATCH v2 00/22] KVM/s390: Hugetlbfs enablement
Date: Wed, 24 Jan 2018 10:14:49 +0100
Message-ID: <86c5bd00-a552-1737-8db8-3f7b3c21057e@redhat.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <8f1ca87d-eb66-1b88-5ef1-0123e04bc565@redhat.com>
 <ad16efe7-3b7a-04b1-7a2a-1225ea460498@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <ad16efe7-3b7a-04b1-7a2a-1225ea460498@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


>> If we simply split up huge pages when protecting the prefix, we don't
>> need gmap_protect_pmd() anymore, and therefore also (at least) not
> 
> We need it for the dirty tracking, no?

Indeed, missed that call. But we don't set any notifier bits, that's the
important part.

> 
>>
>> - s390/mm: Abstract gmap notify bit setting
> 
> Yes, that's not needed then.
> 
>> - s390/mm: add gmap PMD invalidation notification
> 
> We need that one (in parts) because of the protection transfer to user
> space. We will be notified on mm pmds. Even if we split a pmd, we will
> be notified on a pmd, not on a pte. So we need at least a skeleton that
> calls pmdp_notify_split.
> 
> I'm currently preparing a patch that rips out pmd protection with
> software bits. I'll attach it when finished, so we can have a look what
> can go.
> 

Yes, parts of it. Especially without notifier bits.


-- 

Thanks,

David / dhildenb
