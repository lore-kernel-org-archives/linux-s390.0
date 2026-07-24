Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF4D44C51F;
	Fri, 24 Jul 2026 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784917812; cv=none; b=tXIHVR9crCwNCxutlHn6mb2DzJVM7UizND2UbMrhGyty9SgRuLfNslh6EvbEglGAQu3Ml8yEga45J/hq9ruEVkOtnpDUE/fNgUkDO6OZR3MQ1WpGoh36v27vs5sbYb7UVEyzXTisTdCNaQDwaDYOxSMy8t7OXfh+FtK5fdCIX4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784917812; c=relaxed/simple;
	bh=R25O5hzdVj2s5Nz8FUJgsRY/m9xnDrv/jnrI6Va9Q/M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BIUk32NpA9hSsw/LOrxCa8UP0aYJtN2QhnozeTSwHPjKEQxgNIgfzzY/CZ6Sz/Tjc3vK49+LNGXnRnsogWUX3io21JpERiiunCeoVcc9N0P/wieeBm9FEuJ/1d/2E+4kQd52VMVytbxGYWas80SNSNaJwKwFyYmCMgVhx71MPOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anpJquzQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anpJquzQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3121F000E9;
	Fri, 24 Jul 2026 18:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784917811;
	bh=bENrHqeBUO/++oHcf5TfcJpvoxYaRPkdZsxmqn8HVow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=anpJquzQNItNhOnCt3NyAnXSL3DxD2R3YPrKBeKrrRuNparzuzVepk2BzCFQQpjPq
	 1XDlTvhpT2LDletOQO2JKXhFWM8iEqZjkJxnkjA1XVEYN1s8vDkZX+EosDHDU6FK5O
	 bvznJX2l1BZsR+8lUUI0gZqYsDTg6WTv0v0CogK61IM3VW6Bxy2p666sTM/Q0IcA4A
	 nXivb1T7mFTTSzp18JQ90/gR8e/zXH0lCKhpPS12dQ8ZQryAaH/sjUCqdVzowPWzmG
	 Q/0Mzvu6EtoWa14zdY3NBo0ua8rzYgrJ66CA8jaM78g8YWv6+IUOazxx1HWMpzw4Ww
	 NmyoIUDJYczVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/15] s390/vfio-ap: Add 'migratable' feature to
 sysfs 'features' attribute
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260724161351.1802644-15-akrowiak@linux.ibm.com>
References: <20260724161351.1802644-1-akrowiak@linux.ibm.com>
 <20260724161351.1802644-15-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 18:30:10 +0000
Message-Id: <20260724183010.DC3121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added 'migratable' feature is not documented in the Drive=
r Features table, and the Limitations section explicitly states migration i=
s not supported.
--

--- Patch [14]: [PATCH v5 14/15] s390/vfio-ap: Add 'migratable' feature to =
sysfs 'features' attribute ---
commit c8392bd6bcb1403c66327e9551bbba5ecd4a167d
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Add 'migratable' feature to sysfs 'features' attribute

This commit adds the 'migratable' feature to the sysfs features attribute
for vfio_ap. This exposes the feature to userspace, indicating that
migration of vfio devices is supported.

> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio=
_ap_drv.c
> index 8e69ed286bb9c..4e973736522bc 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -26,9 +26,11 @@ MODULE_LICENSE("GPL v2");
>  struct ap_matrix_dev *matrix_dev;
>  debug_info_t *vfio_ap_dbf_info;
> =20
> +#define FEATURES "guest_matrix hotplug ap_config migratable"

[Severity: Low]
Since this adds the 'migratable' feature, shouldn't
Documentation/arch/s390/vfio-ap.rst be updated to reflect this capability?

Looking at that file, the "Driver Features" table appears to be missing an
entry for this newly added 'migratable' flag.

Additionally, the "Limitations" section in the same document explicitly
states: "Live guest migration is not supported for guests using AP devices
without intervention by a system administrator."

Does this patch series render that limitation obsolete? If so, should that
section be updated or removed to avoid confusing users?

> +
>  static ssize_t features_show(struct device *dev, struct device_attribute=
 *attr, char *buf)
>  {
> -	return sysfs_emit(buf, "guest_matrix hotplug ap_config\n");
> +	return sysfs_emit(buf, "%s\n", FEATURES);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724161351.1802=
644-1-akrowiak@linux.ibm.com?part=3D14
