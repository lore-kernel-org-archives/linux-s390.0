Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933EC24886E;
	Fri,  4 Sep 2026 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520415; cv=none; b=nrYyxgIPIFAfHbB8dIN9C5UefbuVr+aqYzCjyWJ9VyVe+hQ6XzJfNqoUg/62zFw/6JA6SpR2y6knvJULeSTkz20OKaWR16sL4H5Emnt21LFtMMQPnw5sIYjGYhQPdYwH/NxdvxhJBFQ982IOSjjkxAPtoWRucSWx9ECxt+184PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520415; c=relaxed/simple;
	bh=eXIStnHC7na2DqRA8H91kfYMTTmO7v3IjJXALVu4tbY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ryi9GYZ6ld3tvASGqnHnESw6wR2yCJ4uMvNqGEc/K53V4q6xcQs4d7TevVk8r67ecbLqtHMM6BdAu93oVYaeFwj22Rrnq8jj4fa/To6x+B4F9V5Z7fLNU1Nsf64ILz51ANPz8rqrfSvoyHexnZ8cfS7Kp+JAcfMDGBMQAfKh+eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuQIZkfX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuQIZkfX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EBC1F00A3D;
	Fri,  4 Sep 2026 11:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788520414;
	bh=oC3JhfNXqmbr7pWk1waSdlAOzIRwht3YQZAve2wPy2M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OuQIZkfXLcmO6qCcBiyaOYr2UCwnNzfUJJQ5gluIeMk5tZbI//O2gRXPm22LUh6t8
	 kt2pCmiCxd2k77fc7FEtNByHIhRc0Yj0BEhqPEIOuPFYrZWIbd6ywzHuXcllqcgPEa
	 t5jtk6XD0Lujxu88uzDVv6aQqAobDkZo45KWv52nfSp7Nfl0Ikqul42PG/UPR3WMyc
	 iJn58g93TB5SCs/Jvdk+D5sPAR80wwyBGL/c3wOUM5dCRYjgajMOvZC16EfBs6Mifk
	 fe8TeNPXu+SP6cFQrsgk+xgZojP6YRE2pY640Uiv3pQmg/0b/tgAObCyiZcebsPYDV
	 nKdZA5//00ssA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/12] arm64/mm: Export set_direct_map_*_noflush()
 APIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: conor+dt@kernel.org, linux-s390@vger.kernel.org, devicetree@vger.kernel.org, linux-trace-kernel@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, robh@kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260904-tegra-vpr-v6-4-79042cfa8de5@nvidia.com>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
 <20260904-tegra-vpr-v6-4-79042cfa8de5@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 11:13:33 +0000
Message-Id: <20260904111333.66EBC1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Exporting `set_direct_map_*_noflush` APIs without exporting `can_s=
et_direct_map` forces loadable modules to silently fail to protect memory o=
n ARM64, breaking security guarantees.
--

commit 6a5f6422ed6de263b9c669919e175cc7d1ac6c09
Author: Thierry Reding <treding@nvidia.com>

arm64/mm: Export set_direct_map_*_noflush() APIs

Drivers that use this may want to be built as a module, so export them.

> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 132938b32eb16..9253c529f8aa5 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -262,6 +262,7 @@ int set_direct_map_invalid_noflush(struct page *page,=
 unsigned int numpages)
>  	return update_range_prot((unsigned long)page_address(page),
>  				 PAGE_SIZE * numpages, set_mask, clear_mask);
>  }
> +EXPORT_SYMBOL(set_direct_map_invalid_noflush);

[Severity: High]
Are loadable modules going to silently fail to protect memory when using th=
is
exported API?

If the kernel boots with a configuration where can_set_direct_map() is false
(e.g., rodata_full and debug_pagealloc are disabled),=20
set_direct_map_invalid_noflush() returns 0 without modifying the page table=
s:

arch/arm64/mm/pageattr.c:set_direct_map_invalid_noflush() {
	...
	if (!can_set_direct_map())
		return 0;
	...
}

Because can_set_direct_map() is not exported, a module cannot check this
capability itself. The module will receive 0 (success) and mistakenly assume
the memory was successfully isolated.

For security features, this means content-protected memory remains accessib=
le
in the kernel's linear mapping. This can break DRM guarantees by allowing t=
he
CPU to read protected memory, or cause a kernel panic if the hardware enfor=
ces
protection but the CPU speculatively accesses the region via stale linear m=
ap
PTEs.

> =20
>  int set_direct_map_default_noflush(struct page *page, unsigned int numpa=
ges)
>  {
> @@ -274,6 +275,7 @@ int set_direct_map_default_noflush(struct page *page,=
 unsigned int numpages)
>  	return update_range_prot((unsigned long)page_address(page),
>  				 PAGE_SIZE * numpages, set_mask, clear_mask);
>  }
> +EXPORT_SYMBOL(set_direct_map_default_noflush);

[Severity: High]
Does this apply the same silent failure logic when a module attempts to
restore the mapping?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-tegra-vpr-=
v6-0-79042cfa8de5@nvidia.com?part=3D4
