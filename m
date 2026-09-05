Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F72313527
	for <linux-s390@vger.kernel.org>; Sat,  5 Sep 2026 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788600046; cv=none; b=mwAunjR/MjLZ8n3IhovAkZ4fU4WqIsMegEI3ZnS5L0WpJUxHuY+ERkZbYf5HgntPLcRXT9ryKADK7RWtUL7GcRte2cfwAfXJU/ns3qRi427K9tBARLSC5bns5hZLBy7M2Y5TvVrC4tp7ja9+KZ2fdECQw6Jod3nYWUhXLn2IKgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788600046; c=relaxed/simple;
	bh=5wmkaNV9q5CZCoNBw450CoJsMlgzZLhVXlYG10H2+hw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nx8xbMcPiyqQAp6/J4rvCGcESPZquJkFIuB6CRPAB/v6p3ln4jbmW7rYy+S1TE66wUQN99R7Jc5f0fOSNwmCiCOeRHXrmjswtW28t/F0rev2263iXzE8cqf+7TQYQ/eNgnQ3auHugGwBcRjwHxu6oc6At7PlQHx9mCUa6qrHejk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiinQ/Fk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiinQ/Fk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CF41F00A3D;
	Sat,  5 Sep 2026 09:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788600045;
	bh=5wmkaNV9q5CZCoNBw450CoJsMlgzZLhVXlYG10H2+hw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WiinQ/FkYEBo2IkrgdIFdQ5SGmo077y/+6r7ZSoJNslMU/kLyCNk4xqtL7dpEqngW
	 0qEMFkCI0DjGMiMAyV66TMQWJhs2eV/cISar89Bz2Ri5bfd9D9vSJaGtEj42Uq8vS+
	 W++DC23bmx/dB8WKUH8IKnrTx0OIai6i+3s0xmecoSuyQw1soOKMZG8l5DdUoKk9ZJ
	 TatqNWHZM/qomauEPEdC0qs2tEfpYxHevLjLtas9E398OB9bHvK5b2pN57huwp3hVY
	 UtE6qEknFHp4RP4CkL9jvMaTrbyzu9zfWaJqTcgAAgPGlIpfzoNMsY/dbOsvIjIEqF
	 nGTiRwE/KE6Wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] docs: s390: pci: Fix the sriov_numvfs attribute name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260905091627.40946-1-kmehltretter@gmail.com>
References: <20260905091627.40946-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 09:20:44 +0000
Message-Id: <20260905092044.D0CF41F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The attribute is sriov_numvfs (drivers/s390/pci/pci_sysfs.c); the
> document names it sriov_numvf, which does not exist.
>=20
> Use sriov_numvfs.
>=20
> Fixes: de267a7c71ba ("s390/pci: Documentation for zPCI")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905091627.4094=
6-1-kmehltretter@gmail.com?part=3D1

