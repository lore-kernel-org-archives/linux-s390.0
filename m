Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797B6379C34;
	Thu,  9 Jul 2026 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611007; cv=none; b=ZhhQvIoijzsHxIEi+uaPSeQllikt1Ei72dxvMFasK0r8ywI1AzjUAUjOjIEjH6R44XEuSDKA8qpiC8ED9PS0/kGETMVA4JvFCVj86BKfqSmVjaEyLHUwD2PXtZYeZ5VGrjgqijher87nMo18lUm55Rz8RmftfOn5w4ZaQaQSzjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611007; c=relaxed/simple;
	bh=mraSf28PzwjPH3SFTjPupW9t6EVfqaozHQgwI+o71Ps=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lDpFjYIbgtpEKVqSpbYxOaSFV+pw4k+ikzdoodc/Uv51443urvgdU1yDvfXq6hoHrudAr9R37Tu56/fnFHaHee10nB357pIIqRVfGm1+r5mYGj5U2y7IPpH6hUYXq6plGTelkeFvJWD26BAmDb18dY1nX/5vITG0W3tvM+TTqNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZDHx96j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZDHx96j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CEA1F000E9;
	Thu,  9 Jul 2026 15:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783611004;
	bh=hSk7RzskBIok731iVGKVgo91Y6ViLvPZRSG1O6gzkdU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cZDHx96jRcAwca2KEhfJ3jDvNSqPI7x3uPaEnLSjSLEjsfK69Bv3iChmAgjkJPo5/
	 trq53m967+hNaC8Bc1xuwYkclYRa9fVrLktr5+T8+1ZaPerKtUrMhuuni0BcWdTKT1
	 M1wQdmLFn4wBVu0tdF4nbKlHKjuSXRQovIeuNZPjGDPpMZxE3cxNgFBAjCTJ6/78QS
	 OyroqG326hClfwRi50i0pnmvHswsK5ocvs24STcgHJ+Rw700RDyUQH1hqHU30yB1kE
	 umnVuPC9cFDxPwDqrJNpOjjQT7ROySi+04zf6FeeVL1zLC909LngmB3368KaR8oNAv
	 IF/fTVbMqhX0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/21] KVM: s390: vsie: Add helper to release gmap
 shadow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260709-vsie-sigpi-v1-14-ea9f12066408@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
 <20260709-vsie-sigpi-v1-14-ea9f12066408@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:30:02 +0000
Message-Id: <20260709153004.37CEA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect replacement of `radix_tree_insert` with `xa_store` inadv=
ertently overwrites active VSIE pages on collision.
--

--- Patch [14]: [PATCH 14/21] KVM: s390: vsie: Add helper to release gmap s=
hadow ---
commit 4c401f4e9eb6b9bc115d89b58dc2831bda3b8f47
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Add helper to release gmap shadow
   =20
Create a helper method release_gmap_shadow_safe() to simplify releasing
the gmap shadow of a vsie_page.
Will be called from multiple places in upcoming patches.

> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 644b37582b5c8..874ed2a553479 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
[ ... ]
> @@ -1623,11 +1632,7 @@ static struct vsie_page *get_vsie_page(struct kvm =
*kvm, unsigned long addr)

[Severity: High]
Does replacing radix_tree_insert() with xa_store() inadvertently overwrite
active VSIE pages on collision?

Looking at get_vsie_page() just above this diff context:

	/* Double use of the same address or allocation failure. */
	if (xa_store(&kvm->arch.vsie.addr_to_page, addr >> 9, vsie_page, GFP_KERNE=
L)) {
		put_vsie_page(vsie_page);
		mutex_unlock(&kvm->arch.vsie.mutex);
		return NULL;
	}

xa_store() replaces existing entries unconditionally instead of returning
-EEXIST like radix_tree_insert().

When an existing entry is overwritten, it returns the old entry (a truthy
pointer), triggering the error path but leaving the xarray pointing to the
aborted new page.

>  	mutex_unlock(&kvm->arch.vsie.mutex);
> =20
>  	memset(&vsie_page->scb_s, 0, sizeof(struct kvm_s390_sie_block));
> -	if (vsie_page->gmap_cache.gmap) {
> -		scoped_guard(spinlock, &kvm->arch.gmap->children_lock)
> -			if (vsie_page->gmap_cache.gmap)
> -				release_gmap_shadow(vsie_page);
> -	}
> +	release_gmap_shadow_safe(kvm, vsie_page);
>  	prefix_unmapped(vsie_page);
>  	vsie_page->fault_addr =3D 0;
>  	vsie_page->scb_s.ihcpu =3D 0xffffU;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-vsie-sigpi=
-v1-0-ea9f12066408@linux.ibm.com?part=3D14
