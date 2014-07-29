From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH/RFC 4/5] s390x/kvm: test whether a cpu is
 STOPPED when checking "has_work"
Date: Tue, 29 Jul 2014 15:52:00 +0200
Message-ID: <53D7A700.8090207@redhat.com>
References: <1404997839-29038-1-git-send-email-borntraeger@de.ibm.com>	<1404997839-29038-5-git-send-email-borntraeger@de.ibm.com>	<53D654D2.40308@suse.de>	<20140728161644.00c09b3f@thinkpad-w530>	<2B39547D-B9A3-4509-808C-B0808067ED54@suse.de> <20140728170318.1eb8ed64@thinkpad-w530>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20140728170318.1eb8ed64@thinkpad-w530>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <dahi@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, KVM <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Il 28/07/2014 17:03, David Hildenbrand ha scritto:
> Well the difference is, that a STOPPED vcpu can be woken up by non-interrupt
> like things (SIGP START) AND a special interrupt (SIGP RESTART - which is like
> a "SIPI"++ as it performs a psw exchange - "NMI"). So we basically have two
> paths that can lead to a state change.  All interrupt bits may be in any
> combination (SIGP RESTART interrupts can't be masked out, nor can SIGP START be
> denied).
> 
> The other thing may be that on s390, each vcpu (including itself) can put
> another vcpu into the STOPPED state - I assume that this is different for x86 "
> INIT_RECEIVED". For this reason we have to watch out for bad race conditions
> (e.g. multiple vcpus working on another vcpu)...

You can do that in x86 by sending an INIT inter-processor interrupt.  A
SIPI is ignored if the CPU is not in INIT_RECEIVED state.

Commit 66450a21f99636af4fafac2afd33f1a40631bc3a introduced the current
implementation.

- an INIT cancels a previous SIPI;

- if both INIT and SIPI are sent, on real hardware you need to have a
few hundred microseconds between them, but KVM will reliably process
INIT before SIPI.

See commit 299018f44ac553dce3caf84df1d14c4764faa279 for an example of
the races that can happen.

Note that x86 has KVM_MP_STATE_SIPI_RECEIVED state but it is obsolete,
we go straight from KVM_MP_STATE_INIT_RECEIVED to KVM_MP_STATE_RUNNABLE.
