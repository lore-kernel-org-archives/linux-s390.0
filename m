Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7578F350A18
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 08:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423040; cv=none; b=s5Wvy4UazvDajQsiEJ/HOFzLiihZdJnoK6oK5S3tXyyfRXk2f58Y8FDrYQA8XPaHp43Z9C+s4IFxZ4pa4Q63ud5jU2RrgnRroIfTgY+6wnNvgPoTkuJlBrXVV8wzt/WoQSP+Hur7sjXwAd3wox8SjkJg9gjPgKv9ybBawWwXLNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423040; c=relaxed/simple;
	bh=x55yUBxAvhF2wfT0U25NzH0DTtwGAZP3lA+a1Om5uy8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OubhVIIld7SFhPNqcgKP4d157hu2Bn5VBcAmKfvcNz+ywFeDwsG1louBI2lK50tHoT73XxobMATlQq1IHKyiQau83q69I1ZXzSWo/MUMdmWxce4oHeolseS/1tYzcCuOk9cLdibYHs8y5CjrxbVJl0dKxiWMsT0K4AaxpeZOsmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoh8CrgO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoh8CrgO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68891F000E9;
	Thu,  3 Sep 2026 08:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788423039;
	bh=x55yUBxAvhF2wfT0U25NzH0DTtwGAZP3lA+a1Om5uy8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aoh8CrgO8+btUJDoQdLOroKjXoWAAb4eZbIF/YjYIVgP3g5PnJDJa7I+Mn/77kchN
	 9SWxc18gxUtXVwNsORegGWtA6Y4eGm0l357cqKMD/xKhHuReQs+wmYx/4dt3XZL+dg
	 JlCsHBnr3IN7Sq2X1nwCgCrJi+bdY5043SBDZCLvXh57ytr2xmh3a8+7ZDNu3u7dRC
	 qKeIajZlCHXI1y8u8Hr46/edlIkIRhI1A1iBMKy+ae+Jxta0LTjYJeazc6o0IPGEU1
	 8tC1PTZrPChKrQkxBYq6h4Hoi6qfuj+xgZYrFcHTOR2iTabsvmuLmqPLHtwO9RGOkT
	 1zyC/M3dq/m6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/15] powerpc: Remove AT_VECTOR_SIZE_ARCH from UAPI
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260903-at-vector-size-arch-v2-10-5bc32a71e3d8@linutronix.de>
References: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
 <20260903-at-vector-size-arch-v2-10-5bc32a71e3d8@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 08:10:38 +0000
Message-Id: <20260903081038.C68891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> There is nothing userspace can do with this value. In the kernel is
> always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
> userspace and also changes from time to time.
>=20
> Move the symbol to a kernel-internal header.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-at-vector-=
size-arch-v2-0-5bc32a71e3d8@linutronix.de?part=3D10

