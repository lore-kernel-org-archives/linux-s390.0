Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EEE39020C;
	Wed, 12 Aug 2026 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551714; cv=none; b=BHG5sxF1IbXR3miqVAgzy6AyiwF8BKSBfLsZMgQ46Gde5Ixji+IU7+3RKVrC3z7inG4hJgC0A/mwVAfcZ4l21u/KtJJx45N6d9X19IDUnRNMH7UaGsbFNgeyGlEzlOPhrrS8Rd4Gn2UNxAEe6WkIxJBd5AOg4CamLVaV2ASOlHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551714; c=relaxed/simple;
	bh=d6gBnB0coIDMFI31oFdlIuFVAvpudF5x9g6TcUophBs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dhfEPBT7YstHsHvTFRPFauDDzP2kaUI1mva0aeExkX5lWfQoiVw2ztjb7TwW2HcBLSwFjyoQFGlfCqF2aI3HPb06YrsyHqZ5hYX/CQTpATtNqeYFDERXyXwbFOhZ/QsJpXXzFWFqm5SuMK4Im1z/7EM6iwnzztS7lnQYbPQBbRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UctMKPIU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UctMKPIU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF01C1F000E9;
	Wed, 12 Aug 2026 16:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786551712;
	bh=NWb34c7wFH0xUNnIAmftCdQBySX2QkmwVQVBTE7TJjA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UctMKPIUd4jKNtanOcFaaq3GQUTeZTyYsSexwSWTF9OZmn3ZzcWCiNJpFpUK6PSJz
	 +CQXpbykdIsVRdNaWNJaubMDwI9AorhbsLDyNUs0AjVmJFL6CvvVPX4XyjZxgDJrtZ
	 boXVjC6OAADfqNC8JL/wUrFPguZ3W2Uh2QogFn6fDommPOeDRXtGU10TGlBzLCHs+s
	 I704niA7zUYNwpo4q4LMw3rVPk2Hjr/6w8jIqQiwck3KCLXSdKEgGTxY9nDJ/AaDJ/
	 0ClgLfnTs21dAXylFeqfkYTJElPkoXA4ejDYoOxXidoupe35pVXp7WRrfAUoJJ9zxH
	 q7uhqCi+4bA9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 22/33] KVM: s390: Prepare KVM/s390 for a second KVM
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Marc Zyngier" <maz@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvmarm@lists.linux.dev, "Oliver
 Upton" <oupton@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260812153631.3376090-23-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-23-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:21:51 +0000
Message-Id: <20260812162151.DF01C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch fails to provide all necessary stubs to make s390 KVM com=
pile when merged with an arm64 KVM Kconfig, leading to undefined references=
 to functions like `kvm_get_dirty_log` and `kvm_arch_allow_write_without_ru=
nning_vcpu`.
--

--- Patch [22]: [PATCH v6 22/33] KVM: s390: Prepare KVM/s390 for a second K=
VM module ---
commit fb387e8f82c2198f5fffbab975b0cb04cd2ac49c
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: Prepare KVM/s390 for a second KVM module

The second KVM module will have a different Kconfig set. When both
modules are compiled the Kconfig sets get merged and the native s390 KVM
needs to implement functionality required by the respective config
options. Ensure that s390-KVM will still compile by implementing a stub
for kvm_arch_vcpu_run_pid_change if CONFIG_HAVE_KVM_VCPU_RUN_PID_CHANGE
is enabled and defining KVM_NO_MMIO to disable KVM_MMIO.

> diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
> index 1d0d94f000f72..d1e736e1f06f2 100644
> --- a/arch/s390/kvm/s390/s390.c
> +++ b/arch/s390/kvm/s390/s390.c
> @@ -5868,6 +5868,14 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct k=
vm_gfn_range *range)
>  	return gmap_unmap_gfn_range(kvm->arch.gmap, range->slot, range->start, =
range->end);
>  }
> =20
> +#ifdef CONFIG_HAVE_KVM_VCPU_RUN_PID_CHANGE
> +/* Make s390 compile if arm64-on-s390 is selected */
> +int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_HAVE_KVM_VCPU_RUN_PID_CHANGE */

[Severity: Low]
Are there other missing stubs required to make s390 KVM compile when merged
with the arm64 KVM Kconfig?

If CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT and
CONFIG_NEED_KVM_DIRTY_RING_WITH_BITMAP are enabled by the merged configs,
could there be undefined references to functions like kvm_get_dirty_log() a=
nd
kvm_arch_allow_write_without_running_vcpu()?

For instance, s390_kvm_mmu_get_dirty_log() in arch/s390/kvm/gmap/kvm_mmu.c
calls kvm_get_dirty_log(), which is omitted from virt/kvm/kvm_main.c when
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT is selected.

Would adding stubs for these functions be needed to fully resolve the linker
errors this patch aims to fix?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D22
