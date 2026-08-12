Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62282429CC2;
	Wed, 12 Aug 2026 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535232; cv=none; b=aR55ON0Ngl/kZcROqrTTo7D5i+wWQMOrXnteyHg16tqLyZJoADrHt35B7ka58/HvnDgwSpXDqd6HnTTGEuiBbjS0KBLsv9KDhAtGkKwV3fGhFg+f1p3z01SDDQO9TXcfK2yJLfMjvWlHBbL92n4LzN/Cb2yqfM+F8Q03B1jjYh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535232; c=relaxed/simple;
	bh=1yA+yUbpIiUgazqwE2GzcIX4jKVCLStNp/wludgjnHw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J4UpI76asWhOeo6D+dsjq7helHYvrplCX51+vpT96xC5gBSclYR/NtmOIT6C9ctVSc1o4V7ESiQvqIpFTv0ClwBm7BqlTRS5ypPhhiMhzL9ny+Wsuddez1Ck1Anqz9296IIHcTEtpnhQjEa62ROw/xlsA9BwA4aOau3eLYHRbNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/lDQ1VS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/lDQ1VS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41061F000E9;
	Wed, 12 Aug 2026 11:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786535231;
	bh=AKFcYPZlwzN8WS4xOHr6ff6Kbsqit4qkZg/wrR+Jb64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C/lDQ1VSLvcJEDcakE0/ShTAjEp0W2/niHM4Y2qq4Oz2v3Vi3jD7BBG3tohowWllL
	 eTWKwIKPHJRgTLqkWLFl6SlBzBaVDFZ52BwhGoTvSt5AGU/LFLyBEFu4bUxrcD2lmD
	 4nGe1Rygn6pk192nNTtEKbgi3FfoKnzz7PMTm/tNZzbuYeSdt37SJkbv/rhg+oRlXp
	 ckRtgBRNoLBMv9MwlxIDxkkqa4LvzL009f8vbDBGTAa4EuANEOFMKH1B6e1sUirjMu
	 LGwa+9MWmbxOVy91DRgR1HK/qRfsBbLCe1bGryhF4YwZymVuAebOVXQ3zEA95gq43o
	 9ZwDieEP7zvCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 9/9] KVM: s390: Fix _gaccess_shadow_fault()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260812104436.109741-10-imbrenda@linux.ibm.com>
References: <20260812104436.109741-1-imbrenda@linux.ibm.com>
 <20260812104436.109741-10-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 11:47:10 +0000
Message-Id: <20260812114710.B41061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Calling `gmap_link()` inside `_gaccess_do_shadow()` while hold=
ing `sg->parent->children_lock` causes a guaranteed lockdep splat and a rec=
ursive spinlock deadlock.
--

--- Patch [9]: [PATCH v2 9/9] KVM: s390: Fix _gaccess_shadow_fault() ---
commit 2773a2ded997afc2d9abf44ed48fd84a08d773f8
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix _gaccess_shadow_fault()

This commit addresses an issue where shadowed nested guest memory is not
present in the parent guest gmap, causing -ENOENT to be incorrectly
propagated to userspace. It fixes this by manually calling gmap_link()
on the missing memory of the nested guest.

> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
> @@ -1551,8 +1552,17 @@ static int _gaccess_do_shadow(struct kvm_s390_mmu_=
cache *mc, struct gmap *sg,
>  			return -EAGAIN;
>  	}
> =20
> +retry:
>  	rc =3D dat_entry_walk(NULL, entries[LEVEL_MEM].gfn, sg->parent->asce, D=
AT_WALK_LEAF,
>  			    TABLE_TYPE_PAGE_TABLE, &host, &ptep_h);
> +	if (rc =3D=3D -ENOENT) {
> +		slot =3D gfn_to_memslot(sg->kvm, entries[LEVEL_MEM].gfn);
> +		if (!slot)
> +			return PGM_ADDRESSING;
> +		rc =3D gmap_link(mc, sg->parent, entries + LEVEL_MEM, slot);

[Severity: Critical]
Does this introduce a recursive spinlock deadlock?

Earlier in _gaccess_do_shadow(), we enforce that the parent's children_lock
is already held:

	lockdep_assert_held(&sg->parent->children_lock);

However, the new call to gmap_link() passes sg->parent as the gmap argument.
If gmap_link() eventually triggers an unshadow event, the call chain reaches
gmap_handle_vsie_unshadow_event(), which attempts to unconditionally acquire
the same lock:

	scoped_guard(spinlock, &parent->children_lock)
		_gmap_handle_vsie_unshadow_event(parent, gfn);

Additionally, gmap_link() can lead to _gmap_ptep_xchg() which explicitly
asserts that the children_lock is not held:

	else
		lockdep_assert_not_held(&gmap->children_lock);

Could a nested guest trigger this missing mapping path and cause a host
kernel hang?

> +		if (!rc)
> +			goto retry;
> +	}
>  	if (rc)
>  		return rc;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812104436.1097=
41-1-imbrenda@linux.ibm.com?part=3D9
