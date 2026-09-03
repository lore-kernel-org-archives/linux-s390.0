Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4900044838E
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 08:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423162; cv=none; b=e0iLAXPRD4lZfWheJqpsjRnWMNGj8EWznOW/IfJpXdCTXF5Du+Vmocy8o5xF5aFtNoLIVxi1Mfa/QrT8b68BFbmogdXwZuauuz/qRGUUSlPRXBxMmWYBKoZroixSV0sD8d+rwvexBQTWgebSdlTmx3fJMMLFbNH4+k81HuKoqOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423162; c=relaxed/simple;
	bh=0pHN+Sk0Nf1PcpKal5MF7qWvK4RFtW76Ubvh7BLl3v4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sOrAiDTyjXSvBTB8nCYuZ1IB56bUjFLPhToAt0ghVBtIjeCuCaHSCMqMdRwo8TWn8fB/Im3Gqt3Faizzx4l3+6DCv7lOPiLX1lCtlv0jT4eZqoJLntyXmL3eZEA+vSMbp4d8F4XVyoNjVfmeaZp0D1Mx6b3jd1OnjPqC1jHv/zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAA0IoFG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAA0IoFG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4151F000E9;
	Thu,  3 Sep 2026 08:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788423160;
	bh=0pHN+Sk0Nf1PcpKal5MF7qWvK4RFtW76Ubvh7BLl3v4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JAA0IoFGGpnm8dRcEqlceP7ieaqZIfylMIpgf/LvfyXIH4GJ/IRpW0HrUBN2/1NW2
	 iF54R01NfA4nDGym4saMgnesBwSW6oG0xlSRAu1bE+YFQ9JBS1GNNAANPKbO8nWc2/
	 2FxM24Oj9i3FNSJzTWANov46tcpyiAEUX3ZGX8iB3gBZoumwV66LmAuFQkaYiB6q6f
	 Gqroz5i0pe34QGTq7RbQEI4gcCaFjHBblNSNHmNL+VAtyBwu2gHRJisN70YVPiltM8
	 Kzz1BG4BP2KOIFGtUHKEfvaH74oajanKPlzYoc+pP33C68PZclyjQHWnIZwvb9e+6+
	 NmmHrRFlOsfng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/15] sh: Remove AT_VECTOR_SIZE_ARCH from UAPI
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260903-at-vector-size-arch-v2-13-5bc32a71e3d8@linutronix.de>
References: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
 <20260903-at-vector-size-arch-v2-13-5bc32a71e3d8@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 08:12:40 +0000
Message-Id: <20260903081240.9D4151F000E9@smtp.kernel.org>
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
size-arch-v2-0-5bc32a71e3d8@linutronix.de?part=3D13

