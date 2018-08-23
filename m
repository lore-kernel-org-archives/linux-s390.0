From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v9 21/22] KVM: s390: CPU model support for AP
 virtualization
Date: Thu, 23 Aug 2018 09:42:12 +0200
Message-ID: <d921be51-42a0-b819-39b0-59f06fd587cb@redhat.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-22-git-send-email-akrowiak@linux.vnet.ibm.com>
 <2c2c4859-ed3e-a492-dd59-78529c7768b2@redhat.com>
 <e7e1efe7-a7f5-f9a8-bd85-88759fa8ba2b@linux.ibm.com>
 <b04e7d88-b7d3-b55d-cba8-bec0623e4adc@redhat.com>
 <9f512d55-ef10-e2ae-f34e-e003c929bc3f@linux.ibm.com>
 <befdd6b9-6ca8-96c2-68c7-f52f8367443c@redhat.com>
 <abd85777-b7db-ee42-1c7b-7131d3475fe0@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <abd85777-b7db-ee42-1c7b-7131d3475fe0@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, pmorel@linux.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 22.08.2018 23:05, Tony Krowiak wrote:
> On 08/22/2018 12:57 PM, David Hildenbrand wrote:
>>>>> In this case we will have no problem with older guests not having idea
>>>>> about APXA.
>>>>>
>>>>> Would it be a solution?
>>>> Any feature the guest sees, should be part of the CPU model. The whole
>>>> environment for cpu subfunctions is already in place both in KVM and
>>>> QEMU. Only disabling subfunctions in KVM is not implemented yet.
>>>>
>>>> You can exclude any subfunctions/facilities that are only valid on LPAR
>>>> level and cannot be used in some guest either way. (that makes life
>>>> sometimes easier)
>>>>
>>>>
>>>> I know that this might sound a little bit complicated, but it really
>>>> isn't. Boils down to modifying kvm_s390_cpu_feat_init() and specifying
>>>> some features+feature groups in QEMU.
>>> OK, we definitively need another patch/patch-set, to handle this.
>>> Do you think it can be done in another series since if we always support
>>> APXA when we have AP instructions, we already have an indication that
>>> APXA exist: the AP facility.
>>>
>> Please implement the subfunction stuff right away. This will allow to
>> handle all future facilities transparently from a kernel POV.
> 
> I find your use of the term 'subfunction' confusing here. In the
> kvm_s390_cpu_feat_init(void) function, it looks like the
> kvm_s390_available_subfunc structure is filled in with bits
> returned from CPACF queries of various MSA facilities to indicate
> which CPACF functions are supported. APXA is not a subfunction but
> a facility that is indicated by a bit returned from the PQAP(QCI)
> instruction. If we are to implement this, wouldn't it be done as
> a CPU model feature as opposed to a subfunction? Am I
> misunderstanding what you are asking for?

Yes, "subfunction" is a confusing terminology. (I once called it
subfeature/sufacility, but ended up using subfunction).

From a high level perspective, these are just feature bits - "can I use
feature X" / "is feature X available".

What all of these "query" blocks (MSA, PLO, PQAP(QCI) ...) have in
common is:
- in contrast to STFL(E), they are as a default not modified by the
  hypervisor but silently passed through
- dropping one of the bits (e.g. APXA) can break the guest - guest
  visible ABI
- any newly added feature/facility in such a block (new HW generation)
  should be transparently handled by HW and not require modifications in
  the hypervisor - because they are right away presented to the guest.
  (unfortunately with minor exceptions - e.g. APXA might be such a
  candidate, but that was rather a design error back then)
- there is a way we can overwrite which features are presented to the
  guest

The nice thing about that "blob" exported to user space (in contrast to
features) is that it does not have to be fixed up in KVM every time a
new feature/facility is added. As they should be transparently handled.
Only QEMU has to be thought about the new feature - which can be done
right away when introducing the new CPU model.

That's why the natural choice for PQAP(QCI) is also exposing it as
subfunctions, and not as CPU model features (kvm interface).

-- 

Thanks,

David / dhildenb
