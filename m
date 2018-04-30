From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 30 Apr 2018 16:04:02 +0000
Subject: Re: [PATCH v2] KVM: s390: introduce defines for control registers
Message-Id: <20180430180402.54d8511c.cohuck@redhat.com>
In-Reply-To: <20180430155524.4174-1-david@redhat.com>
References: <20180430155524.4174-1-david@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 30 Apr 2018 17:55:24 +0200
David Hildenbrand <david@redhat.com> wrote:

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

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
