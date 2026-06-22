Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9CB2F5485;
	Mon, 22 Jun 2026 16:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782145487; cv=none; b=dt/QzpOM5BZZ9xqx1nFIhhqRMGKJiX3x0fvCPaHCkWO8/C3QAYg6wUlhC2j8pycRP3jY1M2y024dT5QGGDGjWwsyG7iQD9vC1bdDi6choT40Tv1bHqEKu1aa5kiDwWMVgsSGc9BtcKkxiuuqoJFfl0N44maZTcKLzH7H/x6B4cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782145487; c=relaxed/simple;
	bh=TphRlSpnC7iTiy86k+vqLZCVIkexI2eq04SfvbVl190=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cjPiS61QPXuZQlUWHqumeqr1/JrOQU0QDlnhifKEUcHbrOl0Hdhje6PXpSLWDGfDudPOqxN36Hvph3m4I3T7A6cW6uDKlyS8TMKYjjxzLyF6YdmIPIxHCQ9MlQ7oKk//ADSE3MrIcMI5vGUX2oIsBgQ/MsLH8HMUgl2IOE+FtSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QU2Nekfx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QU2Nekfx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA1B1F000E9;
	Mon, 22 Jun 2026 16:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782145486;
	bh=jRdgpmhjGnidM6+bAon764FnXLlnWA3Tnuk3cBYGITk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QU2NekfxvuAguZCSBGO6FbFDrUgIJ/1vuJIpFfnsGAaQ6fUsj1+0WErxzmjY2WI3c
	 sktUvi41Hg1pkQ/G7CuUsBdu8vqHoIMuBL4WtVP/H/hjPM3yDTuL6iaq1s86+mw3HU
	 pTIODJmgI69YyaSnEjFm4/mkP31oEDpNvU7WTr3yN9NouTIDMNMgbl2YrjjDwo30Gh
	 A9YoTT7GlC4vETH8ZRWctODrE0czBbXQPMvoSH6FIenhC4BxtHeMqeNvHWyl9jXQHP
	 C7NCYiSPFw235AUP8Rq55tz/SmbPg3nI7EaMOLppnc/4hT4bFEwUzEe9xMGMM8QgFW
	 Thapx+ilyzd7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/9] KVM: s390: Fix code typo in
 gmap_protect_asce_top_level()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260622160739.202044-5-imbrenda@linux.ibm.com>
References: <20260622160739.202044-1-imbrenda@linux.ibm.com>
 <20260622160739.202044-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 16:24:45 +0000
Message-Id: <20260622162445.EEA1B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Preexisting ABBA deadlock between KVM `mmu_lock` and gmap `childre=
n_lock`.
--

commit d8dbe6f4197c6a65f9a60ab673cf05c59e3ecf7b
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix code typo in gmap_protect_asce_top_level()

This commit fixes a typo in gmap_protect_asce_top_level() where asce.dt
was used instead of asce.tl for the length passed to
kvm_s390_get_guest_pages().

> diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
> index 3192f610f6962..e6e786811db86 100644
> --- a/arch/s390/kvm/gmap.c
> +++ b/arch/s390/kvm/gmap.c
> @@ -1262,7 +1262,7 @@ static int gmap_protect_asce_top_level(struct kvm_s=
390_mmu_cache *mc, struct gma
>  	/* Pairs with the smp_wmb() in kvm_mmu_invalidate_end(). */
>  	smp_rmb();
> =20
> -	rc =3D kvm_s390_get_guest_pages(sg->kvm, context.f, asce.rsto, asce.dt =
+ 1, false);
> +	rc =3D kvm_s390_get_guest_pages(sg->kvm, context.f, asce.rsto, asce.tl =
+ 1, false);
>  	if (rc > 0)
>  		rc =3D -EFAULT;
>  	if (!rc)
>  		rc =3D _gmap_protect_asce_top_level(mc, sg, &context);

[Severity: High]
This isn't a bug introduced by this patch, but is there a preexisting ABBA
deadlock between parent->children_lock and parent->kvm->mmu_lock here?

In __gmap_protect_asce_top_level() (which handles setting up non-real-space
shadows), the code acquires sg->kvm->mmu_lock first, and then acquires
parent->children_lock:

arch/s390/kvm/gmap.c:__gmap_protect_asce_top_level() {
    guard(write_lock)(&sg->kvm->mmu_lock);
    ...
    scoped_guard(spinlock, &parent->children_lock) {
        ...
}

However, in gmap_create_shadow(), the lock ordering is reversed. It acquires
parent->children_lock first and then acquires parent->kvm->mmu_lock when
creating a real-space shadow:

arch/s390/kvm/gmap.c:gmap_create_shadow() {
    scoped_guard(spinlock, &parent->children_lock) {
        ...
        if (sg->guest_asce.r) {
            scoped_guard(write_lock, &parent->kvm->mmu_lock)
                ...
}

If two vCPUs of the same VM concurrently attempt to create a real-space
nested shadow and a regular nested shadow, could this lead to a soft lockup?

>  	if (rc)
>  		kvm_s390_release_faultin_array(sg->kvm, context.f, true);
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622160739.2020=
44-1-imbrenda@linux.ibm.com?part=3D4
