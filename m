From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v9 21/22] KVM: s390: CPU model support for AP
 virtualization
Date: Wed, 22 Aug 2018 18:57:31 +0200
Message-ID: <befdd6b9-6ca8-96c2-68c7-f52f8367443c@redhat.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-22-git-send-email-akrowiak@linux.vnet.ibm.com>
 <2c2c4859-ed3e-a492-dd59-78529c7768b2@redhat.com>
 <e7e1efe7-a7f5-f9a8-bd85-88759fa8ba2b@linux.ibm.com>
 <b04e7d88-b7d3-b55d-cba8-bec0623e4adc@redhat.com>
 <9f512d55-ef10-e2ae-f34e-e003c929bc3f@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9f512d55-ef10-e2ae-f34e-e003c929bc3f@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pmorel@linux.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


>>>
>>> In this case we will have no problem with older guests not having idea
>>> about APXA.
>>>
>>> Would it be a solution?
>>
>> Any feature the guest sees, should be part of the CPU model. The whole
>> environment for cpu subfunctions is already in place both in KVM and
>> QEMU. Only disabling subfunctions in KVM is not implemented yet.
>>
>> You can exclude any subfunctions/facilities that are only valid on LPAR
>> level and cannot be used in some guest either way. (that makes life
>> sometimes easier)
>>
>>
>> I know that this might sound a little bit complicated, but it really
>> isn't. Boils down to modifying kvm_s390_cpu_feat_init() and specifying
>> some features+feature groups in QEMU.
> 
> OK, we definitively need another patch/patch-set, to handle this.
> Do you think it can be done in another series since if we always support 
> APXA when we have AP instructions, we already have an indication that
> APXA exist: the AP facility.
> 

Please implement the subfunction stuff right away. This will allow to
handle all future facilities transparently from a kernel POV.

Implementing that should be easy - and I don't like gluing features
together in such a way.

You can always assure that consistent data (e.g. AP + APXA availability)
is reported from KVM to QEMU.

> Regards,
> Pierre
> 
> 
> 
> 


-- 

Thanks,

David / dhildenb
