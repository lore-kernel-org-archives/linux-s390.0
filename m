Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429002;
	b=5EMcBZAjkvwgg7EQe0iIvFlErTeWCf+gpqEeTFYT0HL7zqW8Jc+akba85QWM8lWHX+Z9
	 hH7RJ4en2+mnG+AZwrcYMV66V7T0JySA0UR9gF4ED3asxxMQ0QkCUjcp245I+kecMTy6k
	 N4hRHyId23CuUNb3bgfZEoH9ME96SzyJQXJP6QQRjq6r09diMRduoOkUwK966RDAb39KX
	 GGystXTbzLOE5fg8pqiBWh2VctzWEmaFOv4t9RWMNyxwccyvF0AT512FoNCCpF/4AMX63
	 yi9m8WgHikwmA1HkO/kb7Ax5DXK2ClX0QNvexXRqCSCvZ3hWlfHGzIlABn2cdpiiLNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429002;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jyYhalhzAX7JG3gxwsTsSCV3hTjtDMOqB1R2woMXsHs=;
	b=HD1ES5OvtMYjdG8Di+D5VTEABx0NzJTjFUpuZ4/ph8dJph7HdDNrf4r8tkjQ3dCSGxTI
	 KB5glxqWhLOKVOrpUPxtW24HwuqkVxztFKAkPKlnCAZbiPdo2QK/LIr5+u2tNqXrxQiva
	 KqDzPdGu6fewMEZNRyXxsNpwwYCjbsrdjp2yr0qixFPgiWCXn4Nr95QAxGt5JEpHTz407
	 Spo3WFEGbv4mm/st9lIk6CeuK5DQn5hSOQlTuDMOJBu123IuR5YB/CslfYJDXANQNQ7LC
	 xfQxr0Nt5JiyjGlOd2daGX9Qmzb/wNdsXPUxDSrPKlcYH2yyXxaL/r9pBCcb+E2V7ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J1UWWWss;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35724606A321
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 20:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J1UWWWss
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E0C1F00A05;
	Wed, 11 Nov 2026 20:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794429002;
	bh=jyYhalhzAX7JG3gxwsTsSCV3hTjtDMOqB1R2woMXsHs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J1UWWWssnjUK48RxYTYpwhxLseKSyOgwl2KtAV+K2qnoI3DT6KrkqHDXeS6g2fJ7A
	 4UYfFKZfapZ+3bRt4QRM9b4BruLc10NS4gVySf1fyqy+zB8kbQ1iyageFiv5D7lR4z
	 VLVTr3eQPcxM+oKJ1YJPcMrDiCGp1+wFJZmimOItsHlU3KG0MAJiazeqoSMhUHU4Vi
	 KjZRqlAEj5Pkoz16VMNtWb7uMahGjMqwzLXoloWnkyDGMgW1kNvC7s74Wc0OJH2KRW
	 JSNAkyePsS8Pwa0A7/FTTr3JA5Y+wmnMLwjQXx865o11nZrZ6FkcMIP1wgNszjP/Pb
	 n/5ZplnpGmUqA==
Message-ID: <sashiko-outbox-209667@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 13/14] s390/vfio-ap: Add 'migration' feature to
 sysfs 'features' attribute
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261111192308.2585984-14-akrowiak@linux.ibm.com>
References: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
 <20261111192308.2585984-14-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:30:01 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add the 'migration' feature to the features provided by the sysfs
> /sys/devices/vfio_ap/matrix/feature attribute to indicate that migration
> of vfio devices is supported. Since live guest migration is not supported
> for SE guests, the 'migration' feature will not be included when the
> feature attribute is displayed.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111192308.2585=
984-1-akrowiak@linux.ibm.com?part=3D13

