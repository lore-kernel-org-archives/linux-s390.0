Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75F63C0610;
	Fri, 14 Aug 2026 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725987; cv=none; b=KrWlL2OOGyUbhEAE4YL9mjjBxhOKcQPeCkIzOxgUatDfeq88QpjSuke9rtT82y2I47eqyFrZL1u8TkLuayIY3+4sLGPwfpPeysfDnBPMU9Z+5+hYsnHH5EErGXBZCnkxr7nCK+Uf3wXa7VfmP+AacOeLurLOcltMexj2MA1z/kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725987; c=relaxed/simple;
	bh=X3xy9AcwfIfdnc24r4obB+YdF3LD+ZRrSVq8m0pOGPA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W5pHzknCGFhB4B/kVPj6yE7wFIKVjgOWosYoxkwEH7fX0cFbhFYGti0ZPLptloB/AnlPXUgbQsRmpHyELvXDmlV1EIGx9RssNZ7zA7omR3xzTdfb89mzcwy5P0/4RP0W/MDEU59uU2Zr38OEdhXvOyY1a0wnZFgu30/0NOL25aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+W8MC6g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+W8MC6g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242221F000E9;
	Fri, 14 Aug 2026 16:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786725985;
	bh=F3IvnyYd+KrtMq1DfflIUddsVbVYI6XXOSELq8KmcMI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F+W8MC6gB3RuWP5UgV8124F8DpMnDmagcwRQd9r5zRAowUDn3fwpkdKui/OEBHmJm
	 De8EazFXOBVpAyzV3Am3rvzvJy6IvxrFW3Q/uomdlYmmfrgTp9AE4hxY9x0mn3CHnU
	 LgmqDPkIV/KvfJmwpQGvdKtI0xMnFACEIr5gzO9rBKCEcJLe+LnPXhJH3tu4vmvENN
	 eTFZH5psXkf42UnnyOrGbJUmJ6inhok41avpyZHpdk6o/zK5f0z359E4jKnT+GuZMc
	 dJvyfivr4/yVno7H46v2eZ+8d0WfozQP68Cd0qDe7PcFcFqxjqp0h5fauuDLvXT/T9
	 o5PsEba7irioA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] KVM: s390: Fix potential races in dat skey
 functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260814163355.227191-7-imbrenda@linux.ibm.com>
References: <20260814163355.227191-1-imbrenda@linux.ibm.com>
 <20260814163355.227191-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 16:46:24 +0000
Message-Id: <20260814164625.242221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The functions `dat_get_storage_key` and `dat_reset_reference_bit` =
loop infinitely when the requested guest address is unmapped, leading to a =
host lockup (Denial of Service).

Pre-existing issues:
- [Critical] Missing TOCTOU fix for concurrent large page split in `_destro=
y_pages_crste()` allows KVM to use out-of-bounds physical addresses, leadin=
g to host memory corruption or panic.
--

--- Patch [6]: [PATCH v2 6/6] KVM: s390: Fix potential races in dat skey fu=
nctions ---
commit 7ad4916f2fab0f5e4f1cfe048d34867e81b79c1b
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix potential races in dat skey functions

This commit addresses a race window between dat_entry_walk() and
large_crste_to_phys() where a large page could be split concurrently.
It fixes this by using READ_ONCE on the crste pointer and retrying the
walk if a race is detected.

> diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
> index 7e5dd5a1eb1ef..b4c318ebd91e9 100644
> --- a/arch/s390/kvm/dat.c
> +++ b/arch/s390/kvm/dat.c
> @@ -620,17 +620,20 @@ int dat_get_storage_key(union asce asce, gfn_t gfn,=
 union skey *skey)
>  	union pte *ptep;
>  	int rc;
> =20
> +again:
>  	skey->skey =3D 0;
>  	rc =3D dat_entry_walk(NULL, gfn, asce, DAT_WALK_ANY, TABLE_TYPE_PAGE_TA=
BLE, &crstep, &ptep);
>  	if (rc)
>  		return rc;
> =20
>  	if (!ptep) {
> -		union crste crste;
> +		union crste crste =3D READ_ONCE(*crstep);
> =20
> -		crste =3D READ_ONCE(*crstep);
> -		if (!crste.h.fc || !crste.s.fc1.pr)
> +		if (!crste_leaf(crste))
> +			goto again;

[Severity: High]
If the guest address is unmapped, dat_entry_walk() with DAT_WALK_ANY can
return 0 with ptep =3D=3D NULL and an unmapped directory entry (where crste=
.h.fc
is 0).

Since crste_leaf() returns false when fc is 0, won't this unconditionally
trigger the goto again path and create an infinite loop?

> +		if (!crste.s.fc1.pr)
>  			return 0;
> =20
>  		skey->skey =3D page_get_storage_key(large_crste_to_phys(crste, gfn));

[ ... ]

> @@ -775,9 +792,12 @@ int dat_reset_reference_bit(union asce asce, gfn_t g=
fn, union skey *skey)
>  	if (!ptep) {
>  		union crste crste =3D READ_ONCE(*crstep);
> =20
> -		if (!crste.h.fc || !crste.s.fc1.pr)
> +		/* A large page has been split concurrently, try again */
> +		if (!crste_leaf(crste))
> +			goto again;

[Severity: High]
Does this also suffer from the same infinite loop issue as
dat_get_storage_key() when processing an unmapped physical address?

> +		if (!crste.s.fc1.pr)
>  			return 0;
> -		skey->skey =3D page_reset_referenced(large_crste_to_phys(*crstep, gfn)=
) << 1;
> +		skey->skey =3D page_reset_referenced(large_crste_to_phys(crste, gfn)) =
<< 1;
>  		return 0;
>  	}

[Severity: Critical]
This isn't a bug introduced by this patch, but while reviewing the TOCTOU
fixes here, I noticed a similar pre-existing issue in
arch/s390/kvm/gmap.c:_destroy_pages_crste():

	if (!crstep->h.fc || !crstep->s.fc1.pr)
		return 0;

	origin =3D crste_origin_large(*crstep);

The crstep pointer is dereferenced twice without READ_ONCE(). If a concurre=
nt
large page split occurs between these reads, crste_origin_large() could ret=
urn
-1, passing an out-of-bounds address to phys_to_page() and
__kvm_s390_pv_destroy_page().

Should this also be updated with READ_ONCE() to prevent potential host memo=
ry
corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814163355.2271=
91-1-imbrenda@linux.ibm.com?part=3D6
