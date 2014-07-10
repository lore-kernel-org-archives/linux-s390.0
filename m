From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH/RFC 0/5] s390x/kvm: track the logical cpu state in QEMU
 and propagate it to kvm
Date: Thu, 10 Jul 2014 15:14:31 +0200
Message-ID: <20140710151431.0b7e3c34@thinkpad-w530>
References: <1404997839-29038-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1404997839-29038-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

> This is the qemu part of kernel series "Let user space control the
> cpu states"
> 
> Christian Borntraeger (1):
>   update linux headers with with cpustate changes
> 
> David Hildenbrand (4):
>   s390x/kvm: introduce proper states for s390 cpus
>   s390x/kvm: proper use of the cpu states OPERATING and STOPPED
>   s390x/kvm: test whether a cpu is STOPPED when checking "has_work"
>   s390x/kvm: propagate s390 cpu state to kvm
> 
>  hw/s390x/ipl.c            |   2 +-
>  hw/s390x/s390-virtio.c    |  32 --------------
>  linux-headers/linux/kvm.h |   7 ++-
>  target-s390x/cpu.c        | 106 +++++++++++++++++++++++++++++++++++++++-------
>  target-s390x/cpu.h        |  33 +++++++++++++--
>  target-s390x/helper.c     |  11 ++---
>  target-s390x/kvm.c        |  49 ++++++++++++++++++---
>  trace-events              |   6 +++
>  8 files changed, 179 insertions(+), 67 deletions(-)
> 

Looks good to me
