From: Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH v6 11/13] KVM: s390: add functions to (un)register GISC
 with GISA
Date: Tue, 29 Jan 2019 14:32:21 +0100
Message-ID: <b323fd49-0a72-fe78-0cdb-42a23f264811@linux.ibm.com>
References: <20190124125939.130763-1-mimu@linux.ibm.com>
 <20190124125939.130763-12-mimu@linux.ibm.com>
 <20190129140905.288d750a.cohuck@redhat.com>
Reply-To: mimu@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190129140905.288d750a.cohuck@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM Mailing List <kvm@vger.kernel.org>, Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 29.01.19 14:09, Cornelia Huck wrote:
> On Thu, 24 Jan 2019 13:59:37 +0100
> Michael Mueller <mimu@linux.ibm.com> wrote:
> 
>> Add the Interruption Alert Mask (IAM) to the architecture specific
>> kvm struct. This mask in the GISA is used to define for which ISC
>> a GIB alert will be issued.
>>
>> The functions kvm_s390_gisc_register() and kvm_s390_gisc_unregister()
>> are used to (un)register a GISC (guest ISC) with a virtual machine and
>> its GISA.
>>
>> Upon successful completion, kvm_s390_gisc_register() returns the
>> ISC to be used for GIB alert interruptions. A negative return code
>> indicates an error during registration.
>>
>> Theses functions will be used by other adapter types like AP and PCI to
>> request pass-through interruption support.
>>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm_host.h |  13 +++++
>>   arch/s390/kvm/interrupt.c        | 117 +++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 130 insertions(+)
>>
> 
>> +int kvm_s390_gisc_register(struct kvm *kvm, u32 gisc)
>> +{
>> +	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
>> +	u8 alert_mask;
>> +
>> +	if (!gi->origin)
>> +		return -ENODEV;
>> +	if (gisc > MAX_ISC)
>> +		return -ERANGE;
>> +
>> +	spin_lock(&gi->alert.ref_lock);
>> +	if (gi->alert.ref_count[gisc] == 0) {
> 
> If the ref_count is 0 here...
> 
>> +		alert_mask = gi->alert.mask | 0x80 >> gisc;
>> +		WRITE_ONCE(gi->alert.mask, alert_mask);
>> +	}
>> +	gi->alert.ref_count[gisc]++;
>> +	if (gi->alert.ref_count[gisc] == 1)
> 
> ...it will certainly be 1 here, won't it?

Sure, the increment is unconditional and can be done right away.
Thus it is logically the same and now symmetric to the unregister
function:

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index ba314da746b7..f37dfb01c63c 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2976,11 +2976,11 @@ int kvm_s390_gisc_register(struct kvm *kvm, u32 
gisc)
                 return -ERANGE;

         spin_lock(&gi->alert.ref_lock);
-       if (gi->alert.ref_count[gisc] == 0)
-               gi->alert.mask |= 0x80 >> gisc;
         gi->alert.ref_count[gisc]++;
-       if (gi->alert.ref_count[gisc] == 1)
+       if (gi->alert.ref_count[gisc] == 1) {
+               gi->alert.mask |= 0x80 >> gisc;
                 gisa_set_iam(gi->origin, gi->alert.mask);
+       }
         spin_unlock(&gi->alert.ref_lock);

         return gib->nisc;


> 
> Can you do all of the manipulations in a single if branch?
> 
>> +		gisa_set_iam(gi->origin, alert_mask);
>> +	spin_unlock(&gi->alert.ref_lock);
>> +
>> +	return gib->nisc;
>> +}
> 

Thanks,
Michael
