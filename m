Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828366;
	b=HG8VzkBlU0i4HCEflIC834v/GHn5rk6q0dy/PWDzCMRME8Mty5M6BqCDEdE483LB8zlQ
	 5UB/wpBIZcCSeRmD03mtQAQrPPV++EottahwBioLBqN3oAZyEC3s6vxlNZ5wN3UAMUB5n
	 UQ7yJhV45Tug23Dmur+Gkg4c0FPBDZpq2FBxdi2auK2xokbMR/ZKNXN7FNqHjqR7pLoZh
	 g21JOzMmCGzREXLi67lEttwpDiJs0M8GBMcvVNMnhXZIhTgHizxZhZtOglyfHMWw9iP1x
	 /TOOQAioND9e1TCTWcOu3Q4k8JOIupZbET2UYlK7Rjl6dExEOvzHR4qW7LRdaSZBS2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828366;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Pmf+JKIQKTy66mytOnOZTV4U4D/vm7WEHhiHF7O4+70=;
	b=pR+YDBAkzeF0ERRrds/bD9usbGCRbI9ZhnBVgJDZ18aUnXsQ0e4MfbG5QYCSw2trmMeH
	 vzVq6PiI78/TvWcqJphy40r3YhLXVyaAycHUzBiJ5PWRIRYux+YKMorWGQuJVeen/LONy
	 dTXQ79dxKVVU80Jf4AATMRNei7p8xlHC4BMduMoCLlaVWJNcf9uZeAZi5LsRitTZVP1ix
	 G6RzApVKiTkK3NsJ0sxY59zJ6HYs5cBFVNe5Sd6t44JQsqJQ8eEoFMKge47KIPEKlPkag
	 EZ2ICjE3+0dj8IJvbU9BlBxOjHMF+UdM6j11/cIE7ZVPR2PDej0fafX+nbFPmup9xew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7BH7qp6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF974606A780;
	Mon, 16 Nov 2026 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7BH7qp6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B405C1F000C4;
	Mon, 16 Nov 2026 11:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828366;
	bh=Pmf+JKIQKTy66mytOnOZTV4U4D/vm7WEHhiHF7O4+70=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O7BH7qp6iCwlO60BxT6x9fXfzqPT8qtWfyKoyE0VvH6kSM61Yzx+rX6K9aSTx+/KP
	 R4DnkgEADwupyYQ4UMflbePpi7ejOlCg7voW/zcBr3DVioAYby8TUpxDaah2HKeJFS
	 ScqE2//Ze/8w8rCXVJJzeZ2yCupd+uxwWeRUT5OjdtdB8RX4q9NMz2yljdH3RJb5WB
	 yE4FTCAaT95RjpHWBIuzgH2kMXFI+/cIyu04mvJvUVlImfekMTeizrCZchMbfVLzLz
	 xvr9Z7edzmo0RvJK2kVOEzRinUAyVkWga4//thfDdyuJO/KLOwhKmelJ7umY4WHh8i
	 VnZOL6dpJND6Q==
Message-ID: <sashiko-outbox-216918@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 40/44] fuse: refuse files on pseudo filesystems
 as passthrough backing files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-40-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-40-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:26:05 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> The fuse server can register any regular file as a backing file. procfs
> and binfmt_misc files are already refused by the stacking depth check as
> both set s_stack_depth to FILESYSTEM_MAX_STACK_DEPTH. sysfs and the
> other pseudo filesystems aren't. Reads and writes of the fuse file would
> then be done on the pseudo file with the fuse server's credentials.
> Refuse files on pseudo filesystems just like loop does.
>=20
> Note that the backing file is only registered here and opened again for
> every fuse file that uses it. Only its path is used and O_PATH file
> descriptors are allowed since commit efad7153bf93 ("fuse: allow O_PATH
> fd for FUSE_DEV_IOC_BACKING_OPEN"). So pass FMODE_PATH to
> file_check_backing() to keep them working.
>=20
> The file that reads and writes are actually done on is opened in
> fuse_passthrough_open() with the flags of the fuse file. So check that
> file as well and pass the mode the fuse file was opened with. It has
> the same path as the registered file so files on pseudo filesystems are
> already refused. But this also makes sure that the backing file
> implements ->read_iter() if the fuse file is opened for reading and
> ->write_iter() if it is opened for writing. Like the other failures to
> set up passthrough this fails the open with EIO.
>=20
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/all/CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo=
91QjJHH9T_Yw@mail.gmail.com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D40

