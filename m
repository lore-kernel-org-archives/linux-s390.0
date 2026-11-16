Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828387;
	b=g6pBHXFH+NOTb+mRVc/PQ4LGXeGJ7x1A88bub2IzLu4BYBOnI7/mdqAxLg00Zqvb3SBt
	 GBv11VWMS0fvklxGTuI/uJZ8NfWit/Vm4dpvvWmSmJj1rWjbJMDX7VYsRmovYE20JqZlR
	 92Vi7qbYQzIkOFSJCtaNZ4IXiH33Iug7gEOVXCmzu5LpcslkoQ4IbBWgeVOsTlyvuHY1/
	 sXl8xVbstvr45mHgjixrEVv/dHoQbnllju7Ih/eNhT2rt8OJj1IER/9mqPSSAqqPZR30h
	 ndxLgQoMnWZsRg/Qian6+iR7ZiluOU0lFlFYB6bK+ciusAjo9Tnbzb0pOkLIHQpNn3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828387;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GUKx3Vz+fgjIvTtE1/HxaF/T4Xc/20ZoSQhTWcZzXc0=;
	b=K4HrYhFiq3DhAsLFUzVC462A1I72tA7uBQ+ATrTnmO2PJkgwdUO8uGTWtSes9LjuCFeE
	 0IqYBfBmrFwwnMicsFdAi2d5pQzAAolwmgM3/R6LcK8MpbdLzRC0mK8bgTAI3bOU2M4SO
	 km3lCepK7auEcLokHbFqpEWgNiv9JuwXX84fSsv33W7BYGmCR+KuY85VQs7/Y35pTud8+
	 sMLolbA4854WZoEO6RhCWEbGJU3Ows7wISBuzx6CKlNotCFHsvCkdjxf4aqudr5gP2oqJ
	 NNbXj6l9l0EIunIjzGfKu3ViIMezWIPd6qlx4x+7eCZenY2NUZ8N2zPgCA6hLx3Aj8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H9NzeQf8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5D3606A7A1;
	Mon, 16 Nov 2026 11:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H9NzeQf8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D052E1F000CC;
	Mon, 16 Nov 2026 11:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828387;
	bh=GUKx3Vz+fgjIvTtE1/HxaF/T4Xc/20ZoSQhTWcZzXc0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H9NzeQf86YvajgBCgagQXAn+QIYi9hKtroWWrIZnL2PbeydljDq1GB78EjUY/0xbF
	 H0KhvLPBJFHcp4A0FNK/44RvfqNlcp7DDEd/seFCfS/4yoTqMK15FCM8xvAvPErdDg
	 p+Y8R70I+4jvUym7UoEckLvwdFatvBUpZheyq1xOTJvS9PBvJlLVgD29MAEe5kZ6Oa
	 9U6uRHrYRk6Q4PFz2xZvj7IJGNpgMvO8y0JW19StM+3nLWMKYXzYsXDwBbE22XTYAJ
	 s/A8wSnWoOhevtYZwh40Ve/iBRMHx0n+++uEF3ByTay5cEzPVdiRUHqVNMWcfw6bhv
	 zPyAHKjVI3Fqg==
Message-ID: <sashiko-outbox-216919@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 41/44] usb: gadget: f_mass_storage: refuse files
 on pseudo filesystems
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-41-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-41-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:26:26 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> fsg_lun_open() takes any regular file as the backing file of a LUN. The
> file-storage kthread then reads and writes it with kernel_read() and
> kernel_write() on behalf of the USB host. With a procfs or sysfs file
> behind a LUN the host gets to read and write kernel interfaces with
> kernel credentials. Refuse files on pseudo filesystems just like loop
> does by switching to file_check_backing().
>=20
> The helper also does the file type and readability checks. So the
> messages for an unsuitable backing file become one. It looks at the
> inode of the file instead of the host of ->f_mapping. For regular files
> and block devices both have the same type. It also wants ->read_iter()
> where FMODE_CAN_READ was enough so far. But kernel_read() never worked
> without ->read_iter() anyway.
>=20
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D41

