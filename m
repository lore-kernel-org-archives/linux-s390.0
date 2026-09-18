Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE7D3D6CA3;
	Fri, 18 Sep 2026 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744772; cv=none; b=ufsEWJcXQwSACEX0Qzp5cMbMqxnkb4fUcPM2fJIoy/8JYoR/fqb2WwAVoEbzamh00mUWLLoxO6RRfQZRVnrQ8EOhnxrV2g/7mfDkJphWUO6S6mXpVvofs4vGqlBowK3lg13jik59qV9Y4p/WkLUpN8ZxLnfaT31G0wtsSS9URNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744772; c=relaxed/simple;
	bh=vxGrkJqmLngCYGpNexeZHUBxdnnM6uI36+LxIIp/ZHI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iFX8HeSFg/Yz5X6G6WhelgYqEA+w1EAs+1q3duDW9XCXbxcpZGpFMIxC5lvnYmAMBKLkvo/j6CZ798/agm6e3LT7h7rfjvdoUjixX2ZNpqUfwlJRTC4SFBca5bbrHJp7IlDwwCFU06SOvppkavO0NL4LuxGV8B/I1+PkpKeb0I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoeyhHch; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoeyhHch"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29541F000FF;
	Fri, 18 Sep 2026 15:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744770;
	bh=jxvxEwIs46X6V79+sLj8IgiU91LRK68xToVSUhhjBeI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BoeyhHche+84qQlAqeVp3c4khGoERNHh4tMYmmFJq4fAtiJmMGzpitbQo9cCkYhgD
	 pFnjfjuWCJTs+yIt3RDtAqNAiDCoAiHui2OJhRhBYCowSOEV1VWfSBmyym8Ibln6tu
	 UcM6PltGYTanDC5aCccPggEPGIYEyHLCRAdaKbuwdTWoUGDenqM2LT2EOlndlBNw1S
	 j3Ffc9+qpNn2ewHtAC/WFPQkhR2ToJsM03J7abKVwQuDMcJlYtbYMao1c7zddAPVxc
	 vUV2ZXshbPjQRqVQAldDhHN+SKJaRySg1ik9HNWlt7Ra/wMi77iflIcSgoCNrL2rj9
	 NFzmLZ5YoIE7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/21] KVM: s390: vsie: Create helpers to alloc and
 free vsie_pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260918-vsie-sigpi-v7-8-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
 <20260918-vsie-sigpi-v7-8-f39806eaae37@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:19:29 +0000
Message-Id: <20260918151929.B29541F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] kvm: s390: unused parameter 'kvm' in alloc_vsie_page()
--

commit 1e1ca0f3e1c46c0196550769e69e63dd15389aa5
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Create helpers to alloc and free vsie_pages

This commit encapsulates the allocation and freeing of struct vsie_page
into their own methods to allow reuse from multiple code paths.

> diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
> index afc2e56fcabfa..e7005bade7574 100644
> --- a/arch/s390/kvm/s390/vsie.c
> +++ b/arch/s390/kvm/s390/vsie.c

[ ... ]

> +static struct vsie_page *alloc_vsie_page(struct kvm *kvm)
> +{
> +	struct vsie_page *vsie_page;
> +
> +	vsie_page =3D (struct vsie_page *)__get_free_page(GFP_KERNEL_ACCOUNT | =
__GFP_ZERO | GFP_DMA);

[Severity: Low]
Does this new function need the kvm parameter? It appears the kvm
parameter is never used within the body of alloc_vsie_page in=20
arch/s390/kvm/s390/vsie.c.

> +	if (!vsie_page)
> +		return vsie_page;
> +
> +	/* Mark it as invalid until it resides in the tree. */
> +	vsie_page->scb_gpa =3D ULONG_MAX;
> +	return vsie_page;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-vsie-sigpi=
-v7-0-f39806eaae37@linux.ibm.com?part=3D8
