Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793992908;
	b=DZCSODrHEGVPfeElHs+xCF9Ryb6EMzLkJvlerhh3opUx3OQZnlXAmBk4oK+1xt1b98Ai
	 C1UkQ6xP49/GidvL0V6yxKY11qvW7/NFWaBkcLDpou38drMQTq9OuivgEw3d/zx5v5asN
	 lZs7I8VDcgIm9VN8nlIJ2pxXUEwCSUvn3/e8hQEN39eC+ZoomAROMTfuMIRxCLEY76n2R
	 EYWenE3aoRFpOtb1euD5LUX3NHD0LR/yg3BLnwnFous6ucfHk6cXyrJ/1x0s9u3b8fgkA
	 vJMEbXa4XWl3lsimbLoxnPo0x90/dL7o686ufryUKtTwDaHbiqBV34gYhc3OCdwwkOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793992908;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Acki+rQmtiNtR3kaqXRVlqoF7ArfkjUpU+pQBV8nc18=;
	b=rUw5L+G8vTzsmfn0sS8GrLqShX/cGNAdiDdiUoX467ULrCc4u3GNu5Wh27FZq+YMVBob
	 0Bp9PQfTjUrHXpC1uKNbGeSG/qzhaaRmLmYe/B5YKOXCCTT99DymjS9njpITsfhE8qJF6
	 XlIhL11spTJ6rKy4TP5KsnuuHoA1zMezqTJ8MI0BpnhJV+sd+PkAbjGiuxHUmN5xOEu4z
	 tgflTeOb/uko1VCZA4tBl7LSwJ4Z+bwa8dBKN/7iJd7z1PFHcAWnVYZbPII8Xd3CVbC/w
	 L90l0tQA64cwGuIdDebbdWfSZw7CvCsIIAgl5KJ3W5I03H57PeSP9fFDoAXTiEo+HVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e5lI+212;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC72606A337
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 19:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e5lI+212
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B9A1F008A1;
	Fri,  6 Nov 2026 19:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793992908;
	bh=Acki+rQmtiNtR3kaqXRVlqoF7ArfkjUpU+pQBV8nc18=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e5lI+212PlqHs+qsFAZnLFzBuNLFHwyp+epkg7sfbum0X2kocak2v4ge9f/vHHStQ
	 l6CKcUQOugpJA0hYjgCMxRh1pCN1usvhbr3Umcho75VF4R/hXcLS7IPRk65TW5LCDB
	 h0QWqoR5QeCB2u5rveVsawEvlu576hzJufWkb5rMgAvDGd+q+NjVDtlirtQtNnZsRy
	 HOL+W19MBLqD6iN+adS0VZMzB3ZulBLU73R+b1/l2fH87eVlcXsJ51cS8hn8l8L87j
	 QPLZNkd8DJHfMcKc+xdmhQIxwgbku1ibxzSqy08VKH1zDlUBtaSi068id0jdk7EESx
	 2g10avBEVFsDw==
Message-ID: <sashiko-outbox-202148@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] vfio/ccw: Flush notoper_work before returning from
 reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <oss.patchbox@gmail.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106191029.469837-2-oss.patchbox@gmail.com>
References: <20261106191029.469837-2-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 19:21:47 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> vfio_ccw_dma_unmap() is the DMA invalidation callback, which must unpin
> the pages covering the range before it returns.  It calls
> vfio_ccw_mdev_reset(), which raises a CLOSE event.
>=20
> On the normal path fsm_close() calls cp_free() itself, so the pages are
> unpinned synchronously.  But if the subchannel cannot be disabled or
> quiesced, fsm_close() falls through to a NOT_OPER event.  Since commit
> 0c11f61a876e ("s390/vfio_ccw: Move cp cleanup out of not operational"),
> fsm_notoper() only queues notoper_work, which is where cp_free() then
> runs.  That commit flushes the work in vfio_ccw_mdev_close_device() and
> vfio_ccw_mdev_release_dev(), but nothing waits for it on the reset
> path, so the callback returns with the pages still pinned.
>=20
> Because notoper_work runs asynchronously, vfio_dma_do_unmap() can exhaust
> its 10 retries before cp_free() completes, hitting BUG_ON(++retries > 10)
> and taking the host down.  A further CLOSE cannot help either, as both
> CLOSE and OPEN are fsm_nop in the NOT_OPER state.
>=20
> Flush notoper_work after the CLOSE event, as vfio_ccw_mdev_close_device()
> already does.  The flush returns immediately when the work was never
> queued, so the normal path is unaffected.
>=20
> Fixes: 0c11f61a876e ("s390/vfio_ccw: Move cp cleanup out of not operation=
al")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106191029.4698=
37-2-oss.patchbox@gmail.com?part=3D1

