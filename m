Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7668D426694;
	Mon, 24 Aug 2026 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580681; cv=none; b=G9hlDr8Q955j3bIq31930ZR/ziabwrz5369yJEq1crMyTI49JSDtkH77LUWn2Zodjn8yr7TvmR7ZKqE3/dHVkxwdEOpOUBaV9+HpP4Y4/wn4vMcFRItUcBO8We+Exxv5wz7BqHznupkyEDuuiCzkKF64f8QXK7OCGgId5Pn5WIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580681; c=relaxed/simple;
	bh=b6SyPvcoegecL/KFupWyxjc3SsV/5j8jK2wnErHOLFM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X3ZYNiIUoeAjI6ckd/8il1Xdct2qyV69NSN0QHBoVgIQUbXnwsDR9wg+W9uEsw1ciygEz8xvX5ffmKaWWTFuJIIykEO7oFYDx3BxmndfgilNRflKCSG//M4TUl8gloVd0Sz4bn9j3+XVvHRlWo+puY0YHf/VghNZ2KPnLZpV8qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1B9IY7b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1B9IY7b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C19C1F000E9;
	Mon, 24 Aug 2026 14:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787580679;
	bh=0dRQeo9YyeRQLXjoo+W0U0NYvjaGkUKnDorZkkWZPJU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c1B9IY7bLV6aCKcyFoA8Od3DYxzToD7/HtoZyNuuuRrJYtTVFKWew1SLAxCeCrZxt
	 asRtvof8qDKUuJYVVp+eZGNmLrQiCu6wRdsY00JxzcXgySbcj268vvEP5F5S7wQCxq
	 Mrj9olWhzbuxrLxQzBVLr8t5FOoVO0j3YKaLt5E6FjBh8SxAQy2yzhE8JtxIThwlrO
	 QFI5/RmnuvLsB82LE5RIZcnmXYU6WjjIIwrmUDIcOweYr859vDIQWYC2hOCKli680o
	 OApSMapE6hDeLOLbxgZcfMS+tafvaRu4RINxjTShq7+m+lykhvS6wYUL0rGfbONtwh
	 LBFityRYDGTQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap
 size in vfio_ap_mdev_cfg_add()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260824135850.503728-5-akrowiak@linux.ibm.com>
References: <20260824135850.503728-1-akrowiak@linux.ibm.com>
 <20260824135850.503728-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 14:11:19 +0000
Message-Id: <20260824141119.9C19C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete Fix / Latent Stack Buffer Overflow due to Inconsistent =
Constant Usage
--

--- Patch [4]: [PATCH 4/4] s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap =
size in vfio_ap_mdev_cfg_add() ---
commit 35cf2442d556c90b8b97a43b8f409fe51d21bae0
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap size in vfio_ap_mdev_cfg_ad=
d()

This commit changes the bitmap size constant from AP_DEVICES to AP_DOMAINS
in vfio_ap_mdev_cfg_add() for the adm_add bitmap. The change prevents future
issues if the constants' values ever diverge.

>     Control domains are indexed by AP queue index (APQI) and their
>     bitmaps are sized by AP_DOMAINS, not AP_DEVICES. The two
>     constants are both 256 today so there is no functional impact,
>     but the wrong constant is inconsistent with the two bitmap_and()
>     calls immediately above it and with every other operation on
>     adm/aqm bitmaps in the file, all of which correctly use
>     AP_DOMAINS.

[Severity: High]
This is a pre-existing issue, but does every other operation correctly use
AP_DOMAINS?

Looking at vfio_ap_mdev_on_cfg_remove(), it appears AP_DEVICES is still used
for domain masks sized by AP_DOMAINS:

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_on_cfg_remove() {
...
	do_remove |=3D bitmap_andnot(aqrem,
				   (unsigned long *)prev_config_info->aqm,
				   (unsigned long *)cur_config_info->aqm,
				   AP_DEVICES);
	do_remove |=3D bitmap_andnot(cdrem,
				   (unsigned long *)prev_config_info->adm,
				   (unsigned long *)cur_config_info->adm,
				   AP_DEVICES);
...
}

Similarly, in vfio_ap_mdev_hot_unplug_domain():

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_hot_unplug_domain() {
...
	DECLARE_BITMAP(apqis, AP_DOMAINS);

	bitmap_zero(apqis, AP_DEVICES);
...
}

If the constants AP_DEVICES and AP_DOMAINS ever diverge, could these
operations cause out-of-bounds stack memory accesses?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824135850.5037=
28-1-akrowiak@linux.ibm.com?part=3D4
