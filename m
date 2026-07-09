Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2992D37F01D;
	Thu,  9 Jul 2026 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611331; cv=none; b=SVMl7nxEbIJi5FV69LwRlhUNVyPHayP87BwocR58Jme8krAeijt/du5FhR3bWA3eHhPkFwksECkGy+805EZiG/BXj8HRQ+58+7a8Dl1TdxvxwjkYUXzzvZRvEWFwpsOo4D2xFMjmmcxH86hH5ROQCvoXWB3oWt0X2pBen5IPFkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611331; c=relaxed/simple;
	bh=GL5+aXAG7lup7EQC6JAruqG9hFDr9rua6c9e0elwy8A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ww0J5hBs4xIdkGF0LDlSRiUppyGqPNzZqucLJzS0ZnJPc2Zl3MvFSs0ozDYuVxVDn+9W2LGOZrT2SMWCK3U1ND2YXrYfyvU4+LPOB9mAVz3GDACQZ2LMG+WtQ8w7D5Vnm0JuGbrAZGTKVyietUHoCD7ZW2iFI2CRHykZj/fUYFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErWfHbkL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErWfHbkL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F0A1F00A3A;
	Thu,  9 Jul 2026 15:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783611329;
	bh=md6ctp74PT6Huy+2hltZzOIsNFLP7FULS9+GvlfWrGY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ErWfHbkL5PdTa/yhD7f0rSJgJQoH+JSdyNTL36LXwk3pGVyWvoMGYJkzkHBlWxeav
	 inQg6oP150aFf/L99GNkIH67jaQ2Rk86JSuuPRwylX0btA8irtErmO3Mtlir7gqBm8
	 N0rx694REdY7R5TnWBzbfmtEvQfwGnwJM/PBExod9Xe9qoZCJObsf+Immak1fDDVy7
	 mf3RSzcOMwKmrG79CEJb5rYuBVljK+n3C5Mep7coyf9XmIcM5aMhh2jZ+SUDNkFF9I
	 0XIca9csKMZGxKb+VLlRGKL2ox42mxNzBbyF6L8yOqxa0frGr9yiRscPMofp6UebFn
	 TW4lqQuH6Icew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 18/21] KVM: s390: vsie: Add VSIE max shadow
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260709-vsie-sigpi-v1-18-ea9f12066408@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
 <20260709-vsie-sigpi-v1-18-ea9f12066408@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:35:28 +0000
Message-Id: <20260709153528.A3F0A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Using the `MIN()` and `MAX()` macros on concurrently mutable modul=
e parameters causes a TOCTOU vulnerability leading to out-of-bounds array w=
rites.
- [Medium] Setting `vsie_shadow_sca_max` to 0 fails to disable SCA shadowin=
g, breaking the documented administrative feature.
--

--- Patch [18]: [PATCH 18/21] KVM: s390: vsie: Add VSIE max shadow configur=
ation ---
commit 20f6b4acf8a001837c97129c0036793d506ee32c
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Add VSIE max shadow configuration

This commit introduces vsie_shadow_scb_max and vsie_shadow_sca_max
module parameters to control the maximum number of shadow structures
kept by KVM.

> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index de8931e714ca2..c392f7afe130c 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c

[ ... ]

> @@ -1038,7 +1048,8 @@ static struct vsie_sca *get_vsie_sca(struct kvm_vcp=
u *vcpu, struct kvm_s390_sie_
>  	 * We want at least #online_vcpus shadows, so every VCPU can execute the
>  	 * VSIE in parallel. (Worst case all single core VMs.)
>  	 */
> -	max_vsie_sca =3D MIN(atomic_read(&kvm->online_vcpus), KVM_S390_MAX_VSIE=
_VCPUS);
> +	max_vsie_sca =3D MIN(MAX(atomic_read(&kvm->online_vcpus), vsie_shadow_s=
ca_max),
> +			   KVM_S390_MAX_VSIE_VCPUS);

[Severity: Medium]
Does setting vsie_shadow_sca_max to 0 actually disable SCA shadowing
as documented in the commit message?

Since online_vcpus is at least 1 for an active VM, MAX(online_vcpus, 0)
will always evaluate to online_vcpus. It appears max_vsie_sca silently
defaults to the number of active VCPUs instead of 0, which would prevent
the feature from being disabled.

[Severity: High]
Could the use of MIN() and MAX() macros on a mutable module parameter lead
to a time-of-check to time-of-use out-of-bounds write?

The MIN() and MAX() macros evaluate their arguments multiple times. If
vsie_shadow_sca_max is concurrently modified via sysfs from a value < 256
to a value > 256 during evaluation, could this macro return the new
out-of-bounds value?

If max_vsie_sca exceeds 256, it could allow kvm->arch.vsie.sca_count to
exceed array capacities, leading to an out-of-bounds write here:

kvm->arch.vsie.scas[kvm->arch.vsie.sca_count] =3D vsie_sca;

[ ... ]

> @@ -1902,7 +1913,8 @@ static struct vsie_page *get_vsie_page(struct kvm_v=
cpu *vcpu, unsigned long addr
>  		put_vsie_page(vsie_page);
>  	}
> =20
> -	max_vsie_page =3D MIN(atomic_read(&kvm->online_vcpus), KVM_S390_MAX_VSI=
E_VCPUS);
> +	max_vsie_page =3D MIN(MAX(atomic_read(&kvm->online_vcpus), vsie_shadow_=
scb_max),
> +			    KVM_S390_MAX_VSIE_VCPUS);

[Severity: High]
Does this have the same double-evaluation vulnerability as max_vsie_sca?

If vsie_shadow_scb_max is modified during macro evaluation, max_vsie_page
could bypass the KVM_S390_MAX_VSIE_VCPUS limit, leading to out-of-bounds
writes on the kvm->arch.vsie.pages array.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-vsie-sigpi=
-v1-0-ea9f12066408@linux.ibm.com?part=3D18
