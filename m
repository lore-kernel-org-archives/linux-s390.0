Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF4E43E07D
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 08:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423538; cv=none; b=lliericwsJrD42iJoisKIULguw2+ugUHDmUtSsoZiauA5fRt8IpmwwZDhVTaQWBzlKp81ibhuns0B0v2E65xv8CKu9IxY16rYPKnMm4ZhnAtxxboDaj2qaYJ+Za9/XEGFQJCI+ypLWf5SSjJTLvLzr7cQMhZLHl5RTmi4E6lGQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423538; c=relaxed/simple;
	bh=7qnTzURM0Z0W2WVKFCtyc2qRl2XtFwWXoXGgqkebNgQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fdgaodWZvcO3HZgJQck5KJywxtjt0gRlc+S99tepeSCuiOin4wb5Re24fAF6WMRJReR9GrY7+Gz4dHexqMtOx7DdwSoafEfLdoId+fs6fvTUdRGIW7ZcY3CjXGQx7vQwiagju3QEB5RwK1+jubUbilRenaqe8m0YK1ekoePf/Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ofnh9jOA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ofnh9jOA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED711F000E9;
	Thu,  3 Sep 2026 08:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788423536;
	bh=7qnTzURM0Z0W2WVKFCtyc2qRl2XtFwWXoXGgqkebNgQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ofnh9jOAoKDeKGo9YdbvVvyHn04C+wC1hhZ8WHiAih7c0dDJfW3hqIPAqrxfxwNad
	 tie+qP+HUe0XXZX/0mMatUqstP/QuxLFwFB0m1S1S41aW6um+71/UuW19Vp1G7raDe
	 730Vut9PuMJYm5lB5iJiOumoSOVMQx0DN35QpmpRZkk79pW2HZjp0Xn6eXbz3Gj8XX
	 Kka/RM0YSqU7j/d4+31/jC3aDgn3scmA8/g23CPPDqs9g6ShsAIjPQNVbRODN/uSTX
	 aBDJyQVuoecHY7LJ4XYAZNo0QVR0vckvDlxgNmuaw0GzeW0x3Xo6nuVaeiLVj0g12i
	 ZdROrqCiWri/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/15] alpha: remove AT_VECTOR_SIZE_ARCH from UAPI
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260903-at-vector-size-arch-v2-14-5bc32a71e3d8@linutronix.de>
References: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
 <20260903-at-vector-size-arch-v2-14-5bc32a71e3d8@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 08:18:55 +0000
Message-Id: <20260903081856.3ED711F000E9@smtp.kernel.org>
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
size-arch-v2-0-5bc32a71e3d8@linutronix.de?part=3D14

