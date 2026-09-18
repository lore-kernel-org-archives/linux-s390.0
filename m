Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06A94FDA70;
	Fri, 18 Sep 2026 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745592; cv=none; b=L6XmZ9Ky4ypWOFWswoXmXxLABEeEyI2jaOv35lPoWLgBTO1itLc1Vw+BV5NS/v7xUwq/BcifpGApcJ0VFOhR8pEKSlpxeOPKL2x/ORON5vTqdbrTG+Lhy3XNnSF2AM2vBSBX/k10UjHxBmBbqGfUpET8Ioa9C48BmtTAqRyoVW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745592; c=relaxed/simple;
	bh=vANwA4QjhVKkxawAebvCvqntsivhnVwWmnmCrfkr2BQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V0uN/DGQ/sKv+nmzb50ruzrOC3vffv/jiA4IawYQC26LrbWk3n1uUCJCtOkh8Bh3oOtPu4doqMt/LakTHjM1dfx3jSdqHfX7XUHwiAMmC5Dch0mb0RpXUmO3VVhbbVG0uu/zp0AYRZzkX896u9e903IKl7nSxGTK5TmeYUnqdk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MclAkBPg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MclAkBPg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE441F000FF;
	Fri, 18 Sep 2026 15:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789745591;
	bh=vANwA4QjhVKkxawAebvCvqntsivhnVwWmnmCrfkr2BQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MclAkBPgOk8I3gg7Rz+8GKxYhbCkSAW8qjPx1E+xJB0tpxnmOmk6PDajxVIF19P64
	 /ZAZ4E1hRWhFKVGIzvN3KAKgVUJdk0WLm9wkvjA5ebnMCwZFz2lpz1JaLiGDMKWgYo
	 v/3QqZxUTGwFKvV4yjqrQqToOjJQdb+y6sXEg5//4W8A4UOfvlkD2W+7fK9BPTCT6s
	 okOGFyOZToT5v77/vyw0tozz8QDJrQvfEEjEytb3mzFG824eyMVbIyc4zpMOm9x/VI
	 cEoY97x3LVOCimQFMWigh7ZyALOmO+p9Xm3ncDNjPEVoETJMYmTx9Ya/MFsXNWu/a8
	 YpEFxGAr8RNVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 15/21] KVM: s390: vsie: Add struct vsie_sca with pin
 and unpin methods
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260918-vsie-sigpi-v7-15-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
 <20260918-vsie-sigpi-v7-15-f39806eaae37@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:33:10 +0000
Message-Id: <20260918153310.DDE441F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-vsie-sigpi=
-v7-0-f39806eaae37@linux.ibm.com?part=3D15

