From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH/RFC 4/5] s390x/kvm: test whether a cpu is
 STOPPED when checking "has_work"
Date: Mon, 28 Jul 2014 16:16:44 +0200
Message-ID: <20140728161644.00c09b3f@thinkpad-w530>
References: <1404997839-29038-1-git-send-email-borntraeger@de.ibm.com>
	<1404997839-29038-5-git-send-email-borntraeger@de.ibm.com>
	<53D654D2.40308@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <53D654D2.40308@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

> 
> On 10.07.14 15:10, Christian Borntraeger wrote:
> > From: David Hildenbrand <dahi@linux.vnet.ibm.com>
> >
> > If a cpu is stopped, it must never be allowed to run and no interrupt may wake it
> > up. A cpu also has to be unhalted if it is halted and has work to do - this
> > scenario wasn't hit in kvm case yet, as only "disabled wait" is processed within
> > QEMU.
> >
> > Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
> > Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> This looks like it's something that generic infrastructure should take 
> care of, no? How does this work for the other archs? They always get an 
> interrupt on the transition between !has_work -> has_work. Why don't we 
> get one for s390x?
> 
> 
> Alex
> 
> 

Well, we have the special case on s390 as a CPU that is in the STOPPED or the
CHECK STOP state may never run - even if there is an interrupt. It's
basically like this CPU has been switched off.

Imagine that it is tried to inject an interrupt into a stopped vcpu. It
will kick the stopped vcpu and thus lead to a call to
"kvm_arch_process_async_events()". We have to deny that this vcpu will ever
run as long as it is stopped. It's like a way to "suppress" the
interrupt for such a transition you mentioned.

Later, another vcpu might decide to turn that vcpu back on (by e.g. sending a
SIGP START to that vcpu).

I am not sure if such a mechanism/scenario is applicable to any other arch. They
all seem to reset the cs->halted flag if they know they are able to run (e.g.
due to an interrupt) - they have no such thing as "stopped cpus", only
"halted/waiting cpus".

David
