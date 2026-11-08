Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794143778;
	b=egA8RYXZHEXWFIaTg7yYkiGz/e/iLTxIZu1+xpF5z6OHNW2EXQ+oDo9nXNluqwRm+qSh
	 Py/k41UZbV4YVWBvxEu9OVJDJyS/lA4KWmguXZG3IFfL4Sbt49B4pV4gmi+C+fRiBvQ9c
	 jVePNL+yxwkYGe3mJR+/8o2gl0HYgkSZ7hVoF3aV5WZN6Z+w6Ee4mJQ14p28HSn2ckxf2
	 p8rM7WXPKNg3c6W90NAoA1H9HG6lUhwjZ0QLHqp3FD+9jZeHvHLawuN2YhFuZUwZQSyY0
	 WqNafbMKtKh78rnrN6WcHO5PWIA5FgoZvPxTlbznvnccHyUrKPv1PVOMsn0YuAoEiAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794143778;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4UhvmBN4eJC3qpXttruDr7aya3OlSyB+9suuHtI4Wd0=;
	b=gMFpBANAkMRZZeXyNbXWv706DxbfI6G4xTgnoXcb9NYXxCQMUXHcfM0jXt5SMkjI2qOj
	 dWDVsM5AVgoYp+6fRab/niM5wX3Jj/zAprqJvBrwK4gjJyB34zlp0fVDL5OcHMl8yBVDZ
	 4TFFNaLFJdI+lusTvDqVd9kYsd7W9Ijcj3ZmUPAzVD0y+NNz+ov+C12sW7vgI8oW75fz0
	 C/7qmPYVU/lo0TJ+qvj3duul/fPA3J4I2qW85g5XP0w+gzVw2vFrAnwLkzvKzqLwYwebk
	 gHK8Iq/Cam6qv6YhA/kK6LusZnRhaSy+G/wCm0ibgL3ECN9PElI0gYTF60vqHCx0GnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QsXiSvhO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C44606A330;
	Sun,  8 Nov 2026 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QsXiSvhO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCF01F008A2;
	Sun,  8 Nov 2026 13:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794143778;
	bh=4UhvmBN4eJC3qpXttruDr7aya3OlSyB+9suuHtI4Wd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QsXiSvhOrlBhfxYn4AZB2Y3p08NGdE7Bm2n74bprITOE8H4WUcRxM3iZgEAioaNEG
	 F+ipTeYpYsfELW9h1tkOzAGOpL5PTXE55uWjcIUF8z5fTDMdD5I+SY6Q3OzOMHORop
	 xYix8rhexZW2UgcFKkqOt2tmJ5K4TeUwIJRPSkcYMsNd7KOj6nIOlBD5nIv0JBJ8bJ
	 nZCUvZsR/oU3fKbLeb7RLZQRLFchkhdvLeRZ49+ZOHgGt7+md7ZdWNm+UfqR8Y/yUt
	 geatkHT/D0AWbzgzaYozPhJz6hVtfuHmN41o8zYOhNxmZqt9kvMLUf5Y5MpCJGiZ6n
	 B9MMcLgMqH5pg==
Message-ID: <sashiko-outbox-203763@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/11] smb: client: Clear idmap/SPNEGO caches when
 the last session is unloaded
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261107131512.3603168-5-jarkko@kernel.org>
References: <20261107131512.3603168-1-jarkko@kernel.org>
 <20261107131512.3603168-5-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 13:16:17 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> CIFS caches cifs.idmap and cifs.spnego keys in the module-owned keyrings
> that are only destroyed in module_exit().
>=20
> Once keys pin the kernel module of the key type, the cached entries will
> retain CIFS pinned after the last SMB session has been torned down.
>=20
> Serialize the session count transitions with a mutex and clear the idmap
> and SPNEGO cache keyrings when the last session is freed.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107131512.3603=
168-1-jarkko@kernel.org?part=3D4

