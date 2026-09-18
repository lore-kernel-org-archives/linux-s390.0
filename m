Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73472EEE8A;
	Fri, 18 Sep 2026 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746828; cv=none; b=RJZVAGDGT0LCKzDcG6SFv3KOEnorrnDRwK6d8mnT8ojARHOrvYnjf+WCSHWEguiJNiH76ZxbyjfYFIlWFqWzedPosz/8LAhR5lHlfKdZoKcYqFbmb2RXl58yDKlIl8jSqzchhxoFVms8eEHSQsZeCAp4OKP9y1JuuJFUOnp67QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746828; c=relaxed/simple;
	bh=ny5E8hoLYdHjR6usmiDsgHfT2otoTlUKobRr9Bgug9c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SBLB+m4eCHUc1bZGbvus9PVnAFP+DOvdxtLSvS5Wl+N2oknYEvg4hK2HlFHjf85AQrQDDbfir0P7kxoixPZOpuZ6B8gvB6Btii9rL8+lcir/tU+GvP4Mo+RJnXCISPDr4hu6eOsGLyJl0vAaJq4fvqxoh0wIgLguUHJ1XroaZ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqyAv1su; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqyAv1su"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F1B1F000FF;
	Fri, 18 Sep 2026 15:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789746826;
	bh=akyI3txdzwF4Jc4VNnEVqqlVsMmV/w43ECBf0Ywc4Bg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hqyAv1subQjr6uzZZdZFOkeKLncExlU6iil0P2HeDE5Mk4HdfAzgimN/G6ILZPair
	 rVAycg6oVwz+IMSCvJof546xhcYRvjlophP7Lkx5SY00EdPQ/5qXGbVAo2rERLJ1FW
	 Rzl1m4K2P0aE18T/wHDPfZ2HIW7zfXY25TR33sUdoJW2Gg9Q5V0fUdhxFuMbNNGByC
	 6GtLFfa+R3RH1INhKdArWV3mwjTuaLuvNB0awD7Kohkc3M9B8fPznFVWjMvoSj/f0P
	 kAUsbTT7g7vrut62Kev6NIE+jmdCMqxecXN+p4iAkqox0PQ6rllFBJOWRV45z0SBew
	 3q2e7BIa+stdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 21/21] KVM: s390: vsie: Enable use of VSIE SSCA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260918-vsie-sigpi-v7-21-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
 <20260918-vsie-sigpi-v7-21-f39806eaae37@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:53:45 +0000
Message-Id: <20260918155346.20F1B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: s390: missing MMU notifier integration causes stale page tran=
slations
--

commit c91eb6421a6b9ec0c4df9e03f9cc7aa92ee08182
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Enable use of VSIE SSCA

This commit enables code paths that configure and use VSIE SIGPI and
SRSI, allowing hardware to handle SIGP EXTERNAL_CALL and
SENSE_RUNNING_STATUS instructions without exiting VSIE. The feature can
be enabled globally via the ssca module parameter and improves guest-3
performance.

> diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
> index c99cc03ecb81d..04c14d33927a6 100644
> --- a/arch/s390/kvm/s390/vsie.c
> +++ b/arch/s390/kvm/s390/vsie.c
> @@ -147,6 +147,8 @@ static inline bool use_ssca(struct kvm *kvm, struct k=
vm_s390_sie_block *scb)
>  {
>  	if (!kvm->arch.use_ssca)
>  		return false;
> +	if (!test_kvm_cpu_feat(kvm, KVM_S390_VM_CPU_FEAT_SIGPIF))
> +		return false;
>  	if (!(scb->eca & ECA_SIGPI) && !(scb->ecb & ECB_SRSI))
>  		return false;
>  	if (!read_scao(kvm, scb))
>  		return false;

[Severity: High]
By enabling the use of SSCA here, doesn't this expose a memory corruption
regression in how the vsie control blocks cache host physical addresses?

Looking at get_vsie_sca() which caches the pinned SCA pages:

arch/s390/kvm/s390/vsie.c:get_vsie_sca() {
...
	rc =3D pin_sca(kvm, vsie_sca);
	if (rc) {
		put_vsie_sca(vsie_sca);
		vsie_sca->sca_gpa =3D ULONG_MAX;
		goto out;
	}

	rc =3D xa_insert(&kvm->arch.vsie.osca_to_sca, vsie_sca->sca_gpa >> SCA_ALI=
GNMENT_SHIFT,
		       vsie_sca, GFP_KERNEL_ACCOUNT);
...
}

This appears to cache the pages across VM exits without registering an MMU
notifier to invalidate them when the host mapping changes.

Furthermore, looking at pin_guest_page():

arch/s390/kvm/s390/vsie.c:pin_guest_page() {
...
	page =3D gfn_to_page(kvm, gpa_to_gfn(gpa));
	if (!page)
		return -EINVAL;
	*hpa =3D (hpa_t)page_to_phys(page) + (gpa & ~PAGE_MASK);
...
}

Because this extracts the physical address without closing the time-of-check
to time-of-use window via mmu_invalidate_seq, if host userspace alters the
mapping for the guest physical address (e.g., via madvise with
MADV_DONTNEED or memory hot-unplug), won't KVM retain and use a
stale physical address?

Since this bypasses the MMU notifier retry protocol, could a malicious guest
or dynamic host environment cause the hardware to read or write an old
physical page while the guest OS accesses a new page?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-vsie-sigpi=
-v7-0-f39806eaae37@linux.ibm.com?part=3D21
