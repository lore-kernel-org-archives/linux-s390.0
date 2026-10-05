Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE97471D1C
	for <linux-s390@vger.kernel.org>; Mon,  5 Oct 2026 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202367; cv=none; b=U17eaq75ZfGGbUpk/B2gyVM2Mts82qC7kzXEg/X3fhypfPfm/MsoM1Wli2u/dN/bd4fl92ThcVAzVUgRUr7QjrP8kJQ5eC3wVPYhPtwsAHsEviuS9jpDdR8KvI3S2pgu/nJW26a9Sugl2POBFDn+vmLm5VYhhtAt7UpG9fLheY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202367; c=relaxed/simple;
	bh=PAM9SYK+Xc9hEPXoqcaE1hQPIzgUB+yMQddlaNvK0vg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uaL0LXlF4y3cD1NtAyClDcFN7+FvFCo3nDJMDQVefU48LkNprYtUfNmzSbcTUYizK18sWjEkGrBTF/cxXPfphT4EGEKsYaA546+yErgWxdIE/fIUFcvAmPygI1CvwWZtUvwoRBgaobW/ZI7cyugN+xBL/OnZNTgc9ESjOdrb3kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNWjlEJo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNWjlEJo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1CD1F000FF;
	Mon,  5 Oct 2026 12:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791202366;
	bh=PAM9SYK+Xc9hEPXoqcaE1hQPIzgUB+yMQddlaNvK0vg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FNWjlEJoBg/O7AzbB3TBOm9BeU1y7pxfzGrpJ9M85x4t9dKIYFPo1yKan1dxoUYhh
	 90HaM3JonXXeTiJo/KnSo67+DVf6jNCiqJpWy0JW5y80UJywLbdx25KApCZE86aKAz
	 EAoDfgHs+sLPefiwKbcQlDQd8pqNH/u0IW70b96Cah4VVDjKUYH1UstysRXCsGXRTE
	 9kc1OLGGh5sTvKo3K9lhu+R5U2/nwA/fL2rQMOCdYNfA3cM3xKBCxHkG4WffU5QB9y
	 OXzpaGYsCfW3vo+Xf8gZDSLtKkFddVGgB8sxU2rOKF7+eT9byLXbiLuuw7Vduaq8rc
	 J4ef2XNtI8fzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/7] s390/pci: Fix double-free and NULL deref in zpci
 MSI domain cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tobias Schumacher" <ts@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261005-s390_irq_domain_fixes-v2-1-d45b824874c0@linux.ibm.com>
References: <20261005-s390_irq_domain_fixes-v2-0-d45b824874c0@linux.ibm.com>
 <20261005-s390_irq_domain_fixes-v2-1-d45b824874c0@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 12:12:45 +0000
Message-Id: <20261005121245.BA1CD1F000FF@smtp.kernel.org>
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
> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-s390_irq_d=
omain_fixes-v2-0-d45b824874c0@linux.ibm.com?part=3D1

