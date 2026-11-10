Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302644;
	b=BulOSL5FroinIQiTfikDyGw6Kja8K1xybf3SSVDy4D1wB/0AukYJX0hNinIxI2HFT+Ic
	 iQWKanLCdJcEfjFWIEuLNY36zKy+/UW5myHDAkncIwcpTPNax0PBToHorlDRU78nF6b//
	 jmDzr3Y4YX+aZ9L6nhCV3k3Dr5kDMj98YE5YNe9l63x9UXjrnsgwZmgG4xxwbBR8SIIcC
	 RA9hoSmCVUtwd3JD+YI++Q+MhQgaKbhkscD8dS1dNCj4PYVyfuotPFGNnlNS2zAbdjs/L
	 Ywe4T6rYDoIZzLIIYiLXBFtkpbr1SrB97iuAaS3uO8sCmlxWZ6xZy2i2fajZmQymwlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302644;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=o6POLq7v4NtIwdpTyOPt259nbNWWP/pVPB1+WiiIb88=;
	b=g419FA0nOYmBHRC4cd4gk2ieRpqeCikO23v7nd+cy6dwM/j9tNcsRyzf5zXyx3bdp5S+
	 5h9xlAgLU+F+cmS05lPSOrwcNb7dyyx13Cd685N4QU3O0pmphreV473LZfn6l/4mpx+7n
	 GSUMHQHxTEKVOA/esQD+5AjX4c7fCzWaCvRDdSIckfohZMwvQgYY3tQ8VTyJ1gYZzp8PD
	 413V+Itsz16t2nQfj2DYp5BEfABv1r0+4XQ5z7owdlE1GUrh5yTfxE/93kKWxHNJgbUMR
	 rRmncns4x7RWO4zRd9oXyGyIrat1C0YXyxm8Ell4i0AA74oxgfohiB0UcKozGZWf6wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XLygyhu6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A90F606A9BE;
	Tue, 10 Nov 2026 09:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XLygyhu6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4FF1F0089F;
	Tue, 10 Nov 2026 09:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302643;
	bh=o6POLq7v4NtIwdpTyOPt259nbNWWP/pVPB1+WiiIb88=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XLygyhu6NvutsH4TUIPH12hTUqclI2VW5fTmXMVgqw6S1+AkmhVDv4s2sKR4QUbt2
	 YYdiVD1jt+MZihuIb5wsr9GYFHzx/lBVO5u3kc9cYRKoQBdWga+gOuJJ2Dq1ciyH3w
	 dN0ozERBtPUHcHIpS2+qn3G8eGtuWASnuh0KKcixdjj+C8+CQ9N8KsOTyVvY4rQZJ5
	 2F+p9zBM6ofGNR0OQ7Y6ESqAP2EqByQvQI7Zjhis1qOl6SnWq9TJD9Tk73z9IN5aiZ
	 2nUegUFwNxIf894W6bKg0ecMFfopMFDnuwmonq9jxBPqF4/wFP+iI5xTPGanCWPgIn
	 tTeZ1F0dQCNtw==
Message-ID: <sashiko-outbox-206725@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 04/41] fs: add SB_I_PSEUDO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-4-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-4-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:24:02 +0000
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
> Pseudo filesystems also never hold executables or device nodes. But
> currently each of them decides on its own whether to raise SB_I_NOEXEC
> and SB_I_NODEV. Some do, most don't. Add fc_init_pseudo() as the common
> initialization point for all pseudo filesystems that raises all three
> flags and switch init_pseudo() over to it. The following patches
> convert the mountable pseudo filesystems.
>=20
> Nothing checks SB_I_PSEUDO yet so no functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D4

