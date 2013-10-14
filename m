From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [Patchv5 2/7] KVM: s390: add floating irq controller
Date: Mon, 14 Oct 2013 09:58:47 +0200
Message-ID: <525BA437.2030707@de.ibm.com>
References: <1381244100-59056-1-git-send-email-borntraeger@de.ibm.com> <1381244100-59056-3-git-send-email-borntraeger@de.ibm.com> <20131013083954.GB15657@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20131013083954.GB15657@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Jens Freimann <jfrei@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 13/10/13 10:39, Gleb Natapov wrote:
> On Tue, Oct 08, 2013 at 04:54:55PM +0200, Christian Borntraeger wrote:
>> From: Jens Freimann <jfrei@linux.vnet.ibm.com>
>>
>> This patch adds a floating irq controller as a kvm_device.
>> It will be necessary for migration of floating interrupts as well
>> as for hardening the reset code by allowing user space to explicitly
>> remove all pending floating interrupts.
>>
>> Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
>> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  Documentation/virtual/kvm/devices/s390_flic.txt |  36 +++
>>  arch/s390/include/asm/kvm_host.h                |   1 +
>>  arch/s390/include/uapi/asm/kvm.h                |   5 +
>>  arch/s390/kvm/interrupt.c                       | 296 ++++++++++++++++++++----
>>  arch/s390/kvm/kvm-s390.c                        |   1 +
>>  include/linux/kvm_host.h                        |   1 +
>>  include/uapi/linux/kvm.h                        |   1 +
>>  virt/kvm/kvm_main.c                             |   5 +
>>  8 files changed, 295 insertions(+), 51 deletions(-)
>>  create mode 100644 Documentation/virtual/kvm/devices/s390_flic.txt
>>
>> diff --git a/Documentation/virtual/kvm/devices/s390_flic.txt b/Documentation/virtual/kvm/devices/s390_flic.txt
>> new file mode 100644
>> index 0000000..06aef31
>> --- /dev/null
>> +++ b/Documentation/virtual/kvm/devices/s390_flic.txt
>> @@ -0,0 +1,36 @@
>> +FLIC (floating interrupt controller)
>> +====================================
>> +
>> +FLIC handles floating (non per-cpu) interrupts, i.e.  I/O, service and some
>> +machine check interruptions. All interrupts are stored in a per-vm list of
>> +pending interrupts. FLIC performs operations on this list.
>> +
>> +Only one FLIC instance may be instantiated.
>> +
>> +FLIC provides support to
>> +- add/delete interrupts (KVM_DEV_FLIC_ENQUEUE and _DEQUEUE)
>> +- purge all pending floating interrupts (KVM_DEV_FLIC_CLEAR_IRQS)
>> +
>> +Groups:
>> +  KVM_DEV_FLIC_ENQUEUE
>> +    Adds one interrupt to the list of pending floating interrupts. Interrupts
>> +    are taken from this list for injection into the guest. attr contains
>> +    a struct kvm_s390_irq which contains all data relevant for
>> +    interrupt injection.
>> +    The format of the data structure kvm_s390_irq as it is copied from userspace
>> +    is defined in usr/include/linux/kvm.h.
>> +    For historic reasons list members are stored in a different data structure, i.e.
>> +    we need to copy the relevant data into a struct kvm_s390_interrupt_info
>> +    which can then be added to the list.
>> +
>> +  KVM_DEV_FLIC_DEQUEUE
>> +    Takes one element off the pending interrupts list and copies it into userspace.
>> +    Dequeued interrupts are not injected into the guest.
>> +    attr->addr contains the userspace address of a struct kvm_s390_irq.
>> +    List elements are stored in the format of struct kvm_s390_interrupt_info
>> +    (arch/s390/include/asm/kvm_host.h) and are copied into a struct kvm_s390_irq
>> +    (usr/include/linux/kvm.h)
>> +
> Can interrupt be dequeued on real HW also? When this interface will be
> used?

This is used for migration. (Will send the qemu patches soon). 

The thing is,that we dont have classic interrupt lines from a software perspective. We have
external interrupts, I/O interrupts, machine check interrupts, program interrupts, restart
interrupts, supervisor call interrupts. Several interrupts are cpu local (restart, supervisor
call, program check interrupts). This is simple, because only one interrupt can be pending
at a CPU.

There are several types of external interrupts. Some are cpu local (after a sigp --> IPI)
others are floating (pending on all CPUs).

All I/O interrupts are floating. The thing is now, that each classic I/O interrupts has a 12
byte chunk of per interrupt payload. (There is an additional interrupt response block that has
to be queried by the guest with TSCH). 

Since we can have up to 256k devices per guest, we could in theory have up to 256k classic 
interrupts with different payload pending. (plus machine checks, plus other floating external
interupts)
We dont want to always dump this big queue, therefore we decided to keep these in a list.

I think Jens will give some introduction about s390 architecture at the KVM forum this year.


PS: There is some upcoming changes that will use adapter interrupts for virtio (I/O interrupts
with limited payload that do interrupt coalescing for all pending devices), Still we need to
be able to handle the classic interrupts as well for ccw configuration handling.
