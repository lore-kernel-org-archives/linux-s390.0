Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A06E515894
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907810; cv=none; b=r2glqpRgOXqR9Y7X3E6wsifkSXonTaxoA+/pZoX2slmTY1CiN8aw2vL+AlCHuLnXhEif/IuqsbQ5h73wR77iSzuFpbD5HXJyD598LM9APqyWA7f+buegFTzDlRahhlV1DI571OB945ygjgGm65C4SUlnILQ3uK90f0cNEnCPlN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907810; c=relaxed/simple;
	bh=JLgBU/6OFeKhBy/pJpVU8XAc3IkVLDKL2xysqYUJxKo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=K7q8HyK1ECStjPdN/FW7T3xsyErGjzVps5P+LOgNpLm0WXwlwvD5mY+BnpnNlYgd09Ex5vEMw0qen+74/En2VaX1JvNQn3q3tFBEh9xW0qCWyn2ok3+hQDX3jiDbuVOwnrEuUFUhCk2M3jT89dc3oOwrMGIGzVshh7M3fbXBTXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gp0NdPoS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gp0NdPoS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3224C1F000FF;
	Tue, 13 Oct 2026 16:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791907807;
	bh=JLgBU/6OFeKhBy/pJpVU8XAc3IkVLDKL2xysqYUJxKo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gp0NdPoSnkC6qDKHswYpVAgQDjzLMo773yOjEyrmJZyiUL/XA6hbbF3wXXxucAemc
	 oWiZQus4EHbJihw/xxyh57xXsdJ9e4idM2w1jtGJQ8WveCtvqyRPrrUYiTGPQnqZjL
	 0v70xudxFjO1nOW2j8iy0S4gpn2QYd40yfpnEpwONPw/HwW1D8tbVWGiZiyb1aymuC
	 pDWxy1NdzkqEhZrwxwSSc0D4mnC/dwwjES474vl9jYbe3HpAj9a0J85Eu1oELJ9o8d
	 QGKwa3NOaB1q8iCD2n4OgHvxNwHRkwPdibZ6fq1M/ATlos00htxSovhwG6OUz3UTXn
	 qJJVehqkLla4w==
Message-ID: <sashiko-outbox-170093@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 13/15] s390/vfio-ap: Callback to get the size of data
 to be migrated during guest migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013153219.3534306-14-akrowiak@linux.ibm.com>
References: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
 <20261013153219.3534306-14-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:10:06 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Callback to get the estimated data length of the data that will be requir=
ed
> to complete reading of the vfio device's internal state. It's mandatory f=
or
> VFIO_DEVICE_FEATURE_MIGRATION migration support.
>=20
> The function pointer for this callback is specified via the
> 'migration_get_data_size' field of the 'vfio_migration_ops' structure
> which is stored with the VFIO device when the 'vfio_device'
> structure representing the mediated device is initialized.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013153219.3534=
306-1-akrowiak@linux.ibm.com?part=3D13

