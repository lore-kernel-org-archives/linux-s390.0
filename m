From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 0/2] KVM: s390: fixups for cmma migration (kvm/master)
Date: Thu, 21 Dec 2017 12:57:04 +0100
Message-ID: <bcf68339-9e90-8d5a-0e77-2a0b72fbbc6c@redhat.com>
References: <20171221090416.17351-1-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171221090416.17351-1-borntraeger@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>
Cc: Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 21.12.2017 10:04, Christian Borntraeger wrote:
> This is targetted as minimal fixups. Claudio is reworking this
> to handle this better in general (e.g. memory wholes).
> 
> I will wait for a review for patch2 (which is new) and then spin
> a pull request as we now have 2 patches for master
> 
> Christian Borntraeger (2):
>   KVM: s390: fix cmma migration for multiple memory slots
>   KVM: s390: prevent buffer overrun on memory hotplug during migration
> 
>  arch/s390/kvm/kvm-s390.c | 9 +++++----
>  arch/s390/kvm/priv.c     | 2 +-
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 

[waking up from vacation mode]

Sorry to say, but I guess there is more.

do_essa() can race with
kvm_s390_vm_set_migration(KVM_S390_VM_MIGRATION_STOP).

CPU0: handle_essa()
	-> vcpu->kvm->arch.migration_state == true
	-> do_essa()
CPU1: kvm_s390_vm_set_migration(KVM_S390_VM_MIGRATION_STOP)
	-> vcpu->kvm->arch.migration_state = false;
	-> vfree(mgs->pgste_bitmap)
CPU0: test_and_set_bit(gfn, ms->pgste_bitmap)
	-> access to freed data structure

The kvm_s390_sync_request_broadcast(kvm, KVM_REQ_STOP_MIGRATION) will
only make sure that all CPUs have left SIE mode, not that the request
has been processed.

Does that make sense?

[going back to vacation mode]

-- 

Thanks,

David / dhildenb
