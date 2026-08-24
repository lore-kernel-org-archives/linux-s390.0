Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7813A25A640;
	Mon, 24 Aug 2026 22:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787609187; cv=none; b=kVs6UtzW3qOjkejCGCk5OKSNAvxeqAZqUlm91HtPu7gu3qLChd6TLcsCG85rfWvDQZfWL8fTC+dNO+r8gIO2PXuL8Lxb2+2VXvUyZwkg+wLhivV55GDtmQTNlkq7k8hcNhrYjFznB94tWf/IG3EYcKf03HvJvz1S92rbbo5PMl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787609187; c=relaxed/simple;
	bh=aOygqbOzAbmHy9BCdDTUiE2YMQJpLHiPC+Kd4xvevGI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X+8Jli/xb5p8BcDRwhR1/yHUti+Cugdbm92v69UJ0bp6ivqajIRl4MchizsK9WdzgTQga1F0zW+VxCZL2Mn4u4m0wEjWRu2fpcJ4GiO14f4FdNp9iIADcCPp6jiwSCDNbSQN/6yy9P9RNrzSSOX/9neNypMqMXr071DmxpxewkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZtSr5TH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZtSr5TH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BC81F00A3A;
	Mon, 24 Aug 2026 22:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787609186;
	bh=aOygqbOzAbmHy9BCdDTUiE2YMQJpLHiPC+Kd4xvevGI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SZtSr5THL+h2f9GZYKWV13dGmnj6Wr+3SlH3xoA5jnDy8WoMSydqYncdz5Gr1uGT/
	 lFZb7CvFmNnZ2eQ2wUaLf1AZPVx2Sa39FBdyWctF13KJ0LabFpNs1n0JYX4jj08oyM
	 KkBXqkvr1USL0tQP8SPcj+BGlyedgmPAiWESVLfrTIaPv468LwNgySWANmPpZI/DhA
	 WArdQiJPuvjpQh1EkmXAUl6BkanJfr+eAGeuOc2GQWmbggecS/ja1qJ4g2Ioq1MTiK
	 UZ1WRkAqKhRvk674wqsPnixzgM28nCdUCYJRfvy9ie6jZMSEvrg3a14hGqY6FVRPbB
	 8g0IUglvAn2Zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap
 size in vfio_ap_mdev_cfg_add()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260824215603.819379-5-akrowiak@linux.ibm.com>
References: <20260824215603.819379-1-akrowiak@linux.ibm.com>
 <20260824215603.819379-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 22:06:25 +0000
Message-Id: <20260824220626.08BC81F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Domain and control domain bitmaps are sized by the AP_DOMAINS constant, n=
ot
> AP_DEVICES. The two constants are both 256 today so there is no functional
> impact, but using the wrong constant is inconsistent with every operation
> on aqm/adm bitmaps.
>=20
> Use AP_DOMAINS to keep the code consistent and correct in case
> the two constants ever diverge.
>=20
> Note:
> This patch was submitted in response to a sashiko review comment pointing
> out there are other functions besides vfio_ap_mdev_cfg_add(), so there are
> fixes included here for those also. The subject line was kept the same
> since this is in v2 of this patch.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824215603.8193=
79-1-akrowiak@linux.ibm.com?part=3D4

