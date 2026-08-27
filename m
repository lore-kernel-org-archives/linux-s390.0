Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BBA3B3899;
	Thu, 27 Aug 2026 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787847070; cv=none; b=m5YZ84YdlNjgwNo1AQGVyx4SA0CmBYO38ucjlGpNbB8Ir8+b/sO+ml6POLiYsDhYsM0OzRt9Ly32gqlhPQDzj3lXfLuRN5/MFMzW7A+Mwwlhb6B9a2BZU0CqvK7E71AnSImqSul4r/VMl3kuSv4fLmewJUhhOm3AgOHHLWxYBEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787847070; c=relaxed/simple;
	bh=GkTUbWQEc7pU1Z6tR3CNxkAkOhwTb4F0W9KyrneciWE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QohVTjvVIzgIP99cMgWBOkXS2NE6MANsexxpTqigSbCNRHl7yT2tT1sxtNM3ESuCaeENhcbvFwozJ/XPraKs5P7HdAiO2MJr1bbPivcAlvkbDOwupdYkq8JCm7SE0bSlCA0gwIAF84o/lfi1TcC4brI52PZUu85pXNi+kdITn30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJN0rOKU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJN0rOKU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1881F00A3A;
	Thu, 27 Aug 2026 16:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787847067;
	bh=GkTUbWQEc7pU1Z6tR3CNxkAkOhwTb4F0W9KyrneciWE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DJN0rOKUUhoYo7dost6Ccr4aBx/p7lNw7yly5UJQltQIV2QNhm181c2GhmYTcvh9u
	 aHv9EQUb9Lb0uuX2ndDXJ9yDl544BX0UYrr1M2gYKoijcZQdGKq+D4L82JHhZvqh6Z
	 aY2Tbt1HGYv7bTfqvFxuKRy8b88ddsHL1q18X98qY7L9Pj8oBw6DfMJwoGcMw2YEKt
	 gLvPQX5xY9E/4ADS1JH9sePsjZUz1aNvJ6EHc7F9KvEs99HzbgB2TFJB+hnUkmEJ4g
	 kRm7FFbBaLZuZk9lRmRrnpaWSEmrP2FAnZgnJWZH0Pbh90Q1UJv2WylZ58oI7WN4uq
	 Xy5wrxgczvrVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/21] KVM: s390: vsie: Move SCAO validation into a
 function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260827-vsie-sigpi-v6-2-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
 <20260827-vsie-sigpi-v6-2-8020bb53be52@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 16:11:06 +0000
Message-Id: <20260827161106.EB1881F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Improve readability as well as allow re-use in coming patches.
>=20
> In particular add the logic to be able to check the validity of BSCA and
> ESCA origin addresses.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-vsie-sigpi=
-v6-0-8020bb53be52@linux.ibm.com?part=3D2

