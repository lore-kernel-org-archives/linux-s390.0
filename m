Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634543;
	b=PygVVScxNvFN5PDBGakUrnk3hCS+u8NrAy4aCes96TncDedkqLuwo7/Ug7H+OhStXsMc
	 i7al6YS7eOoHXMGRNOolAwNXhJsV5Ao41FYWAPka6g95/m8IOMBNAurBaw65KqHFkE2+E
	 3KxoYtxBHmJKBaJ1CO/ghzOQ+m+yDYli5gujN5yXR5qqe886Jk4rmMwZBoVmbBYsl7OLg
	 5l5I38loDRy2Oa6S06t1m9krd9pB/S91Kko+Xxkwlj9wKY11nFozJQniCfsKGhkahOC4N
	 8L0lL2UHsGsUEMgS3XZK+SspH9+XzyXXseAwYw4DNDCGc7wEJD3VL6TMEgOW0sDW6/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634543;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yWNmP6m1zOkBxAp74lv30qYCaaaN5W6TbJEGkNvkpsk=;
	b=xp72YOAM1tUiwNVqca286ym1E782Xs1EnWKM7SNE/YmIiEF+rbt4/X44cZFCQgyOJk9t
	 Cl8TU3wqsSreltcAzjIyofCgAgx3l7dYCTMsmIvdjJ3W/oo9u0yMtwdI+ppaGnKsqSNRF
	 pWx/fjBQgwPJCZH/UaxB1XHRmdLwV63OUgBNimGXdAJnhv0mGFoCm9gVJDTsq8781w8/0
	 wEpUzWRcUJ2E7J6mdlWF5rXkiO49BR+FGDIhmcsIIl2nJDaR9kTGRDaP8lDitU9SvnY79
	 5Of0APTkFHwpsGMXdzk+ahN0LoMn6covbkrnr2CQS95Q/eQUvblN+/af1W02rCIhbiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ekyfsM/l";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991206078248
	for <linux-s390@vger.kernel.org>; Mon,  2 Nov 2026 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ekyfsM/l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48C21F00A16;
	Mon,  2 Nov 2026 15:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793634543;
	bh=yWNmP6m1zOkBxAp74lv30qYCaaaN5W6TbJEGkNvkpsk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ekyfsM/lg8SmIE+lPwc+wAtylRA6upfcCCP1CFuIgf54vgkB1r1QtINyw3XAZaTEv
	 N8ataaMi0KF+Tmmu+PM3BQ3d2xjyWL1AttNZflXUWkcaihfXO7w06sU/8srPq+xaUl
	 XGnMgTyOiz2EZq7QGpMzEJ0liZdt7PvABNZUgDDDm1nOZUSazhQp0yURrkEzdV70QI
	 /Y5ADLfnteGZvsWcndA64G8Y3IQ77NYf60uDiUPggGuPVi5jSzf25mK3BZAChw/hpK
	 PlyvrZ3Ic7US+qsrkXowZXgt+um4FfVmcY9x9A30GsA6Mw8O2rxEuAbpt2vZPrZqIR
	 mO8wVvEIh40Lw==
Message-ID: <sashiko-outbox-193705@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 04/14] s390/vfio-ap: Reset migration state in
 VFIO_DEVICE_RESET ioctl handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261102151604.2150055-5-akrowiak@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
 <20261102151604.2150055-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 15:49:02 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> According to the VFIO migration specifications, userspace must issue a
> VFIO_DEVICE_RESET ioctl if a vfio device enters an error state or fails a
> state transition to recover the device and return its migration state to
> RUNNING. This patch adds a function that is called when a VFIO_DEVICE_RES=
ET
> is issued that releases any open migration file buffers and resets the
> migration state to RUNNING.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102151604.2150=
055-1-akrowiak@linux.ibm.com?part=3D4

