From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v9 21/22] KVM: s390: CPU model support for AP
 virtualization
Date: Wed, 22 Aug 2018 17:05:31 -0400
Message-ID: <abd85777-b7db-ee42-1c7b-7131d3475fe0@linux.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-22-git-send-email-akrowiak@linux.vnet.ibm.com>
 <2c2c4859-ed3e-a492-dd59-78529c7768b2@redhat.com>
 <e7e1efe7-a7f5-f9a8-bd85-88759fa8ba2b@linux.ibm.com>
 <b04e7d88-b7d3-b55d-cba8-bec0623e4adc@redhat.com>
 <9f512d55-ef10-e2ae-f34e-e003c929bc3f@linux.ibm.com>
 <befdd6b9-6ca8-96c2-68c7-f52f8367443c@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <befdd6b9-6ca8-96c2-68c7-f52f8367443c@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, pmorel@linux.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 08/22/2018 12:57 PM, David Hildenbrand wrote:
>>>> In this case we will have no problem with older guests not having idea
>>>> about APXA.
>>>>
>>>> Would it be a solution?
>>> Any feature the guest sees, should be part of the CPU model. The whole
>>> environment for cpu subfunctions is already in place both in KVM and
>>> QEMU. Only disabling subfunctions in KVM is not implemented yet.
>>>
>>> You can exclude any subfunctions/facilities that are only valid on LPAR
>>> level and cannot be used in some guest either way. (that makes life
>>> sometimes easier)
>>>
>>>
>>> I know that this might sound a little bit complicated, but it really
>>> isn't. Boils down to modifying kvm_s390_cpu_feat_init() and specifying
>>> some features+feature groups in QEMU.
>> OK, we definitively need another patch/patch-set, to handle this.
>> Do you think it can be done in another series since if we always support
>> APXA when we have AP instructions, we already have an indication that
>> APXA exist: the AP facility.
>>
> Please implement the subfunction stuff right away. This will allow to
> handle all future facilities transparently from a kernel POV.

I find your use of the term 'subfunction' confusing here. In the
kvm_s390_cpu_feat_init(void) function, it looks like the
kvm_s390_available_subfunc structure is filled in with bits
returned from CPACF queries of various MSA facilities to indicate
which CPACF functions are supported. APXA is not a subfunction but
a facility that is indicated by a bit returned from the PQAP(QCI)
instruction. If we are to implement this, wouldn't it be done as
a CPU model feature as opposed to a subfunction? Am I
misunderstanding what you are asking for?

>
> Implementing that should be easy - and I don't like gluing features
> together in such a way.
>
> You can always assure that consistent data (e.g. AP + APXA availability)
> is reported from KVM to QEMU.
>
>> Regards,
>> Pierre
>>
>>
>>
>>
>
