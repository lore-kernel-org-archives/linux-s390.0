Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979915;
	b=xz6Gc/ZWWljKgAgfZRNYC6XJJPvnz+s+mgV4T9g20tiiQGU6gxejzK5oSLiXHMAh5rsp
	 usm/GZjcz4J8veA+wlXtCG5BBS0xn3OkbGNZQ2hEGcgrOxz53VawX5OrHei8lxnDugmC4
	 /u66SGsPxIqyixAkvYdqNCqmOaBbJ2XStHB08jWqI0gpBuwS+r1QOPA3CToA2WxINOUcO
	 Vda4hoyPCUTlkDJNNqPRIx2ym25c8A1jQbNMp/T08lGeow857k8Cr5W98DRKv0ioVqd2W
	 bWH7xbTZkzqj93cSmIaqFjRkFLfnU8c25+GnxrznInFHrKK5i50Cfsb6z2DB5RwAhYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979915;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=f/pm2nQJN1juSuynS2mAqdabre8bTE1mz/ZrgIXcZcQ=;
	b=TI06qO8vMOjR4EqwSjiDTlpdSqz/39W6G5qZDMjfIKcMZeCXBT+TCEiXEoT6cJrv3btR
	 36wxNd6YdjKPan9EYZ0T2nFL8bwANtC+NH0hxvkBXOy7AK5EvDOf3yQaKqPYXp0efxvLC
	 81JASwdILye5JAMUJ8dKXulyWGLN5ceTxTLw5Mz11/oBOFxuZ9ti8a3138TCcnJ/oF9an
	 QRMTUVm7W0irblqkxMaAgYrMwDXVQgRlr2G1TdfUvcYGhNKFdzsE5rpyRdOrhzwfgnyd8
	 YlxZAbTHz9VCCqv6/jFf9hRQCQ/LGaZrcaylSFiZhe+/6uz8Awlf4Ps/n44vpkD9YTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="is+/d0yX";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5531606A329
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=is+/d0yX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153F91F008A2;
	Fri,  6 Nov 2026 15:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793979914;
	bh=f/pm2nQJN1juSuynS2mAqdabre8bTE1mz/ZrgIXcZcQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=is+/d0yX/KdH2okNuuZWYuxVag8gHZOC62KkV2rLHlwqOrREMa+a+1R7/pCVDAmlL
	 XujVqM0D/tq0lz93+ZIu56w8JkQQnDlQkUyrVmB4nYeb82mtQaxD9aVCSWn2Y9TLat
	 ZznC9TqOqrN4NgACxy1XoPhuPZbcIvaf+5esjH4r0j7IwBPW+99bKe0XNsakpTXYml
	 RRIKounr1sOmLgvxe6g6tVBqSdhS7WFNCcO24AYXmfRwryNjuxcgXe5v/tusJCdLCl
	 kW7ABD16BPzi5hWmAvYGZabN6S0bsHJohgmaiaSkevAnPf16+9RWGZQa+IHCB4DJ6+
	 aVrAOjBuvjvpg==
Message-ID: <sashiko-outbox-201726@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 07/14] s390/vfio-ap: File ops called to save the
 vfio device migration state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106152259.1360651-8-akrowiak@linux.ibm.com>
References: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
 <20261106152259.1360651-8-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:45:13 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Implements the read callback function that was added to the
> file_operations structure for the file created to save the state of the
> vfio-ap device when the migration state transitioned from STOP to
> to the STOP_COPY state.
>=20
> This function copies the guest's AP configuration information to
> userspace. The information copied is comprised of the APQN of each queue
> device passed through to the guest along with its hardware information.
> This state data will be transferred to the vfio_ap device driver on the
> destination host when the state is transitioned to RESUMING.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106152259.1360=
651-1-akrowiak@linux.ibm.com?part=3D7

