Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64320212FAD;
	Tue, 22 Sep 2026 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096490; cv=none; b=fqxfPwPoRRMwqBmvOvqPHl1JWFCcchd9Y7iNF2wrR4EEeA+ma4dB2Ugpl4oTTHf3fkc3oCrCQS21MVgS7hbfw+sH9+g9kOMCNy29dN3UM40j2M3/GcUV8J1EUrOzKi0TFVnQQmnSFZqEfJO0ekhI/+aoNXcKUStwDfbo7kuFtHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096490; c=relaxed/simple;
	bh=MNQdP2HOZRfi+gZOe9KZquEQou+ctQieEajuMR27oS4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XAkJFzicN7hUUefslrdPY9ZmHB1FQ7xAe3BY9BVv71eb8jzZoF2ho0QbOhmQgQH0NlENCWmBQpTZVnAPHs5rH+p7HCb/tgTkCxTGBcfIILcwpc+d2ETyb+GW6Fcw3Isf8Cf11ID+dXJDU62h7nNTI5On/6h26FJ0ZS8OGA49Sdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqLnqnkT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqLnqnkT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BB01F000FF;
	Tue, 22 Sep 2026 17:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790096489;
	bh=uH7QJBVBktHCqG8zVhJLOhsKg3+XVR+jUpeD3sm0mN0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GqLnqnkT6in8UJiHKfeI92MotYb+j1fpPzJvfM/8VPJjhuhwrR+uRozBxenUNuQ0j
	 sDaHhSrEmlVyaBMyGJLTJxkeKKw68V17xNLvDonPR4N7Qmkmiyt0Lz9lECONQHU4a7
	 kEE7AQ5XYM8P0Vvg0U4zOhJ8ic+m0r55HX3D5CpnFuw1+PEITItd0eLxJrZXv8bsp0
	 qr5oaeQ8bRNONPz4itCrysHAVxfxdEyL1vEObyIbjYlBoRiI2XSKXTt0q1WV88jIk7
	 f8XXiXVKZfHQwGIpzU1J3k/88VHQ8p2s5nShIiv/87U/JXFClMgjgPN8wVTtorTneg
	 eG/VTOxTKIaLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] vfio/ccw: Flush notoper_work before returning from
 reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <oss.patchbox@gmail.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260922164928.477669-1-oss.patchbox@gmail.com>
References: <20260922164928.477669-1-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 17:01:28 +0000
Message-Id: <20260922170128.99BB01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> vfio_ccw_dma_unmap() is the DMA invalidation callback, which must unpin
> the pages covering the range before it returns.  It calls
> vfio_ccw_mdev_reset(), which raises a CLOSE event.
>=20
> On the normal path fsm_close() calls cp_free() itself, so the pages are
> unpinned synchronously.  But if the subchannel cannot be disabled or
> quiesced, fsm_close() falls through to a NOT_OPER event, and fsm_notoper()
> only queues notoper_work, which is where cp_free() then runs.  Nothing
> waits for that work, so the callback returns with the pages still pinned.
>=20
> Because notoper_work runs asynchronously, vfio_dma_do_unmap() can exhaust
> its 10 retries before cp_free() completes, hitting BUG_ON(++retries > 10)
> and taking the host down.  A further CLOSE cannot help either, as both
> CLOSE and OPEN are fsm_nop in the NOT_OPER state.
>=20
> Flush notoper_work after the CLOSE event, as vfio_ccw_mdev_close_device()
> already does for the same reason.  The flush returns immediately when the
> work was never queued, so the normal path is unaffected.
>=20
> Fixes: ce4b4657ff18 ("vfio: Replace the DMA unmapping notifier with a cal=
lback")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922164928.4776=
69-1-oss.patchbox@gmail.com?part=3D1

