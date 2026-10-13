Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BC74137A2
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899548; cv=none; b=XSoHaVw03sxGnnl8IQDnvX/J8rdr3tOt7uxwFsQ0Tq9jIDOLaEFZigYiQDhSenUEoPUI2pBPnqEcYVTB9stYZxPWLAMRMEgvdqv0Zjxsl/XhjrqrLE/ARqGt8Sug0CMtYVZ0LWC3Xl0M9l0tVcAvgV07mi0I/p6+sg7NwzsuSQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899548; c=relaxed/simple;
	bh=GWwT88vhLTWf+Fr+6SqQovNSFiDWc6wPZGAbSkeK27k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=uJFtuL/YVHZODzyxLscb/tU/JEIZWQDmeOvsUB9KDAUCRCoyrDINbVq6lWPBrZkhGzXRQY9SgODhURb0peRF4DDZFXgTtI7Z2o6Irwd6vx+qQwpabuh6iVFI/moHWc3eME4rjBLkuXD8inaKCkqMN93o2Ra0HAC3d6aym20BmPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+ZzPuqi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+ZzPuqi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E481F00898;
	Tue, 13 Oct 2026 13:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791899547;
	bh=R0UQDGXJIXag5bMFZnS2Hhy93YUSzYiGYfx8DRnbWBg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O+ZzPuqisAJf2ZYk0KjvS+qpXhRJW/HIjdhUlbq61hKI/wh+SrpbP9OtUU2WalQB4
	 biWi2j+v1mU2gtDsEnyF5qwYBx3BkzzQg20NUPfiaXrAco4aKLgBYNmddlCENartCG
	 0Yo/HOmRqo8+MqV/2lUZw8RU25LtjOA1x8S58O5w3i+rK/JqqZKiEacnJNzO+1u/K6
	 tJqkQ0GJ+hPy4WYnj8MijodsRHNrV2UoJS9QJnPZ3+uqKL8bX3GRBq8Tp18fkF4YMn
	 ZlsXQax4AI3jwOAdTJW4H/vZeb1gQkEEvsOumd+KURk8QyCgEVk2OCzZErRekFww+F
	 gcwsIF7laNERA==
Message-ID: <sashiko-outbox-169868@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] s390/ap: Support new APMLM field with PQAP/TAPQ
 instruction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013134422.64155-2-freude@linux.ibm.com>
References: <20261013134422.64155-1-freude@linux.ibm.com>
 <20261013134422.64155-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:52:26 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> There is a new field APMLM (AP message limit multiplier) defined
> within the GR2 register on successful invocation of the TAPQ
> subfunction for the PQAP instruction.
>=20
> So the new formula to calculate the AP max message limit is now:
>=20
>   if ml field <=3D 3
>     AP max message limit is 12KB
>   else
>     AP max message limit =3D apml * (apmlm + 1) * 4KB
>=20
> Also adapt the HWINFO mask to have this new apmlm field shine
> through this bit filter mask.
>=20
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013134422.6415=
5-1-freude@linux.ibm.com?part=3D1

