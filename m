Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC25243713C
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785583320; cv=none; b=nVXBbhMgM4KViksdXko+0e8xpWJP3LbwZ2BoRsnfkPU7mOcGQyZiDaNukHLlApHJxyRqvoAR+u2SUJin8Pt8EtyikTu42VmsJWET0Vpa5Vw/MaNXy/51Nclo7gvFsGUoHvA6KNsEC62aM3dSoQQH2oInzhgmbp+BqKexGciO0hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785583320; c=relaxed/simple;
	bh=jsag86lF+Y7vtXFwSkwmBjdEGePsQRPYCDom9kmckD8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eW6cbbZ2bcPfnqbF7PQyDLRVbgBQ60YdLKrSuY0GHLfRer2GlvCj5z6uAf+MqaB3Q3C5lRn1r0q6Ba/6gHp4qyxnxIIEF+ijbd6bWCqgRlmAwkB6SVQwlRfzssEWHS3z5a+ALOQPT9PX3AnlRLsa8T9PO3RV2acmyE8rk/ssf84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xnep0hTs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xnep0hTs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CAA1F00ACA;
	Sat,  1 Aug 2026 11:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785583319;
	bh=jsag86lF+Y7vtXFwSkwmBjdEGePsQRPYCDom9kmckD8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xnep0hTsOIZifsrxdFiUZhs8MejkZReZ3jNnPkF3V2FWMvjNcxBldlbdQp15irVt3
	 9Pwa3PlrRklyIfKLx9R+PbMROhqeKtkMDfMMQIhKONoJb+cK5ZE/YoaPIvnpT4WvLi
	 Qc6bxH1yZ16ExZ+G4BTiPNOTuAtaQdE+N7s2vWG0hVN5Z+DupFQsxqNUPBSAkGJCfP
	 9zr7McW1urMB8YGWMMlG90oJ+VEP+fVzM52S3Ij5eEZpmGUmA46y9D9v5ofuSSKRdD
	 VosXlSX7IswtCJy1nws/iFWmCvXwbaXvIB0/NmmJhfU7/O0+Mc0q6+7iunjYHcD5SX
	 Sjp7c6ffY72Vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/18] s390/dasd: Use GFP_KERNEL in
 dasd_alloc_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260801111008.3391031-6-sth@linux.ibm.com>
References: <20260801111008.3391031-1-sth@linux.ibm.com>
 <20260801111008.3391031-6-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 11:21:58 +0000
Message-Id: <20260801112159.45CAA1F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> dasd_alloc_device() runs in process context (device set_online), so its
> pool allocations do not need GFP_ATOMIC. Use GFP_KERNEL instead, which is
> more reliable, especially for the larger DMA allocations that later ESE
> full-track work adds here.
>=20
> No functional change intended.
>=20
> Reviewed-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801111008.3391=
031-1-sth@linux.ibm.com?part=3D5

