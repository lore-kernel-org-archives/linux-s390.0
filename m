From: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC/PATCH v3 00/16] KVM/s390: Hugetlbfs enablement
Date: Wed, 14 Feb 2018 16:57:35 +0100
Message-ID: <d47f5cdf-ca2f-fe76-1f2c-93fe9c746913@redhat.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <16d92e45-97bc-fbbd-55e7-36da8c1a6d73@redhat.com>
 <70de883f-4120-1b36-fb0f-5b940b05aab4@linux.vnet.ibm.com>
 <7dadc09b-8ada-a9e4-14c1-aca36ac0afe5@redhat.com>
 <9a8bc606-217c-db26-3a1a-85c8405c9487@linux.vnet.ibm.com>
 <0d53e8c2-2f9c-b874-61ac-aad03be6c038@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <0d53e8c2-2f9c-b874-61ac-aad03be6c038@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


> I think it would work out fine for the Linux case. We do not use storage keys.
> And if a guest uses them they will be slower if the host uses large pages. Tough.

Yes, slower but handled correctly. (e.g. old SLES if I'm not mistaking)

> 
>>>>
>>>> My only concern here is:
>>>> Can this coexist with the cpumodels in a coordinated way?
>>>>
>>>
>>> We already have to fake away the CMMA facility in user space. So that
>>> shouldn't be a problem. The other instructions
>>> - PFMF
>>> - ISKE, SSKE ...
>>>
>>> Will simply always be interpreted. Should not affect the CPU model.
>>
>> Bear with me, it was a long day:
>>
>> Would it make sense to force user space to configure HPAGE before asking
>> for model data, so that we can remove these model bits already from
>> kernel side and wouldn't need extensive handling on two points?
> Looks like that we do not claim CMMA and storage key interpretion anyway
> via the CPU model.
> 
> In the kernel we should then modify try_handle_skey to not believe in
> sclp.has_skey (but a new flag instead). For VSIE we already disable
> storage key interpretion (and do it manually). We could then also make
> the HPAGE stuff XOR KVM_S390_VM_MEM_ENABLE_CMMA. Whatever comes first will
> trigger an -EINVAL for the 2nd.
> 
> Something like this.
> 
Exactly what I had in mind.

-- 

Thanks,

David / dhildenb
