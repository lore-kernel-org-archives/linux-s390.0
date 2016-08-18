From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/4] KVM-S390: Improve determination of sizes in
 kvm_s390_import_bp_data()
Date: Thu, 18 Aug 2016 12:55:11 +0200
Message-ID: <38bba070-d157-dc49-b428-47768ad647ca@redhat.com>
References: <82b84c9c-38a4-4d17-910f-312668dbae01@users.sourceforge.net>
 <033d8595-d051-1fa8-95b1-5d2056eb5667@users.sourceforge.net>
 <57B562F3.1080004@bfs.de> <alpine.DEB.2.10.1608180502080.3107@hadrien>
 <9db1986a-9b93-72ca-f35e-85b5b5e9f351@redhat.com> <57B5935B.3050602@bfs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57B5935B.3050602@bfs.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: wharms@bfs.de
Cc: Julia Lawall <julia.lawall@lip6.fr>, SF Markus Elfring <elfring@users.sourceforge.net>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 18/08/2016 12:52, walter harms wrote:
> 
> 
> Am 18.08.2016 11:48, schrieb Paolo Bonzini:
>>
>>
>> On 18/08/2016 11:02, Julia Lawall wrote:
>>>
>>>
>>> On Thu, 18 Aug 2016, walter harms wrote:
>>>
>>>>
>>>>
>>>> Am 17.08.2016 20:06, schrieb SF Markus Elfring:
>>>>> From: Markus Elfring <elfring@users.sourceforge.net>
>>>>> Date: Wed, 17 Aug 2016 18:29:04 +0200
>>>>>
>>>>> Replace the specification of data structures by pointer dereferences
>>>>> to make the corresponding size determination a bit safer according to
>>>>> the Linux coding style convention.
>>>>>
>>>>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>>>>> ---
>>>>>  arch/s390/kvm/guestdbg.c | 6 +++---
>>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/arch/s390/kvm/guestdbg.c b/arch/s390/kvm/guestdbg.c
>>>>> index d1f8241..b68db4b 100644
>>>>> --- a/arch/s390/kvm/guestdbg.c
>>>>> +++ b/arch/s390/kvm/guestdbg.c
>>>>> @@ -216,7 +216,7 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
>>>>>  	else if (dbg->arch.nr_hw_bp > MAX_BP_COUNT)
>>>>>  		return -EINVAL;
>>>>>
>>>>> -	size = dbg->arch.nr_hw_bp * sizeof(struct kvm_hw_breakpoint);
>>>>> +	size = dbg->arch.nr_hw_bp * sizeof(*bp_data);
>>>>>  	bp_data = kmalloc(size, GFP_KERNEL);
>>>>>  	if (!bp_data) {
>>>>>  		ret = -ENOMEM;
>>>>> @@ -241,7 +241,7 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
>>>>>  		}
>>>>>  	}
>>>>>
>>>>> -	size = nr_wp * sizeof(struct kvm_hw_wp_info_arch);
>>>>> +	size = nr_wp * sizeof(*wp_info);
>>>>>  	if (size > 0) {
>>>>>  		wp_info = kmalloc(size, GFP_KERNEL);
>>>>>  		if (!wp_info) {
>>>>> @@ -249,7 +249,7 @@ int kvm_s390_import_bp_data(struct kvm_vcpu *vcpu,
>>>>>  			goto error;
>>>>>  		}
>>>>>  	}
>>>>> -	size = nr_bp * sizeof(struct kvm_hw_bp_info_arch);
>>>>> +	size = nr_bp * sizeof(*bp_info);
>>>>>  	if (size > 0) {
>>>>>  		bp_info = kmalloc(size, GFP_KERNEL);
>>>>>  		if (!bp_info) {
>>>>
>>>>
>>>> IMHO the common pattern for kmalloc is
>>>>   bp_info = kmalloc( nr_bp * sizeof(*bp_info), GFP_KERNEL);
>>>>
>>>> i can not remember code with a check for size < 0, i guess it is here
>>>> to avoid an overflow ? since kmalloc takes a size_t argument this would cause
>>>> a malloc failure an can be ignored.
>>>
>>> Shoudn't it be kcalloc?
>>
>> Or kmalloc_array, since zeroing is not necessary.  Might be an idea for
>> a new Coccinelle script, like
>>
>> - kmalloc (N * sizeof T, GFP)
>> + kmalloc_array(N, sizeof T, GFP)
>>
> 
> 
> my personal taste is to stay close to the libc functions.
> technical there is no difference
> 
> static inline void *kcalloc(size_t n, size_t size, gfp_t flags)
>  {
>         return kmalloc_array(n, size, flags | __GFP_ZERO);
>  }
> 
> and i do not see any time critical things here,

This is _not_ premature optimization.  (k)calloc tells the reader that
it's safe not to initialize part of the array.  kmalloc_array says the
opposite.  Using the right function adds important hints in the
code---which unlike comments cannot get stale without also introducing
visible bugs.

Paolo
