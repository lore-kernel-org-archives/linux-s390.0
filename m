Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E2A3AA4E2
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032435; cv=none; b=GM4DrKZKITGryHjk6j9hhDKoz1qr5GOx2T3D4h5ALejlmQkwVmm877Rlo1UILYJT+VpJd+FJjhdfaSj+L0Fwn00nVpyQrEC3YLqcynZC87xCD272vVE4FGaIHebzcuGPa06hhuajfoUdfXxjyMJPJqX6p0N2hEYwkgl1YiDJIXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032435; c=relaxed/simple;
	bh=u6lfY1enPNUeIloYPyaxepWy5YbXxx2DhWFXTPoIfjk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fosG3QU2U2cLOgCGZd3Tw50D7bDzCCpGZFefBLa+BwitShqqKX5EHaWuWN2MFPyonF3MSXpNaatX8CMTPcvUqBRBbCmggZaOJ8NLM4EVSb/dPng/6wjYRjBfdKdMmbd7qra2OnlHf0DeFOaWEceIzLfBTuLSW5Adhm2NZyw0nuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDz1SRar; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDz1SRar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C864D1F000E9;
	Thu,  6 Aug 2026 16:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786032434;
	bh=ot68+m53yr6wetPgqgZwk4syF2xEDf++f23+qbCF6Pw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lDz1SRartkNm1wCJ1H97C/6RWMec8xv5cIVmF+SUKr4/Q/V7lzI8XmcfY3L5w3AAe
	 Vs01T7hsaVxd+fEBcWv/BZNeJ/XYhl9PZsKsV1bIceJd9ogMjWRy/HuA2ca9c4qI0e
	 Bb8+B/QJiZdMwKr0s6pRCIqCqMLx4QTUtzx/lpQ4YH+ZgXg3SJL13EV4LySI8DMwEC
	 sCn1uVchHEHhjx3kkYDZVxapLVm1qd7SmBcL614B4R+1YeA2e/5CQQTeklhEIu27BS
	 rgHQa++Kcue4aLqHiKax65OOd0ZRR8Tk0xKa7P33XTix1ZlMcrhiE/pG2OhBAkRAMd
	 FxVgMgtG2jMjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] s390/ap: Drop unused member from ap_device_id
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?= <u.kleine-koenig@baylibre.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260806155757.1281233-2-u.kleine-koenig@baylibre.com>
References: <20260806155757.1281233-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 16:07:13 +0000
Message-Id: <20260806160713.C864D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The commit message incorrectly references `device_info` instead =
of `driver_info`.
- [Low] The `kernel_ulong_t` typedef is no longer used after the removal of=
 `driver_info`.
--

--- Patch [1]: [PATCH v1] s390/ap: Drop unused member from ap_device_id ---
commit 88f5caa72995cfeb3eb825fd5c1c4f333ad8e5d7
Author: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.c=
om>

s390/ap: Drop unused member from ap_device_id

This commit removes the driver_info member from the ap_device_id structure.
The structure is not part of the API/ABI and the member has no in-kernel
users.

> ap_device_id::device_info is not used in the kernel. The structure is
> also not part of API/ABI, so the unused member can just be dropped.

[Severity: Medium]
This isn't a bug in the code, but the commit message references device_info.
The struct member actually being removed by this patch is named driver_info.

> diff --git a/include/linux/device-id/ap.h b/include/linux/device-id/ap.h
> index 0992333a34db2..011af33c0bcf2 100644
> --- a/include/linux/device-id/ap.h
> +++ b/include/linux/device-id/ap.h
> @@ -14,7 +14,6 @@ typedef unsigned long kernel_ulong_t;

[Severity: Low]
Does this change leave behind an unused typedef?

With the removal of driver_info, it appears the kernel_ulong_t typedef and
its enclosing #ifdef __KERNEL__ block are no longer used anywhere in this
header file.

>  struct ap_device_id {
>  	__u16 match_flags;	/* which fields to match against */
>  	__u8 dev_type;		/* device type */
> -	kernel_ulong_t driver_info;
>  };
> =20
>  #endif /* ifndef LINUX_DEVICE_ID_AP_H */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806155757.1281=
233-2-u.kleine-koenig@baylibre.com?part=3D1
