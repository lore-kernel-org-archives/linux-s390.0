Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302736;
	b=HfudXNZzOO/nje5AleNu3CtOgJWthmaicyU7JBvQ1Biic+bkpNhmav6YhAHzg7bcIDwy
	 C8R1sbX7yi3HrSW5bQwRr+AaQllfbcPhxuhWJe6PJjLER8OYvGYNl32ej7SNOivRkgZcD
	 s69c2QLbnoL78+zvEl9CTXyUX6gj7b2pfGsgf/BPC28dspG9YK9Qp8Pn5lVw92SpjN2b0
	 m+kRHhr3gMXD6vqq7StzttfkIu1qaq3YwDCnbLjjspjo5f/pmSxbblM/QfEnhEgJ+4vly
	 fipDJBB4nbRaIMREW2/O2Czcglo8jDqfwznTNaLufnoNiXMXlxcHf6YQiMlfs0TYxVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302736;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ONPRjrmi0MwP1+AMTKXKtmotzkW5/Jqy6+wv9IDM+uk=;
	b=XIDp3YLbbdkedaQdAVWbDZucc1Wi9Sop1koIaVgM3KT4KK0EgpHhDiqtbVNbYBzt/IWO
	 t1FpSPcxw0v8psOd2aR6RW2Lyz68UYROA26OuHWx/3RzX2pAq9GK6dUCU9c0t8lB7VU2a
	 ygJ6rSHzemcrOw9U3JClrz6b1oDZi8aUoJ4gd12tHlolgRiRCDV6yuVEiRddymasuneB3
	 H7C/4XY+UzXDLGU5XyfrJZCTXURG0OiN339HWcr2AzWw4pXTJA2arrG00GhLTUiTYtYre
	 Tac2JaEevMJIzEHjTMlfBVx4IZfLzPKvhoYYYVTVl0DjK8pldXIpfkFN1OUtvFocy4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SgB6Uboe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18576072F4A;
	Tue, 10 Nov 2026 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SgB6Uboe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3391F008A1;
	Tue, 10 Nov 2026 09:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302735;
	bh=ONPRjrmi0MwP1+AMTKXKtmotzkW5/Jqy6+wv9IDM+uk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SgB6UboebtdSG7T0/ii2ZTNr78rtd+M/X5Z5OqLRAHUJWauytNuGWwBUbyweg95pK
	 VmWDSm4eyb1BOjPix+xBAuV1R+OCHs1P6Pd0CzQrxodOhl5MlANzXRbV2/YvgOrYcP
	 LrQx5gHG058sUdiHYhi8ODg93iAuVqNO9VXiX8g2gJsxh9lPSBSXuvM6cRUZFN7aBq
	 Nvvyo5t3qCKdEafJrNuv+9iOpOz/4jzQj8DxfuiMXJZ0XMODEiNJPADhXGj+JOWILV
	 MqkYI6Jgni3VyNvBrYwIvYlHuMwtTzQDWFpiKNc1WqhmCf8pa8H8MJiQyJMwn2+nVP
	 c+1qDJlCEvsOg==
Message-ID: <sashiko-outbox-206739@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 05/41] kernfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-5-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-5-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:25:34 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize all kernfs based filesystems as pseudo filesystems in
> kernfs_get_tree() instead of raising SB_I_NOEXEC and SB_I_NODEV by hand
> in kernfs_fill_super(). This adds SB_I_PSEUDO for sysfs, cgroupfs and
> resctrl.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D5

