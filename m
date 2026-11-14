Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662311;
	b=MikrJy4Lzytj5xI2EZOqvem+anGAMLxX3uLjqCfqgpgZi7W2cnKtMlNzLEWcY0uz2vIg
	 tczxwEEd/dPVpVYUm9pHgJXQLCbU5ZVyn/Th667G/+IDL3WNPPmj451AXE0WraaJU3xXL
	 Bl5jOG6J1hJy747ZNcKrkU31vIbkJ7aWc2qskH3aV8eo3n2y5lazhVUGJCbdKdRD3/KUr
	 jaoISvmw0dLQI+RCAwseve5s+Z7+hshFoGvqMoLT9P6w+Nr7cLSvw96edEqiCUooCGj3P
	 skbA2HQdJaz70pboDxJ7vlzkIV64UUY3EsDbzAKKuGaCW4bFlaZQTdr5X/vX/Eu4LVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662311;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=crdZaV8zQVZguOgCDJWt8yNgVjZ1d+iSK5g/GPZabR4=;
	b=4VFxfoIhwmIi0VYTmeUqqu7QRnJ5ANJdshMqAWMbdnPhZ/p+N7i207G9eTSaSgmoHgKu
	 U4r1XGTQ/OUcvidnxcFmxk+NpALZNeaxL3eg9+oRzsHn/doXGnLLBRQAu0yY1aKGG+h97
	 GgYSeQVGRtja34s7kv0/AxeI2cREi/cgKxbDGKJ2nNb5CDCwssiuKvVKf+Ty3fVmKklyL
	 tBPi4hSlrpL5QJ39zmFo0J7VX3itXJ5gM1tN+NC1jfzGV+hlzdoa/6BolHc+8GNCceW+/
	 xT0SewivScxI1zIFV8bIEvtaaBcxi5tohoTUsxV8aKg6BUPbi6UGAiy3QuYqdUbI1Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SjQCPo0t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB02606A88F;
	Sat, 14 Nov 2026 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SjQCPo0t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7911F000C4;
	Sat, 14 Nov 2026 13:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662311;
	bh=crdZaV8zQVZguOgCDJWt8yNgVjZ1d+iSK5g/GPZabR4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SjQCPo0t2mvF9zXnJFQNYvILeMYgdc6Dw9BisJZLDCRfnCy2iBz1skkbHPyFaXsgF
	 ZVmju0nP1M9MWBr9xF0bMZulGBoZAqQ0CWX21eyOekuhr355RQ14mszxv/KXw33CeV
	 kR0cq51EC+MszF7AsQJ+4+0dQbkL9JZKcWuFDXJnTwANarCB2bDB8L//LM2PrqsBrN
	 3Q2S/jik1vT7MRRipK39NRN+NkXgYjveEO7zxKCEh+PlUdwAAqHcHCoRToQQnwMji7
	 qSapCK7bP8hzXvxUsUZtX1YAUxWMjKvv17EDHAM59nnzUTKCQadxThV4lJy7Rhz7Ie
	 0bOsJwg3LpCdw==
Message-ID: <sashiko-outbox-214529@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 04/42] fs: add SB_I_PSEUDO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-4-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-4-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:18:30 +0000
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
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D4

