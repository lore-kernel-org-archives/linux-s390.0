From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Wed, 02 May 2018 06:49:46 +0000
Subject: Re: [PATCH v2] KVM: s390: introduce defines for control registers
Message-Id: <20180502064946.GA3838@osiris>
In-Reply-To: <20180430180402.54d8511c.cohuck@redhat.com>
References: <20180430180402.54d8511c.cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Apr 30, 2018 at 05:55:24PM +0200, David Hildenbrand wrote:
> In KVM code we use masks to test/set control registers.
> 
> Let's define the ones we use in arch/s390/include/asm/ctl_reg.h and
> replace all occurrences in KVM code.
> 
> As we will be needing the define for Clock-comparator sign control soon,
> let's also add it.
> 
> Suggested-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/include/asm/ctl_reg.h | 12 ++++++++++++
>  arch/s390/kvm/guestdbg.c        |  2 +-
>  arch/s390/kvm/interrupt.c       | 20 ++++++++++----------
>  arch/s390/kvm/kvm-s390.c        | 10 +++++++---
>  4 files changed, 30 insertions(+), 14 deletions(-)

If you need an ack for the non-KVM part:

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
