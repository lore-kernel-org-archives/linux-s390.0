Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157F73B9DA1
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673372; cv=none; b=T4rwS2VHYt+4NxQjm2KjKGddRMU3dowTadTuVHfeBGN9/6DoXZIOCCVWnC0hoYyT8KY4uR58Lx+7iMecf4WasTaysy1gKKDyaboVupcMge+IDwJ2LijuJMbvW9XFqnjJj1iBvGylB/ogqtMx0TChYhEUJpXWN3YDlnMRfRiIT0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673372; c=relaxed/simple;
	bh=EiO2A8wLRwq8SeVkk2uVPCG9oxol4nTzjqqESeyDiWE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i1k1KQioLkkgYW5i/lKsYJLs/6bw2sfdo4WvoTq+g8KRWgVZrfghsn3NA4sMxA+5poH9DMwruVbQ7N6KoC22lxP3AQPruqAFZ/BQPr+SHF4MfvWD4u18sdM9lXlL6LXSPktJY1kP2bnPeW6B3fkQA27hI/vSeudH0MeDEttenQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1MVtkK2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1MVtkK2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED8B1F000FF;
	Thu, 17 Sep 2026 19:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789673370;
	bh=EiO2A8wLRwq8SeVkk2uVPCG9oxol4nTzjqqESeyDiWE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i1MVtkK2VnYDmxbpUuxpd7X0mEJjVrxBKuV4SH6hLVHADiiryJ9148ij5cU4tRd5Q
	 LL16xOXKWMZb5doADLuUgv3i4KY8bDfxOAjOuPvOSWoB1h7Hby7b8gzhcWJRuydYK6
	 CTcrzDZ7/tSRdtSCiqP0yEJ8lltqv9b+IgNCe7nkGSZPAY2LGvHcZzH0VfKQFsC/tT
	 QtpCuOfcWpcg6/6sl48HI+00RDkM38hkV04JfC7RYm6HYsdoshIJegBGA+88KZbPY/
	 rf0NYE81P3CH+Ox/zCR2QQii6ZeEMNxC6ZFTTdoovdLpousn88OsSqMD2BW+baU0e+
	 MUE3yXfCCneEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/12] s390/lowcore: Remove _AC() from
 LOWCORE_ALT_ADDRESS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260917192237.638324-4-hca@linux.ibm.com>
References: <20260917192237.638324-1-hca@linux.ibm.com>
 <20260917192237.638324-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 19:29:30 +0000
Message-Id: <20260917192930.6ED8B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Remove the _AC() conversion from LOWCORE_ALT_ADDRESS. This changes the
> type of LOWCORE_ALT_ADDRESS from unsigned long to int in C code, however
> looking at the current users this should not cause any changes.
>=20
> This allows to use __stringify(LOWCORE_ALT_ADDRESS) for inline
> assemblies, which otherwise wouldn't work because of the UL suffix.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917192237.6383=
24-1-hca@linux.ibm.com?part=3D3

