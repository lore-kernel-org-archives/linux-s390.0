From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 7/7] s390/kvm: In-kernel channel subsystem support.
Date: Thu, 20 Sep 2012 09:26:15 +0200
Message-ID: <505AC517.1040602@de.ibm.com>
References: <1346771610-52423-1-git-send-email-cornelia.huck@de.ibm.com> <1346771610-52423-8-git-send-email-cornelia.huck@de.ibm.com> <48430489-B96F-4717-AA1E-B04445F55717@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <48430489-B96F-4717-AA1E-B04445F55717@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 19/09/12 16:47, Alexander Graf wrote:
> 
> On 04.09.2012, at 17:13, Cornelia Huck wrote:
> 
>> Handle most support for channel I/O instructions in the kernel itself.
>>
>> Only asynchronous functions (such as the start function) need to be
>> handled by userspace.
> 
> Phew. This is a lot of code for something that is usually handled in user space in the kvm
> world. The x86 equivalent would be an in-kernel PCI bus, right? Have you measured major 
> performance penalties when running this from user space?

Conny is on vacation, but I will try to answer that based on the discussions with Carsten
and Conny that we had the last 9 month. ( so Conny, Carsten please correct me, if I got 
something wrong).

In essence it is that way, because we have our interrupt delivery in the kernel.

Here is the story of how this evolved:

we started with a userspace solution but it turned out that this cannot work in an
architecture-compliant way. The problem is that the channel subsystem interacts with the 
interrupts of the system. For example there is a "test pending interruption" instruction, that
can clear pending interrupts (a pending interrupt must not be delivered after tpi, but it might already
be queued in KVM for delivery on another cpu)
Since the channel subsystem and the interrupt delivery work so closely together, to code structure
has to follow that. So there are two possible ways of implementing:

1. do basic channel subsystem (instructions + interrupts) and interrupt handling in userspace
- e.g. qemu would have a call to kvm to ask for a cpu that can accept a certain interrupt type
- if that cpu returns to qemu, qemu would then do the psw swap (deliver the interrupt) and go back
to KVM_RUN.
Given that interrupts have a priority, that also means that in the long run qemu would need to do
that for all kind interrupts, even those that the kernel currently handles. For example if a 
sigp and and I/O interrupt should be delivered to a cpu, you have problems to obey the priorities 
if kvm and qemu are allowed to do a psw swap
- we already had that variant prototyped, but it has its downsides:
    - it makes things like vhost impossible (you have to go to userspace to deliver an int)
    - interrupts require an additional call into the kernel (get it out + KVM_RUN, instead of
      one KVM_S390_INTERRUPT call)
    - (future) passthrough of ccw devices does require in kernel handling anyway

2. do basic channel subsystem in kvm
- the kernel handles the basic channel subsystem instruction to be able to have the interrupt
delivery architecturally correct. qemu will implement the devices on this in-kernel channel
subsystem. This will allow for things like vhost and it is also cheaper for things that the
kernel already handles. The downside is, that the non-kvm case differs in qemu (but Conny 
left here userspace implementation in)

Please note, that the channel subsystem architecture is tightly coupled to the cpu architecture
(e.g. by having instructions for interaction), so the comparison with PCI is not fully correct


Christian
