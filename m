Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CDB388379
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162990; cv=none; b=ECxLUwROoDaEioRApspt9kJBVQ4wi9Kurw/hNtOR2KdCcnSYXp6MU48WcS9lqkQD2ZBnktNJ4RLau3R4MPzC8CpnVw51FA6d1Ev0TMUT2bPfDG8LYktlKj/f1siqX4is32+c6H7QYd9CFyBCDkQomG4SXaj8RLqUc8Tq/Z4RlCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162990; c=relaxed/simple;
	bh=mdr7bw9pWZ2isnHIbpP0EN6XWoo8lDY3s7kIAq//o14=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rQrudhV5UtinPUw34Ew39DnPkfkAsDMx9UpjCHL+vhW+UvUkgaVsDb2GXDd4HQglHHX0SCVixRo5Pde6JWvEuGF63N12TAWVymkMT/sIE1y8J2PfyfsWHyFQx0+DgUy+YJNBzp6VH5W25ZRFWai3WgmhVwwrSI1F0gW/nebGvAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2UVV+ta; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2UVV+ta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98191F000E9;
	Mon, 27 Jul 2026 14:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785162987;
	bh=mdr7bw9pWZ2isnHIbpP0EN6XWoo8lDY3s7kIAq//o14=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I2UVV+taAH6tJFja/+Qv5AZFIsprhiaUo00wHH4KJL+E6bQk4ByrNXtvDSwKjyy+5
	 2XYl8A1Sj+VOrwBx9o2J8mbAVHaLqEKAo7FdZzzSrjFjXshUd9D3w8cIxZ5UCpBEJ5
	 2n1HJMHVlAGag2OKARp26EJ3Oz7vJa7iUo7QD/Qb4sAtGaCcu2Q0TAY+SlSTEw8dBv
	 Rz8gUoZsq2PF5VUxzmzFwJc7lsblHy1UOytpPbuyRMod4jRLjnt88MQTGxYkMnMODR
	 TBlyebcgIGGPoKuK0Ol4Q8K6OU6dvdjjpIWbhU2BIn89XaYjPANo/L0sh7jxGzuvWg
	 HO4xD+ZnivfkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] s390/dasd: Fix potential NULL pointer dereference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260727142840.567286-3-sth@linux.ibm.com>
References: <20260727142840.567286-1-sth@linux.ibm.com>
 <20260727142840.567286-3-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 14:36:26 +0000
Message-Id: <20260727143626.E98191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
>=20
> dasd_release_space() checks the implementation of the is_ese()
> discipline function before calling it to determine if a given device is
> an ESE DASD.
>=20
> The current usage of the logical AND operator will lead to a NULL
> pointer dereference as the function is called even if the function
> pointer is NULL.
>=20
> Fix this by using the logical OR operator.
>=20
> Fixes: 91dc4a197569 ("s390/dasd: Add new ioctl to release space")
> Cc: stable@vger.kernel.org # v5.3+
> Reported-by: Vasily Gorbik <gor@linux.ibm.com>
> Acked-by: Eduard Shishkin <edward6@linux.ibm.com>
> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
> Signed-off-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727142840.5672=
86-1-sth@linux.ibm.com?part=3D2

