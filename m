Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH RFC 1/2] KVM: s390: vsie: simulate VCPU SIE entry/exit
References: <20180807125131.3606-1-david@redhat.com>
 <20180807125131.3606-2-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c0de34b7-9ffa-0d59-debf-b82ddb8a3a5c@redhat.com>
Date: Thu, 9 Aug 2018 09:20:28 +0200
MIME-Version: 1.0
In-Reply-To: <20180807125131.3606-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 07.08.2018 14:51, David Hildenbrand wrote:
> VCPU requests and VCPU blocking right now don't take care of the vSIE
> (as it was not necessary until now). But we want to have VCPU requests
> that will also be handled before running the vSIE again.
> 
> So let's simulate a SIE entry when entering the vSIE loop and check
> for PROG_ flags. The existing infrastructure (e.g. exit_sie()) will then
> detect that the SIE (in form of the vSIE execution loop) is running and
> properly kick the vSIE CPU, resulting in it leaving the vSIE loop and
> therefore the vSIE interception handler, allowing it to handle VCPU
> requests.
> 
> E.g. if we want to modify the crycb of the VCPU and make sure that any
> masks also get applied to the VSIE crycb shadow (which uses masks from the
> VCPU crycb), we will need a way to hinder the vSIE from running and make
> sure to process the updated crycb before reentering the vSIE again.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kvm/kvm-s390.c |  9 ++++++++-
>  arch/s390/kvm/kvm-s390.h |  1 +
>  arch/s390/kvm/vsie.c     | 20 ++++++++++++++++++--
>  3 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 91ad4a9425c0..c87734a31fdb 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2766,18 +2766,25 @@ static void kvm_s390_vcpu_request(struct kvm_vcpu *vcpu)
>  	exit_sie(vcpu);
>  }
>  
> +bool kvm_s390_vcpu_sie_inhibited(struct kvm_vcpu *vcpu)
> +{
> +	return atomic_read(&vcpu->arch.sie_block->prog20) &
> +	       (PROG_BLOCK_SIE | PROG_REQUEST);
> +}
> +
>  static void kvm_s390_vcpu_request_handled(struct kvm_vcpu *vcpu)
>  {
>  	atomic_andnot(PROG_REQUEST, &vcpu->arch.sie_block->prog20);
>  }
>  
>  /*
> - * Kick a guest cpu out of SIE and wait until SIE is not running.
> + * Kick a guest cpu out of (v)SIE and wait until (v)SIE is not running.
>   * If the CPU is not running (e.g. waiting as idle) the function will
>   * return immediately. */
>  void exit_sie(struct kvm_vcpu *vcpu)
>  {
>  	kvm_s390_set_cpuflags(vcpu, CPUSTAT_STOP_INT);
> +	kvm_s390_vsie_kick(vcpu);
>  	while (vcpu->arch.sie_block->prog0c & PROG_IN_SIE)
>  		cpu_relax();
>  }
> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
> index 981e3ba97461..1f6e36cdce0d 100644
> --- a/arch/s390/kvm/kvm-s390.h
> +++ b/arch/s390/kvm/kvm-s390.h
> @@ -290,6 +290,7 @@ void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu);
>  void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu);
>  void kvm_s390_vcpu_block(struct kvm_vcpu *vcpu);
>  void kvm_s390_vcpu_unblock(struct kvm_vcpu *vcpu);
> +bool kvm_s390_vcpu_sie_inhibited(struct kvm_vcpu *vcpu);
>  void exit_sie(struct kvm_vcpu *vcpu);
>  void kvm_s390_sync_request(int req, struct kvm_vcpu *vcpu);
>  int kvm_s390_vcpu_setup_cmma(struct kvm_vcpu *vcpu);
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 63844b95c22c..faac06886f77 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -989,6 +989,17 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
>  	int rc = 0;
>  
> +	/*
> +	 * Simulate a SIE entry of the VCPU (see sie64a), so VCPU blocking
> +	 * and VCPU requests can hinder the whole vSIE loop from running
> +	 * and lead to an immediate exit. We do it at this point (not
> +	 * earlier), so kvm_s390_vsie_kick() works correctly already.
> +	 */
> +	vcpu->arch.sie_block->prog0c |= PROG_IN_SIE;
> +	barrier();
> +	if (kvm_s390_vcpu_sie_inhibited(vcpu))
> +		return 0;
> +
>  	while (1) {
>  		rc = acquire_gmap_shadow(vcpu, vsie_page);
>  		if (!rc)
> @@ -1004,10 +1015,14 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>  		if (rc == -EAGAIN)
>  			rc = 0;
>  		if (rc || scb_s->icptcode || signal_pending(current) ||
> -		    kvm_s390_vcpu_has_irq(vcpu, 0))
> +		    kvm_s390_vcpu_has_irq(vcpu, 0) ||
> +		    kvm_s390_vcpu_sie_inhibited(vcpu))
>  			break;
>  	}
>  
> +	barrier();
> +	vcpu->arch.sie_block->prog0c &= ~PROG_IN_SIE;
> +

I am thinking about moving this down to the actual sie64 call. We
eventually take locks and even call into MM code (to resolve faults)
inside do_vsie_run(). I think this extra overhead can be avoided (where
any caller - e.g. on prefix unmaps has to wait).


-- 

Thanks,

David / dhildenb
