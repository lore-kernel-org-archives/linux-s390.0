Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC1338D3FE;
	Wed, 12 Aug 2026 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551332; cv=none; b=oPk6wOlR/Dyke2727gD+w4yycQvTydM6DOGk477m+Sc+Lt27IbBmNAUnySRQNVnpzlKwP7v1wjwHlZgGoo045DNcaxzIN+S8cCzJlywLvcN8DnMw6nZgBPhjKZYM+KJ6SSw9DQE81JNdyugge/CSkTUl3mmUQirHItUeXgGCUx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551332; c=relaxed/simple;
	bh=uG9RBeq1U6vyluUk/HRnHcIYQJja7+z1xcciP/WGm+Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W4wQU3kzQUXGPthosnkSNQrzsqjnJi3/VkQt0vTZc6uOEG0R+o8IPB7KhtA51burOyw7WvYz0IeSkp5MIESalkfCu5j1fIWP5+qLUR1trE9MHj0CZ7/ceQuwhIES/ReqbHTsdyM23KrrZzkxp8U0j1KG6WqEJ0V/UYcXRYlRyvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTuALt/r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTuALt/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202F51F000E9;
	Wed, 12 Aug 2026 16:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786551331;
	bh=uG9RBeq1U6vyluUk/HRnHcIYQJja7+z1xcciP/WGm+Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DTuALt/rC4S2T5aemlHejcstrLa4H79l0ROsgARrdDgJcKoBDIKxPMfPosr4QRiPr
	 NFqPbKKKdnkKX+Jdg/p4RPLRvlpAehfq4uhdfcRPSHWSRbzuUdWK3TJc/+1PfHE5Lz
	 qTVDpB4GVtqOS2HHhqKZ24Dpjx/Vursdi9gPZD8pN6XqmiT1/vUWClArwWsSe13T8W
	 gRZ18hQ7y36PxFRYQQM/I3iVOpTdODNk3rB74JM2FKVEO1iY3KC7WT2u3aHw3d73jb
	 ax/iIPiLquX2O1XNdAIOWaQSCocP6DZJq4nIb9l7uxopObs8uDDsfHahUP77VEsc/R
	 eI+ks5v195gfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 27/33] s390/hwcaps: Report SAE support as hwcap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, kvmarm@lists.linux.dev, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, "Marc
 Zyngier" <maz@kernel.org>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260812153631.3376090-28-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-28-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:15:30 +0000
Message-Id: <20260812161531.202F51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Hendrik Brueckner <brueckner@linux.ibm.com>
>=20
> Report SAE support as hwcap (and /proc/cpuinfo)
>=20
> Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D27

