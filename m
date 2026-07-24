Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60F92F7EE7;
	Fri, 24 Jul 2026 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784915027; cv=none; b=p1hGXOhYFdDzi1gqz0MsKRL/PzXpGRqK/TmFqn2zgBVDtYUGzLsGcPeI5rINBmbI4Pa9hZgq4MIWYOrEj+AfIdhjZtMy1XMJRoHlzlncYEhynKPE/xFAmmeAQRuFjg4n8Mia9fvvou/nwBrM+HKTOy4fjy793UBZz1586HHaduI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784915027; c=relaxed/simple;
	bh=OUGz2XYy9zQIV2Cwd9ww5s03P12G/MXH/B5IsH5KLBc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GLpEKwNt722jb4K/bCirSlfiEcgqSbbaAHwYEMudjlNRuBLp1uRLKoTtDkwo5/61rVUIeWDy0rS8NvbUV+3wOOexrGd4RD6o7x50DpK2kNZaqlxnBruayCzOARqDoIf5uK8hTnPRHRq0Q3sz4m/1Zx9EOoZJCgB3bH8mOaupASA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvbMn75i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvbMn75i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AE31F000E9;
	Fri, 24 Jul 2026 17:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784915026;
	bh=OUGz2XYy9zQIV2Cwd9ww5s03P12G/MXH/B5IsH5KLBc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kvbMn75i8UbuuqAnSYJfdr/cjiWDgxdNpAgzFwyAfXR7ZIn5aKO5rXbx4CtmuCWp8
	 FzcERbA5jKjuXmc2YTxDILR6sfqtixJPOZLg1d4IXruE59yzek5HBkOhVRZo4WWbWk
	 aKmUPY4as1TkyOSipGiVkSnqc66oH6j0zcM0ZxWzXea05RXkVCMPoI78NxmOIRyipx
	 sMUIoDHHAD9dXtQWTV8c05jLFRksff3igDiMO0UA5xdKqNf5AFTHZr+X+QlybmpXTI
	 eN1VMNxUfs7iCMS5Xpa7/vv28ZV/oNNF4xPt6bukC8bdJc+07eaFFfguzU3zl4P88q
	 Flbr5Y6S2eK7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/15] s390/vfio-ap: Reset migration state in
 VFIO_DEVICE_RESET ioctl handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260724161351.1802644-5-akrowiak@linux.ibm.com>
References: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
 <20260724161351.1802644-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 17:43:45 +0000
Message-Id: <20260724174346.69AE31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> According to the VFIO migration specifications, userspace must issue a
> VFIO_DEVICE_RESET ioctl if a vfio device enters an error state or fails a
> state transition to recover the device and return its migration state to
> RUNNING. This patch adds a function that is called when a VFIO_DEVICE_RES=
ET
> is issued that releases the migration files and frees the storage allocat=
ed
> for maintaining the migration state.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724161351.1802=
644-1-akrowiak@linux.ibm.com?part=3D4

