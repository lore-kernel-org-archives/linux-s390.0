Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662634;
	b=Eznly9dsiVigQ1Pdg/vWIBXlwt+SprWT867EGr72PWGeqeuNeV0XJO702Qt5lrBV77se
	 UNZLz2XCMOSAa3AZJ3PQOqHqL1m03m6yZ3RJ6LwiRD1vvlF3aD4QqlI3u/duDQ4eSa9Ym
	 GksIwTBB5UydjTVMjHKHrkTwHcGAZ8yeTxPwhwIuypBV0fXbjw+A2iK8H9DYRcbRBa1jh
	 h0UNpkDI/amzwKdillplb+/f3ORh68UxJ5lJi8UZvs5w/i5bhVVlSfsSJQ9HLxIEw7LuE
	 CeUM/2mE0P/PvpvsE6aJbQNdCe2uJ4wHzBZzj9luVs3xUvnGE8FgSBwKVVo5NxD+rcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662634;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=I1sgVqiVaeOF++bDeu3LAxnHkMUdW9DXxl15P6Q3yeU=;
	b=GpPcdFvPl9CXtTNR0ty93nMZi49mI1e7xsOujBHxdv6v6NusqQ8YHK6SXLZ/vqw/ABrF
	 Vj7wGmtEy5kLZ5IZQuM9mUlJ7OHy7GT6JTdoHz9gX3XT4Fqf1mbAhxHfyUvZGqdXkCFNn
	 bXtrEBg0eNwEdcKtQaLj8/VNjgq7CMRuMA9SPJFh63lKcoFlkE5AqNE+3qdordXZuXSqv
	 DSB3yLIieH03iMsFVtnxNqO4zBirSM1XsnFUTrdJ1ixV5fGqei6nEtt5JEdMWQph5tTsf
	 OV+cVQLN30T1Q5PDDCzwI5qZvflnBxN3uoiPm4MMifPGKVE4FpD6VeGhVkbv21ix/4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZlulUOKI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E48606A881;
	Sat, 14 Nov 2026 13:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZlulUOKI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828121F000C7;
	Sat, 14 Nov 2026 13:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662634;
	bh=I1sgVqiVaeOF++bDeu3LAxnHkMUdW9DXxl15P6Q3yeU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZlulUOKIrwUY2CtpdtCw3maeewquyDBAeeZ68n8HbnpfPdU6a1F5JvVbE5v3sQLlO
	 0zInUwS1bjghASOTRZguL4MfwSnue2dmTRMwC8jAG9emyWx1deCrFNwGBIZfTzAruA
	 +ZuxiRv73Ywqi5FY3+/tvz8pqmIju9Ba8qPjg6GkKzj5VtvzHxvONgcyrb6xgb6N3r
	 anqPH9NzmMDuRD6gHfoqk9T45J2dy4o79zEUqEFq5iBeKnvkLp7TlsFETv0cOPpGuh
	 +4Dagmt3MMY+fHFxRcGvPG9GyIQg8oAeTcjKsZscvhHgqmNHhY4odOFOpUQ2r5O57a
	 0AfN9v8hWiq2g==
Message-ID: <sashiko-outbox-214561@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 39/42] usb: gadget: f_mass_storage: refuse files
 on pseudo filesystems
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-39-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-39-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:23:53 +0000
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
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D39

