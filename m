Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C21A3D7D88
	for <linux-s390@vger.kernel.org>; Wed, 15 Jul 2026 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105389; cv=none; b=nSO0W/382adNDs5PVtIplhumJU+Pnc3r5lbIQuqAAs9Wo8fUDZs+srbnYpGrt0JR90tmYoN+mlEc7AwWziju4ikKAllnd1//coxzZ8grn1IxQQs5XrWo5wL3LDVRYrrv4Pl5i0C5/dB6eaoTusyPTbCjt/EBykwiVXw8qsvr4Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105389; c=relaxed/simple;
	bh=3XEdO/htil4GsE/4DwUGBMQzigC6UfCKXuEfonaYhzM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N0rog31Om3iCLk4EN283aMD0g0UBWQ8akYpkbMeBrQNlisjGAXgdZMaA15K74+1keRsz/w+JJIG7mqvw0kHmN5u2UVFWVwzVijQp7Fv8zuy65EPTf+9j8OEk/617PMAw8MmlLDjI52Y1IjtW3mpaFwEsqCXxKU1OHdRxFfJI+FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPJvXeYV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPJvXeYV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C671F000E9;
	Wed, 15 Jul 2026 08:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784105382;
	bh=0DqsA2FKZASx26F7P9LtkuDEGJh/XvK/Pk/KgKfzK2E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RPJvXeYVsbAxDV16Bsr6b+NbE2Ih5SVNhBkg4/5lJFjp8S7bAajntxnhlS6gufWjY
	 X1kIOE4TudQVaqlxVT1cyTZR6DYod35JatA7o52w0I9WxTyXojH51tLZlz4mgmnkkN
	 hOhgg0lE0VjlcSbG7OHeJARowGmgpBYxpKeGWVt/QEjZPzmZaKZvtEbMzpqlYO/uzt
	 vBzzl/s+nnrCDABWkSP3gu5K2AQ6K0H9bLDHSSK5mw8/yKBJIs/SWNajYQZZd6QQSi
	 QhMGZ8lzDBDTPLEen8Mr9OUPmeOf+GQsrCAtM+hzD5/ccYicrLMEeuvCZi9Z1B4fNN
	 sAD4JSpbnOK3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] ptp: ptp_s390: Add missing CC check for ptff()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sven Schnelle" <svens@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260714084921.3926697-2-svens@linux.ibm.com>
References: <20260714084921.3926697-1-svens@linux.ibm.com>
 <20260714084921.3926697-2-svens@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 08:49:41 +0000
Message-Id: <20260715084941.B3C671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message explicitly states "returning EIO if it is not=
 zero", but the implementation actually returns `-EOPNOTSUPP`.
--

--- Patch [1]: [PATCH 1/2] ptp: ptp_s390: Add missing CC check for ptff() -=
--
commit 1da4a31377dcdb1f0789c86ae0f57516f6c5caf1
Author: Sven Schnelle <svens@linux.ibm.com>

ptp: ptp_s390: Add missing CC check for ptff()

This commit updates ptp_s390_qpt_gettime to check the condition code
returned by ptff. It adds an error path to handle non-zero returns from
the hardware call.

> The code doesn't honor the returned condition code when issuing
> the PTFF_QPT call. Fix this by checking the return code and returning
> EIO if it is not zero.

[Severity: Medium]
Is the description in the commit message accurate? The message states the
code returns EIO, but the implementation actually returns -EOPNOTSUPP:

> diff --git a/drivers/ptp/ptp_s390.c b/drivers/ptp/ptp_s390.c
> index 29618eb9bf442..7299c3aae65f6 100644
> --- a/drivers/ptp/ptp_s390.c
> +++ b/drivers/ptp/ptp_s390.c
> @@ -48,7 +48,8 @@ static int ptp_s390_qpt_gettime(struct ptp_clock_info *=
ptp,
>  {
>  	unsigned long tod;
> =20
> -	ptff(&tod, sizeof(tod), PTFF_QPT);
> +	if (ptff(&tod, sizeof(tod), PTFF_QPT) !=3D 0)
> +		return -EOPNOTSUPP;
>  	*ts =3D tod_to_timespec64(tod);
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714084921.3926=
697-1-svens@linux.ibm.com?part=3D1
