From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v1] kvm: Make vcpu->requests as 64 bit bitmap
Date: Thu, 24 Dec 2015 09:40:07 +0000
Message-ID: <20151224094007.GA22430@jhogan-linux.le.imgtec.org>
References: <1450949426-25545-1-git-send-email-asmetanin@virtuozzo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450949426-25545-1-git-send-email-asmetanin@virtuozzo.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andrey Smetanin <asmetanin@virtuozzo.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Gleb Natapov <gleb@kernel.org>, Paul Burton <paul.burton@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Alexander Graf <agraf@suse.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org, linux-s390@vger.kernel.org, Roman Kagan <rkagan@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
List-ID: <linux-s390.vger.kernel.org>

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrey,

On Thu, Dec 24, 2015 at 12:30:26PM +0300, Andrey Smetanin wrote:
> Currently on x86 arch we has already 32 requests defined
> so the newer request bits can't be placed inside
> vcpu->requests(unsigned long) inside x86 32 bit system.
> But we are going to add a new request in x86 arch
> for Hyper-V tsc page support.
>=20
> To solve the problem the patch replaces vcpu->requests by
> bitmap with 64 bit length and uses bitmap API.
>=20
> The patch consists of:
> * announce kvm_vcpu_has_requests() to check whether vcpu has
> requests
> * announce kvm_vcpu_requests() to get vcpu requests pointer
> * announce kvm_clear_request() to clear particular vcpu request
> * replace if (vcpu->requests) by if (kvm_vcpu_has_requests(vcpu))
> * replace clear_bit(req, vcpu->requests) by
>  kvm_clear_request(req, vcpu)
>=20
> Signed-off-by: Andrey Smetanin <asmetanin@virtuozzo.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Gleb Natapov <gleb@kernel.org>
> CC: James Hogan <james.hogan@imgtec.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Paul Burton <paul.burton@imgtec.com>
> CC: Ralf Baechle <ralf@linux-mips.org>
> CC: Alexander Graf <agraf@suse.com>
> CC: Christian Borntraeger <borntraeger@de.ibm.com>
> CC: Cornelia Huck <cornelia.huck@de.ibm.com>
> CC: linux-mips@linux-mips.org
> CC: kvm-ppc@vger.kernel.org
> CC: linux-s390@vger.kernel.org
> CC: Roman Kagan <rkagan@virtuozzo.com>
> CC: Denis V. Lunev <den@openvz.org>
> CC: qemu-devel@nongnu.org

For MIPS KVM bit:
Acked-by: James Hogan <james.hogan@imgtec.com>

Thanks
James

