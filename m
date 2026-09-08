Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2073937E5FD
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 06:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788849582; cv=none; b=Wb7S9Y/2hoex9yjHKJqiaLUC/1+E7jVBgoC9VEVmGfET7/Uert06NY2NFM9apZp4Tp6I5voTatael6BCt0z4w1wxrEBJ67peKwRUKw3jiJ4pxiO9GEnPv6/HKTZWg8MadbXJ51i7FhB/rEaUZm9mRlsc9KBnRhcrnbYDgyIdI6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788849582; c=relaxed/simple;
	bh=dkwnec3Y+8pj+pGsHCDxVveQWiLfMBTa5yQh39/Jors=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fmubs2Lk35TTKaOzwRX5vkZE/7mUje08cU+wqqw0+nns6DZ3+SWTuuL2KPxNOlwBYw5252QwNTN80Df0znUjvEoiGv97gPtL7CmTpkH8IbyYeherVKrHukK3UlrZpyp7ynO1ehYFLLinGO9zJtiZTrH+qF7Yn/lXoprLx6y6x60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SV24XLot; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SV24XLot"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE071F00A3A;
	Tue,  8 Sep 2026 06:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788849580;
	bh=dkwnec3Y+8pj+pGsHCDxVveQWiLfMBTa5yQh39/Jors=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SV24XLotzAiCv/kz89e8942BgqdStNJjb3X0bz21XfS1DQ0xtBOziN1Q6ne2tjTWG
	 y+GILo4V7nwhV/LZt4CXGU4cvXYNAROP04KLEQcS3gJu14UpUAZDgG9YIPn7MyO5tf
	 n1fria6tyXbwjUPTj6zWicxtlEb11aPWaceGf0AYmIfdWR1o13PEVGv8wKrvYALfje
	 LMKWKYdhARYiG/XRUJvu1HUeLMRSF957fXriZ3S3XZ+IPBdKFSFQ73fMbzuLUDz1fW
	 jobYzVHCrmkhIQHOARsV0tOZWnnDQ+KuaKFgSfMeoFDZ7wVIahjKnNrli0Vk+VVpHz
	 /ftJ2uR4M/9GQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/24] ARM: elf: Move relocation constants to UAPI
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, ojeda@kernel.org
In-Reply-To: <20260908-vdso-absolute-reloc-v5-3-3a93791af1cf@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-3-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 06:39:39 +0000
Message-Id: <20260908063940.5EE071F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> These constants are useful for cross-platform userspace, for example to
> process ELF files during kernel cross-compilation.
>=20
> Move them from the kernel-private architecture-specific header to the UAP=
I.
>=20
> One arm64 header is also changed as it duplicates an arm definition.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-vdso-absol=
ute-reloc-v5-0-3a93791af1cf@linutronix.de?part=3D3

