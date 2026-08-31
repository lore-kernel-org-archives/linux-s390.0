Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842E22EBBB9;
	Mon, 31 Aug 2026 19:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788203020; cv=none; b=YFsGE7r3Zi5KwmDOLlxmZVdCYyRoDqnCiDFc2TG/VSRVTP4djkEEsv2PxHwCEy41+DimVRa5p++XV+Wux82nYi5HV05YTb1h17xfGEUFTyhjzhcsTku3nTGO3iBhXOETNJd+WP0N3pPhpvNrpbUtf6EsrYeIBAo8s2GGXXe/gdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788203020; c=relaxed/simple;
	bh=IJWaSHFdpy5gniXSU/YxA/s66lqgYByAXzCR61G7j50=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Otzij6Rc+LEPTQCCLeW5OHot2usu6rDuQKM74Nk/2hbNYbpyZk9yybdaddPNSBAwydYUlRRT7VqhJrNh2MC7Rm3JojcNVrPeJ/qfDS0htDZ7ywW9Q1KBATTY5zhKk/5w4oItvc1UlS0/Qp2fJFGY1YiZhoEzbzUm70hx0+rcpFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yl7F6TFj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yl7F6TFj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E591F000E9;
	Mon, 31 Aug 2026 19:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788203019;
	bh=IJWaSHFdpy5gniXSU/YxA/s66lqgYByAXzCR61G7j50=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yl7F6TFjUIGl1nqvrTdb4rsl3JDnXv2Lg0RagCAu7d0JtPQKAEns/smiymbhu1ZOC
	 4yxASPmp7fZUzWqdX5fw4z4aluaTHQ6ww/cJDmjYSVdvYouWjr+ZckeWeSvrpJnm/Q
	 RpwFIJUvLYdWM5jJug6tBrBDsoWdVtIiOFXZ1NVkJlZei0t9aYlS4Td/BrjZoYDJgr
	 QEyEyJAjjCCPpgoBkV+VIWnslZNvGnF+Kyd0zV1ZIiUr84A7opUuvFb63ReNEsN4y0
	 SRmPzfgqiKHVpojI+n4oF4tM7GydjlFzFdPihPrhheFiOOda/rYCpokQkq5o7NZSAf
	 8xbjIDl9sryRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/20] s390: tools: Allow sharing arm64/kvm headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, kvmarm@lists.linux.dev, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>
In-Reply-To: <20260831145536.913567-9-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
 <20260831145536.913567-9-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:03:38 +0000
Message-Id: <20260831190338.A1E591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> In addition to sharing headers in arch/arm64/include/{asm, uapi/asm}
> also allow to share headers in arch/arm64/kvm which provide local KVM
> definitions.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831145536.9135=
67-1-seiden@linux.ibm.com?part=3D8

