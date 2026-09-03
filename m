Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB30375AC6
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422370; cv=none; b=lQQH9hgP1tcm3zNOEDX6ucgdQdRgROsH1jPy85UssykomHKdTPb1jW454mRH8T26nUJUr9MB+HmKXGJ14++dMDb3X8G3LobP0ZI0hRM1v/Z6sFZ9x1oxdSDljF55GhGua2dusP6sJNublNTpaTyKLyxchpCkV2Goe232PXvYbzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422370; c=relaxed/simple;
	bh=wEYN4L2g0iGaJvqf4ydHGJdLS98VAi8VDwM3vW8c+q0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R0424MPk5//nVOwJprmJ2WW3Wv9BcqxIS9Sik4RKQeWwlf0KMO1LLK3mgmexRZPd6ibOJ2DwePdxz+O+LRk3VVEoqA3Zf5N6yR41NFiN2gfKZMrmXaGpfc31tmcVGR5kCwcxje5sIxvycLutOWxvIuT3MdTL6cEeo0O5UWjQpVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8iXz2ct; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8iXz2ct"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4040C1F000E9;
	Thu,  3 Sep 2026 07:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788422368;
	bh=TMUuiTzCy1DeUgnTkYApb4rzaHqrsOSFXvFpQMZvjQU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z8iXz2ct9IZNNInV4lY+zvjY9CG6M6hnKG0Gd2YtzAxyGg3RSTciP7rqjrotOGJtB
	 cpoM2XYXNLPX3hrOTSmkypjaScdYMh5V7GHDVb3HsIKX4BdTWEwI0GTf/JnyEZSBzm
	 R1XJ29L/QYIa4Zr7/jMh+wT3/v+oSywh2FXmRWj8ts0rAF9iEWZeKtLnFY940MI+PC
	 jg7ca8BMefHKD+m2lhWrJlCk8BOR6xLW8940IivOrsc9KmSZnIBW4wO8vpbXMUvTNa
	 0vHPh9e10GclilqvFsKk0kL085f7rDsm59kfyWMKHfnWmnYq4AKkR1P8U5Gc00+bNe
	 t+8WQttUt12aQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/15] RISC-V: Remove AT_VECTOR_SIZE_ARCH from UAPI
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260903-at-vector-size-arch-v2-7-5bc32a71e3d8@linutronix.de>
References: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
 <20260903-at-vector-size-arch-v2-7-5bc32a71e3d8@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 07:59:27 +0000
Message-Id: <20260903075928.4040C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Copy-paste error in header guard comment.
--

commit 720f0a96cf858b439bf53a700bc4833d17fac31f
Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

RISC-V: Remove AT_VECTOR_SIZE_ARCH from UAPI

This commit removes AT_VECTOR_SIZE_ARCH from the RISC-V UAPI headers since=
=20
it is not used by userspace. It moves the symbol to a newly created=20
kernel-internal header instead.

> diff --git a/arch/riscv/include/asm/auxvec.h b/arch/riscv/include/asm/aux=
vec.h
> new file mode 100644
> index 0000000000000..fb4233445276a
> --- /dev/null
> +++ b/arch/riscv/include/asm/auxvec.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2012 ARM Ltd.
> + * Copyright (C) 2015 Regents of the University of California
> + */
> +
> +#ifndef _ASM_RISCV_AUXVEC_H
> +#define _ASM_RISCV_AUXVEC_H
> +
> +/* entries in ARCH_DLINFO */
> +#define AT_VECTOR_SIZE_ARCH	10
> +
> +#endif /* _UAPI_ASM_RISCV_AUXVEC_H */

[Severity: Low]
This isn't a bug, but should this #endif comment match the newly defined=20
_ASM_RISCV_AUXVEC_H guard at the top of the file instead of referencing=20
the old UAPI header guard?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-at-vector-=
size-arch-v2-0-5bc32a71e3d8@linutronix.de?part=3D7
