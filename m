From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 07/15] KVM: s390: Interfaces to configure/deconfigure
 guest's AP matrix
Date: Wed, 28 Feb 2018 14:11:38 -0500
Message-ID: <6e2fb969-4470-06e4-aab9-43969a75367b@linux.vnet.ibm.com>
References: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1519741693-17440-8-git-send-email-akrowiak@linux.vnet.ibm.com>
 <c06ad065-9f10-2d0d-f56f-faae813557d9@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c06ad065-9f10-2d0d-f56f-faae813557d9@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 02/28/2018 11:15 AM, Pierre Morel wrote:
> On 27/02/2018 15:28, Tony Krowiak wrote:
>> Provides interfaces to assign AP adapters, usage domains
>> and control domains to a KVM guest.
>>
>> A KVM guest is started by executing the Start Interpretive Execution 
>> (SIE)
>> instruction. The SIE state description is a control block that 
>> contains the
>> state information for a KVM guest and is supplied as input to the SIE
>> instruction. The SIE state description has a satellite structure 
>> called the
>> Crypto Control Block (CRYCB). The CRYCB contains three bitmask fields
>> identifying the adapters, queues (domains) and control domains 
>> assigned to
>> the KVM guest:
>>
>> * The AP Adapter Mask (APM) field identifies the AP adapters assigned to
>>    the KVM guest
>>
>> * The AP Queue Mask (AQM) field identifies the AP queues assigned to
>>    the KVM guest. Each AP queue is connected to a usage domain within
>>    an AP adapter.
>>
>> * The AP Domain Mask (ADM) field identifies the control domains
>>    assigned to the KVM guest.
>>
>> Each adapter, queue (usage domain) and control domain are identified by
>> a number from 0 to 255. The bits in each mask, from most significant to
>> least significant bit, correspond to the numbers 0-255. When a bit is
>> set, the corresponding adapter, queue (usage domain) or control domain
>> is assigned to the KVM guest.
>
> ...snip...
>
>>   static int kvm_ap_apxa_installed(void)
>>   {
>>       int ret;
>> @@ -50,3 +170,140 @@ void kvm_ap_set_crycb_format(struct kvm *kvm, 
>> __u32 *crycbd)
>>               *crycbd |= CRYCB_FORMAT1;
>>       }
>>   }
>> +
>> +static int kvm_ap_matrix_apm_create(struct kvm_ap_matrix *ap_matrix, 
>> int apxa)
>> +{
>> +    if (apxa)
>> +        ap_matrix->apm_max = 256;
>
> AFAIK the number of possible bits in the masks for a system is not a 
> generic value but is
> returned by the QCI instruction.
> Is there a reason to use a fix value?
Right you are! I'll initialize the value based on what is returned from 
the QCI call.
>
>
>> +    else
>> +        ap_matrix->apm_max = 64;
>> +
>> +    ap_matrix->apm = kzalloc(KVM_AP_MASK_BYTES(ap_matrix->apm_max),
>> +                 GFP_KERNEL);
>> +    if (!ap_matrix->apm)
>> +        return -ENOMEM;
>> +
>> +    return 0;
>> +}
>> +
>> +static int kvm_ap_matrix_aqm_create(struct kvm_ap_matrix *ap_matrix, 
>> int apxa)
>> +{
>> +    if (apxa)
>> +        ap_matrix->aqm_max = 256;
>
> same here
ditto
>
>> +    else
>> +        ap_matrix->aqm_max = 16;
>> +
>> +    ap_matrix->aqm = kzalloc(KVM_AP_MASK_BYTES(ap_matrix->aqm_max),
>> +                 GFP_KERNEL);
>> +    if (!ap_matrix->aqm)
>> +        return -ENOMEM;
>> +
>> +    return 0;
>> +}
>> +
>> +static int kvm_ap_matrix_adm_create(struct kvm_ap_matrix *ap_matrix, 
>> int apxa)
>> +{
>> +    if (apxa)
>> +        ap_matrix->adm_max = 256;
>
> and here
ditto
>
>
> Pierre
>
