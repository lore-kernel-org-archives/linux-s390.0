Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A2039020C;
	Wed, 12 Aug 2026 16:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551812; cv=none; b=FFkVFDZj3kTMOBaRtgp6EIM0mXOvUm6JcxFWCAF6ePe7dQc5Dtm9hGvVhuA1oRFeM4OwAi7DsUtZUbult4cSrzP9+jwRLdIjF8faRcHb8iVD43z3e8pwO7vd6cG6ztEakqmdLRGbjnh4bj6krqnYL8twv2BtnWF/GBc8G80HoOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551812; c=relaxed/simple;
	bh=81yw9KtPJY4092rNlVXefaB399BE7qJwHaU91lcN/fM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JyAHG8lmS2bmfovvb5Vd7wAvVLorPLmhTeelSTYbJe0IxvgR9IdjlSFNXcoJ6X9K2LyXgZOFJzeCRGYbp+biRM1D9UIxgdoSjVjPaCCCYABLWql4YdB1yj2ealkBHfCP46zDGFfyJxEWdnPWZKgoDkJj+9wOHAUGWaXnoJaFSXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Be4LJIU0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Be4LJIU0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0DA1F000E9;
	Wed, 12 Aug 2026 16:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786551810;
	bh=p0dYXF1qx5UMR3XWh7zBHvv/Wh/mEHm6UZu213x79ek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Be4LJIU0nXLG4siCmFDHQakjTRTICu3NaZJfrSzFv8bGbC3pVid+EEF1VHdm29bqv
	 73K53vohYxKCuihG6wbcYDQC7h4kgOMOoWtM79QK2i4SwRSXhfRLuSZGzJQw9XH/Cd
	 4Rq1AMqwePv18HYM2036wt3s3sBhriNJLzpwaBU7xFsxMMc2MSl1bDstWVualaIT2H
	 7DFRZNeMALDAbLsuzB+KW9pqCxH+Eisct/Lyj3wfPMxjy6nZ9UloABr0UJYY1RcS8b
	 rHf+mr7LPQhmRSeXCQUi+gsLxhm/0R242iLRtG2ZB2uc5HE14BiKtgwsghzJuSUXwq
	 qm+UfXjFwFgQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/20] KVM: s390: vsie: Guard against invalid CPU
 address
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260812-vsie-sigpi-v4-15-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
 <20260812-vsie-sigpi-v4-15-f19e49666315@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:23:30 +0000
Message-Id: <20260812162330.9C0DA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The newly added bounds check for `scb_o->icpua` is completely =
ineffective due to a signed-integer mismatch and a Time-of-Check to Time-of=
-Use (TOCTOU) race condition. A malicious guest can bypass this check, lead=
ing to a massive out-of-bounds array access and severe hypervisor memory co=
rruption.
--

--- Patch [15]: [PATCH v4 15/20] KVM: s390: vsie: Guard against invalid CPU=
 address ---
commit b018701df60566888acc3dc5acc8b060071a7256
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Guard against invalid CPU address
   =20
Inject a specification interrupt if the CPU address is above 255.
This adds a check to ensure compliance with architectural limits and
guard against out-of-bounds accesses.

> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -2169,6 +2169,11 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
>  		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
>  	scb_o =3D (struct kvm_s390_sie_block *)phys_to_virt(scb_hpa);
> =20
> +	if (scb_o->icpua >=3D KVM_S390_MAX_VSIE_VCPUS) {

[Severity: Critical]
Is it possible for icpua to be a negative value? If icpua is a signed 16-bit
integer, a negative value would bypass this check.

Additionally, since scb_o resides in guest memory, is this check subject to=
 a
Time-of-Check to Time-of-Use (TOCTOU) race? A guest could potentially mutate
icpua after this check passes but before it is fetched again.

For example, could the guest change the value in memory before the secondary
fetch occurs later in kvm_s390_handle_vsie():

vsie_page =3D get_vsie_page_cpu_nr(vcpu, vsie_sca, scb_addr, scb_o->icpua);

If a bypassed or mutated value is implicitly cast to a large unsigned index
in get_vsie_page_cpu_nr(), could this result in an out-of-bounds read and
write on vsie_sca->pages[cpu_nr]?

> +		rc =3D kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> +		goto out_unpin;
> +	}
> +
>  	if (!use_ssca(vcpu->kvm, scb_o)) {
>  		/* get the vsie_page with pinned scb_o */
>  		vsie_page =3D get_vsie_page(vcpu, scb_addr);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-vsie-sigpi=
-v4-0-f19e49666315@linux.ibm.com?part=3D15
