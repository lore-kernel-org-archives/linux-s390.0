Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D01421240;
	Fri,  4 Sep 2026 06:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502516; cv=none; b=OPU1sQYANuK5ARB5lLzxQDYpQPHOwTklB5KbQxlu4HykQumAeuDKV3gIZaINMNizrQyKNPNvCXspamywLqlGa6W47oGPW6rYBJd48vG+kdZdiOpyvHTYfqBfD5yo00ciysvYdWh74XzYBfU1j02aqqtIwA3pNJ/OZgUtjyG5Cv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502516; c=relaxed/simple;
	bh=NGXArIjcG6BgTX27OBxSoaEreY+9yebP4FvsFz/B1nE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b519bDr/i0PNp0Czr3lfCWsmkkG/Fzf+3vXTA3BoUBKkMHdfDsmH8OXrPbzJismKtNqzI4Sh3n69PDwLDbk+SY4ouDkGDLjFqkFMerDBf9MhFaT94MSixKI/IOZCBSv902K/+G2BM2p59kwWrFEOrz8UnpOhAmPPZuzzH0/moNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiDL3XXd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiDL3XXd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC911F00A3E;
	Fri,  4 Sep 2026 06:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788502515;
	bh=NGXArIjcG6BgTX27OBxSoaEreY+9yebP4FvsFz/B1nE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KiDL3XXdymY3AKezwN57nhRp1IUjHHplcTLssCyUqadB7U1FnBvQX8b8g6BVc3Ypl
	 TpMeiRws5yODZHjVWU5ySBy1UVU7fH3KX0v1fI/lWVOP49euuN4Oh6RfzlFnvwrrZa
	 iStpvQ0/9k69SXDc7XC9vUssMzOxTJ3ev86zmn3wPoSAesFUKZh3wGATOqHPRVIrvI
	 gguUm7/Mv4vKDtpiHWglZ1f8JKFToPuhPwH58s4yaOU3J0VgYDdm1A1q4LX2tVbnh1
	 bxbP3pxdcFC4gmlk9FBiD0TV5L1Kf0acfpGYmuVRjVcxQ3ta0ZNk6RXzA1JGWyS3sw
	 KXt3+N/zb48uQ==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 01/11] KVM: s390: Fix dirty marking in
 adapter_indicators_set*()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260904060647.562443-2-imbrenda@linux.ibm.com>
References: <20260904060647.562443-1-imbrenda@linux.ibm.com>
 <20260904060647.562443-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 06:15:14 +0000
Message-Id: <20260904061515.1AC911F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When the indicator and/or summary bits are set in the guest, the
> accessed page was only marked dirty in KVM if the access was performed
> using the slow path; accesses through the new kvm_arch_set_irq_inatomic
> fast inject path would not mark the page as dirty.
>=20
> Fix by adding/moving the missing calls to mark_page_dirty(). Note that
> for the inatomic path set_page_dirty{,_lock}() is not needed as the
> page stays pinned; the unpin path correctly marks it as dirty.
>=20
> Opportunistically reorder the local variables to be in reverse
> Christmas tree order and refactor to use guard().
>=20
> Fixes: 1e95e3bc6b05 ("KVM: s390: Enable adapter_indicators_set to use map=
ped pages")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904060647.5624=
43-1-imbrenda@linux.ibm.com?part=3D1

