Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB554854F6
	for <linux-s390@vger.kernel.org>; Wed,  9 Sep 2026 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944654; cv=none; b=Mj/L2Uz22EQEVSIv8OLbzHQ2XqrMLNaQRTElGbuUTJ9wX5KlvcvZjWo5Su1DPaUp08GDbdihdyZAnoqMQCwY1Qib9hvfFCXNC8An9RvkozFQcSswyCnK0IgfcsC1ndYRPuQT+3OO0rVHxry8azYIcXGlmYA1370QCDVghbpCHZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944654; c=relaxed/simple;
	bh=u4QcNKZXfrds8zTFIVwCsfhnHlN9hUVs7SE3EDXgf4w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gOexSKm2u85sjlyIdtjZJObK+AfHQIq0rbrzy8ZDfobIj3mMxibS4z0waDLhloguqiMvy4JK0qNdn02sf/XfU792RQcCwQuGF87k53GY5rnOrYPZwaae1TlZf2f4kDcNOV71MxGXdBWSBXMjdNGJQ1REwb1l4qqwPYwCL2bWMjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0lc4Xtp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0lc4Xtp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497B21F00A3A;
	Wed,  9 Sep 2026 09:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788944653;
	bh=u4QcNKZXfrds8zTFIVwCsfhnHlN9hUVs7SE3EDXgf4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b0lc4XtpmUrZJm82TpYQnfcu4VKiAJ2YpP87j88AtNgrA8kfQVRLXotflxHocI1bm
	 X6lpX7WifzfZZq+WgtRNRd2GxtZ0h99l3ftKqS+kpfDHZ4z6G/8kOSxUO8vwtrQ2+f
	 YkbTZclpsk5ovJ3idf/KJSajyrn016QYSYNijI+G4DY0ljFBzqotxvUe/1eikw+2hz
	 5AK6juyMT0d+iQVfGv5Hx1uPjeb5iU9QiH4tTW5+ihF3ciLVbS90VLYIF4oBDwsZal
	 gCgQ7lk3H+XL0vAlBEBY0DF1WKS3cDxb4n4UvfnX+10mvE8ldyWnZtOw6djXj0wLP4
	 xZjSj7xkal5Uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/15] vdso: Add asm-generic/vdso/vsyscall.h
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260909-vdso-asm-generic-vsyscall-h-v1-14-63ae856cc659@linutronix.de>
References: <20260909-vdso-asm-generic-vsyscall-h-v1-0-63ae856cc659@linutronix.de>
 <20260909-vdso-asm-generic-vsyscall-h-v1-14-63ae856cc659@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:04:12 +0000
Message-Id: <20260909090413.497B21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Most architectures' asm/vdso/vsyscall.h do not define any symbols.
>=20
> Add an empty asm-generic variant and replace the pointless
> architecture-specific copies.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-vdso-asm-g=
eneric-vsyscall-h-v1-0-63ae856cc659@linutronix.de?part=3D14

