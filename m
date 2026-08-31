Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28374366042;
	Mon, 31 Aug 2026 20:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207020; cv=none; b=m0SAtFAVelbwW9TQFm/kWfKR5OG5ShDT3JOtvbll45clQm+jp17Gxp+nmG1sg5oZoIIigtt/QRE+99fo5B0cExaYCIR447QD1qxoiqKUzemiKyLKJrpKz5O7bbf4TK6xFht6g+a0UbGFW2p1UEjPD5q/+kOia+vHYepXicwCuJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207020; c=relaxed/simple;
	bh=LfIubIv1Hy2idY4NxDbT5P2KIR8nKC4DT7aBqgjdv2o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gK+zF4501tZHsUdoCW88yWQmhMNcK3MGgvB8w5oxrgT3gdxTSi7mtcwi6WDAvnXze4c1qVC+Lb1RZnY7L4yYUYCP1EUEAB8rfLnDd02KJ9+h4uGq4VBN0JDs7RULCsExQnJr02yDnYcBUQYf9cnxUO3Br9WXdR0c/vm5q3kpqRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgvormQk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgvormQk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784051F000E9;
	Mon, 31 Aug 2026 20:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788207018;
	bh=LfIubIv1Hy2idY4NxDbT5P2KIR8nKC4DT7aBqgjdv2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fgvormQkNZc2xEEhOQuS9tobeHhSMMJRPSrYgNmQA+210+8jPbTlzt4L3YO1nL5xh
	 2gMUTLSu+1u9qzyMGUb2II2evh93+lm4wDKCw7qG7POwKRrE5jd41z38OJshIWxGz8
	 8S8kCto+TVldhcfxhxO7Vy6RR4iFGeDJLhgvXOOIMo5kRHVQbi2jghAXor9NVRLA9U
	 WkFHiocmb4K26X2HbeqOo9Fa2oqq7/OYHqnZPca4LpMvGLx6QPrMyblEMrWO/eehas
	 5zGoPIdPtKRBsHfa4fHqjWONwNrYSPdCe05NLS4P/664HbMP2igEidMId/G9DCBex0
	 0GRKsuLG4RIOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/4] s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap
 size in vfio_ap_mdev_cfg_add()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260831171443.222225-5-akrowiak@linux.ibm.com>
References: <20260831171443.222225-1-akrowiak@linux.ibm.com>
 <20260831171443.222225-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 20:10:18 +0000
Message-Id: <20260831201018.784051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Domain and control domain bitmaps are sized by the AP_DOMAINS constant, n=
ot
> AP_DEVICES. The two constants are both 256 today so there is no functional
> impact, but using the wrong constant is inconsistent with every operation
> on aqm/adm bitmaps.
>=20
> Use AP_DOMAINS to keep the code consistent and correct in case
> the two constants ever diverge.
>=20
> Note:
> This patch was submitted in response to a sashiko review comment pointing
> out there are other functions besides vfio_ap_mdev_cfg_add(), so there are
> fixes included here for those also. The subject line was kept the same
> since this is in v2 of this patch.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831171443.2222=
25-1-akrowiak@linux.ibm.com?part=3D4

