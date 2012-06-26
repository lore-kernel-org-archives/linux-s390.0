From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 3/6] KVM: s390: fix sigp sense running condition code handling
Date: Tue, 26 Jun 2012 16:52:56 +0200
Message-ID: <06A9A05A-0EF3-4ACF-8254-1F3F10844793@suse.de>
References: <1340719601-11867-1-git-send-email-cornelia.huck@de.ibm.com> <1340719601-11867-4-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1340719601-11867-4-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>


On 26.06.2012, at 16:06, Cornelia Huck wrote:

> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> Only if the sensed cpu is not running a status is stored, which
> is reflected by condition code 1. If the cpu is running, condition
> code 0 should be returned.
> Just the opposite of what the code is doing.
> 
> Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

Yikes. Is this a stable candidate?


Alex

> ---
> arch/s390/kvm/sigp.c |    4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
> index fda1d64..caccc0e 100644
> --- a/arch/s390/kvm/sigp.c
> +++ b/arch/s390/kvm/sigp.c
> @@ -268,12 +268,12 @@ static int __sigp_sense_running(struct kvm_vcpu *vcpu, u16 cpu_addr,
> 		if (atomic_read(fi->local_int[cpu_addr]->cpuflags)
> 		    & CPUSTAT_RUNNING) {
> 			/* running */
> -			rc = 1;
> +			rc = 0;
> 		} else {
> 			/* not running */
> 			*reg &= 0xffffffff00000000UL;
> 			*reg |= SIGP_STATUS_NOT_RUNNING;
> -			rc = 0;
> +			rc = 1;
> 		}
> 	}
> 	spin_unlock(&fi->lock);
> -- 
> 1.7.10.4
> 
