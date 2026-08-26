Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67CF446073;
	Wed, 26 Aug 2026 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757971; cv=none; b=TF8O8IzKx2JE6v5OlPskeoei1MFSt+zSHDtNugRC885xhmDoV3TmGz7gdeadeORwAZMoSmUADMqI+OVCixZIeF8cBx6BdTHydeaI33jE18DzWTBSHgCHPWuwnGDAPgrsBNxLwdH2azjBgoJcQWNtfH+ZKNSP+GEdfM1nhFehg3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757971; c=relaxed/simple;
	bh=/HX7c38HQ42jGrRnUuC/xBGg4w6rGorKpz5trGntotY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oACqNTyxj8WbpwAyJC0hVjzirkasHkJ++GJZAAe/g4YlgRzca4XK/WtIb1IRKMXkgx7eh2IrBlpcVxKf0SIYYPg6qK1lB0zTDXVR5xdT/wKdIVmBZlGX66rJOmaiEBG7z55xB/74vqY3cQr/9NptcQkrlOI90BcOfrQ35xHokK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1jjEaQX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1jjEaQX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17871F000E9;
	Wed, 26 Aug 2026 15:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787757967;
	bh=/HX7c38HQ42jGrRnUuC/xBGg4w6rGorKpz5trGntotY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P1jjEaQXbS57o8qgjoQn2Wgk6nW4lMLVEzNbKLQKEKKikoJ5Kv4HwY5QaabUrpUZQ
	 K0KYIwuLnpGfyc1OxyeZtMPAdgBqSNN8roT8wBEg8TM0BEJh8prftv9Wtv6sL6hfOA
	 H6VMMaQZlNvvDf7+Mjv7Kb1UJKN15jMdmaFXuhZE+aWxWzsEXVEY0SQfKDE14txi0o
	 3ZHMMNr2iooJKTyEGv3efKAD/1FqUg4DBHrO+J22aWfy7kC8mgtBSLqBxR5B9D7rG/
	 eX007f/mJjIWLiJWk/B3AK2HRgTBlf2SpWZAqylbnaUWAhH1cMNIYMFzPspBH9Mzl/
	 qe6bggs0uVyOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/21] KVM: s390: vsie: Add struct vsie_sca with pin
 and unpin methods
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260826-vsie-sigpi-v5-15-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
 <20260826-vsie-sigpi-v5-15-cf471edb46b2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 15:26:06 +0000
Message-Id: <20260826152606.E17871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Introduce the struct vsie_sca to hold the SSCA and required management
> data along with alloc and free methods to use with the struct.
> On this basis we can also add methods {,un}pin_sca() to simplify the
> pinning SCAs in g1.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-vsie-sigpi=
-v5-0-cf471edb46b2@linux.ibm.com?part=3D15

