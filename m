From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2] KVM: s390: add proper locking for CMMA migration
 bitmap
Date: Wed, 24 Jan 2018 14:02:14 +0100
Message-ID: <495294ee-97a3-b444-d1e8-4a0205ebe79d@de.ibm.com>
References: <20180124124100.15690-1-borntraeger@de.ibm.com>
 <7d7d8328-32ef-5bee-21f2-548fd4cf4bb0@redhat.com>
 <11efd39c-b4bd-707b-518c-9c4461733a7c@de.ibm.com>
 <b181c844-37d7-e192-fb5e-7eccf57c43dc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <b181c844-37d7-e192-fb5e-7eccf57c43dc@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 01/24/2018 01:54 PM, David Hildenbrand wrote:
> On 24.01.2018 13:51, Christian Borntraeger wrote:
>>
>>
>> On 01/24/2018 01:51 PM, David Hildenbrand wrote:
>>> On 24.01.2018 13:41, Christian Borntraeger wrote:
>>>> Some parts of the cmma migration bitmap is already protected
>>>> with the kvm->lock (e.g. the migration start). On the other
>>>> hand the read of the cmma bits is not protected against a
>>>> concurrent free, neither is the emulation of the ESSA instruction.
>>>> Let's extend the locking to all related ioctls by using
>>>> the slots lock and wait for the freeing until all unlocked
>>>> users have finished (those hold kvm->srcu for read).
>>>>
>>>> Reported-by: David Hildenbrand <david@redhat.com>
>>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>> Cc: stable@vger.kernel.org # 4.13+
>>>> Fixes: 190df4a212a7 (KVM: s390: CMMA tracking, ESSA emulation, migration mode)
>>>> Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
>>>> ---
>>>> v1->v2: fix comments in kvm_s390_vm_[start|stop]_migration
>>>>  arch/s390/kvm/kvm-s390.c | 18 +++++++++++-------
>>>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>>> index 2a5a9f0617f88..e81b748af4553 100644
>>>> --- a/arch/s390/kvm/kvm-s390.c
>>>> +++ b/arch/s390/kvm/kvm-s390.c
>>>> @@ -769,7 +769,7 @@ static void kvm_s390_sync_request_broadcast(struct kvm *kvm, int req)
>>>>  
>>>>  /*
>>>>   * Must be called with kvm->srcu held to avoid races on memslots, and with
>>>> - * kvm->lock to avoid races with ourselves and kvm_s390_vm_stop_migration.
>>>> + * kvm->slots_lock to avoid races with ourselves and kvm_s390_vm_stop_migration.
>>>>   */
>>>>  static int kvm_s390_vm_start_migration(struct kvm *kvm)
>>>>  {
>>>> @@ -824,7 +824,7 @@ static int kvm_s390_vm_start_migration(struct kvm *kvm)
>>>>  }
>>>>  
>>>>  /*
>>>> - * Must be called with kvm->lock to avoid races with ourselves and
>>>> + * Must be called with kvm->slots_lock to avoid races with ourselves and
>>>>   * kvm_s390_vm_start_migration.
>>>>   */
>>>>  static int kvm_s390_vm_stop_migration(struct kvm *kvm)
>>>> @@ -839,6 +839,8 @@ static int kvm_s390_vm_stop_migration(struct kvm *kvm)
>>>>  
>>>>  	if (kvm->arch.use_cmma) {
>>>>  		kvm_s390_sync_request_broadcast(kvm, KVM_REQ_STOP_MIGRATION);
>>>> +		/* We have to wait for the essa emulation to finish */
>>>> +		synchronize_srcu(&kvm->srcu);
>>>>  		vfree(mgs->pgste_bitmap);
>>>>  	}
>>>>  	kfree(mgs);
>>>> @@ -848,14 +850,12 @@ static int kvm_s390_vm_stop_migration(struct kvm *kvm)
>>>>  static int kvm_s390_vm_set_migration(struct kvm *kvm,
>>>>  				     struct kvm_device_attr *attr)
>>>>  {
>>>> -	int idx, res = -ENXIO;
>>>> +	int res = -ENXIO;
>>>>  
>>>> -	mutex_lock(&kvm->lock);
>>>> +	mutex_lock(&kvm->slots_lock);
>>>
>>> Why were we holding the kvm lock here? Is it okay to drop this lock now?
>>>
>>> (I assume it only existed to avoid having multiple concurrent users
>>> trying to set the migration state - in that case this is fine)
>>
>> Yes, it was used to prevent multiple users. 
> 
> So we are using srcu to protect a pointer not managed via rcu. Looks
> strange, but guess this works because of the request bit handling.

No we are using kvm_slots_locks for all migration related functions:
-kvm_s390_vm_start_migration
-kvm_s390_vm_stop_migration
-kvm_s390_set_cmma_bits
-kvm_s390_get_cmma_bits


In addition to that we use synchronize_srcu to ensure that the essa handler 
has finished. 
