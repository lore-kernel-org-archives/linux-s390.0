From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 06/12] KVM: s390: exploit GISA and AIV for emulated
 interrupts
Date: Fri, 26 Jan 2018 10:12:51 +0100
Message-ID: <20180126101251.482480dc.cohuck@redhat.com>
References: <20180125170608.38276-1-borntraeger@de.ibm.com>
        <20180125170608.38276-3-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180125170608.38276-3-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 25 Jan 2018 18:06:06 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Michael Mueller <mimu@linux.vnet.ibm.com>
> 
> The adapter interruption virtualization (AIV) facility is an
> optional facility that comes with functionality expected to increase
> the performance of adapter interrupt handling for both emulated and
> passed-through adapter interrupts. With AIV, adapter interrupts can be
> delivered to the guest without exiting SIE.
> 
> This patch provides some preparations for using AIV for emulated adapter
> interrupts (inclusive virtio) if it's available. When using AIV, the

s/inclusive/including/

> interrupts are delivered at the so called GISA by setting the bit
> corresponding to its Interruption Subclass (ISC) in the Interruption
> Pending Mask (IPM) instead of inserting a node into the floating interrupt
> list.
> 
> To keep the change reasonably small, the handling of this new state is
> deferred in get_all_floating_irqs and handle_tpi. This patch concentrates
> on the code handling enqueuement of emulated adapter interrupts, and their
> delivery to the guest.
> 
> Note that care is still required for adapter interrupts using AIV,
> because there is no guarantee that AIV is going to deliver the adapter
> interrupts pending at the GISA (consider all vcpus idle). When delivering
> GISA adapter interrupts by the host (usual mechanism) special attention
> is required to honor interrupt priorities.
> 
> Empirical results show that the time window between making an interrupt
> pending at the GISA and doing kvm_s390_deliver_pending_interrupts is
> sufficient for a guest with at least moderate cpu activity to get adapter
> interrupts delivered within the SIE, and potentially save some SIE exits
> (if not other deliverable interrupts).
> 
> The code will be activated with a follow-up patch.
> 
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  1 +
>  arch/s390/kvm/interrupt.c        | 93 ++++++++++++++++++++++++++++++++--------
>  arch/s390/kvm/kvm-s390.c         |  8 ++++
>  arch/s390/kvm/kvm-s390.h         |  3 ++
>  4 files changed, 87 insertions(+), 18 deletions(-)
> 

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
