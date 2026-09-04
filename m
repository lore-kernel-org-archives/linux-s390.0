Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E837C37882B;
	Fri,  4 Sep 2026 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561997; cv=none; b=Waj1rTpVBqOJ6IwlFpp9NTeFZaFM368RpQsYWqG9ox9k4uGGmCSHJEPcMJ/Wr5Q70QfYc7J4UuqLRxYZpnX66PviUoku5kfkaIDRwi5STgLfb4s5HyLLpCO2Jzt4UG/usEcBG8Ct9YrtjdZaM77eUSxK1xl1uHRVVa1/wqPufJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561997; c=relaxed/simple;
	bh=AgZ8kjcEW10tke+lRA1/R1eMu0bpuJIZ9Xbs4D8jGUw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jq6/U215YrUxAuG5Jyh8dQvUVepQ5XOTvE4pzDsnchkPOJhAzGjWZDzcr+JJoKwelC4n58DKZuQG8PPyVPWAI/J0fd9AQstzLPsM+vpmOXRcpm295MBxBjP/yZOQt1rYEfMmVtXa44BCmU8rjYUfw+lazX60H7T09BJvdelgNME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMUdVdIy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMUdVdIy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67331F00A3D;
	Fri,  4 Sep 2026 22:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788561992;
	bh=AgZ8kjcEW10tke+lRA1/R1eMu0bpuJIZ9Xbs4D8jGUw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bMUdVdIyIC0TK2DScU59UvZNZcK3ZPj3w0xZxBFx4+jGSQpRo9aF/CgyriHrWHXAL
	 iUVftC5UyLBsgf2mOHuCDeUas5I0iTsPoxpmoJKS9T6OY667tK8+kD99mPt5ojCprr
	 7lRUxlSIfE+NG9yYrpFUrXike5+ruqCOvgZXWKLcdO/whuZfRfX29iE0tLlzDgrukB
	 vc3TUov+N4rt4fkSCmxhXUINz7wH9luJn9PU/IR0gJzaIHgONMG7fUYs6DSCZ5fI02
	 I278TsmWy9LnafJ1eytX//eFn5pUJmYxkMA5hvU0gz0ZzOIx8u5OrWz1C/YAXaRXRM
	 XtxgHzqg+vmfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/6] s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap
 size in vfio_ap_mdev_cfg_add()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260904223531.1611088-5-akrowiak@linux.ibm.com>
References: <20260904223531.1611088-1-akrowiak@linux.ibm.com>
 <20260904223531.1611088-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 22:46:31 +0000
Message-Id: <20260904224631.B67331F00A3D@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904223531.1611=
088-1-akrowiak@linux.ibm.com?part=3D4

