From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 08/15] KVM: s390: interfaces to (de)configure guest's
 AP matrix
Date: Wed, 2 May 2018 16:57:44 +0200
Message-ID: <54e4c3ef-0750-981b-7b0e-6b18d1a77c3c@linux.vnet.ibm.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1523827345-11600-9-git-send-email-akrowiak@linux.vnet.ibm.com>
 <99f4752a-1358-61e4-bf9e-5672b2d4036f@linux.vnet.ibm.com>
 <0f47c442-47b8-ee57-d014-5200c59125d7@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0f47c442-47b8-ee57-d014-5200c59125d7@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 25/04/2018 18:21, Tony Krowiak wrote:
> On 04/23/2018 09:46 AM, Pierre Morel wrote:
>> On 15/04/2018 23:22, Tony Krowiak wrote:
>>> Provides interfaces to assign AP adapters, usage domains
>>> and control domains to a KVM guest.
>>>
...
>>> +/**
>>> + * kvm_ap_matrix_create
>>> + *
>>> + * Create an AP matrix to hold a configuration of AP adapters, 
>>> domains and
>>> + * control domains.
>>> + *
>>> + * @ap_matrix: holds the matrix that is created
>>> + *
>>> + * Returns 0 if the matrix is successfully created. Returns an 
>>> error if an APQN
>>> + * derived from the cross product of the AP adapter IDs and AP 
>>> queue indexes
>>> + * comprising the AP matrix is configured for another guest.
>>> + */
>>> +int kvm_ap_matrix_create(struct kvm_ap_matrix **ap_matrix);
>>
>> why not simply return the pointer?
>
> The function returns a value indicating the reason a matrix could not 
> be created.
> Returning a NULL pointer provides no clue as to why the call failed.

That is why the ERR_PTR exist :)


...
>>> + * Returns 0 if the APQNs are valid, otherwise; returns -EBUSY.
>>> + */
>>> +static int kvm_ap_validate_queue_sharing(struct kvm *kvm,
>>> +                     struct kvm_ap_matrix *matrix)
>>> +{
>>> +    struct kvm *vm;
>>> +    unsigned long *apm, *aqm;
>>> +    unsigned long apid, apqi;
>>> +
>>> +
>>> +    /* No other VM may share an AP Queue with the input VM */
>>
>> I wonder if these functions and structures should really belong to KVM.
>> The only have sense with the VFIO driver.
>> My opinion is that they belong there, in the VFIO driver code.
>
> I disagree for two reasons:
>
> 1. The vfio_ap driver should not have to know how to configure the KVM
>    guest's matrix nor anything else about KVM for that matter.
>
> 2. The interfaces and structures defined in kvm-ap.h and implemented
> in kvm-ap.c don't have anything to do with VFIO and can stand alone
>    to be used by any client code to configure a guest's matrix.

Doing this you will have to change KVM if the AP VFIO matrix protocol to 
access the queues change.
i.e. suppose some day the queues may be shared between guests.
...
>>> +static int kvm_ap_matrix_apm_create(struct kvm_ap_matrix *ap_matrix,
>>> +                    struct ap_config_info *config)
>>> +{
>>> +    int apm_max = (config && config->apxa) ? config->Na + 1 : 16;
>>
>> At this moment you already know the format of the crycb.
>
> How?

you calculated this in kvm_ap_build_crycbd() which is called from 
kvm_s390_crypto_init()
itself called from kvm_arch_init_vm().
It is when starting the VM.

kvm_ap_matrix_apm_create() is called much later when realizing the device


...



-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
