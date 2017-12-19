From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 1/1] KVM: s390: fix cmma migration for multiple memory
 slots
Date: Tue, 19 Dec 2017 12:04:10 +0100
Message-ID: <3d728530-6317-9756-0d1e-f08edec18d56@de.ibm.com>
References: <20171219081921.81670-1-borntraeger@de.ibm.com>
 <20171219081921.81670-2-borntraeger@de.ibm.com>
 <20171219114142.3490f80b.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171219114142.3490f80b.cohuck@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <linux-s390.vger.kernel.org>



On 12/19/2017 11:41 AM, Cornelia Huck wrote:
> On Tue, 19 Dec 2017 09:19:21 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> when multiple memory slots are present the cmma migration code
> 
> s/when/When/
> 
>> does not allocate enough memory for the bitmap. The memory slots
>> are sorted in reverse order, so we must use gfn and size of
>> slot[0] instead of the last one.
> 
> I've spent way too much time looking at the memslot code, but this
> seems correct.
> 
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
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 
> As you wrote, this is good as a minimal fix.


Paolo, Radim,

do you want a respin and/or pull request or can you take a fixed up version (
adding the Review and fixing when vs When/ for kvm/master?
