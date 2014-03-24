From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v3 0/4] KVM: irqfds for s390
Date: Mon, 24 Mar 2014 09:46:25 +0100
Message-ID: <532FF0E1.5000502@de.ibm.com>
References: <1395406341-14698-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1395406341-14698-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: agraf@suse.de, pbonzini@redhat.com, gleb@kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 21/03/14 13:52, Cornelia Huck wrote:
> Hi,
> 
> here's the next iteration of my patchset introducing irqfds for s390.
> 
> Changes from v2:
> - rebased against current kvm/queue
> - kvm common code lock fix is already in queue
> - move some changes that belonged in patch 2 from patch 3
> - add a limit for mapped pages to patch 2
> - collected some acks
> 
> Changes from v1:
> - rebased against current kvm/queue, bumping capability numbers
> - guest adapter interrupt support is already in the kvm tree
> 
> Again, find it on
> 

> git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git kvms390-irqfd

Looks all good. 

Paolo,

I guess this will miss the next merge window,  but can you pull for kvm/queue
if you have no further comments?

Christian
> 
> Cornelia Huck (4):
>   KVM: Add per-vm capability enablement.
>   KVM: s390: adapter interrupt sources
>   KVM: s390: irq routing for adapter interrupts.
>   KVM: Bump KVM_MAX_IRQ_ROUTES for s390
> 
>  Documentation/virtual/kvm/api.txt               |   27 ++-
>  Documentation/virtual/kvm/devices/s390_flic.txt |   45 ++++
>  arch/s390/include/asm/kvm_host.h                |   32 +++
>  arch/s390/include/uapi/asm/kvm.h                |   22 ++
>  arch/s390/kvm/Kconfig                           |    2 +
>  arch/s390/kvm/Makefile                          |    2 +-
>  arch/s390/kvm/interrupt.c                       |  294 ++++++++++++++++++++++-
>  arch/s390/kvm/irq.h                             |   22 ++
>  arch/s390/kvm/kvm-s390.c                        |   42 ++++
>  arch/s390/kvm/kvm-s390.h                        |    2 +
>  include/linux/kvm_host.h                        |   13 +
>  include/uapi/linux/kvm.h                        |   16 ++
>  12 files changed, 511 insertions(+), 8 deletions(-)
>  create mode 100644 arch/s390/kvm/irq.h
> 
