Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828576;
	b=zqwhc8sR17hLzzAHRCjFLfrqNBb2b7j2CGf3rJo+sbltnVQzjwI+7qBjts5csndLoFz5
	 S4kQmDpINlBS1Ho1NTCsGJ637iNJHD7AKPWe9Xf5CXiVtpLJfSxa4bJ2nF7rdwFbG8uR4
	 u14fFFKjdrRQ4+rU6Z6+Ihc0yIDlSo73bC58CiTYOwW6JNjp2dhtDZ4owF/AcV4GBfgjY
	 Ys3StRaN5nlBYHALgFjaPo1J+9uWNuuYphS7EPreW1nCRdUMu3xWTO18kShwsMVUa6dcK
	 rErJ1vAcTLJOCDL1B3EjuKPXclXd5R2wBChAR8ThqZgrRRnC++BZDS6BT9jE822Wqaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828576;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CxpBB37oaSxijuST6VNNv3gEjM6KilmHhMUvQpRNviM=;
	b=mA3EB0FxeOs3sIq1Wc8K+PCqXxIkDt5L8urwCjkKlk7u7KZCSTkuulP0r/vxI5J/iDxz
	 Hjsw99RMzCY1seKcRe8w0vZyKypqB1wGEzBcWIitrLzSXHE8sfROkCzW9CG+7BnCBFv3h
	 Tkjss6sU1s/0ERz28zhvkFvZqkeIRf5qTRIs9up5894JPlSguEA5qZjbnHlpapxPCqV/a
	 MPEArl9/NLTxye7uxX4MT85LC8DpqtJe9/Cj/kS7FHCLAjtXSmBavW04Fv0TwIh4gZZNo
	 erRvny2ArJ0dRMRzIakuu7mCWdzrNSDp3upZJBljHwVsgrI49oOpMVrT5GyQAOOz4lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQ4NcfxH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014F9606A337;
	Mon, 16 Nov 2026 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQ4NcfxH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6631F000C4;
	Mon, 16 Nov 2026 11:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828575;
	bh=CxpBB37oaSxijuST6VNNv3gEjM6KilmHhMUvQpRNviM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hQ4NcfxHI3FrR7grBtjtSe+ct6lVFEr0DL5kwpcDHM4R+aNuceG9Q4nlyqTl1IKTm
	 mtDMmkJ93wWQ5cyhmLaAkTYVP1cnQRW2etcu5WTXCfv9/6itqk05wXZh2FjFbHiR8T
	 2oKkYeyLJHJ6s2sBm5JNFRHFlo0yX6PNNVBqV94Pv9TeGhSedzH0c/cPC2IEJD69Dn
	 V/HoBInpg0q+7fttCAgn/GDnAwu6qs8o4FLUNLc9C/A2tJJML37BsgcE4F+q4hHW1+
	 OPvhJUTUEZrahHA19puDdcbL0CDsvu6ZfOAKEsmyUnAikTQUKSlrSnkL2N62bkPPLj
	 EFdTsFlsTk0mQ==
Message-ID: <sashiko-outbox-216931@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 44/44] selftests/filesystems: add backing file
 tests for pseudo files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-44-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-44-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:29:34 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add tests that files on pseudo filesystems can't be used as storage:
>=20
> - a procfs file attached read-only to a loop device
> - sysfs files attached read-only and read-write to a loop device
> - a sysfs file behind a lower-only overlayfs attached to a loop device
> - a symlink and a magic link to a sysfs file attached to a loop device
> - a procfs file as the backing file of an nvme target namespace
> - a procfs file as the backing file and as the protection file of a
>   fileio device of the scsi target
> - a procfs file as a zloop zone file
> - a sysfs file as the backing file of a usb mass storage gadget LUN
> - a sysfs file as the source of a file-backed erofs mount
> - a sysfs file as fuse passthrough backing file, by O_PATH and by
>   regular file descriptor
> - an O_PATH file descriptor of an overlayfs metacopy file whose data
> [ ... ]
>=20
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Tested-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D44

