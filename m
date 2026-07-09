Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CFE366DA5;
	Thu,  9 Jul 2026 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610635; cv=none; b=D3gXiFoM54uNj9k0y+kqvBAxISL5AtDIWvwirIaM+eR69RRdrGhkxnrgp68016+ljrJobk5TG4QeDu+/SYO9shiUVStTvn6ekjskRaPo54UEglbXje0hPPGLTkJxvFZnMLM0CZL6TdoKTnNs4aITFXEynKj2tiPKCxre5fk03Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610635; c=relaxed/simple;
	bh=XZzlVyGw75CjnzPF1C8rWFyBKohOMgikqkHtAcDZUDY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LIN+RomwHOlQ2PgCBYskDi9OGjhH5ThEKtwKpoIb4x6d2qXEnbPUZPxjbCRz7U0Gy/L1sDWUQe5ljJ5tc5qrcmWMSQ77zBrhVxphuh5KQKGLfuSRc6oMsv2boBsUur2bE2+9+LsUjiUWQAIEe/B1wTjZWLGjNfmtzoGPoWZ53ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lR6b3GAe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lR6b3GAe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158B61F000E9;
	Thu,  9 Jul 2026 15:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783610634;
	bh=XW7yE19Zbw4E2j+RJi5K640xbsI2LAn0rG+3XcMCsNk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lR6b3GAeTSICoEgJYhJTsquYyXTIGxqL98YXe/kQ5NJkg9ZfSYAlHyaVsLkvIlqhv
	 r01NdiPFRGCcopIE0ypkLjVN8S6IPqLA+6QIQQ+Q2OMbAMfNDVRyZ8F8ROmvcuC6Bn
	 Gew+x72clvB0ODKXrNNde85q/8hc9M271v90JAIQbqORfYIO8dtt5Q4NFOVHmNj3hb
	 KFm5ysjlxhUSFgMWSrz42qMcaNDkMjGlne0zQ0dU66ju7L0Jrik64kDUJ56n72tDUJ
	 HOCMUMBk69+nQKnDK9JaIH4wfatYxfifWuc7+9zwgduYnqsr7+39lMUfID4FlRJFSt
	 eQxDqL2ZN84wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/21] KVM: s390: vsie: Create helpers to alloc and free
 vsie_pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260709-vsie-sigpi-v1-11-ea9f12066408@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
 <20260709-vsie-sigpi-v1-11-ea9f12066408@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:23:53 +0000
Message-Id: <20260709152354.158B61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unused parameter 'kvm' in newly added function `alloc_vsie_page`.
--

--- Patch [11]: [PATCH 11/21] KVM: s390: vsie: Create helpers to alloc and =
free vsie_pages ---
commit c4b88feb6783fb127e24e97af58ad89ffa8ef444
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Create helpers to alloc and free vsie_pages
   =20
This commit extracts the allocation and freeing of vsie_page structures
into dedicated helper functions. This encapsulation allows these operations
to be reused across multiple code paths.

> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 5bdd9385266f0..4090b4019f215 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c

[ ... ]

> +static void free_vsie_page(struct vsie_page *vsie_page)
> +{
> +	free_page((unsigned long)vsie_page);
> +}
> +
> +static struct vsie_page *alloc_vsie_page(struct kvm *kvm)
> +{
> +	struct vsie_page *vsie_page;
> +
> +	vsie_page =3D (struct vsie_page *)__get_free_page(GFP_KERNEL_ACCOUNT | =
__GFP_ZERO | GFP_DMA);

[Severity: Low]
Does this function actually need the kvm parameter? It appears to be comple=
tely
unused inside the function body.

> +	if (!vsie_page)
> +		return vsie_page;
> +
> +	/* Mark it as invalid until it resides in the tree. */
> +	vsie_page->scb_gpa =3D ULONG_MAX;
> +	return vsie_page;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-vsie-sigpi=
-v1-0-ea9f12066408@linux.ibm.com?part=3D11
