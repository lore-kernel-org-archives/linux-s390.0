Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792535734;
	b=iK5NhVzMw4KVE5hJ4CK4K99CSoYzpYATGTl9HZ8L9y0ttxIKIisd0Sy7yT4Ct95gDNTx
	 VxS+euq9XD/6FJkq3O3Pkk9/XnHoq6TCQ0GEbwCrlusXezkop4OXMiqML2YJUSfLfbZ79
	 GkBRg2phMUVQrMpGaWBYt6JtW0RMdrxPXfArhFG9/EJ3Tcakf7x2eDIcy2ymrifNR/u05
	 uRkkpc+7U8RMDYnRVXYezZFMGIsp6Bn1R/emGINKpdUfSROtArQ8/EY6IT6tt7l2PeEoo
	 YO4uWReTYS9zQi/NqdJ2EqWQC88dn4hRyqw0kWz1Ba+kamf8fX1QKiZuIZGdcgjuGWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792535734;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=i9w70mPVyl3Zld96r4Sfu5VBKmc8Nss3lcacNOngNXQ=;
	b=XuwQJ/FtAm0Xap4hu9DsukXn8ZKmpJLll7AIOSg9/gUEYfQjFvyuoGTYi3hZk6lK/T8j
	 6+ZYgTsw7J4nZNNvstH6rLWyboOLTjBnvj3l+Rylyi5cSo9VDrK/6ngDtrUY5+0fdkCrv
	 kw42ih+8UOCpaEEGEw7xsct2gngI+QAQRlBl/YhaK3wUD4KaskHv/uo2YUQd+SoLFGV7U
	 ie9KqM22OeHeypeEjf389rjIOqFwObiI52+cPNHbBpe0dmiGoUeLv4FIFNMutxLVAYbvo
	 GlkyBcwL0WjhxS2grw0TYPxULKYEBux9KgdfSb3Zu4NSv8MiaWN53Jepd9sqhsfklaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BB2/JT1E";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBEF606A319
	for <linux-s390@vger.kernel.org>; Tue, 20 Oct 2026 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BB2/JT1E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC571F000C9;
	Tue, 20 Oct 2026 22:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792535733;
	bh=i9w70mPVyl3Zld96r4Sfu5VBKmc8Nss3lcacNOngNXQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BB2/JT1Er02dwFPwo2KGO2qJIjdHLhxW7SwBPZDP10rqRdYwkSJLQHd7ezxpeTiwx
	 jaL61wFlOTnhi14CxaqWOrg47dR8Vfr3Rr96ClmxSaCZS7vR6PiFZxfU234VB4HRkh
	 J271kf+UiL9JDsGTQ0fYCF38h9kWtZQKQgcx4v48JctSMtg1HedHFox/maO5Y6tUkY
	 wCnQwtI3jRCd4jzINOGPhKbVYHrwPICOoBmnLBExnsAa3nIz3CwiL+bBlSsIPq/yla
	 ldkE33OJvjev+jw2DALG43cCTb/s3nm0cD5u6lG9gcpPtdBkh2/CPdQKpUetV92kBo
	 jMXLzKjLcq8Kw==
Message-ID: <sashiko-outbox-179546@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/5] s390/pci: Hold fmb_lock when enabling or
 disabling PCI devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261020212427.2561-2-oelghoul@linux.ibm.com>
References: <20261020212427.2561-1-oelghoul@linux.ibm.com>
 <20261020212427.2561-2-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 22:35:32 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Ensure that fmb_lock is held by pcibios_enable_device() and
> pcibios_disable_device() when calling zpci_fmb_enable_device() or
> zpci_fmb_disable_device(), respectively. Additionally, assert that the
> fmb_lock is held within the latter two functions to prevent future race
> conditions regarding new callers.
>=20
> Fixes: af0a8a8453f7 ("s390/pci: implement pcibios_add_device")
> Fixes: 944239c59e93 ("s390/pci: implement pcibios_release_device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020212427.2561=
-1-oelghoul@linux.ibm.com?part=3D1

