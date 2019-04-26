Return-Path: <SRS0=JTmC=S4=vger.kernel.org=kvm-owner@kernel.org>
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH] KVM: s390: vsie: Do not shadow CRYCB when no AP and no
 keys
References: <1556269010-22258-1-git-send-email-pmorel@linux.ibm.com>
 <fcb4dd93-0035-2d19-10db-7c22b7a21606@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 26 Apr 2019 12:59:46 +0200
MIME-Version: 1.0
In-Reply-To: <fcb4dd93-0035-2d19-10db-7c22b7a21606@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <07bf68b1-43a7-07cd-a869-2d53d985d631@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 26/04/2019 11:04, David Hildenbrand wrote:
> On 26.04.19 10:56, Pierre Morel wrote:
>> When the guest do not have AP instructions nor Key management
>> we should return without shadowing the CRYCB.
>>
>> We did not check correctly in the past.
>>
>> Fixes: b10bd9a256ae ("s390: vsie: Use effective CRYCBD.31 to check CRYCBD
>> validity")
> 
> We should really try to pay more attention, commit b10bd9a256ae already
> was supposed to fix 6ee74098201b.

yes, sorry for that.

> 
> Unfortunately, I don't have access to documentation and can't verify.
> 
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks

> 
>> Fixes: 6ee74098201b ("KVM: s390: vsie: allow CRYCB FORMAT-0")
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   arch/s390/kvm/vsie.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>> index c6983d9..ac411e9 100644
>> --- a/arch/s390/kvm/vsie.c
>> +++ b/arch/s390/kvm/vsie.c
>> @@ -290,6 +290,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>   	u8 ecb3_flags;
>>   	u32 ecd_flags;
>>   	int apie_h;
>> +	int apie_s;
>>   	int key_msk = test_kvm_facility(vcpu->kvm, 76);
>>   	int fmt_o = crycbd_o & CRYCB_FORMAT_MASK;
>>   	int fmt_h = vcpu->arch.sie_block->crycbd & CRYCB_FORMAT_MASK;
>> @@ -298,7 +299,8 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>   	scb_s->crycbd = 0;
>>   
>>   	apie_h = vcpu->arch.sie_block->eca & ECA_APIE;
>> -	if (!apie_h && (!key_msk || fmt_o == CRYCB_FORMAT0))
>> +	apie_s = apie_h & scb_o->eca;
>> +	if (!apie_s && (!key_msk || (fmt_o == CRYCB_FORMAT0)))
>>   		return 0;
>>   
>>   	if (!crycb_addr)
>> @@ -309,7 +311,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>   		    ((crycb_addr + 128) & PAGE_MASK))
>>   			return set_validity_icpt(scb_s, 0x003CU);
>>   
>> -	if (apie_h && (scb_o->eca & ECA_APIE)) {
>> +	if (apie_s) {
>>   		ret = setup_apcb(vcpu, &vsie_page->crycb, crycb_addr,
>>   				 vcpu->kvm->arch.crypto.crycb,
>>   				 fmt_o, fmt_h);
>>
> 
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
