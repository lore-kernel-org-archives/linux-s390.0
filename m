Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828502;
	b=IGl5ivQFJHFtpZSq2EZaVcEwXG/f2zRWSNVXzw3eq+L/LaGBozeKQuPBnfY9dJVWtmX5
	 mnBO9BuMV3YKNKGD5P1YekI6tTb46Lj12MndsI+Q/dCoc4AxHnEldUH0vYF3QLSTfGGah
	 iQujadvaB+efMjAI82/mTnbF/+6/NevRex/OFJILx3b7gyD079Sic8HbTo5DoLgXpbcUg
	 a2V4NDpoYXdpgC4b7VuUAhoXSdE5jpe3aBtPjFN87Fhg9dgFIBNRKd+1cb8Pk9uDZBTSu
	 l4CNRg1S8gz8m1fNNLlmCYrirq0lEls0YJPeCyAbPp53W/m5YzI/JHOF8XgZOyU/A+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828502;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JEX8oOiM8UbtDXXCAf7CmJIZMjMfrZwVgn0ZcNomOX4=;
	b=GpOYNfP4P7A75gwwwq0KqBVXLGHlPFvb51EBzoRttdum1pNSS4COVxacdb9WisL6pcuG
	 dymPg/ZNiEcVcyinhMsOp/UaD2DW28N8K74ni3B++Y/y2fK0JssumSp/M2rknTZ+Uhonn
	 8fkt1GVK4OM+8pFFkT80pwB6o37HxdWcYj0N6NRbWu0xYFzvI4Uyddk1M723A6+y/Ieil
	 sMoWOVwH/n6J9+gKfQrccWSOyCSVJ1qgPVghyk4bRvzXdi8T4yqZ2fsOpjSxxj8HMU2Nc
	 3iT/NACfZGvEMYpRTOep0hNoIgLTtmb27VcF18DKmywT1IzIbMewzcT5HPhPhASgsZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JPgG8MLU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F98606A795;
	Mon, 16 Nov 2026 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JPgG8MLU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678A21F000C4;
	Mon, 16 Nov 2026 11:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828502;
	bh=JEX8oOiM8UbtDXXCAf7CmJIZMjMfrZwVgn0ZcNomOX4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JPgG8MLUFd2kRqKheYwSFoXDgn3A/6bqJezZCWcUPQxZ5n8Iezg8f7oEcV3cQJTfu
	 C6Pwqmi2kOWl/+fYMqH+zzXYCX0J5FW1QBJI5IAe9TZzE0FaWwfxsWkfF0IpEBB0zq
	 WncbGecwX+w9nFiiKUtbSk9AUqow8Ry5qMe8u0NYUYRt6uKb1qOnnETT8fJCzdywwu
	 IDthgFP1y/0u4UieD3/+pogmKNwFBAnqTOAwScto9wZ2SZj8tL1qQ774mKTCPARuiv
	 6RsRcsvfXtu5iN+AEl2zXnTUkXfgzDcJZduYs+nLVeySBx0H4Yjq7oZY8YYwp4h4vS
	 4czwiDwYiAQ+Q==
Message-ID: <sashiko-outbox-216926@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 37/44] zloop: refuse zone files on pseudo
 filesystems
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-37-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-37-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:28:19 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> zloop opens its zone files by name below the base directory but a bind
> mount can put any file there, including a procfs or sysfs file. Refuse
> files on pseudo filesystems as zone files just like loop does by
> switching to file_check_backing().
>=20
> Note that the helper only accepts regular files. So far zloop took
> anything with ->read_iter() and ->write_iter() as a zone file. That
> includes character devices, FIFOs and block devices if someone put them
> where zloop expects a zone file. Zone files are created by zloop itself
> and zloop truncates them to size and to reset and finish zones which
> only works for regular files. So refuse everything else.
>=20
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Tested-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D37

