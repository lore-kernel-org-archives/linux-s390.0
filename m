Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62272 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725894AbgFQLNg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Jun 2020 07:13:36 -0400
Subject: Re: [PATCH] KVM: s390: reduce number of IO pins to 1
References: <20200617083620.5409-1-borntraeger@de.ibm.com>
 <d17de7d7-6cca-672a-5519-c67fc147f6a5@redhat.com>
 <6953c580-9b99-1c76-b6eb-510dcb70894c@de.ibm.com>
 <20200617131101.36d2475e.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <a73f2316-e5d1-692d-2e08-51f3a2d7d26c@de.ibm.com>
Date: Wed, 17 Jun 2020 13:13:29 +0200
MIME-Version: 1.0
In-Reply-To: <20200617131101.36d2475e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>



On 17.06.20 13:11, Cornelia Huck wrote:
> On Wed, 17 Jun 2020 13:04:52 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 17.06.20 12:19, David Hildenbrand wrote:
>>> On 17.06.20 10:36, Christian Borntraeger wrote:  
>>>> The current number of KVM_IRQCHIP_NUM_PINS results in an order 3
>>>> allocation (32kb) for each guest start/restart. This can result in OOM
>>>> killer activity even with free swap when the memory is fragmented
>>>> enough:
>>>>
>>>> kernel: qemu-system-s39 invoked oom-killer: gfp_mask=0x440dc0(GFP_KERNEL_ACCOUNT|__GFP_COMP|__GFP_ZERO), order=3, oom_score_adj=0
>>>> kernel: CPU: 1 PID: 357274 Comm: qemu-system-s39 Kdump: loaded Not tainted 5.4.0-29-generic #33-Ubuntu
>>>> kernel: Hardware name: IBM 8562 T02 Z06 (LPAR)
>>>> kernel: Call Trace:
>>>> kernel: ([<00000001f848fe2a>] show_stack+0x7a/0xc0)
>>>> kernel:  [<00000001f8d3437a>] dump_stack+0x8a/0xc0
>>>> kernel:  [<00000001f8687032>] dump_header+0x62/0x258
>>>> kernel:  [<00000001f8686122>] oom_kill_process+0x172/0x180
>>>> kernel:  [<00000001f8686abe>] out_of_memory+0xee/0x580
>>>> kernel:  [<00000001f86e66b8>] __alloc_pages_slowpath+0xd18/0xe90
>>>> kernel:  [<00000001f86e6ad4>] __alloc_pages_nodemask+0x2a4/0x320
>>>> kernel:  [<00000001f86b1ab4>] kmalloc_order+0x34/0xb0
>>>> kernel:  [<00000001f86b1b62>] kmalloc_order_trace+0x32/0xe0
>>>> kernel:  [<00000001f84bb806>] kvm_set_irq_routing+0xa6/0x2e0
>>>> kernel:  [<00000001f84c99a4>] kvm_arch_vm_ioctl+0x544/0x9e0
>>>> kernel:  [<00000001f84b8936>] kvm_vm_ioctl+0x396/0x760
>>>> kernel:  [<00000001f875df66>] do_vfs_ioctl+0x376/0x690
>>>> kernel:  [<00000001f875e304>] ksys_ioctl+0x84/0xb0
>>>> kernel:  [<00000001f875e39a>] __s390x_sys_ioctl+0x2a/0x40
>>>> kernel:  [<00000001f8d55424>] system_call+0xd8/0x2c8
>>>>
>>>> As far as I can tell s390x does not use the iopins as we bail our for
>>>> anything other than KVM_IRQ_ROUTING_S390_ADAPTER and the chip/pin is
>>>> only used for KVM_IRQ_ROUTING_IRQCHIP. So let us use a small number to
>>>> reduce the memory footprint.
>>>>
>>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>> ---
>>>>  arch/s390/include/asm/kvm_host.h | 8 ++++----
>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>>>> index cee3cb6455a2..6ea0820e7c7f 100644
>>>> --- a/arch/s390/include/asm/kvm_host.h
>>>> +++ b/arch/s390/include/asm/kvm_host.h
>>>> @@ -31,12 +31,12 @@
>>>>  #define KVM_USER_MEM_SLOTS 32
>>>>  
>>>>  /*
>>>> - * These seem to be used for allocating ->chip in the routing table,
>>>> - * which we don't use. 4096 is an out-of-thin-air value. If we need
>>>> - * to look at ->chip later on, we'll need to revisit this.
>>>> + * These seem to be used for allocating ->chip in the routing table, which we
>>>> + * don't use. 1 is as small as we can get to reduce the needed memory. If we
>>>> + * need to look at ->chip later on, we'll need to revisit this.
>>>>   */
>>>>  #define KVM_NR_IRQCHIPS 1
>>>> -#define KVM_IRQCHIP_NUM_PINS 4096
>>>> +#define KVM_IRQCHIP_NUM_PINS 1
>>>>  #define KVM_HALT_POLL_NS_DEFAULT 50000
>>>>  
>>>>  /* s390-specific vcpu->requests bit members */
>>>>  
>>>
>>> Guess it doesn't make sense to wrap all the "->chip" handling in a
>>> separate set of defines.
>>>
>>> Reviewed-by: David Hildenbrand <david@redhat.com>  
>>
>> I guess this is just the most simple solution. I am asking myself if I should add
>> cc stable of Fixes as I was able to trigger this by having several guests with a
>> reboot loop and several guests that trigger memory overcommitment.
>>
> 
> Not sure if I would count this as a real bug -- it's mostly just that a
> large enough memory allocation may fail or draw the wrath of the oom
> killer. It still sucks; but I'm wondering why we trigger this after
> seven years.

I think it is just that every kernel has a different threshold regarding "did
I made forward progress in freeing enough memory before I trigger the OOM killer"
I had to make it run very long with heavy overcommitment. 
