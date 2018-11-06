From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 06 Nov 2018 14:34:38 +0000
Subject: Re: [PATCH 03/10] KVM: s390: factor out nullify_gisa()
Message-Id: <20181106153438.0c41a903.cohuck@redhat.com>
In-Reply-To: <938101fc-0840-7270-68c7-00cdd150efb3@linux.ibm.com>
References: <938101fc-0840-7270-68c7-00cdd150efb3@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 25 Oct 2018 14:37:44 +0200
Michael Mueller <mimu@linux.ibm.com> wrote:

> This function will be used by the GIB alert handler and during
> the GISA clear operation. Thus it gets factored out here.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
