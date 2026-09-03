Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264853515C9
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421921; cv=none; b=RUTy6Lumr+1Gakmvicj6ZgPm8of3e7Ui0ZpzWFbHFx7otIhGezqxEzOHOZY9+COAnieL8cHqjBxffl7NO8xzWCHHlU/gEPTTFxKroWApx4DVa5d/LzFUHmDeuaXKqZoD3o6ys0qcVLHSQeZtkncBVvqzg6YCTo514zwIhKsCJsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421921; c=relaxed/simple;
	bh=/pxMPeqri05UKU3aVG/OZ9cCCi8bqyVOk/vdm6GWzXw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DQYSmkY5w+Xl3ZNfMGuLg0ue34LV6C/XDGWpxhLmYX713F4vEYVh3cG8siRLbx5nGxBBJdyMRC/QEbeaLP2GWq52vh5TU8g9EheMPPX6MVPAHlfeoFCl7akVJAJWl2GwPBs/mUkeu1deax0E7QdBCuVsrTJWxyj+JPuz9NFx5Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTKEcVmV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTKEcVmV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390771F000E9;
	Thu,  3 Sep 2026 07:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788421919;
	bh=/pxMPeqri05UKU3aVG/OZ9cCCi8bqyVOk/vdm6GWzXw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MTKEcVmV6i+BJHlemfyH7CdGgaPdBOJvd0geu2yKJzBGP/2c6mJVJ5YcN2zndGguh
	 Aga5AFPrfRePFTdS35+9uU5XXAdytlrRMg5TL0qRudQfrGLI2thj4cYQMMTFfbZSxj
	 fN8isQ4bMbEo0OoCzgxs3lIokfZC89EjFHuvD4XU/lqxDd8jhiNQoH9HW4lmay0WIg
	 1Wn4AMauUqWsh7/jMk7NVKAtv/xNU9uY4FJ2DGNJ4HjbXlkjKRtivTn3pNjihAd/4e
	 TWPBNfK9Jpn/gJrtE9ca6TkdmkbIFp11sW6jQZOUC9Cb9MQ5XwF4jdylye6iROPBid
	 5zEWe0UGxd8fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/15] asm-generic: add an in-kernel auxvec.h header
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260903-at-vector-size-arch-v2-3-5bc32a71e3d8@linutronix.de>
References: <20260903-at-vector-size-arch-v2-0-5bc32a71e3d8@linutronix.de>
 <20260903-at-vector-size-arch-v2-3-5bc32a71e3d8@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 07:51:58 +0000
Message-Id: <20260903075159.390771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incorrect include guard name in `include/asm-generic/auxvec.h`.
--

commit a6c0fee565d771a1d46c4c885fe6773f26339df1
Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

asm-generic: add an in-kernel auxvec.h header

This commit adds asm-generic infrastructure to handle fallbacks for
architectures which are not migrated yet and those which won't require
their own definition of auxvec.h. It also extends linux/auxvec.h to
cover all potential low-level auxvec.h headers.

> diff --git a/include/asm-generic/auxvec.h b/include/asm-generic/auxvec.h
> new file mode 100644
> index 0000000000000..e4abd2a8c5ed3
> --- /dev/null
> +++ b/include/asm-generic/auxvec.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_GENERIC_AUXVAL_H__
> +#define __ASM_GENERIC_AUXVAL_H__

[Severity: Low]
This isn't a bug, but there appears to be a typo in the include guard. The
macro name __ASM_GENERIC_AUXVAL_H__ does not match the filename auxvec.h.
Should this be named __ASM_GENERIC_AUXVEC_H__ instead?

> +
> +#define AT_VECTOR_SIZE_ARCH 0
> +
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-at-vector-=
size-arch-v2-0-5bc32a71e3d8@linutronix.de?part=3D3
