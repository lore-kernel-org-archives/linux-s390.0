Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457892;
	b=ADv6mw2s312HGmpxMwX/tMhF05xg2BA94CmgSljbRZT7wv3rz4sv0pj4qRJQByvc4Vld
	 5pKWNaY9KBhqjz+/fBzT96T+eAuNSu0a/F0uoFpY6hbtdfT7AkPxbsueq/Odgefj18aj3
	 1rzSjI6EenqcvRI+F/SjuvC8joB/G5ZHTreWTK8/HxCTLuoy0ZB8xiMQ3Sfcl3BWSlyRD
	 cxV99Ue26HEx8Nm/451qImUhxViu1jQpYwJIy71Ba9BQwjVPWWo8u2mDVg+ZHcEjAkZQr
	 WuWw11ljUmQSUyDFn90ZeS8bZ5yteAv//tYg78YRvz0acwJLlOjPB0EUupxZas/KxSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457892;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cLXx74nCZd0OCDxr0e6YQ9FSeFgHNMVZbOb67SHCa9Y=;
	b=yYlrw32QH66jjry9Jx7Jwlh3WGE3iHluVXtKoP5rdom4ft/UmxCdfWJxp57Rt65dEa1o
	 FikUj8ucZ27IFHKMWdEl4jWIfUq26DMYxUxnEHuwcmRM+90tySmfVxlzW45geOGSal/m6
	 ON12zZBqkfOGteqUnS/+pfGpoZhu6efSvBmVNKUXWmq44P4INobSWfTAIC+PQ7Wr5nAw3
	 E/+mJXatXiPGaxBIzy8kHXhB5hCu8k5plTYfUePS04ZcT2cpc8yJe8hQSqxwNzmmgteSe
	 Liz/DfD/L5qltH9WB9PCgT4YRy2yCp7MQrLebDFupkow7UQc9Yb/z6FAXz3H5o18t0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YEbgFrCh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64416606A880;
	Thu, 12 Nov 2026 04:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YEbgFrCh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFD21F00A06;
	Thu, 12 Nov 2026 04:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794457892;
	bh=cLXx74nCZd0OCDxr0e6YQ9FSeFgHNMVZbOb67SHCa9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YEbgFrChi7avMPUlafBc1/+y17L62SOrHklQ5u2AmWyKYUVqhCi5W2IRWlYWJpQSY
	 czw9OiRYvWG4kz01lWyNC0BtbPSKlazW0FBosD5iHO9VjR//n8oPXJfri60UA26ifL
	 rMkwQ5/aTOMw3G1yIBMns2xBV38LfGvg1xYZGfp0HjQmN29XevzHmeUEomnJnAOE9X
	 tJJs5vA8vRJFmSCO9Qi8kYy1A0jT0swfD457rDkCjSVbNoiWs3py1zv9X/idlf1LLp
	 5EbnK/AQAP9JJtUPtG0shZUEGCdIMSjvJ7iYDyY/T5G72qV0FrTsxR4IIzz56xjKb6
	 3NHAD3dQ+jaaQ==
Message-ID: <sashiko-outbox-210352@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/13] KEYS: trusted: Update static calls before init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112040242.247168-7-jarkko@kernel.org>
References: <20261112040242.247168-1-jarkko@kernel.org>
 <20261112040242.247168-7-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 04:31:31 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Given that the static calls are updated only after ->init() returns, an
> added trusted key can race with the callback initializations. This can
> ultimately lead into null dereference as static_call() is used unchecked.
>=20
> Address the bug by updating the static calls before invoking ->init(), and
> roll back on failure.
>=20
> Cc: stable@vger.kernel.org # v5.15+
> Fixes: 31de287345f4 ("KEYS: trusted: Rollback init_trusted() consistently=
")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112040242.2471=
68-1-jarkko@kernel.org?part=3D6

