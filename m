Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48D7502796;
	Fri, 18 Sep 2026 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745952; cv=none; b=JW2IRNx0OasBVJAZF0kvFPZ7Js0exQdnkAdONFvG7PivS39qGcgXb0xkz8aFJQQiane2PEPPYIK5HOjaQh2SFln5yaoeNCoYmF5P1CKDijMcfLHA0PxxghK3fZPVIt0Rvv3kOo4SO3zxPoCG+pdSRIJlhPIo41aWDySWmqC3pEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745952; c=relaxed/simple;
	bh=MaR7CPQmELPKDIA8wmGK5otdb/uc66d+LtdVblLr51M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D+RIEZ/R/E9MpyvC4Vddy7902Hb5pav7BRm0PDrARqN6uyMHjyhDE0L/UHp6oNTjrne5LHfSU4XI0tSTyExnOpJtoK40UeN0cjrSIpchgSjULXxUTtbZ4luVgV/CLTuXLiR4FMky3o24c5TUH19ONVvRtOERGxwyGkRbg/+H8oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEn7IjS0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEn7IjS0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB7F1F000FF;
	Fri, 18 Sep 2026 15:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789745950;
	bh=MaR7CPQmELPKDIA8wmGK5otdb/uc66d+LtdVblLr51M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HEn7IjS0Bk1b8fevt7jPOBQTLKRRYvF/VCewLo5pas0tCvx2lbe2hE5pZRYdn84l/
	 f9MsF2Iv3IYTG9IrLC3uZfyc+0LbnEada/x/XgwPQEs1UHNCZctD6tVCqU8KgAa5qA
	 zok9IdUZhQkL2tW0Ea6wZ2/8qinj4IhpTqpdFSE/EGp6sQ5d4TvmNXjeIlPpQ7+oEN
	 p7HK8uChbE1yrYCkOY88cWqgnS6c4f/6XXUV2vgx+R4LcDSOez/Mq+Ysv+HvSZJtsB
	 YEKpsDvk3VISObNrgj6iP8GqkmJ8Ma079Vxdl16bwWJuUKy7cNk7Iw9d+PbU0opJnb
	 J4eoqdGV+k+9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 15/29] arm64: Prepare sharing arm64 headers with s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvmarm@lists.linux.dev, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>
In-Reply-To: <20260918133107.1042730-16-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-16-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:39:09 +0000
Message-Id: <20260918153909.BFB7F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Prepare the sharing of arm64 headers with s390 by moving definitions
> inside headers to reduce the number of shared markers. Clean up includes
> to further streamline the sharing of headers.
>=20
> No functional change.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D15

