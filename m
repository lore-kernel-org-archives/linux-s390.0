From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 1/1] KVM: s390: mark irq_state.flags as non-usable
Date: Tue, 21 Nov 2017 19:27:28 +0100
Message-ID: <1cc037e2-3b22-93a5-49f1-6b56a1112f66@redhat.com>
References: <20171121150806.47075-1-borntraeger@de.ibm.com>
 <638982df-e3a1-16d4-51a2-5a400075ac3d@redhat.com>
 <11a6b47b-9e82-78b0-aba0-89d8ae3e4339@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <11a6b47b-9e82-78b0-aba0-89d8ae3e4339@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Halil Pasic <pasic@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 21.11.2017 18:42, Christian Borntraeger wrote:
> 
> 
> On 11/21/2017 04:18 PM, David Hildenbrand wrote:
>> On 21.11.2017 16:08, Christian Borntraeger wrote:
>>> Old kernels did not check for zero in the irq_state.flags field and old
>>> QEMUs did not zero the flag field when calling KVM_S390_*_IRQ_STATE.
>>> Let's add a comment and dummy code to prevent future usage of flags
>>> and pad.
>>>
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>>  arch/s390/kvm/kvm-s390.c | 14 ++++++++++++++
>>>  1 file changed, 14 insertions(+)
>>>
>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>> index 6a5e02f..1baa393 100644
>>> --- a/arch/s390/kvm/kvm-s390.c
>>> +++ b/arch/s390/kvm/kvm-s390.c
>>> @@ -3834,6 +3834,16 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>>>  			r = -EINVAL;
>>>  			break;
>>>  		}
>>> +		if (irq_state.flags) {
>>
>> I don't see the need for if (do I need more coffee?).
> 
> It is a dummy construct that matches other checks like "if flags return -EINVAL". But since
> it is dummy we can do whatever we want (even just a comment) since nobody reads flags as of
> today.

Not sure if changing the code here really makes sense ... I think I'd
rather prefer to add a comment to the header where the struct is
defined, and add some proper sentences about "flags" to the api.txt file.

 Thomas
