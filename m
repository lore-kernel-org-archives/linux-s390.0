Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59D021255A;
	Tue, 23 Jun 2026 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782229796; cv=none; b=SOwtveusPERv5ij3naMWGUnGtdxip0qVXIfUbVEnpgmBBf1elfp2g9+2SQpD4VIvqL6fwj2nutLysIiShTbOPbDrIqeUH8s2OosPB2mcNjrLcsUg+8wX0LBtIXcMPwGWShv2SvIzEx/IOiuMhJFZfaaUJA5Tti4nBxIBwTR03rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782229796; c=relaxed/simple;
	bh=1MeT1/fiQ6GlIguBnnTJtg/ndB8VWT+HE3GVJMM/LUY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rcsv0DpP2OPTeSgDMrj/uxvzntycNlapDDWKRTpr3NqhK/6sGAk+0giEo5JuaOLAkvHyGGmuC/ri6geDcjc6ulE9aHXXJ4ifXBUDReXQirvza74lLxSfi0rUsXgoqONtDXPQE/YcHkKpiNBTtTVriX7P3D26qtrcEN5eQKqgIQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRwO2y3R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRwO2y3R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614DD1F000E9;
	Tue, 23 Jun 2026 15:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782229794;
	bh=F47HPVewEyALefWieJqv0LzI11OsiwNpaCmfgWRtFVQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mRwO2y3RLYhkTRgEd/DuYqsnlTIyb5kKRdhME7DqOBnybRi1nAqbaPpV2nbPE0A4i
	 rrJhfTe6BpEtI1KI2b7LS1/gqRBZG4BBKRyaUd4NJu/HyEt91t55h1887A75aMnYE4
	 cHcENxCT0mpZ55W5PylC6FHHGXqeaKTF5rImCvqe64H8yG0RPcI2S/3gZiJshFTog7
	 ub5mkCt+XWVAXYAhSeSGZ9vAMmaiCRbCOvSbgIONmHQwcb+3rv6A8zGQcm8dk6G00Y
	 7M3mnHa7CTT0+/M2jQIBucyv97eDklqTW20xBoMoiKvdvMCCbAWjJVTFXHs7WIykZb
	 TjQu0bGfjdiBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/10] KVM: s390: Fix locking in
 kvm_s390_set_mem_control()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260623153331.233784-7-imbrenda@linux.ibm.com>
References: <20260623153331.233784-1-imbrenda@linux.ibm.com>
 <20260623153331.233784-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 15:49:54 +0000
Message-Id: <20260623154954.614DD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lost early-exit return codes in `dat_crste_walk_range` leads to so=
ft lockups and aging logic failures.
--

commit b7c3f62b3078686b2bddd109edeee90c43ecceb5
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix locking in kvm_s390_set_mem_control()

Add the missing locking around dat_reset_cmma().

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index ffb20a64d328f..fe0ae15e5ad07 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -990,9 +990,11 @@ static int kvm_s390_set_mem_control(struct kvm *kvm,=
 struct kvm_device_attr *att
>  		if (!kvm->arch.use_cmma)
>  			break;
> =20
> +		guard(mutex)(&kvm->lock);
>  		VM_EVENT(kvm, 3, "%s", "RESET: CMMA states");
>  		do {
> -			start_gfn =3D dat_reset_cmma(kvm->arch.gmap->asce, start_gfn);
> +			scoped_guard(read_lock, &kvm->mmu_lock)
> +				start_gfn =3D dat_reset_cmma(kvm->arch.gmap->asce, start_gfn);

[Severity: High]
This is a pre-existing issue, but looking at how dat_reset_cmma() and other
DAT walk operations use _dat_walk_gfn_range() under the hood, is there a bug
in arch/s390/kvm/dat.c:dat_crste_walk_range() where we can silently lose
early-exit return codes?

When dat_crste_walk_range() performs lower-level walks, it assigns the resu=
lt
to 'rc', but lacks an immediate check to break the loop:

arch/s390/kvm/dat.c:dat_crste_walk_range() {
	...
		if (!crste.h.i && !crste.h.fc) {
			if (!is_pmd(crste))
				rc =3D dat_crste_walk_range(max(start, cur), min(end, next),
							  _dereference_crste(crste), walk);
			else if (walk->ops->pte_entry)
				rc =3D dat_pte_walk_range(max(start, cur), min(end, next),
							dereference_pmd(crste.pmd), walk);
		}
	}
	return rc;
}

If a walk operation defines both crste_ops and pte_entry (such as
dat_reset_skeys or test_age_ops) and dat_pte_walk_range() returns a non-zero
code (like a gfn for a reschedule request or 1 for finding a young page),
the loop continues to the next iteration.

In the next iteration, if the upper-level crste_op evaluates to 0, could it
silently overwrite 'rc' and allow the walk to incorrectly continue?

Can this cause soft lockups on the host for guests with large memory due to
lost reschedule requests, or incorrect page aging data causing performance
degradation?

>  			cond_resched();
>  		} while (start_gfn);
>  		ret =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623153331.2337=
84-1-imbrenda@linux.ibm.com?part=3D6
