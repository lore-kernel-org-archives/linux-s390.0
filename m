From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH/RFC 2/2] KVM: enable kvm_vcpu_kick/wake_up for s390
Date: Fri, 17 Feb 2017 16:23:57 +0100
Message-ID: <20170217152357.GF12224@potion>
References: <1487337007-91063-1-git-send-email-borntraeger@de.ibm.com>
 <1487337007-91063-3-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1487337007-91063-3-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

2017-02-17 14:10+0100, Christian Borntraeger:
> while we still need to provide our private version of kick and wakeup
> to synchronize with some special cases, we can still enable the common
> code variant.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 12 ++++++++++--
>  virt/kvm/kvm_main.c      |  2 --
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 7cfd0dd..fa20686 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2485,8 +2485,14 @@ static void kvm_gmap_notifier(struct gmap *gmap, unsigned long start,
>  
>  int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
>  {
> -	/* kvm common code refers to this, but never calls it */
> -	BUG();
> +	/*
> +	 * STOP indication is resetted when delivering interrupts. This
> +	 * is done before we handle requests, so we only "loose" this
> +	 * when we are still going to handle requests. In that case
> +	 * we no longer need that STOP indication.
> +	 */
> +	__set_cpuflag(vcpu, CPUSTAT_STOP_INT);
> +	kvm_s390_vsie_kick(vcpu);

I wouldn't put the kick into that function.  On other architectures, the
function decides whether we should call an operation that actually
forces the exit.  e.g. x86 and arm do

  return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE

(which also contains an optimization, because they will not kick a VCPU
 twice or do a kick for a VCPU outside the guest mode.)

There little point in having vcpu->mode if we do not use it here.
And we'd also like to use kvm_arch_vcpu_should_kick() for the same
decision in kvm_make_all_cpus_request(); basic idea:

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 4f4d250e1f53..676c0636d73c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -163,10 +163,6 @@ void vcpu_put(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(vcpu_put);
 
-static void ack_flush(void *_completed)
-{
-}
-
 bool kvm_make_all_cpus_request(struct kvm *kvm, unsigned int req)
 {
 	int i, cpu, me;
@@ -194,13 +190,13 @@ bool kvm_make_all_cpus_request(struct kvm *kvm, unsigned int req)
 		smp_mb__after_atomic();
 
 		if (cpus != NULL && cpu != -1 && cpu != me &&
-		      kvm_vcpu_exiting_guest_mode(vcpu) != OUTSIDE_GUEST_MODE)
+		    kvm_arch_vcpu_should_kick(vcpu))
 			cpumask_set_cpu(cpu, cpus);
 	}
 	if (unlikely(cpus == NULL))
-		smp_call_function_many(cpu_online_mask, ack_flush, NULL, 1);
+		kvm_arch_cpu_kick_many(cpu_online_mask);
 	else if (!cpumask_empty(cpus))
-		smp_call_function_many(cpus, ack_flush, NULL, 1);
+		kvm_arch_cpu_kick_many(cpus);
 	else
 		called = false;
 	put_cpu();
