Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422974746A4;
	Thu, 27 Aug 2026 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846390; cv=none; b=SSOsOQHP83u97NR+GaHAJePIhjYrT+mkFKa5HG4XWEF5uTomemDiFj8wQZstsD30A5Yc7hojZqSs5krtoha+CaIAvlgEJcYsEd04bfgL0yGM8hg7l80b3Z/zj+J6r0fups1ObGZp6AbsndcK/W3Sply0qmDnGs0zqzEV65y9j58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846390; c=relaxed/simple;
	bh=v+lSKPY3hH17+N72MjTsOdL2JX7nf9Pgj5Zy4dRtYH8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AVL5Wj9kz0+Vb3sJfGUgCGLYRGNN7RUetODkVop5Be+8pwQzto7uVxSjVr14rXJPjDWKiogUgc2ryogyEpQzxmCmCyDKX9tebJ5aVXNoMtDmhoaTbI3SUEyxyCAhkLPKWorFc/cdQnWCxnBUAJLcqANv4P5Bpw1coh32PRT4Usw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUVo1nhX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUVo1nhX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A161F000E9;
	Thu, 27 Aug 2026 15:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787846388;
	bh=pOLGW7raTzSm1KXNve1DO/A5asj1fyMHXaOodkkVn6A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MUVo1nhX+/n1XyXe/B6W6y3bNzPh+FwPdsSkHbtv28B4Q5LdKgePf9zcMnr2rwWeC
	 glXy1cO56yY7ekoxxVnEijbOEARy3gm8TI6I5bcXZSyIn0j0bCqYq4shlTuRGZj+7E
	 v9z5+nYYoB5N9TBzkn9sZo8Gcagb21Kjv851uhm2X6PefAyx3JzWe56HHRlMIx1PCb
	 YGntC1x4FuyYAhdGbiZ1CrZf8v9xgjLNMukfY75qb0eqFWfAC9ZXq1EKBt8GG2waaF
	 nwbuguM+jjausrRFFJ182VYlIbyDK77KV/Og8TNjgDTXe7FBsYu+Ycs8McXRH6tBjR
	 JOeEj9sYgIjsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/21] KVM: s390: vsie: Create helpers to alloc and
 free vsie_pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260827-vsie-sigpi-v6-8-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
 <20260827-vsie-sigpi-v6-8-8020bb53be52@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 15:59:47 +0000
Message-Id: <20260827155948.81A161F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unused parameter `kvm` in `alloc_vsie_page`
--

commit 60b604fff3f888da712790a060e194270b3464bb
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Create helpers to alloc and free vsie_pages

This commit encapsulates the allocation and freeing of struct vsie_page
into dedicated helper functions to allow reuse from multiple code paths.

> diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
> index afc2e56fcabfa..e7005bade7574 100644
> --- a/arch/s390/kvm/s390/vsie.c
> +++ b/arch/s390/kvm/s390/vsie.c

[ ... ]

> @@ -1502,6 +1502,24 @@ static void put_vsie_page(struct vsie_page *vsie_p=
age)
>  	clear_bit(VSIE_PAGE_IN_USE, &vsie_page->flags);
>  }
> =20
> +static void free_vsie_page(struct vsie_page *vsie_page)
> +{
> +	free_page((unsigned long)vsie_page);
> +}
> +
> +static struct vsie_page *alloc_vsie_page(struct kvm *kvm)

[Severity: Low]
The parameter kvm is passed to alloc_vsie_page(), but it doesn't appear
to be used anywhere within the function body. The memory allocation only
uses constant GFP flags, and the structure initialization is hardcoded.

Is this kvm parameter necessary, or could it be removed to simplify the
function signature?

> +{
> +	struct vsie_page *vsie_page;
> +
> +	vsie_page =3D (struct vsie_page *)__get_free_page(GFP_KERNEL_ACCOUNT | =
__GFP_ZERO | GFP_DMA);
> +	if (!vsie_page)
> +		return vsie_page;
> +
> +	/* Mark it as invalid until it resides in the tree. */
> +	vsie_page->scb_gpa =3D ULONG_MAX;
> +	return vsie_page;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-vsie-sigpi=
-v6-0-8020bb53be52@linux.ibm.com?part=3D8
