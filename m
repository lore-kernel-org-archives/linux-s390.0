Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5F9423E92
	for <linux-s390@vger.kernel.org>; Fri,  9 Oct 2026 06:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791527300; cv=none; b=NhB+sVvRnyvlMCIM3J/HvSfXGFGKJbo/i3qhGpD4tqN+cHZeV8tr/JrJcBPoRgHBBWuZkfF4/auiqGq0zqw3h/qz4UvsmM7z3ZORcwXJxIC9e7rmYzE+7z7LEG/PkYz5XEldHVLYdx9sh9+dnt5sPNUVWamXdBKSfUqf8XF7Hw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791527300; c=relaxed/simple;
	bh=g7dRlUwv+x+5OitsIXlEC1/bdlUR/fSmvNIiM4K692c=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=XSeQFgt4Wsh2uBtWIcGa9TinJ1w3oJfMMhpg5xSw0Ei4oRexgWy/ugGsf4GFzm2u4LCdpdTBHtm11XD7afTMFiHMoU4iuYFSgCGnxmS320RSdi84BU4nL7Ndxpj9ybqUZSltF1QBINNNmLp7uCsn78KQDwjx/uZIUgwvgzVYg3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ss9pnx29; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ss9pnx29"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7561F000FF;
	Fri,  9 Oct 2026 06:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791527299;
	bh=g7dRlUwv+x+5OitsIXlEC1/bdlUR/fSmvNIiM4K692c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ss9pnx29+R2kzEuoG52hcDk9FVSkQm7UWPYXyDdoRsAvdrcUZik0WHdHQQ9MWoFTG
	 yXmRWqgvfm+eDxlMzQwBelPcHfqHod/g0g8AfqzUNaReTrVspcUeeNhlpLasCcR0GE
	 3gifibqSWNJVf3Wa24ro0HWf+KJ3pLA3larsaZrw9CvrB+WmACrlTjs0cFw2jHuDYe
	 g8YmzMDdnqt8OOcaZhNvEjLkUctIwdL3HHlc8ya0OUyFwQGQp63x8ayVwLi/orAqiF
	 O5SfBfjLXTNU6+Cr+xhBwCQuWCUOl1Ar5bXnwJt/8ibM7Wtf71JcBVMLWcyDpD2RoQ
	 peF48+Gv+8pRQ==
Message-ID: <sashiko-outbox-164936@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/8] s390/pci: Fix double-free and NULL deref in zpci
 MSI domain cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tobias Schumacher" <ts@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261009-s390_irq_domain_fixes-v3-1-ced19028da3c@linux.ibm.com>
References: <20261009-s390_irq_domain_fixes-v3-0-ced19028da3c@linux.ibm.com>
 <20261009-s390_irq_domain_fixes-v3-1-ced19028da3c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 06:28:18 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> zpci_remove_parent_msi_domain() dereferences zbus->msi_parent_domain
> unconditionally and does not clear it afterwards.
>=20
> zpci_bus_create_pci_bus() removes the domain when pci_create_root_bus()
> fails, then zpci_bus_release() removes it again on the last kref_put(),
> reading ->fwnode from the freed irq_domain and freeing it twice.
>=20
> If zpci_alloc_domain() or zpci_create_parent_msi_domain() fails, no domain
> is created at all; zbus is kzalloc'd, so the same release path dereferenc=
es
> NULL.
>=20
> Return early when there is no domain, and clear the pointer after removing
> one.
>=20
> Fixes: f770950a4709 ("s390/pci: Migrate s390 IRQ logic to IRQ domain API")
> Cc: stable@vger.kernel.org
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-s390_irq_d=
omain_fixes-v3-0-ced19028da3c@linux.ibm.com?part=3D1

