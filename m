From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 1/1] KVM: s390: fix cmma migration for multiple memory
 slots
Date: Tue, 19 Dec 2017 21:21:57 +0100
Message-ID: <de15ace8-6681-cb19-c739-e18692eba84f@de.ibm.com>
References: <20171219081921.81670-1-borntraeger@de.ibm.com>
 <20171219081921.81670-2-borntraeger@de.ibm.com>
 <1ac27d73-d4a7-b596-266b-8a3ff8aa6f41@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1ac27d73-d4a7-b596-266b-8a3ff8aa6f41@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 12/19/2017 06:11 PM, David Hildenbrand wrote:
> On 19.12.2017 09:19, Christian Borntraeger wrote:
>> when multiple memory slots are present the cmma migration code
>> does not allocate enough memory for the bitmap. The memory slots
>> are sorted in reverse order, so we must use gfn and size of
>> slot[0] instead of the last one.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
>> Cc: stable@vger.kernel.org # 4.13+
>> Fixes: 190df4a212a7 (KVM: s390: CMMA tracking, ESSA emulation, migration mode)
>> ---
>>  arch/s390/kvm/kvm-s390.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 966ea611210a..3373d8dff131 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -792,11 +792,12 @@ static int kvm_s390_vm_start_migration(struct kvm *kvm)
>>  
>>  	if (kvm->arch.use_cmma) {
>>  		/*
>> -		 * Get the last slot. They should be sorted by base_gfn, so the
>> -		 * last slot is also the one at the end of the address space.
>> -		 * We have verified above that at least one slot is present.
>> +		 * Get the first slot. They are reverse sorted by base_gfn, so
>> +		 * the first slot is also the one at the end of the address
>> +		 * space. We have verified above that at least one slot is
>> +		 * present.
>>  		 */
>> -		ms = slots->memslots + slots->used_slots - 1;
>> +		ms = slots->memslots;
>>  		/* round up so we only use full longs */
>>  		ram_pages = roundup(ms->base_gfn + ms->npages, BITS_PER_LONG);
>>  		/* allocate enough bytes to store all the bits */
>>
> 
> If I am not wrong, can't user space:
> 
> a) Create a VM, boot linux
> b) Trigger VM START migration, initializing the bitmap
> c) add a new memslot
> c) make the guest execute an ESSA instruction on that new memslot
> 
> in do_essa(), gfn_to_hva() will now succeed and we will write into some
> random memory as the bitmap is too short:
> 
> "test_and_set_bit(gfn, ms->pgste_bitmap)"
> 
> 
> The same could be possible if the guest onlines memory (creating the
> memslot via SCLP) during VM migration

Yes, this is another bug in that code. Since I would like to avoid coupling this with
KVM_S390_VM_MEM_LIMIT_SIZE I will likely do something like the following as an additional
patch (or folded in).
Will do a proper patch tomorrow.

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 572496c688cc..c554c06fdc6e 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -1006,7 +1006,7 @@ static inline int do_essa(struct kvm_vcpu *vcpu, const int orc)
                cbrlo[entries] = gfn << PAGE_SHIFT;
        }
 
-       if (orc) {
+       if (orc && gfn < ms->ram_pages) {
                /* increment only if we are really flipping the bit to 1 */
                if (!test_and_set_bit(gfn, ms->pgste_bitmap))
                        atomic64_inc(&ms->dirty_pages);
