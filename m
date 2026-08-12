Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8462D94B5;
	Wed, 12 Aug 2026 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550905; cv=none; b=jN+eGaRkEEQ6+OpfTBOeHQyRFFPOXr2qySyunrFlQfrAuVvrombreVnh0TN9iOLwykZskQp4Zf3I/xm9hH5dqUJ4GBTApRLOptSJiQEMzmCVzpiOZv4gd6+SO5aeLtHvEO88quS4AdKIN5Q7QJOk8vWtSlA6eyVATZdA0OtmB1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550905; c=relaxed/simple;
	bh=nj7YkspDWrgtbb7Q0Z4osRap7ywKka0H/KOg2D47s18=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hHDGME9WXxkQURpEyigUkUW08ClOtV03wtM4IMhsI/11TGSrR2qAkQp37GDzBibW3Wv7s5D1Hcw2sdmNf/vrNyCVI2Vtb0qtq/pUd57KzJVbkOmRvxNaKIR6beXx4ctrd/X5s5qPz0Ji2IbVvUmdLamYw8pV7VIS9TjoS0EiTc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrGLguKH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrGLguKH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91011F00A3A;
	Wed, 12 Aug 2026 16:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786550904;
	bh=nj7YkspDWrgtbb7Q0Z4osRap7ywKka0H/KOg2D47s18=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hrGLguKHaRr7xanhWgJkDw90VZO8ZdDCZbvM/7oF2cRrARaEsq/WtANT5zIPAp6w6
	 dt3kbJ2nFhCtUfAzV2UeTUh/8+Dl+hyOFNDWNvgdJ/RiaRG1p5lrBA6IZAfx5d7qQg
	 WhB4qB6krltBLcI1LeWwX1/Jvu1YDlhnEVNXu1uAjJZn4OqLVW678UP717sXR6lgBF
	 XA/sAi+kCmED7ggE70Qvn5nV148b18Imyd0cVHRmzpvUFNWEABnRbIygg35J6LkPGc
	 WOKH9knB8aVOVnj6wNyyPBuetACwnhg0e9vTvxOIw2vg29QBm7bPSPBr/cM/WEXlx8
	 1jUVZhKfp2I+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 21/33] KVM: s390: gmap: Make prefix handling optional
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvmarm@lists.linux.dev
In-Reply-To: <20260812153631.3376090-22-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-22-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:08:23 +0000
Message-Id: <20260812160823.B91011F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Guard guest prefix handling behind `KVM_S390_MANAGES_S390_GUEST`. This
> enables other KVM implementations to use gmap without implementing
> prefix handling. The prefix handling is integrated deeply in the gmap
> implementation. Therefore, provide safe default implementations for the
> guarded functions.
>=20
> No functional changes.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D21

