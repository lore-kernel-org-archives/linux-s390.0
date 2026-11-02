Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641167;
	b=mCRkbzYNn75bG4Ds+roMGslnuk2RDFcSP95/zhQfQ5+3BTaaD4/nZFLLhobIgPn4XT9k
	 hBOizGkf4zj7ZYnCGwNoJfi+KF5936heeELPmYwlojiH07cFjxRg4URbzlhtjq92dWjdW
	 gAWux1/lB5Hp+tuJsV0kLeWSEqumhg9P9QDrpL/SQXsKjJolZsebmsrbNK9pXTReI6luI
	 TewicUmU3KH9oeM8e2zxLpx5lMTLesEId+hU8BauMthStFMoJnyRJlId/4rEz5zesw6id
	 YNX+l5rvGvczgc3LYQ2yN8SBOCRo1OkMq48X3V3ZPALBw2wRCsATVlRgig3XbruiyKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641167;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yXuj6vkLJBPaCLALA7gxKChzzklN9VxoES3eaAtsFxc=;
	b=Xgzy+KPQp5/FcWlx+z6+U8dJkEsR9NbVsGWRliUhs/6g55hUHH6OrCPGjVtHWKeDkkCe
	 kenimBpJa2meu29kkWd+kVn43YutITVJaer6GvU5puBRuZlHiLP/xIeaF7WQJk7/mKL7a
	 d3i7sfygtXmSwiBQNKWvhxGWygQwU8xyrRNJ2RVbYfqjvLr1NvS7pYKonUs/bEQ6wdCRz
	 JXGG7dM7+cjh3gjmEaAcUp5mdqBsVkKF/XbNSrzphCrxRCK10uySPzeeyzxG5gcSM0Tgs
	 pLiM+PMFq0YfEfT9ahYqzh+7/uBAs7MPorQHcakEXzE8UnXZ8OAmyVY56o5MytFTmew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f3V0DF1C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C103C606A90B
	for <linux-s390@vger.kernel.org>; Mon,  2 Nov 2026 17:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f3V0DF1C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DD41F00A16;
	Mon,  2 Nov 2026 17:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793641166;
	bh=yXuj6vkLJBPaCLALA7gxKChzzklN9VxoES3eaAtsFxc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f3V0DF1CR04cNGUIj2o45UOQHi4ZvyC1swQeJ0MBxAoCu5OekBmALKY8NXOI92iCU
	 rr49gDX51kUO2Z5RzRU9htSUf1jalVFk7Fly4XZxO2wvyxJ2iFVJoId/FUSjqVitoG
	 GgVAy34coMRYJROThtYb6U8BZko/sf3Z/bZXBuQQORv3dKiIeyT45SvrU0tq9BUyj8
	 feysoFMOsIas/vYE+czXNOxluEOXdrfpBn0NDIN/hnkIav7CafNdD3CH6/FuatYev0
	 3KKQtGflF8oAn7oY83ZyqkAOlqdyzLpgUK7Z0Sl57ygL7Ac/aesjR8NFk+Xv3VFN9v
	 GW6v1jrJN2OdQ==
Message-ID: <sashiko-outbox-193851@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 11/14] s390/vfio-ap: Callback to get the size of
 data to be migrated during guest migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261102151604.2150055-12-akrowiak@linux.ibm.com>
References: <20261102151604.2150055-1-akrowiak@linux.ibm.com>
 <20261102151604.2150055-12-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 17:39:25 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Callback to get the estimated data length of the data that will be requir=
ed
> to complete reading of the vfio device's internal state. It's mandatory f=
or
> VFIO_DEVICE_FEATURE_MIGRATION migration support.
>=20
> The function pointer for this callback is specified via the
> 'migration_get_data_size' field of the 'vfio_migration_ops' structure
> which is stored with the VFIO device when the 'vfio_device'
> structure representing the mediated device is initialized.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102151604.2150=
055-1-akrowiak@linux.ibm.com?part=3D11

