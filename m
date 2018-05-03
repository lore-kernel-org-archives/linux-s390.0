From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 08/15] KVM: s390: interfaces to (de)configure guest's
 AP matrix
Date: Thu, 3 May 2018 18:01:49 +0200
Message-ID: <829b70c7-1648-f1c3-f656-3dca56bb3d8e@linux.vnet.ibm.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1523827345-11600-9-git-send-email-akrowiak@linux.vnet.ibm.com>
 <99f4752a-1358-61e4-bf9e-5672b2d4036f@linux.vnet.ibm.com>
 <0f47c442-47b8-ee57-d014-5200c59125d7@linux.vnet.ibm.com>
 <54e4c3ef-0750-981b-7b0e-6b18d1a77c3c@linux.vnet.ibm.com>
 <7a733e41-3956-6828-9efa-899c9a954c20@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7a733e41-3956-6828-9efa-899c9a954c20@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 03/05/2018 16:41, Tony Krowiak wrote:
> On 05/02/2018 10:57 AM, Pierre Morel wrote:
>> On 25/04/2018 18:21, Tony Krowiak wrote:
>>> On 04/23/2018 09:46 AM, Pierre Morel wrote:
>>>> On 15/04/2018 23:22, Tony Krowiak wrote:
>>>>> Provides interfaces to assign AP adapters, usage domains
>>>>> and control domains to a KVM guest.
...
> The kvm_ap_configure_matrix(kvm, matrix) interface configures the APM, 
> AQM and ADM in the
> guest's CRYCB which implies AP instructions are being interpreted. 
> There is nothing in SIE
> precluding the sharing of AP queues between guests using SIE to 
> interpret AP instructions,
> it is my opinion - along with several others - that this is not 
> advisable given the
> results are not predictable, not to mention the security concerns. If 
> the protocol to access
> queues changes, then we create a different interface. The other option 
> is to include a flag
> on the kvm_ap_configure_matrix(kvm, matrix) interface to indicate 
> whether sharing is
> allowed. I don't like this, because we have no way of knowing if the 
> caller has taken the
> proper care to ensure the VM sharing the queue should be allowed 
> access. Besides, when
> queue sharing is implemented, it is my opinion that we will intercept 
> the AP instructions
> and the matrix will not be configured in the CRYCB. I stick by my 
> response above.

I mean, validating the queue sharing is a mater of the VFIO driver.
This code is not needed if the VFIO driver is not used.
But it is not very important.

>
>>
>>>>> +static int kvm_ap_matrix_apm_create(struct kvm_ap_matrix *ap_matrix,
>>>>> +                    struct ap_config_info *config)
>>>>> +{
>>>>> +    int apm_max = (config && config->apxa) ? config->Na + 1 : 16;
>>>>
>>>> At this moment you already know the format of the crycb.
>>>
>>> How?
>>
>> you calculated this in kvm_ap_build_crycbd() which is called from 
>> kvm_s390_crypto_init()
>> itself called from kvm_arch_init_vm().
>> It is when starting the VM.
>
> This structure is used by the vfio_ap driver to store the mediated 
> matrix device's matrix
> configuration as well as to configure the CRYCB. The mediated device's 
> matrix is
> configured before the guest is started ... it is the means for 
> configuring the guest's
> matrix after all. The bottom line is, this function will be called 
> long before the
> kvm_ap_build_crycbd() function is called.

you are right, I was thinking about open, should have take more attention.
Sorry.

Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
