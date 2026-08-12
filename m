Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1468F36F8F7;
	Wed, 12 Aug 2026 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549819; cv=none; b=ARq34UOuMYhm3ydt5sgA+jLwbho49e6w8bxgLS5YuKhXovJvu8s12NHC5PYzdkCqMEzGWHd60jfSmxtU10vNI4wlJQv86R2m1yItdqpo/LlYush4qa1p80kEGhuIC5roLnQ0GIcKAoD5er9e5cvuSYjTYe4Hvk2FiPf7GCaN37o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549819; c=relaxed/simple;
	bh=sJsYrWGB/tMMK+KwSNodlFE8qDq750ulNe2IYodU3OA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oQf/tWjE83m4HcZhPYNsYWKhi9paAaS0nTDuseC3StwYj5gAR+f51tH0J+93umLPJNxWPrCR5WCt0rJ6Nnf7UHbfcVoO8uhMCiQgcd6BA8xWW0JQY3FTr8Ia17LfTJeZiCxZoK4Luz67tN0ZnRrS9jCuW3cmNV2wt3wL/xiWxxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsA0Vc0E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsA0Vc0E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5571F000E9;
	Wed, 12 Aug 2026 15:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786549817;
	bh=sJsYrWGB/tMMK+KwSNodlFE8qDq750ulNe2IYodU3OA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VsA0Vc0EO1vKbuSGq6ZsjOMCxOt74hZ0m+/Ms9X40iaZNbGjmqNEcCsyen5ZKXUxT
	 zUXR2Y0SSNkWpqb6fsGsuWoCe4FmB3rhb/go9tkF7EGm1QNMo9nTmywofQOwR4kcyQ
	 oYDfRfEnKH3HNuP2VKUx+fvLo0EXAr5bemhLwsLOANpYpPH/Vp8Dmy9ibBiuIa7nQx
	 K67EIan0XiPN0IPwoyXZwQi2cj2/hC38/wFusg8WJCqA2HUV53w5M2ZiQzpnlZ5rXS
	 g+WFg6d9VrNytR+XlENkznmMSr0T90VfIXQOhtOGZRDZKPlnXIqSo3Bk/Z8tHuKiHL
	 x7z2KMOHwVCcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/33] KVM: arm64: Use accessor functions for core
 regs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Oliver Upton" <oupton@kernel.org>, "Marc
 Zyngier" <maz@kernel.org>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvmarm@lists.linux.dev, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260812153631.3376090-9-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-9-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:50:16 +0000
Message-Id: <20260812155017.3D5571F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Instead of accessing the value directly use assessor function that
> abstract the actual location of the register values. Add a helper
> function to reset fpsimd registers. Enable other KVM implementations to
> reuse this code.
>=20
> No functional changes.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D8

