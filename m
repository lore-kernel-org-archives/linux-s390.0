From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 31 Oct 2018 12:33:32 +0000
Subject: Re: [PATCH 01/10] s390/cio: add function chsc_sgib()
Message-Id: <20181031133332.66962424.cohuck@redhat.com>
In-Reply-To: <85abae78-b165-1e27-e0d2-3ef73fa114ec@linux.ibm.com>
References: <85abae78-b165-1e27-e0d2-3ef73fa114ec@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 25 Oct 2018 14:37:42 +0200
Michael Mueller <mimu@linux.ibm.com> wrote:

> This patch implements the Set Guest Information Block operation
> to request association or disassociation of a Guest Information
> Block (GIB) with the Adapter Interruption Facility. The operation
> is required to receive GIB alert interrupts for guest adapters
> in conjunction with AIV and GISA.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  arch/s390/include/asm/cio.h |  1 +
>  drivers/s390/cio/chsc.c     | 37 +++++++++++++++++++++++++++++++++++++
>  drivers/s390/cio/chsc.h     |  1 +
>  3 files changed, 39 insertions(+)

Can't really review the implementation due to no public doc, but this
looks sane.

Acked-by: Cornelia Huck <cohuck@redhat.com>
