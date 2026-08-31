Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086503B635C;
	Mon, 31 Aug 2026 18:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200733; cv=none; b=mmqLvBVMVEbuEFnJNg+XKNgIY0iPsGJmh8N1b3naxDsyRfAPKyg8VpPAVR9kqUJtmSW7McuNEO6BhWnEPCcYC426TyYOj/7ZaZBgCiEL8cfayW4WLYxVkv688rKjBxO5kLpbvGqTllH0atjb7FCK3+VVRED64iM9YlEOgORyPVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200733; c=relaxed/simple;
	bh=pr66g5Z0OupxRfblEFYBDFn3k0e+fmK8Q6FYAjAf+9s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BaJ1C1ZsjpnpgCcOvgMvKp51/nqyzQ++xyjIuiwU8CMbnne5o3p9vJHMj8Kap71jHQqbj8nGFd98UzxBFEJAg/1ZlFjXoyOmqaJimKBMDfFENSfBIFbxXMgTss0P3rw3MEiWntmnMwj9wA0IDduYISOLZEvTDt2n+Wgns71xtJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3AO7lpx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3AO7lpx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B84D1F000E9;
	Mon, 31 Aug 2026 18:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788200731;
	bh=pr66g5Z0OupxRfblEFYBDFn3k0e+fmK8Q6FYAjAf+9s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g3AO7lpx2aAAGOrc9PPD0Y5zmp1nzaraXEe+pAidgp6zGQ1VlW/fEghcGeLQh/bJd
	 qCzEqB4RTpEb3ARyrSI/uuOR4qwq1hsIdoA4Ooda4BVGQqOwMnHNADdK3WMKSLhTot
	 9Jh6uyvg4ysGdD8TX44PPYI7NRRCpahTs1fVsDAh7MtFjPBrSZczGiOM5XWwGiS0Ar
	 sVHD9GGr15lCPSZcj1+F1ZhS0Q1NxIROF6Hm3ZC7xTBwA3++hxv4kTJWgXSPZG7pT5
	 H32/9zUPq+DnKGglSMUvJf7Ilj0GM6oSbnZesybag42nBU2LJ4Y+8SYCtcZXDPpl3E
	 WjbEl4kyseYGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/23] KVM: Make device name configurable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, "Oliver
 Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvmarm@lists.linux.dev
In-Reply-To: <20260831144802.834315-3-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-3-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:25:30 +0000
Message-Id: <20260831182531.0B84D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Allow KVM implementations to choose alternative device names. This is
> especially useful for architectures providing multiple KVM
> implementations simultaneously. Architectures providing multiple KVM
> implementations must compile the KVM common code once per
> implementation and mange symbols.
>=20
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831144802.8343=
15-1-seiden@linux.ibm.com?part=3D2

