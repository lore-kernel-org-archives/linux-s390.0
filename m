From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v10 10/26] KVM: s390: interfaces to clear CRYCB masks
Date: Mon, 24 Sep 2018 13:50:36 +0200
Message-ID: <42b23a01-bee1-0c87-3f81-320c40bcb7c9@linux.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-11-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180924130153.766eaec7.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924130153.766eaec7.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 09/24/2018 01:01 PM, Cornelia Huck wrote:
> On Wed, 12 Sep 2018 15:43:00 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> 
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Introduces two new KVM interface to clear the APM, AQM and ADM masks in
>> the guest's CRYCB.  The VCPUs are taken out of SIE to ensure the VCPUs do
>> not get out of sync.
> 
> Hm, that patch description does not quite match what the patch actually
> does...
> 

You mean it is not obvious where the masks get cleared? Well the APCB is
defined to contain exactly the three masks. As far as I can tell the patch
description is correct.

Regards,
Halil

>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Acked-by: Halil Pasic <pasic@linux.ibm.com>
>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>> Tested-by: Pierre Morel <pmorel@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/include/asm/kvm_host.h |    2 ++
>>  arch/s390/kvm/kvm-s390.c         |   15 +++++++++++++++
>>  2 files changed, 17 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>> index 423cce7..1e758fe 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -858,6 +858,8 @@ void kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
>>  void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
>>  				 struct kvm_async_pf *work);
>>  
>> +void kvm_arch_crypto_clear_masks(struct kvm *kvm);
>> +
>>  extern int sie64a(struct kvm_s390_sie_block *, u64 *);
>>  extern char sie_exit;
>>  
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index d717041..ac4c93f 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -2033,6 +2033,21 @@ static void kvm_s390_set_crycb_format(struct kvm *kvm)
>>  		kvm->arch.crypto.crycbd |= CRYCB_FORMAT1;
>>  }
>>  
>> +void kvm_arch_crypto_clear_masks(struct kvm *kvm)
>> +{
>> +	mutex_lock(&kvm->lock);
>> +	kvm_s390_vcpu_block_all(kvm);
>> +
>> +	memset(&kvm->arch.crypto.crycb->apcb0, 0,
>> +	       sizeof(kvm->arch.crypto.crycb->apcb0));
>> +	memset(&kvm->arch.crypto.crycb->apcb1, 0,
>> +	       sizeof(kvm->arch.crypto.crycb->apcb1));
>> +
>> +	kvm_s390_vcpu_unblock_all(kvm);
>> +	mutex_unlock(&kvm->lock);
>> +}
>> +EXPORT_SYMBOL_GPL(kvm_arch_crypto_clear_masks);
> 
> ...although this function looks fine.
> 
>> +
>>  static u64 kvm_s390_get_initial_cpuid(void)
>>  {
>>  	struct cpuid cpuid;
> 
