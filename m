Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828645;
	b=KrbivQAze+Z7o4yHSW4hsJZAOH44BHLILULGvhYAXZ1OMxSr7ZItrN+nMtLXAp5p3Lx0
	 Fyjn3QwxDOoAwsY5HjkrXsEZ426go07kveMzIXgY/8mxXDcEnn74M7xvQdj723p9v7hCS
	 VMURWUaAyRNCsfJ1qBG94mHWymDBmkidjsmym+8qhzfmfetJlKWaWmVkbubve63Epijr5
	 nuqz9uGVjGi/cgpu+XrzISe0rWu7cUOIGcUtt1kFpWQHeSWx5gkOVcBRMGgHEO7jxkd+i
	 3XarZnhyVQC7OQJJ+qFPXc4zADp/zrUzA7tdGnwF3pAcjwsx0B/XzkbvyLQUWxxYp/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828645;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sC8zSdKU/pdpUm6HCeosRY1J3TDDwkmGb/X7Ilmq0lE=;
	b=weML/oeirTAI6JY/NBl39MdrWw0G5Z2p15zBH3OLECRmBA8yvKLhqR1Y7g/meF+x/J2V
	 1Ym189wWLTERSDSCLbzUuItuSZt2zzAXteIfMNEEdFz/5lUU8luqx+Rp4yMk+n9zACCNt
	 OwKiSjTHTYVcyjZthjoTXGe2WjVdQBfcKEsBRwFd42y+T8tCweTasfm6Bb9cU6luqcOpn
	 MbC1vWCJDlCyGY5LyfI/HLENaavXJlN+1Nm48DneqGsSI88TxPZtbmSzOQhRWvDZrabCo
	 3nVk2TuA/G0rol9DqYzyzc1EmHhP0+k9//aroCCKQynOiu1NekIV4dUZjjbXwdScpvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OrSsuTpH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15C5606A323;
	Mon, 16 Nov 2026 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OrSsuTpH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C8D1F000C5;
	Mon, 16 Nov 2026 11:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828644;
	bh=sC8zSdKU/pdpUm6HCeosRY1J3TDDwkmGb/X7Ilmq0lE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OrSsuTpHVOVLwKkP9FbWGoCbgqJZ93bvOi+vK/GJa9pBLKGuUqLykS+2YQNObvXU8
	 1992x5qahcv2qF9c6NUv+7+P86fulrKvmxp79FOBSdHQZxOU7ij6eT+Wx2cBs9VnCi
	 OY4sPk2mSAek1Q5krO/T0QVgbzFFJ13wa6oF5r+Zv6B51bLU0ol95RwHJpedLP2F88
	 sGXZTxcSUCgLtR24ddoju7KajgjKENl723UPA1IjALlJXiJ56q0zmtiYkmnWbo4dF1
	 EKeLPO7P1c3omK8Jwcwutw8t6D7MT3Rof8R/se2TG5uZtxIDgtOpQ963wbZz72pxqX
	 lA3p8rXo8MTKg==
Message-ID: <sashiko-outbox-216935@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 35/44] fs: add file_check_backing()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-35-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-35-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:30:43 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Loop, zloop, the nvme target, the scsi target, fuse passthrough, the usb
> mass storage gadget, erofs and acct all take a file from userspace and
> use it as storage. Currently, each of them has its own idea of what to
> check before using a file like that:
>=20
> - loop and the gadget check for a regular file or a block device, the
>   nvme target, the scsi target and zloop take any file type
> - loop checks the open mode, the gadget checks FMODE_CAN_READ, the nvme
>   target, the scsi target and zloop only check for ->read_iter() and
>   ->write_iter()
> - apart from acct which refuses procfs and sysfs files none of them
>   cares whether the file is a kernel interface
>=20
> Add a helper that does all of it in one place. It only accepts regular
> files and, if the caller passes S_IFBLK, block devices. It refuses files
> [ ... ]
> block devices as both inodes are block devices.
>=20
> No functional changes. Nothing calls the helper yet.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D35

