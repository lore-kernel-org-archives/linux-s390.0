Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828441;
	b=4n8ixns+A7LIc/QiEEnzNPyjvjUeeIA6HeFgR/8VBtx/LNU5Uy3RnNjWZNvNHm3LwfYJ
	 AxxWq5B4J6AkpIFq3t3T00T1QnZ/E2v0xuWhG02Xxreo0XARllnNgkjqpSKj3XUK2yza5
	 D0YbBSclBFtTMbc9MTOvQhDi51OGzoJ8XpYMNm/apali1SNvuerx5/Y1q8H/m46LHdnon
	 7vm8Ma6LezNEwNEY93nHJnaDhd58IGgtDXcxOcCyqEuZcmU5ZRft55VcpNAvqL5OYlDua
	 +ouHuc5rysOTV44XHZKx39pNctS+xdEf6/zsB+YAdpvCNVisaX8eBDjOQrQ3AbUHRiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828441;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gosk1sdn+YP0YyIvZ2AIjwbgjj635DebEBuW4lL1NG0=;
	b=qgfGRVltAdLXZJRtdq/f/sBX3BeDJKHKZDl6qWOEGACER04iHu3eXuKi8Er4WnZ7FO2M
	 jhfKNLUxgbyIdBHnA1ahcQcPAe1VkW8nlZ9iSx24nFRyfv71/rS6W9V2bhqwiW2k2cqdR
	 vR9ozx7Ce5OuxgC3xcuQ7rDCENmbmUQEK6gEweYLQtc4Euin7cjbTrtBaUH9cIrChmpQi
	 8Kh6+yVG64n8YbYNw0XqMFQFW1QN04PcdCruEWtYmDe/ehwS0dOATfNE0TAM7LAnNUOBD
	 B8safe0qlXlmdxSR5KZNk57fiT8TRMDcE+weMr/fTJM9SqjfEuryxOpiqCvkdiFfn2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6pat7rp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AD9606A33B;
	Mon, 16 Nov 2026 11:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6pat7rp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5A11F000C4;
	Mon, 16 Nov 2026 11:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828440;
	bh=gosk1sdn+YP0YyIvZ2AIjwbgjj635DebEBuW4lL1NG0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f6pat7rpPy3bQghaUER8OaPN5fPHnKDfRIEtu4MMRUblws0gGRdxBYKifZAO+Id8Z
	 PrzIVwL/Essh++MjVV7naRPxBmIec53DVajsMaV4d4iiR5sHn9YGbpxuIS8jwu1/jr
	 RV1hDB/jEHXussQFvCEEUBdioBscGKiF/uN4sUk1y7pk0e5mpXRQhtTpeyxdjz8PJI
	 eWbeHe42FWVLxVlexsHSiJ9QFOW5XSsP262d0kRGO8FXzvwbwXQgkG0LZ1TUe3gzRl
	 cF7fON0SnFbNAfKDUNBLdP9rPSPdxjeqhaCYBEq3L+DEr3PF3CuSzKcyoJTt50mxaT
	 M34zXPzoL9UyA==
Message-ID: <sashiko-outbox-216924@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 43/44] acct: refuse files on pseudo filesystems
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-43-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-43-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:27:19 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> acct(2) already refuses to write its records to files on kernel internal
> filesystems and to procfs and sysfs files. It recognizes the latter two
> by FS_USERNS_MOUNT_RESTRICTED which misses every other pseudo
> filesystem. So a cgroup2 or binfmt_misc file is accepted as the
> accounting file.
>=20
> The records are written with the credentials of whoever turned on
> accounting so this isn't abusable the way loop is. But files on pseudo
> filesystems aren't a place to store accounting records. Use
> file_check_backing() to refuse all of them.
>=20
> SB_NOUSER doesn't need to be checked separately anymore. It is only
> raised by pseudo filesystems and by tmpfs instances that are either
> kernel internal or can't be mounted.
>=20
> Suggested-by: Alexander Mikhalitsyn <alex@amutable.com>
> Link: https://lore.kernel.org/r/ae189903d4cda27130317a9312d94b53d07415ba.=
camel@amutable.com
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Tested-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D43

