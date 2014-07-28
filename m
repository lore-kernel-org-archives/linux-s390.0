From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH/RFC 4/5] s390x/kvm: test whether a cpu is
 STOPPED when checking "has_work"
Date: Mon, 28 Jul 2014 16:19:35 +0200
Message-ID: <53D65BF7.5060104@redhat.com>
References: <1404997839-29038-1-git-send-email-borntraeger@de.ibm.com>	<1404997839-29038-5-git-send-email-borntraeger@de.ibm.com>	<53D654D2.40308@suse.de> <20140728161644.00c09b3f@thinkpad-w530>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20140728161644.00c09b3f@thinkpad-w530>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <dahi@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Il 28/07/2014 16:16, David Hildenbrand ha scritto:
> Later, another vcpu might decide to turn that vcpu back on (by e.g. sending a
> SIGP START to that vcpu).
> 
> I am not sure if such a mechanism/scenario is applicable to any other arch. They
> all seem to reset the cs->halted flag if they know they are able to run (e.g.
> due to an interrupt) - they have no such thing as "stopped cpus", only
> "halted/waiting cpus".

On x86, INIT_RECEIVED is pretty much a stopped CPU.  It can only run
(and receive interrupts) after getting a special startup interrupt ("SIPI").

Paolo
