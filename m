Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662650;
	b=g+MLhO2DPU4EdcjR76OOi110Yycm3b3TIc7pFuMPKnjf/7uSBSWPcsmVY9iZfRpKUh5U
	 CIwaouBn6kKYOmzggQZ3lf48TApb0dTkopVWBSSW4NvTjJ1rBVSA4qVjmxk/lfCmAD4IC
	 z2U6m0iLwLkDVoO5eSqY65hiQkjh+WMv5xSHhU1Ycs6OURHthWAc2rGnKQcPHxEL1vpO3
	 NIttc0LwQNvG8S6wvGG+zNqKB7r3P08MSaY05dhStLn+YILl6Qdt0hyweLEvh6pRd8Dst
	 PL+ygNmbBaRL5AeMyZsjQ+7BctJxw+Mt3EYWmsov9GTmq4gq/vdFF5g7cUtKLsXn3Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662650;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+V8r4ayNzrlink2djkXu/RvouFdNuvqL0RnYeJZiyBo=;
	b=5WR7WHWOPhm0CE29bSvxnLJ2e1ajqgTKdOvlIpFYZr36KAHeAF+dEy+JRNOkDXqUIXZD
	 txi0oghu/GXx/P7tp8y0jLXx2tpVUiF8aTrw08N7HHJq0miKvtBtZqff5cEDla2/UmeoD
	 KtvAJo3CufnAO4YSHpwnGuRj/fknhb5OIFtWMMXZHs9GWQE5hUzrz2E6ypvfWliAHMxnw
	 PBNr5z8YiAPyPFoN7ZxdQgqaza4PnbVzaAVcA1vRQM5f5NhYarf7LC5e+0lZnE8xFlS2R
	 UrCrFJ5zH6OEBWGajK4ENLNpE4+h06ak3aB4RkL1o07gpdneBKlEEEqmu5jHCzkhXpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UvHc++yD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85012606A323;
	Sat, 14 Nov 2026 13:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UvHc++yD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9006D1F000C4;
	Sat, 14 Nov 2026 13:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662650;
	bh=+V8r4ayNzrlink2djkXu/RvouFdNuvqL0RnYeJZiyBo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UvHc++yDbvtxZ0l5aG5Ral/10bq7RfNgX3ryxGhrIrDjniuvRaOQF3Wx0HoyBrU+7
	 4CeCqupzl0ceJLrHdz2eCur2Q8MOzbdZ2xB1P6SuiYjCAFTzEI11vX2k5Uqbt7rpmk
	 JpabvlLPYK7bBuN7VhqDiOPb4qBcKB198ihXYTw5npm3FToFGA5/4u97WdDT9+QEoL
	 0V9EPsF+eQPvcir2H+Jxbhz3FwolmBSUBZTInMokXzYgVm3bMjTyIqq0MDq+SyLUcP
	 YAhDQfC4NrSPgB/+EtILSAVYbyY6RGuQxIYsD3WQKJmaRQnjpsg3TazcmjI2lOYlkq
	 PKSSTuwBAekLg==
Message-ID: <sashiko-outbox-214562@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 40/42] erofs: refuse files on pseudo filesystems
 as backing files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-40-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-40-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:24:09 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> File-backed mounts take any regular file as the image and the same goes
> for the extra devices of such a mount. erofs reads them with the
> credentials of the mounter so this doesn't hand out anything the mounter
> couldn't read anyway. But files on pseudo filesystems aren't images.
> Refuse them just like loop does.
>=20
> file_check_backing() also checks that the file is open for reading. So
> a source file descriptor that erofs can't read from fails the mount
> right away instead of on the first read.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D40

