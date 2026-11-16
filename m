Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827805;
	b=vHBKR9trxvIFD0CanXt1iy1fGLcG174RCNLDnYpQg4n5FYgWJBVNzlWUAXOk4gHPHI/q
	 Es0g1ZKygj22Z/yVqBrYBvxw7r4+lZ/NZMduEw6ru36f3Gu0zvQVrE6XGdiQJ9i6uTqBo
	 rIAWMhLFPxGwwXTvt/Li4dekRU7tki0tVZ8lVloGJSXC8GsAZUvFue4amwbsuq5do9LxT
	 yPkU7IXk3G1UijZsEZDXHkCynNgDWRDIMcn5x2QWIig4YVrNF/hg0xiGlP2yPf6mVBcqi
	 eAK4D/MD6jApv2AdVYE8z3h8K823fZZAEqOqtuol7UYqWAdFZJySe9A3ic/i49cIbiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827805;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=t4MWVZIQGl3YdbhmQbaBC5JYBFDAzChIjBk5ddePHwE=;
	b=pA1BbE+Py6khi9oHryKXMPj9s2g2N7pFwsMNokBBQRuk3f4KIDN0suhHxrkzGNr1G063
	 rAEjM0Um8K40uaYjxlHYAEpsI1kZARs875mXqvWIh4iGF5YRrmBLNov3B1pzcSDhv4FlZ
	 wAMeu5+1EaISktH7amF/JOMCU3eXS1pkzTP1FjfCcxt1Fsk9nR6UYse82gEg/9ya72nGK
	 g5KhEkgwkUzKN3YLQZCBGf29kVxhW6XYWP74mGTs5+GB8+fOTIgcAmzog7C6vKsdfVfCF
	 QFjYp2nNA7bdGpEuUJ0tUUDi1RX4RZ4TcTZ7706dBdXTyKDlfB0Hn32/FlkoRDxUtpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="W+2FF09/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2598D606D7A8;
	Mon, 16 Nov 2026 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W+2FF09/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345A51F000D3;
	Mon, 16 Nov 2026 11:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827804;
	bh=t4MWVZIQGl3YdbhmQbaBC5JYBFDAzChIjBk5ddePHwE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W+2FF09/NZZPUh4sNJe308X32QfS1pNjWWorBZUNurEVe/4cLZXBXWARs7VLVW1YT
	 RH8qE/AqHKuCcMl7HG1wHq3aAsuUkhqtFGXHMZbN3yh5Yj4/gyCdVLevyV2Lcpvy0v
	 n9xS/N3f7lH1CnfdkQJDDz6/z96akM+513mxr2JNv+3a0H+1QbZI5UhgQH9pz5yj0k
	 aTUxnSWW6DJEqCkj5ZAsDrN34KHn8kDMjRcnQ45YBhLDWFwURdC1mqkf8mc+nta6Lx
	 Xh/IPuOkAehjOrXb72CmJMic77Pcjsy5uQy5znojOpt+esXrx5WqHMbujmJ7qo4XHp
	 78AHMF36oGviw==
Message-ID: <sashiko-outbox-216871@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 04/44] fs: add SB_I_PSEUDO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-4-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-4-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:16:43 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Currently, there's no way to tell whether the files of a filesystem
> store data or whether they are kernel interfaces. Files on pseudo
> filesystems such as procfs or sysfs generate their contents when they're
> read and writes to them are commands to the kernel.
>=20
> But a few places in the kernel take an arbitrary file and use it as
> storage: loop, zloop, the nvme target's file backend, the scsi target's
> fileio backend, fuse passthrough, the usb mass storage gadget and erofs
> file-backed mounts. At most they check the file type and whether the
> file implements ->read_iter() and ->write_iter(). That's not enough.
> kernfs provides both for every sysfs attribute for example.
>=20
> Add SB_I_PSEUDO so a filesystem can state that its regular files are
> kernel interfaces and must not be used as storage.
>=20
> [ ... ]
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D4

