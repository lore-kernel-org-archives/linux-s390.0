Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580DE335081;
	Wed, 12 Aug 2026 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550573; cv=none; b=VqK8OeWBmIRsdK60YSAFo3tEEXIKqkpbKRc4GmjJ9weoQLAnuNtM2ZzZ221HQB9V6/k6ehUS4Fkw4TAaWSGziCbi/O3vBERwaJGSputq6YD2nIabI8eW2cAyHHF8dYK2EkJxvBMWTY6du3g58RhsIc899Yhr9wXIiK0OdsQfOTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550573; c=relaxed/simple;
	bh=d1Q4s4JJnVydYuD/yXZnOHSlqNGfTOvcEdif6Hf5HYo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Voblnogk8sFudoiKnGmYn9UjyBjQIBG93+ouhws4YIHUhB/VfT6GMbSTB5Ylc1Fsqwsxt1CdrdowyHPH0u2/J85b8SX5H+qbw6YR/gIMJRGMpDcEg3Ham/k5jASpFHp5wEpi9gojptXiw98pXW3aKpqKJCG0l9eiBV+9BqbxsTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkW8sjI9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkW8sjI9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBD11F000E9;
	Wed, 12 Aug 2026 16:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786550571;
	bh=d1Q4s4JJnVydYuD/yXZnOHSlqNGfTOvcEdif6Hf5HYo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hkW8sjI9iBx0QreXUVDvfFqpwEzjAz1+xJglTIkGFPjV9EX1oufyMJiPEWuwFbn59
	 wLS8RP6FCI9Ndupntta6GDB7hgXcoje+KL0Cd1OVWk7YppHq2b1GArpdYATgsS+UXl
	 0qssUQB8gweME8zBaByh1cDjXsAXlBSmTs4/FGaPQD6922PJAHn1bV91YiJqDgp/+T
	 DtjJo2XONVT5quOVLXUhGpsm7y/G5VNWcWB32qinmr1xKAlfYxq/Zrq5v8iCNACbJs
	 TKElrT9DJXlz4YcbUM6Q6m2YX60DwuAtNmTzDPlM/RSeAoIXZXBf3/vEpgIsw9AzUT
	 BFiifqwAODVzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 16/33] KVM: s390: Move s390 kvm code into a
 subdirectory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, "Marc Zyngier" <maz@kernel.org>, kvmarm@lists.linux.dev, "Oliver
 Upton" <oupton@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260812153631.3376090-17-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-17-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:02:50 +0000
Message-Id: <20260812160251.5CBD11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move all the code required to run s390 KVM guests on s390 to a s390
> subdirectory. Move gmap related code into a gmap directory to later
> share gmap code between KVM implementations.
>=20
> Update S390 VFIO-PCI MAINTAINERS filepath.
>=20
> No functional change.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D16

