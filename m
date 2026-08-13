Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCB332E151;
	Thu, 13 Aug 2026 23:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786662069; cv=none; b=VSU8Gc9MDYxRiG4hECPMWTzY6J6MdTO9arUylEAlr09pwSXKlRMnw3dLNBAxp+ZFtYbv/n+TCk2eA1LESCGk1hxxKi0IL8BpK+NRljfSIKh/Ab/IlQNJu42tx3Mlxrt/t3RDTh1UK8nj//+I+Sf85xkRfEGNQN+o6i+w+O/nyNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786662069; c=relaxed/simple;
	bh=GAsgRMnWz8UoL5rOje3fwcF5A2QZZXdQeRTDnxyDoxc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l280BqdyjWfPVBm9/H2cnrWrNr7WDuQbjBG9TVuFfPjFFHkGw7yCD0TguVbSGO0RPUZ/cFSEOPGAyHExngwPteay8lOtNtxB/RJdCE4QVqanfYzvev1aRauNcL9sOhF9+NU/Qp3GvAPoq2UEvFKU9TSFZeU8fm/4TnPXNbC854E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2l/zfFq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2l/zfFq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CA11F00A3A;
	Thu, 13 Aug 2026 23:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786662068;
	bh=VhTIDfGcFAlgV0IxMBpanCzug3fm+uF81rfDUPeaWi4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K2l/zfFqy3aDhAVjL7lvXqVDh/F3E92H3gylkvFtRQvS2q1UUEWa/1yQMa758ll6l
	 rF34xBGwqkODlSolHU6uNrDfOD5ULId4+OVsStnZuHqG9vzdscAM6P6TUvUnRe7UO7
	 QO7qv2ZeTuPCGxNI/ILdVhw0ul50t4S6ykxJkkRoJmgan0Kky9P65JmkpSxVQtRxNX
	 WXzfrsLixoZGYD3YMjMptfZ7WBMhPKsxljntQsC07uMHwxvIGA4wZYDG0HSnbeebs1
	 +mI1IjYOm84qyeBLo0P7dM8ghgtuOFCb4VjrlHA9lLb0dkh1ZqEhHM8VBAILAm0LbS
	 hxPSD9H6XpLTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/9] KVM: s390: vsie: Fix guest page tables
 protection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260324174301.232921-9-imbrenda@linux.ibm.com>
References: <20260324174301.232921-9-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 23:01:07 +0000
Message-Id: <20260813230107.99CA11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Uninitialized variable 'gl' used in condition, leading to skip=
ped allocation and host kernel NULL pointer dereference.
--

--- Patch [8]: [PATCH v3 8/9] KVM: s390: vsie: Fix guest page tables protec=
tion ---
commit ff58b599b812f86d2edff5eab1c005a2ef716cc7
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: vsie: Fix guest page tables protection

This patch adjusts the levels of guest page tables that are write-protected
when shadowing, and avoids double protecting the last level. It also skips
attempting to shadow the DAT tables when the nested guest is running in a
real address space.

> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index 0ac2d775d4c05..93a757749a6ee 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
> @@ -1518,6 +1518,13 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_=
cache *mc, struct gmap *sg,
>  	    (!ptep && crste_leaf(*table) && !table->h.i && table->h.p =3D=3D w-=
>p))
>  		return 0;
> =20
> +	/* In case of a real address space */
> +	if (w->level <=3D LEVEL_MEM) {
> +		l =3D TABLE_TYPE_PAGE_TABLE;
> +		hl =3D TABLE_TYPE_REGION1;
> +		goto real_address_space;
> +	}
> +
>  	gl =3D get_level(table, ptep);

[ ... ]

> @@ -1542,6 +1549,7 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_c=
ache *mc, struct gmap *sg,
>  	/* Get the smallest granularity */
>  	l =3D min3(gl, hl, w->level);
> =20
> +real_address_space:
>  	flags =3D DAT_WALK_SPLIT_ALLOC | (uses_skeys(sg->parent) ? DAT_WALK_USE=
S_SKEYS : 0);
>  	/* If necessary, create the shadow mapping */
>  	if (l < gl) {
                  ^^
[Severity: Critical]
Does this leave the variable gl uninitialized when taking the goto?

When a nested guest is running in a real address space, the new goto
statement bypasses the initialization of gl:

_gaccess_do_shadow() {
    ...
    if (w->level <=3D LEVEL_MEM) {
        l =3D TABLE_TYPE_PAGE_TABLE;
        hl =3D TABLE_TYPE_REGION1;
        goto real_address_space;
    }
   =20
    gl =3D get_level(table, ptep);
    ...
real_address_space:
    ...
    if (l < gl) {

If the uninitialized stack value for gl causes the if (l < gl) condition
to evaluate to false, the dat_entry_walk() call is skipped.=20

Since ptep was initialized to NULL at the start of _gaccess_do_shadow()
and the initial dat_entry_walk() may have stopped early without setting it,
ptep can remain NULL.=20

Later in the function, _do_shadow_pte() is called with this NULL ptep,
which could lead to a NULL pointer dereference in pgste_get_trylock() and
a host kernel panic.
       =20
Is there a way to ensure gl is initialized before the jump, or provide a
safe default when running in a real address space?

>  		rc =3D dat_entry_walk(mc, gpa_to_gfn(saddr), sg->asce, flags, l, &tabl=
e, &ptep);
>  		if (rc)
>  			return rc;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260324174301.2329=
21-1-imbrenda@linux.ibm.com?part=3D8
