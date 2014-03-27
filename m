From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v3 0/5] qemu: irqfds for s390x
Date: Thu, 27 Mar 2014 12:09:53 +0100
Message-ID: <53340701.20002@de.ibm.com>
References: <1395406357-14766-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1395406357-14766-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pbonzini@redhat.com
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, agraf@suse.de, gleb@kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 21/03/14 13:52, Cornelia Huck wrote:
> Here's the next iteration of the qemu patchset enabling irqfds for
> s390x, again a companion patchset for "KVM: irqfds for s390".
> 
> Changes from v2:
> - rebased against current master
> - use object_resolve_path() to grab the flic
> - more explicit return code check for enabling KVM_CAP_S390_IRQCHIP
> 
> Changes from v1:
> - rebased against current master
> - pick up changed capability numbers from the kvm patchset
> - use c99 struct initializers in patch 3
> - adapter interrupts are already upstream
> 
> The git branch at
> 
> https://github.com/cohuck/qemu.git s390x-irqfd
> 
> has been updated accordingly.

The whole series looks good to me. 
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>

Paolo,
since we also touch KVM code, and the necessary counter part in
in Linux kvm/next we could push this via the QEMU/KVM tree.
Are you willing to carry those patches in the KVM tree to be 
merged after 2.0?

Christian

> 
> Cornelia Huck (5):
>   linux-headers: add new interfaces
>   kvm: add kvm_enable_cap_{vm,vcpu}
>   s390x: Add I/O adapter registration.
>   s390x/virtio-ccw: reference-counted indicators
>   s390x/virtio-ccw: Wire up irq routing and irqfds.
> 
>  hw/intc/s390_flic.c          |   59 +++++++++++
>  hw/s390x/css.c               |   51 +++++++++
>  hw/s390x/css.h               |    4 +
>  hw/s390x/virtio-ccw.c        |  241 +++++++++++++++++++++++++++++++++++++-----
>  hw/s390x/virtio-ccw.h        |   16 ++-
>  include/hw/s390x/adapter.h   |   23 ++++
>  include/qemu/typedefs.h      |    1 +
>  include/sysemu/kvm.h         |    6 ++
>  kvm-all.c                    |   57 +++++++++-
>  kvm-stub.c                   |    5 +
>  linux-headers/asm-s390/kvm.h |   24 +++++
>  linux-headers/linux/kvm.h    |   17 +++
>  target-s390x/cpu.h           |   33 ++++++
>  target-s390x/kvm.c           |    5 +
>  14 files changed, 513 insertions(+), 29 deletions(-)
>  create mode 100644 include/hw/s390x/adapter.h
> 
