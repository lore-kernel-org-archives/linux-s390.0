Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F71641DEF3;
	Mon,  6 Jul 2026 09:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330617; cv=none; b=Xi5a27yxAIDSgwdvCb0Yz9NLc6irxWERWhXJoqATqQJPMSJgvXkL/zmrph2SIsnpMbFgbcYuhRuIfh+sC8lvl7MfDjHTjlf1sorLmpc4lpUNBF5hyhTJvlDeeetEDePxk8HkQDkSCAf97tPprBDS2TYjwcTEPo3Wp6QaL+oO6Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330617; c=relaxed/simple;
	bh=JFQxxQWKrmxxXex/Zp1iGB/UYVTEYDYiQzY427mF2zQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pYTerlCGZoj0Z2AsYplkkD5YUNPZri/9HZmMpy2Vcjl1EzRceevHee6cH1mQ76kvNOmn8ubfleXoHIOl3wNbfiSG8QcYGhr1/3jS7gOhCQgvDFXoweWBGY0HaPLYLbNLaf6QAsfInRNI3ggUm60lgbfZ7vzmE7psGlUUJ0gFsEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeBya+8V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeBya+8V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10C21F000E9;
	Mon,  6 Jul 2026 09:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783330613;
	bh=6eCNPxXv6mrWXltL5DWFvqnsqciwWuR2dJO+WJGbCOA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZeBya+8VnsWpA+nGjOE+k7ZRIWtQ7o/a8B40BGJG88+QMPvt6rIr+Sq8sjccdHdkK
	 nvOsowpOj3rbilotbNX4Wyg55ncbecAAZOkfen6BAL+XnmP/fI+h71xPAJpSwH2wUk
	 sEGygA53WKEnd/b2z1UbFZxOgp1X3AK7QeqMtwfDFmcGTPMCmN52mp8FpC3zQ02iYF
	 G3xkoqdtgbXJbCcGRbrIoKQHQs7g/4fisOlqyz/UNxyfZub/RsPyPWtpc+pbJo36o7
	 C0KOZGRiw7ftHOzWmdiaIR1HRnTabtX3BWl4g+vt5+jKD2GhizGYCd91bTQ4H3P44V
	 9j58LP1TUf62A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/27] KVM: S390: Prepare gmap for a second KVM
 implementation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Marc Zyngier" <maz@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, kvmarm@lists.linux.dev, "Oliver
 Upton" <oupton@kernel.org>
In-Reply-To: <20260706085229.979525-16-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-16-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:36:51 +0000
Message-Id: <20260706093652.A10C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Fallible memory allocation during the infallible memslot commi=
t phase causes silent Use-After-Free and guest crashes.
- [High] Non-atomic clearing of the memory slot dirty bitmap via `memset` c=
an race with concurrent atomic `set_bit` operations, leading to lost dirty =
bits.
--

commit 2aa486852c957946a99960f65fceb0012466db06
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: S390: Prepare gmap for a second KVM implementation

Refactor gmap code such that a second s390 (host) KVM implementation can
use the gmap code as well. Move relevant definitions into the shared
kvm_host.h. Move mmu code from s390 to gmap so the other KVM
implementation can use it as well.

> diff --git a/arch/s390/kvm/gmap/mmu.c b/arch/s390/kvm/gmap/mmu.c
> new file mode 100644
> index 0000000000000..5bb6609b974b2
> --- /dev/null
> +++ b/arch/s390/kvm/gmap/mmu.c
[ ... ]
> +int gmap_get_dirty_log(struct kvm *kvm, struct kvm_dirty_log *log)
> +{
[ ... ]
> +	/* Clear the dirty log */
> +	if (is_dirty) {
> +		n =3D kvm_dirty_bitmap_bytes(memslot);
> +		memset(memslot->dirty_bitmap, 0, n);
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but since the code is being
moved here, I noticed this clearing logic. Can this non-atomic memset()
race with concurrent atomic bit setting operations?

If KVM concurrently calls mark_page_dirty() (for example, from
kvm_s390_sync_request() for virtio indicators), which sets bits in this
same bitmap using set_bit_le(), it seems we could lose dirty bits in the
gap between the copy and this clear, or have the atomic set overwritten by
the memset().

Could this lead to lost dirty bits and memory corruption during live
migration?

[ ... ]
> +void gmap_commit_memory_region(struct kvm *kvm,
> +			       struct kvm_memory_slot *old,
> +			       const struct kvm_memory_slot *new,
> +			       enum kvm_mr_change change)
> +{
> +	struct kvm_s390_mmu_cache *mc =3D NULL;
> +	int rc =3D 0;
> +
> +	if (change =3D=3D KVM_MR_FLAGS_ONLY)
> +		return;
> +
> +	mc =3D kvm_s390_new_mmu_cache();
> +	if (!mc) {
> +		rc =3D -ENOMEM;
> +		goto out;
> +	}

[Severity: Critical]
This is a pre-existing issue, but is it safe for this memory allocation to
fail during the memslot commit phase?

If kvm_s390_new_mmu_cache() fails under memory pressure, the error
is only printed at the goto out label and the required gmap table updates
are skipped:

[ ... ]
> +out:
> +	if (rc)
> +		pr_warn("failed to commit memory region\n");
> +	kvm_s390_free_mmu_cache(mc);
> +}

For KVM_MR_DELETE and KVM_MR_MOVE, skipping dat_delete_slot() could
leave the guest with a stale, usable hardware mapping to host memory.

Does this lead to a guest-to-host use-after-free if userspace issues
KVM_SET_USER_MEMORY_REGION under high memory pressure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706085229.9795=
25-1-seiden@linux.ibm.com?part=3D15
