Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302983;
	b=2qruo7G5j7oZFYhaiDk/PTL99PsazPIrsc+ZeUaF0/D557/UcLzTZu+7qGBOYqbk2kL8
	 gwetj8xrCaWqj/s1OffIEAYnQSyqmmZxSOqp41TlE8VKdRUhDCbBZ2Ujfj9XcxWRCH+ks
	 flJdIWHBGM5RR293+/Q2I+es/yq9zotFFtgxwSJm37lIMNm0v/+HIwbWnTy930bxnsViM
	 9x3aHYEouMgQSeNU+mx/TxNv3GAXzu4U6f5/CaoHozZIekZBI2Yp5dVFy724vd1DkHkX+
	 YtWpb+IBwwnPOGY+Pri1gM4l0GyW8ktz/aZZQdXpAyN15sL108P8tqWVMuTNyjB/KPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302983;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l1oBAuJNTpnSLKo8aNMVa3sFJ0Kfo9FyOtGOiuLkmJg=;
	b=K7RriC9u1AeS3xNxBBtJUuoEn+cyoOUky45swHQjWxAoS0kSbl47kPDpQrKlMm+sP6Mp
	 UGh9rnaehSeArQtO4iDO/0QoALJZL5kFD7+0qF837YJebFLRyM6MceI8/PjTIvRjXmct9
	 io1QrTYQ5Ec3M4+0r0tgybEWQbcEtIRnBPGFs0SAHs/hcnQtpGjoZoxZu+p5r/Snqk/0F
	 rEpa5QTioMQ09UNZ6J1qtKc4ti35IFn7ZwK+KR8F+nrDknQs0ZiWD0xIGZiAb5EkCSXRv
	 1UDF+In+8TS5PsqeFTz/1KEjy/cQhPfyMEb8uf8v7s9uH/xo6izMhxa9byA+511duWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SscateFN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F281606C65D;
	Tue, 10 Nov 2026 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SscateFN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D681F008BE;
	Tue, 10 Nov 2026 09:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302982;
	bh=l1oBAuJNTpnSLKo8aNMVa3sFJ0Kfo9FyOtGOiuLkmJg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SscateFNK9IPN8FQBVcFdsgUT83abd8bXMwufOw5Z8okh+z5qeo4PH9uKEqHDoSgS
	 BspFaZEjbC+F8822tXCPEsdp4ACBR+Z2rOUtSJaQOTOaseoOrM9Odc+QTgS/l438yF
	 uNhAMaeW11LouFcJxPs3Q8XSdu4ilzebLZL5ZrPIsMrPmaNwCTKQ7pBlX+h/nuBbWF
	 hl36h1L4pv/ThB10B2AsREJvmFlUpUn+3EFUFyNg4uvpmqRBBsTJiH/j53CCkF/Be5
	 wEfOCtiLLzZF7T1YCH4ADzOgKOEU1HCdtQKxc2BPbRA/DffR5luNyCN9S3ObY6NbTo
	 A/L45bouWvVHw==
Message-ID: <sashiko-outbox-206760@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 33/41] fs: add file_is_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-33-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-33-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:29:41 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add a helper to check whether a file is a regular file on a pseudo
> filesystem. Only regular files count. Device nodes on pseudo filesystems
> such as devpts, binderfs or the block devices on bdevfs are what they
> are.
>=20
> Look at the inode that actually provides the data via d_real_inode().
> overlayfs accepts sysfs, cgroup2, debugfs, tracefs, configfs and
> securityfs as lower layers and reads of such an overlayfs file are
> served by the file on the pseudo filesystem. Checking the overlayfs
> inode would miss that.
>=20
> No functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D33

