Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5059B46AA66;
	Thu, 27 Aug 2026 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837426; cv=none; b=MArbqfKYFaWnEXpgBjiJKl2I50eiVUGeKQlhB46ZDgIB3lHP1FWhIJXIe3Ch8vaQDcsMdw+H4nIQOKoAyY2xE3+wgJMyftFU20WAhJZ7BYGNXQqy+3qK9jq6mxw1OJT7nwJcNdRwaRv3Uk38uvjnqZgpl3NK1PMB3bodh/R5rRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837426; c=relaxed/simple;
	bh=tqnr9Vb8PSXuBCPqr2aXV85pQZBIm2Q5btJap21q3KA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ry+gBbORt48+4JPYcGugXdD5jhf7u5OR9Q26zDrnmR+AM+UIEukCqKrBcjnoTzfSIwylIcTLRwirkCwDYOAqIyFXEi0ArjLBiMWo6h4ubhGQQFeyVFBwFcI8Uc9xdpeCO+aQfXSX8kUlE/xo1OzZ0Kwx69njZIwXWJVhl2Y9/M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XulW3MrB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XulW3MrB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CAB1F000E9;
	Thu, 27 Aug 2026 13:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787837417;
	bh=tqnr9Vb8PSXuBCPqr2aXV85pQZBIm2Q5btJap21q3KA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XulW3MrB15xIWK7DTI23Vfs8KZFdQtkHn1nZXE59Hn6HCq2tWnGDg5nuwQzAoMQUg
	 W2RPloFMwinILP5js0vnySp+2TXQEN+Poh73FqglSO5qeIQakIZCjlwZrf3Fyw5q4q
	 tPRs3XCUeR/Mmk7ggjqKJEiIbeCk3qyZXH4Qkj9unBuVerDK+jANW7tB0dtN2ZA4Kt
	 EwqnTrQf9W0czOoXqKC/kjHSMmHrx+X2UQ2sZOOoBeYC/i+hy9XNzN4q3gsXmCZKaD
	 30fVYEGRM6gVumEboVE9XEPCb/QbUZ1P43VtKy9wyZnC7YoV3acbqi8LJuLR84Biu1
	 9GK/8em4GID5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap
 size in vfio_ap_mdev_cfg_add()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260827132441.555866-5-akrowiak@linux.ibm.com>
References: <20260827132441.555866-1-akrowiak@linux.ibm.com>
 <20260827132441.555866-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 13:30:16 +0000
Message-Id: <20260827133016.D4CAB1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827132441.5558=
66-1-akrowiak@linux.ibm.com?part=3D4

