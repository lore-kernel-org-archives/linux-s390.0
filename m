Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214446;
	b=A8yzvxyww4WKqDRo9h+ox7oTK6gBcHuFQda0YL+TVPhwdJ73UsAOsAFCBCbqMk/MLZJd
	 K90+1Wy/K5L4IN1WQLNFVBm5j8720AQIt7SQpEUIuk5NiSnWQWeiYi6PRYpGH0MfJLpWY
	 zV5gJhifjx6PvvHuOEdenMxhD0IxCRGJ27amnu8O+LwFOwCNdzNZMQdsvFfPRFGQwB3UF
	 kQMlDd/Zjb8U2eHNFLY3E2ixgjqt1XT2BKv1ky5NKsYANf/vDq8/cjb/Vfk2iDq5R50vw
	 37KUVw7mmB6soDmJQiTNrFbR7/KxeLyxKgUV8O1CXqDuBgJMgbTUqs6Ygz8YoJGccGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214446;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cuy4W1vFXQ0xiY8rUr1TG0DH/jGfFc8V2Wmo6UXYb+s=;
	b=OPNroiYstHnmM2Jk1qmeY0u/Xx3E6oCIiN3p65bpe0LhpCT4Q2BKMNivws+CywTumi9h
	 ykIy4qEYzlvuRYsLlfVHTRdHQdjhby7yPuw20hZONSUs6/F8GL7kgP40cqR9ga2y+5j1p
	 WyvcF00bkekFguiZ7BKzGmO8ckoYV7lwDHn2o61BCIOpSAHG7TZeM6OHlsko1PhGpBG5U
	 ZoSN7cqxuYQcMW17xvGpeFAuJunPzOIsbTgvDnyRdUiSGkKlsyYZ+BkHumiSrVHldrrdY
	 uTHoOwGsW/dJsE+IoPnMSCJTwv3eUM2wa+lXxZhjIU7uJFhLNAPOF0rNe/myui4lQnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTCd1BLp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF106606A321
	for <linux-s390@vger.kernel.org>; Mon,  9 Nov 2026 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTCd1BLp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3771F1F008A1;
	Mon,  9 Nov 2026 08:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794214445;
	bh=cuy4W1vFXQ0xiY8rUr1TG0DH/jGfFc8V2Wmo6UXYb+s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fTCd1BLpvgSFOQXcoEZHcrcNfpPzU2A+Rw+GwTDjXlBel7VezZWVsT9rGEVjJbz5E
	 YOsBW9s59e6Yr3uIWPqPht77YzHbPeQzcO/Q6FsF0MrNYWKoF3tOIaKS1o3dFENbtY
	 y+D9WtR9oHm6DS8FrFE8sI6E9qGroozxq3SET7p76z6H/y0pvMXcTLt77XKDXeJy+Z
	 YSGyUj0QjeK4/vazLuGLcdsmWKAH5OP5bvE/Sk4JwsBBT4uX2wWhd03+bgPo6bMYLQ
	 IVvGRXMcaGkRG2rycgx8xknwH7iB4gNM4IuhYfyhgnz5W664J/rjVky1SIh/Pugw6j
	 SUhCydSsMmdFQ==
Message-ID: <sashiko-outbox-204630@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] s390/vmur: Replace __get_free_page() with kmalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108-s390-char-ready-v1-2-3db507722530@kernel.org>
References: <20261108-s390-char-ready-v1-0-3db507722530@kernel.org>
 <20261108-s390-char-ready-v1-2-3db507722530@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 08:54:04 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> diag14_read() and verify_uri_device() allocate the buffers that receive
> the spool file data returned by z/VM DIAGNOSE 0x14.
>=20
> These buffers can be allocated with kmalloc() as there's nothing special
> about them to go directly to the page allocator.
>=20
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
>=20
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
>=20
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
>=20
> Replace use of __get_free_page() with kmalloc() and free_page() with
> kfree().
>=20
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@re=
dhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-s390-char-=
ready-v1-0-3db507722530@kernel.org?part=3D2

