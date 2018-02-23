From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 23 Feb 2018 11:11:59 +0000
Subject: Re: [PATCH v2 2/2] KVM: s390: add exit io request stats and simplify code
Message-Id: <20180223121159.0e55fa50.cohuck@redhat.com>
In-Reply-To: <12f31777-ee60-c154-ac75-e9c5424eb45a@redhat.com>
References: <12f31777-ee60-c154-ac75-e9c5424eb45a@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 23 Feb 2018 11:10:25 +0000
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> We want to count IO exit requests in kvm_stat. At the same time
> we can get rid of the handle_noop function.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  1 +
>  arch/s390/kvm/intercept.c        | 17 ++++-------------
>  arch/s390/kvm/kvm-s390.c         |  1 +
>  3 files changed, 6 insertions(+), 13 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