>=20
> ---
>  arch/mips/kvm/emulate.c           |  4 +---
>  arch/powerpc/kvm/book3s_pr.c      |  2 +-
>  arch/powerpc/kvm/book3s_pr_papr.c |  2 +-
>  arch/powerpc/kvm/booke.c          |  6 +++---
>  arch/powerpc/kvm/powerpc.c        |  6 +++---
>  arch/powerpc/kvm/trace.h          |  2 +-
>  arch/s390/kvm/kvm-s390.c          |  4 ++--
>  arch/x86/kvm/vmx.c                |  2 +-
>  arch/x86/kvm/x86.c                | 14 +++++++-------
>  include/linux/kvm_host.h          | 27 ++++++++++++++++++++++-----
>  10 files changed, 42 insertions(+), 27 deletions(-)
>=20
> diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
> index 41b1b09..14aebe8 100644
> --- a/arch/mips/kvm/emulate.c
> +++ b/arch/mips/kvm/emulate.c
> @@ -774,10 +774,8 @@ enum emulation_result kvm_mips_emul_wait(struct kvm_=
vcpu *vcpu)
>  		 * We we are runnable, then definitely go off to user space to
>  		 * check if any I/O interrupts are pending.
>  		 */
> -		if (kvm_check_request(KVM_REQ_UNHALT, vcpu)) {
> -			clear_bit(KVM_REQ_UNHALT, &vcpu->requests);
> +		if (kvm_check_request(KVM_REQ_UNHALT, vcpu))
>  			vcpu->run->exit_reason =3D KVM_EXIT_IRQ_WINDOW_OPEN;
> -		}
>  	}
> =20
>  	return EMULATE_DONE;
> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
> index 64891b0..e975279 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -349,7 +349,7 @@ static void kvmppc_set_msr_pr(struct kvm_vcpu *vcpu, =
u64 msr)
>  	if (msr & MSR_POW) {
>  		if (!vcpu->arch.pending_exceptions) {
>  			kvm_vcpu_block(vcpu);
> -			clear_bit(KVM_REQ_UNHALT, &vcpu->requests);
> +			kvm_clear_request(KVM_REQ_UNHALT, vcpu));
>  			vcpu->stat.halt_wakeup++;
> =20
>  			/* Unset POW bit after we woke up */
> diff --git a/arch/powerpc/kvm/book3s_pr_papr.c b/arch/powerpc/kvm/book3s_=
pr_papr.c
> index f2c75a1..60cf393 100644
> --- a/arch/powerpc/kvm/book3s_pr_papr.c
> +++ b/arch/powerpc/kvm/book3s_pr_papr.c
> @@ -309,7 +309,7 @@ int kvmppc_h_pr(struct kvm_vcpu *vcpu, unsigned long =
cmd)
>  	case H_CEDE:
>  		kvmppc_set_msr_fast(vcpu, kvmppc_get_msr(vcpu) | MSR_EE);
>  		kvm_vcpu_block(vcpu);
> -		clear_bit(KVM_REQ_UNHALT, &vcpu->requests);
> +		kvm_clear_request(KVM_REQ_UNHALT, vcpu);
>  		vcpu->stat.halt_wakeup++;
>  		return EMULATE_DONE;
>  	case H_LOGICAL_CI_LOAD:
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index fd58751..6bed382 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -574,7 +574,7 @@ static void arm_next_watchdog(struct kvm_vcpu *vcpu)
>  	 * userspace, so clear the KVM_REQ_WATCHDOG request.
>  	 */
>  	if ((vcpu->arch.tsr & (TSR_ENW | TSR_WIS)) !=3D (TSR_ENW | TSR_WIS))
> -		clear_bit(KVM_REQ_WATCHDOG, &vcpu->requests);
> +		kvm_clear_request(KVM_REQ_WATCHDOG, vcpu);
> =20
>  	spin_lock_irqsave(&vcpu->arch.wdt_lock, flags);
>  	nr_jiffies =3D watchdog_next_timeout(vcpu);
> @@ -677,7 +677,7 @@ int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcp=
u)
> =20
>  	kvmppc_core_check_exceptions(vcpu);
> =20
> -	if (vcpu->requests) {
> +	if (kvm_vcpu_has_requests(vcpu)) {
>  		/* Exception delivery raised request; start over */
>  		return 1;
>  	}
> @@ -685,7 +685,7 @@ int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcp=
u)
>  	if (vcpu->arch.shared->msr & MSR_WE) {
>  		local_irq_enable();
>  		kvm_vcpu_block(vcpu);
> -		clear_bit(KVM_REQ_UNHALT, &vcpu->requests);
> +		kvm_clear_request(KVM_REQ_UNHALT, vcpu);
>  		hard_irq_disable();
> =20
>  		kvmppc_set_exit_type(vcpu, EMULATED_MTMSRWE_EXITS);
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 6fd2405..e2dded7 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -49,7 +49,7 @@ EXPORT_SYMBOL_GPL(kvmppc_pr_ops);
>  int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
>  {
>  	return !!(v->arch.pending_exceptions) ||
> -	       v->requests;
> +	       kvm_vcpu_has_requests(v);
>  }
> =20
>  int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
> @@ -98,7 +98,7 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
>  		 */
>  		smp_mb();
> =20
> -		if (vcpu->requests) {
> +		if (kvm_vcpu_has_requests(vcpu)) {
>  			/* Make sure we process requests preemptable */
>  			local_irq_enable();
>  			trace_kvm_check_requests(vcpu);
> @@ -225,7 +225,7 @@ int kvmppc_kvm_pv(struct kvm_vcpu *vcpu)
>  	case EV_HCALL_TOKEN(EV_IDLE):
>  		r =3D EV_SUCCESS;
>  		kvm_vcpu_block(vcpu);
> -		clear_bit(KVM_REQ_UNHALT, &vcpu->requests);
> +		kvm_clear_request(KVM_REQ_UNHALT, vcpu);
>  		break;
>  	default:
>  		r =3D EV_UNIMPLEMENTED;
> diff --git a/arch/powerpc/kvm/trace.h b/arch/powerpc/kvm/trace.h
> index 2e0e67e..4015b88 100644
> --- a/arch/powerpc/kvm/trace.h
> +++ b/arch/powerpc/kvm/trace.h
> @@ -109,7 +109,7 @@ TRACE_EVENT(kvm_check_requests,
> =20
>  	TP_fast_assign(
>  		__entry->cpu_nr		=3D vcpu->vcpu_id;
> -		__entry->requests	=3D vcpu->requests;
> +		__entry->requests	=3D (__u32)kvm_vcpu_requests(vcpu)[0];
>  	),
> =20
>  	TP_printk("vcpu=3D%x requests=3D%x",
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 8465892..5db1471 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -1847,7 +1847,7 @@ static int kvm_s390_handle_requests(struct kvm_vcpu=
 *vcpu)
>  {
>  retry:
>  	kvm_s390_vcpu_request_handled(vcpu);
> -	if (!vcpu->requests)
> +	if (!kvm_vcpu_has_requests(vcpu))
>  		return 0;
>  	/*
>  	 * We use MMU_RELOAD just to re-arm the ipte notifier for the
> @@ -1890,7 +1890,7 @@ retry:
>  	}
> =20
>  	/* nothing to do, just clear the request */
> -	clear_bit(KVM_REQ_UNHALT, &vcpu->requests);
> +	kvm_clear_request(KVM_REQ_UNHALT, vcpu);
> =20
>  	return 0;
>  }
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 1a8bfaa..599451c 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -5957,7 +5957,7 @@ static int handle_invalid_guest_state(struct kvm_vc=
pu *vcpu)
>  		if (intr_window_requested && vmx_interrupt_allowed(vcpu))
>  			return handle_interrupt_window(&vmx->vcpu);
> =20
> -		if (test_bit(KVM_REQ_EVENT, &vcpu->requests))
> +		if (test_bit(KVM_REQ_EVENT, kvm_vcpu_requests(vcpu)))
>  			return 1;
> =20
>  		err =3D emulate_instruction(vcpu, EMULTYPE_NO_REEXECUTE);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0601c05..aedb1a0 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1702,7 +1702,7 @@ static void kvm_gen_update_masterclock(struct kvm *=
kvm)
> =20
>  	/* guest entries allowed */
>  	kvm_for_each_vcpu(i, vcpu, kvm)
> -		clear_bit(KVM_REQ_MCLOCK_INPROGRESS, &vcpu->requests);
> +		kvm_clear_request(KVM_REQ_MCLOCK_INPROGRESS, vcpu);
> =20
>  	spin_unlock(&ka->pvclock_gtod_sync_lock);
>  #endif
> @@ -2117,7 +2117,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struc=
t msr_data *msr_info)
> =20
>  			if (ka->boot_vcpu_runs_old_kvmclock !=3D tmp)
>  				set_bit(KVM_REQ_MASTERCLOCK_UPDATE,
> -					&vcpu->requests);
> +					kvm_vcpu_requests(vcpu));
> =20
>  			ka->boot_vcpu_runs_old_kvmclock =3D tmp;
>  		}
> @@ -6410,7 +6410,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
> =20
>  	bool req_immediate_exit =3D false;
> =20
> -	if (vcpu->requests) {
> +	if (kvm_vcpu_has_requests(vcpu)) {
>  		if (kvm_check_request(KVM_REQ_MMU_RELOAD, vcpu))
>  			kvm_mmu_unload(vcpu);
>  		if (kvm_check_request(KVM_REQ_MIGRATE_TIMER, vcpu))
> @@ -6560,7 +6560,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
> =20
>  	local_irq_disable();
> =20
> -	if (vcpu->mode =3D=3D EXITING_GUEST_MODE || vcpu->requests
> +	if (vcpu->mode =3D=3D EXITING_GUEST_MODE || kvm_vcpu_has_requests(vcpu)
>  	    || need_resched() || signal_pending(current)) {
>  		vcpu->mode =3D OUTSIDE_GUEST_MODE;
>  		smp_wmb();
> @@ -6720,7 +6720,7 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
>  		if (r <=3D 0)
>  			break;
> =20
> -		clear_bit(KVM_REQ_PENDING_TIMER, &vcpu->requests);
> +		kvm_clear_request(KVM_REQ_PENDING_TIMER, vcpu);
>  		if (kvm_cpu_has_pending_timer(vcpu))
>  			kvm_inject_pending_timer_irqs(vcpu);
> =20
> @@ -6848,7 +6848,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, =
struct kvm_run *kvm_run)
>  	if (unlikely(vcpu->arch.mp_state =3D=3D KVM_MP_STATE_UNINITIALIZED)) {
>  		kvm_vcpu_block(vcpu);
>  		kvm_apic_accept_events(vcpu);
> -		clear_bit(KVM_REQ_UNHALT, &vcpu->requests);
> +		kvm_clear_request(KVM_REQ_UNHALT, vcpu);
>  		r =3D -EAGAIN;
>  		goto out;
>  	}
> @@ -8048,7 +8048,7 @@ static inline bool kvm_vcpu_has_events(struct kvm_v=
cpu *vcpu)
>  	if (atomic_read(&vcpu->arch.nmi_queued))
>  		return true;
> =20
> -	if (test_bit(KVM_REQ_SMI, &vcpu->requests))
> +	if (test_bit(KVM_REQ_SMI, kvm_vcpu_requests(vcpu)))
>  		return true;
> =20
>  	if (kvm_arch_interrupt_allowed(vcpu) &&
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index da7a7e4..6877b4d7e 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -146,6 +146,8 @@ static inline bool is_error_page(struct page *page)
>  #define KVM_REQ_HV_EXIT           30
>  #define KVM_REQ_HV_STIMER         31
> =20
> +#define KVM_REQ_MAX               64
> +
>  #define KVM_USERSPACE_IRQ_SOURCE_ID		0
>  #define KVM_IRQFD_RESAMPLE_IRQ_SOURCE_ID	1
> =20
> @@ -233,7 +235,7 @@ struct kvm_vcpu {
>  	int vcpu_id;
>  	int srcu_idx;
>  	int mode;
> -	unsigned long requests;
> +	DECLARE_BITMAP(requests, KVM_REQ_MAX);
>  	unsigned long guest_debug;
> =20
>  	int pre_pcpu;
> @@ -286,6 +288,16 @@ struct kvm_vcpu {
>  	struct kvm_vcpu_arch arch;
>  };
> =20
> +static inline bool kvm_vcpu_has_requests(struct kvm_vcpu *vcpu)
> +{
> +	return !bitmap_empty(vcpu->requests, KVM_REQ_MAX);
> +}
> +
> +static inline ulong *kvm_vcpu_requests(struct kvm_vcpu *vcpu)
> +{
> +	return (ulong *)vcpu->requests;
> +}
> +
>  static inline int kvm_vcpu_exiting_guest_mode(struct kvm_vcpu *vcpu)
>  {
>  	return cmpxchg(&vcpu->mode, IN_GUEST_MODE, EXITING_GUEST_MODE);
> @@ -1002,7 +1014,7 @@ static inline bool kvm_is_error_gpa(struct kvm *kvm=
, gpa_t gpa)
> =20
>  static inline void kvm_migrate_timers(struct kvm_vcpu *vcpu)
>  {
> -	set_bit(KVM_REQ_MIGRATE_TIMER, &vcpu->requests);
> +	set_bit(KVM_REQ_MIGRATE_TIMER, kvm_vcpu_requests(vcpu));
>  }
> =20
>  enum kvm_stat_kind {
> @@ -1118,19 +1130,24 @@ static inline bool kvm_vcpu_compatible(struct kvm=
_vcpu *vcpu) { return true; }
> =20
>  static inline void kvm_make_request(int req, struct kvm_vcpu *vcpu)
>  {
> -	set_bit(req, &vcpu->requests);
> +	set_bit(req, kvm_vcpu_requests(vcpu));
>  }
> =20
>  static inline bool kvm_check_request(int req, struct kvm_vcpu *vcpu)
>  {
> -	if (test_bit(req, &vcpu->requests)) {
> -		clear_bit(req, &vcpu->requests);
> +	if (test_bit(req, kvm_vcpu_requests(vcpu))) {
> +		clear_bit(req, kvm_vcpu_requests(vcpu));
>  		return true;
>  	} else {
>  		return false;
>  	}
>  }
> =20
> +static inline void kvm_clear_request(int req, struct kvm_vcpu *vcpu)
> +{
> +	clear_bit(req, kvm_vcpu_requests(vcpu));
> +}
> +
>  extern bool kvm_rebooting;
> =20
>  struct kvm_device {
> --=20
> 2.4.3
>=20

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWe713AAoJEGwLaZPeOHZ6fnMP/06OYeynnmirlYzuDjSYGOqv
Y70w+Htzd0gbnL5YUBrMpZzErGfr9QzRUbhUmTuqp1Bhoo3pZ5uUNVG4M53KKKLo
HSnEId1faOpwiXsiHE9SXMkDJPPVMrMfCiNnX3cctEcBaX0kq5OTozxEAPaJSWWl
HYEDJFbJb9SGJbmk8XLYUfKRM4d3T7iMVkvLVcGTzvWez8Bt55PQaChMImIWIaUg
wYeAqgW85ZByGrs1HRAbooCSCAmJvFJxckg18rBR23/l9hiBN4cNlM6BR8hoSSOL
Bj6KTyPWBBm72sdLwEKmjwivVKlEInMfaWuQUiWNTjDXpOoyqq8vZyIAyl0u0V7N
UCDAzwZEDFhqC2bYdL5ejpgmilQThCfBGCjhTyV06M9oD2+80h1BEapLqxvpy1p1
D+yCAKkSmMEdzrgKWR7KwoGUHFm04NuZDqcQ2gbdjOCn7oGGK+P2Sgvg4/ST5v51
rtugk6URS0SJRb76DMoxa7itexyj2Y54xnCnuwxqdzlatm4wzNPljFrzLQS4EQ8B
SZ/DqjJaE2ObmQPkWO61FLVBc/pfRMe/CE6sTYFOi6WYYM+ngQdxts130CQ9iYEk
nlzAbSXBVa3WuMvWS1RGxBXZWNliZz2V9K93/wb3rPBO9uZC7zTk61xn5L9ebaC6
2lAzATePsIWcQjpFBn3D
=QAOu
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
