From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 0/2] KVM: s390: Tracing APCB changes
Date: Fri, 5 Oct 2018 10:56:53 +0200
Message-ID: <1eaf8e02-aafc-6357-43aa-b5f940ca7a11@redhat.com>
References: <7d147350-4284-8e01-d1fa-0795d2da85c1@de.ibm.com>
 <1538728270-10340-1-git-send-email-pmorel@linux.ibm.com>
 <20181005104420.62792eed.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181005104420.62792eed.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 05/10/2018 10:44, Cornelia Huck wrote:
> On Fri,  5 Oct 2018 10:31:08 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> In the first patch we define kvm_arch_crypto_set_masks,
>> a new function to centralize the setup the APCB masks
>> inside the CRYCB SIE satelite and add KVM_EVENT() to
>> kvm_arch_crypto_set_masks and kvm_arch_crypto_clear_masks.
>>
>> In the second patch we replace the vfio_ap_mdev_copy_masks()
>> by the new kvm_arch_crypto_set_masks() function.
>>
>>
>> Pierre Morel (2):
>>   KVM: s390: Tracing APCB changes
>>   s390: vfio-ap: setup APCB mask using KVM dedicated function
>>
>>  arch/s390/include/asm/kvm_host.h  |  2 ++
>>  arch/s390/kvm/kvm-s390.c          | 41 +++++++++++++++++++++++++++++++++++++++
>>  drivers/s390/crypto/vfio_ap_ops.c | 33 +++----------------------------
>>  3 files changed, 46 insertions(+), 30 deletions(-)
>>
> 
> I like this version better: it moves the mask-setting next to the
> mask-clearing, and, as a bonus, adds a trace event for clearing as
> well :)
> 

Yes, more code but looks cleaner to me.

-- 

Thanks,

David / dhildenb
