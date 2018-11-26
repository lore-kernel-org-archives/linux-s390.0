From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 26 Nov 2018 16:00:17 +0000
Subject: Re: [PATCH v2 07/12] KVM: s390: add kvm reference to struct sie_page2
Message-Id: <20181126170017.02b8fc8e.cohuck@redhat.com>
In-Reply-To: <20181119172536.52649-8-mimu@linux.ibm.com>
References: <20181119172536.52649-8-mimu@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 19 Nov 2018 18:25:31 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> Adding the kvm reference to struct sie_page2 will allow to
> determine the kvm a given gisa belongs to:
> 
>   container_of(gisa, struct sie_page2, gisa)->kvm
> 
> This functionality will be required to process a gisa in
> gib alert interruption context.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h | 3 ++-
>  arch/s390/kvm/kvm-s390.c         | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
