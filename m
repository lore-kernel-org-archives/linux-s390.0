Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827761;
	b=vMruhdUHexq9GQEKRc18N65OJWdWsIE77GQLzGAWriiaYFpMFOLO/BhZFOo2Jt4zau9U
	 luA0eUEMkch8kAn9H0xII1NZQab/kp56CKG/w7AMb2qsLiL6O2L52IUal1HcfrhWO+Gqo
	 m2or6yUKmi1mpzIbj1Xkntb3ZVeeS4fY2UpTB4A33rNL20GwXmB2gxIRZenuQ9Bvt0wLM
	 kPG0Dpp4kSjLhrCAjG8VcuciRapsIEwL10ThKPNBQw0bKSOL6yUKUZuFrkhFzybXwKMJ+
	 IqX9KcOqFxQo1aF/DWeZyQ8PSLWFFVh44FASPDh4vjVXAeTBoRzrY71eJMy50usTFTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827761;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=T95GmUvpCOf+m5OZIWMhzCjcP3n5LvBVhg27WXIuhlM=;
	b=mZGPnsr2TG3It0MKmqlc9aKVuebI5j89CrsOKEbwpebCSGi2DWwc/G69DYN5fV6/KKWg
	 YOm64zoNmQ2fqO/uxW8KgVvu8K2R2a25TBCy8O55S0btsBRJkw7iRXCx8UAPYjmRGVd8j
	 p9lUT4wG0z0oHef/hBFW5n7vQzsfWHjzU/yWyZjlCDOt5GgrdzzxM8IBEOas46EMoCz/Q
	 VFBuRjtcfYr5TjkJRR3ykRD5RpVoXCLlnpbDDuU/ov/O8ctokvAz1ELJZ2TvEnS+AbuzG
	 4SLaN06HXSXvEdOSdyumE5eXUbj9PbVJb8qRZkVPDTBU7wNbDtoU0OYkRJCNQrA9rvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMgWSr1P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99DA606A8AC;
	Mon, 16 Nov 2026 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMgWSr1P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95EF1F000C6;
	Mon, 16 Nov 2026 11:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827761;
	bh=T95GmUvpCOf+m5OZIWMhzCjcP3n5LvBVhg27WXIuhlM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PMgWSr1PesLxpLQ/FTuIxxUMFwE2q1BO82M+ZuiRVU+OzxYFzsuZYu/6qxV8CjO2r
	 /VAe8U1UZgyPksI8qYNCPJHRCzCc2eSN/zFPrqyObO3SzqWT9auhEfi88KUoP9lmX5
	 63a834mW+sP8r1kXRIT/6mlNYJmMfXuw2IMDExLR6ckRtbLGfq9OzUlaY711+ej86g
	 tWhG3vbRP9/jsXwnvTiI9o0S/EzGwWkOM8CSJ7TzHeYD07PwyIr9/j4wIwF68bl1SC
	 92mivb+7HbAYSye0hjzY6CZJCJQjZCQ27BJBROuZsjljsrKgydFc5vv+X3SNxME0jN
	 4dRZ331sUlC7w==
Message-ID: <sashiko-outbox-216868@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 08/44] mqueue: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-8-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-8-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:16:00 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize mqueue as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D8

