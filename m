Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43584525A62
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907213; cv=none; b=bepWiLh5eFN5IZp9Nz0DurslUWupwNS6kmSj/dedUN3doc2GgFRvE2CZ+F68jXELjxu1P8FGiGiOGFEUW4PYnZwdGiVeDCZaHwbOM8a0J6qNHPwBoqeHBRZ0zl8vvd2dGtXFqT3+91Y85nDQe+JdC7ShhQnyhv9Q75hPTgX1gXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907213; c=relaxed/simple;
	bh=OqTYYLU6PX6w6jc4JfN/Ufrq5KtssBpWkv4Ghf+yVyM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Nb01PQSx14CwwVfnmvE/q6aD6riZdLUWt7695bz1IzZrZXnumZquT20qMOvCV2T8Iq0OZsXIfqm7qZIRF1Xi9O0xVat5M8H995K/hIQLgVfKXbFXKJ31RzzmIL5iVo6pA7o15zMCGgAJ4X6J4WhosIJLPHWpjm9t6GGgS7YA6uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRLeJGm5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRLeJGm5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904541F000FF;
	Tue, 13 Oct 2026 16:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791907211;
	bh=OqTYYLU6PX6w6jc4JfN/Ufrq5KtssBpWkv4Ghf+yVyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hRLeJGm5qlqHSi2QJ4S/AVHp+1AimeuDjTJHHNUuIZ0dgR+fQ3Cm57h1iOJDvnAtV
	 A3DLFABJ3TLsaoyYHgnSH4+xDOcLjCd3YwLT/gmWtUtOFMW46d+mIVEtfn/7fHP8rR
	 PNE3WtmvmnGJca7X+D3MhLsfQAkFdtxgEpr64L8jaSEoLN2FuQlyEZ+IzteLLXX59A
	 7iZbuKTnzF0vsEgWwfOxQM8OzMUTgOzbiDkS8fYiCvGPTmceI7cwM+txqNyHIcVDxE
	 f8Zxfs45xU8fYHtE9wPMtydomKxsK7uiTphaDsv71dpALOxqz2XT7J7uLYtcVXyMxV
	 uHUgZ7IWe6Efw==
Message-ID: <sashiko-outbox-170077@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 09/15] s390/vfio-ap: Prepare lock helpers and matrix
 init for cross-file use
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261013153219.3534306-10-akrowiak@linux.ibm.com>
References: <20261013153219.3534306-1-akrowiak@linux.ibm.com>
 <20261013153219.3534306-10-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:00:11 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Move get_update_locks_for_mdev(), release_update_locks_for_mdev(),
> and assert_has_update_locks_for_mdev() from vfio_ap_ops.c into
> vfio_ap_private.h as static inline functions so they are accessible
> to vfio_ap_migration.c in subsequent patches.
>=20
> Make vfio_ap_matrix_init() non-static and add its declaration to
> vfio_ap_private.h for the same reason.
>=20
> No functional change.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013153219.3534=
306-1-akrowiak@linux.ibm.com?part=3D9

