From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 0/2] KVM: s390: fixups for cmma migration (kvm/master)
Date: Thu, 21 Dec 2017 13:26:45 +0100
Message-ID: <47241caa-9e66-7b1e-bdc5-af1d52fc8407@de.ibm.com>
References: <20171221090416.17351-1-borntraeger@de.ibm.com>
 <bcf68339-9e90-8d5a-0e77-2a0b72fbbc6c@redhat.com>
 <36afdadb-994b-22b8-70fd-ff99efb859a3@redhat.com>
 <32605f3e-b533-d059-88a7-f49380215cf8@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <32605f3e-b533-d059-88a7-f49380215cf8@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, KVM <kvm@vger.kernel.org>
Cc: Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 12/21/2017 01:12 PM, Christian Borntraeger wrote:
> 
> 
> On 12/21/2017 01:03 PM, David Hildenbrand wrote:
>> On 21.12.2017 12:57, David Hildenbrand wrote:
>>> On 21.12.2017 10:04, Christian Borntraeger wrote:
>>>> This is targetted as minimal fixups. Claudio is reworking this
>>>> to handle this better in general (e.g. memory wholes).
>>>>
>>>> I will wait for a review for patch2 (which is new) and then spin
>>>> a pull request as we now have 2 patches for master
>>>>
>>>> Christian Borntraeger (2):
>>>>   KVM: s390: fix cmma migration for multiple memory slots
>>>>   KVM: s390: prevent buffer overrun on memory hotplug during migration
>>>>
>>>>  arch/s390/kvm/kvm-s390.c | 9 +++++----
>>>>  arch/s390/kvm/priv.c     | 2 +-
>>>>  2 files changed, 6 insertions(+), 5 deletions(-)
>>>>
>>>
>>> [waking up from vacation mode]
>>>
>>> Sorry to say, but I guess there is more.
>>>
>>> do_essa() can race with
>>> kvm_s390_vm_set_migration(KVM_S390_VM_MIGRATION_STOP).
>>>
>>> CPU0: handle_essa()
>>> 	-> vcpu->kvm->arch.migration_state == true
>>> 	-> do_essa()
>>> CPU1: kvm_s390_vm_set_migration(KVM_S390_VM_MIGRATION_STOP)
>>> 	-> vcpu->kvm->arch.migration_state = false;
>>> 	-> vfree(mgs->pgste_bitmap)
>>> CPU0: test_and_set_bit(gfn, ms->pgste_bitmap)
>>> 	-> access to freed data structure
>>>
>>> The kvm_s390_sync_request_broadcast(kvm, KVM_REQ_STOP_MIGRATION) will
>>> only make sure that all CPUs have left SIE mode, not that the request
>>> has been processed.
>>>
>>> Does that make sense?
>>>
>>> [going back to vacation mode]
>>>
>>
>> FWIW, doesn't apply the same thing to kvm_s390_get_cmma_bits(), too? I
>> can't find locking while quickly glimpsing over it. But I might be wrong.
> 
> If there is a bug in a piece of code it is certainly a good idea to look deeper....
> I think we can prevent both bugs by something like
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 8951ad4d33be..6ee12afced5a 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -841,6 +841,7 @@ static int kvm_s390_vm_stop_migration(struct kvm *kvm)
>  
>         if (kvm->arch.use_cmma) {
>                 kvm_s390_sync_request_broadcast(kvm, KVM_REQ_STOP_MIGRATION);
> +               synchronize_srcu(&kvm->srcu);
>                 vfree(mgs->pgste_bitmap);
>         }
>         kfree(mgs);
> 
> 
> Need to have a look.

It needs a bit more changes for the get_cmma case.
