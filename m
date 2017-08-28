From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 05/11] KVM: s390: Support Configuration z/Architecture
 Mode
Date: Mon, 28 Aug 2017 16:24:05 +0200
Message-ID: <c71d559e-a304-c6cd-3bbf-30fb7851d681@de.ibm.com>
References: <1503907651-65296-1-git-send-email-borntraeger@de.ibm.com>
 <1503907651-65296-2-git-send-email-borntraeger@de.ibm.com>
 <a73ff132-288f-3acc-3b4c-3369145b48cf@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <a73ff132-288f-3acc-3b4c-3369145b48cf@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 08/28/2017 04:06 PM, David Hildenbrand wrote:
> On 28.08.2017 10:07, Christian Borntraeger wrote:
>> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
>>
>> kvm has always supported the concept of starting in z/Arch mode so let's
>> reflect the feature bit to the guest.
>>
>> Also, we change sigp set architecture to reject any request to change
>> architecture modes.
> 
> Hm ... this seems to imply that CZAM is always set, but what about
> running on old user space (possibly on old hw)? Old QEMU will not enable
> CZAM.

3 cases.
1. very old QEMU without user sigp
2. old QEMU with user sigp/without CPU model
3. new QEMU with user sigp/cpu model

I think we agree that cases 2 and 3 should not matter at all for this kernel patch
as the sigp is handled by QEMU. 



This is case 1:
> And especially old user space will rely on SET ARCHITECTURE being
> handled in the kernel.


Yes, and it continues to be handled in the kernel. It is just that the guest
will now see a different sigp return code. Before, our sigp implementation lied
to the guest in a way that worked for Linux (we lied by saying "yes, we switched"). 
We now say "sorry, we are already in zarch mode, sigp ignored" which also works
perfectly fine for Linux. And IMHO it is even the better choice even without 
STFLE.138 being set as it matches what an old hardware would do when in zarch mode.


> 
> I agree, that for QEMU we can always do that change (as we control which
> features are indicated to the guest). But I am wondering if we would
> have to stick to existing behavior unless test_kvm_facility(vcpu->kvm, 138).
> 
>>
>> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/kvm/sigp.c             | 36 +++++++++++++++++-------------------
>>  arch/s390/tools/gen_facilities.c |  1 +
>>  2 files changed, 18 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
>> index 1a252f5..11d3845 100644
>> --- a/arch/s390/kvm/sigp.c
>> +++ b/arch/s390/kvm/sigp.c
>> @@ -155,29 +155,26 @@ static int __sigp_stop_and_store_status(struct kvm_vcpu *vcpu,
>>  	return rc;
>>  }
>>  
> [...]
> 
>>  	}
>> -	return rc;
>> +
>> +	*status_reg &= 0xffffffff00000000ULL;
> 
> s/ULL/UL/


Right, will fix.
