Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F45E3AEF57
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851199; cv=none; b=AQmLNyaRM8byea/ZT0DWBkEXFrmruXtRkQqKVnZ/3Dmw70BvvyGo2nD9yy/KBHBLIyDDffN2ieEWUr6lgQw5IHaFfM+w4FB2aZrBP5n9UX1tO2+k8Fi92ZJa8dakWm1mrRJu6sE5Rm9LG9YW+6hHZNjoepvwSwgAJ6lQNn+oGR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851199; c=relaxed/simple;
	bh=zHPEFn9Hneu2ijJJsLGMWC2WQ2TfGvhO2uvIpe92zlI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G36ySsbWQX8+U6XIafDjI8EE0rBMC0R8XEnon1qVYXT9OiaE2Nsj1/NEyS2BHKv6C/uB5ETPA6Z1piVmHILsvP5Q4P8AZli6pr+rQL7NQHyeA3Ep4hLTN7GfLZYJxlp9+FB81l8d0UIAMg/S+15Tc8lc30NVOgQKF7IY3qs/bYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ib64ql/s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ib64ql/s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF531F00898;
	Thu,  1 Oct 2026 10:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851191;
	bh=zHPEFn9Hneu2ijJJsLGMWC2WQ2TfGvhO2uvIpe92zlI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ib64ql/s0ZBTJZ0nQ3is4XW+WhVwlMBpAxGvMkMB0I0zHFUZAzQMbXNJhvDw9AE0r
	 FiyCj0ykRYPD7ISbzyQucGVtJpqXChq60rXNWixOj73A7QwWXd6eP4k0QhvSsAS0d1
	 WnyppOOSay+aEuvqqt8GbEjaIgTUFeF4WJcQdbU/C4fYupQQLqP3U0T+FfcLOIzZ4l
	 BO7M89nYB3ldPFCBkhSKOavY5D8h908d6l8k0V6cEP7tmFKJFa0OziYfJuGaJ5TbUx
	 Q7VGUviGpNCV+Juqz45PF2kQ/Tw/pXEj0nmVbcN/6sMVslyfHVNtl4bVVeXg4DhDy5
	 KlRQHPlOq55+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/32] s390/cert_store: Convert inline assembly to
 EX_TABLE_INSN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-18-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-18-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:39:51 +0000
Message-Id: <20261001103951.7DF531F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert the diag320 exception table entry to use EX_TABLE_INSN.
> With EX_TABLE_INSN entries always point to the faulting instruction,
> so nopr padding is no longer needed and removed.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D17

