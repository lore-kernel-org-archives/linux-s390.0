Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794303418;
	b=PseFyzynMT50Dq/P0CV+238GYa3hHn6KsvU4udrNvt0zgElrcPCAeHIj2N9197pFcCXY
	 wS+Y0fLp/uG/Ps0eKGVxhib4gmvlwHitJ0M+WJBsNbaImKVZiYYS4+fWvvK44uulCbaAH
	 6NfSepqWWVjFVz4av8T96NQzR8yh5GdGNbet3Zyuc5ttOrsFi+LnyfbkyZ7CxcQ8Xgvww
	 C+mAKskHf/Jp8z9f69GpIWapIEoXvxZJDlIb48e3gqsOroxZZbYFWry3wlYBh8++pxP6p
	 mO3mK9S59mYH/BcmZkaNxPrAB7fxn3Ekd3UMBdp4ZZTMbNQC/qInSD4u9f5H/G9skUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303418;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jmISzwnri3fuvNL+fVrm7rCOzRIqMFYgsnVDWUvmGvs=;
	b=5A9hEq5EaZbw/yI9JE6dMMnkyNRZJQpZ9ltUf4SfxQ2WVK18MD/FPiZcNXFPuUrCdhWs
	 +IpBciBWVwa51a83KdOJz0+1ZpNas+84oeBwchSYIfACOYWSzLLdkzMIaRHNDDCc/d9lX
	 zW7UFC90iHFfMHZCbaJ4Q3RF2aQZTHuFZu601MEBECjOF4B9nXt7yWeyZ1r3R1m7OPqqi
	 pagWxmbTUGE9b6fryg/V7p1Xtlwk+QvIVw2fMHDG19ig0GikwvKdTbQz5mAGgNyrKfnaV
	 QcohGNZb1zxiCy5wc3+CZohHR56nMoqV7qaMoIqFjSbOmCAC9oglKr5l/x5TZmR/09w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U01oBIVX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CDF606DAAE;
	Tue, 10 Nov 2026 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U01oBIVX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55351F008A1;
	Tue, 10 Nov 2026 09:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794303418;
	bh=jmISzwnri3fuvNL+fVrm7rCOzRIqMFYgsnVDWUvmGvs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U01oBIVXIS6618sYQFfMdHaL5FgNwbsT/bDU5+7/RNEXMvt/NX5UkwStHhS3lnpg5
	 l4PF25GqlNVf3nEssvMgknnnprh0PogyiBI7ols2gEqlldy6yfWaisP28uGQzKSZwz
	 obOYQfyjAN3xdHkExnW1kCCkhsGTZX5fIdDgnevMaH01GR7e25yLITjdgXabzQwpVe
	 lfAL6OjDKel3BTQx6uILgk5PnRGJxsYCD5bVrPofFpw7xSTwtVZxkX4AGEmDjgdMzB
	 KhXApNuxmYP5EA9a5PsxBKECdQNBFj7POx9wFAOVR3N48aBlS5YTlsZcf5MIrg2sfc
	 5ljJ1TD3Hnmyg==
Message-ID: <sashiko-outbox-206771@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 35/41] zloop: refuse zone files on pseudo
 filesystems
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-35-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-35-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:36:57 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> zloop opens its zone files by name below the base directory but a bind
> mount can put any file there, including a procfs or sysfs file. Refuse
> files on pseudo filesystems as zone files just like loop does.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D35

