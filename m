Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016983;
	b=vx7+zT4FQJa4qDb2161yYY7GsWe5ihuySiXFmHYBWci2wwKa9Q2EFTWRv2wBZvmHAth3
	 nD2PTKIb28JMFEV++94VNdYKCpOsXqWWNUHnz4IrwsMf10mWGCplS5UonfFKkTSXjRgfU
	 2Zbi5I9f03FhjsX3NZsRZ8wcqIpjGcjRh4xOa/nrOPnqaVDh+RQXZOFWmAJFlRdq2S6ak
	 loCjq3DwiZDD67sAq35UipsiNhNKxWABdfc6QkN7mnAT/WUxhq0wVVIZhvLyJfwa5QzmA
	 740Hrw2c9EqOjjQn/HSutAi2ZWgsqguef6236LzKGsU1L0iHcD7LHJ4XdnO84adVM3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016983;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DmRb7Ob3Uad8Xl3ifc03AHO9+P4IzbVnwQ2Tqs8U1Fo=;
	b=hhUbZWMOKa1/heLjohEjrN4SK/ULn6EOYnphDxHPJ938bvUBk3ehJ5IcNd9yp7fxrGkB
	 NwCjF2xiAnPv2DW8KED8not1yBmVgGVcNJaSsQTPsL4Y0pPcoxrxKfQySOI+OE6SKtxOx
	 QaqT3GjafD/1QOBbW+Xv5S7khbKbUTvMfz7i+C9c6OEh1ldAMwE6R4/QuIqj9Cuqltspr
	 HF1eo+1q5IEW0nwmXpOkc85Y/bio7UC2lY5yPXOw/pJMm9bq13a2I1AWztKi0Vhl+7xlZ
	 aNWKeJ4gsLjc84/U9G68CQ98TQcjdGeImM/L2NlNP2eGAroCmGpNLrcKH4XbJA521gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QtMuG3W5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C018606A31E
	for <linux-s390@vger.kernel.org>; Mon, 26 Oct 2026 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QtMuG3W5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19591F01825;
	Mon, 26 Oct 2026 12:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793016983;
	bh=DmRb7Ob3Uad8Xl3ifc03AHO9+P4IzbVnwQ2Tqs8U1Fo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QtMuG3W5hG+6ijY4VR9znH1fVsZvKYjHRtc+1LR4/HUmvmiqER4bK/v8/WNRfd7ZV
	 LyXR861UADi+ODYA3IJ+7teFzIgh2B/MvyM4n6OhrZmq+BCS7bkegZo+Lr+nWlIKXB
	 E4jqcdpbFroyuDzXyVdDesqXMRjqx9v0tVjGAY37z4iBrD1Y86UvK0iE2ulXgoZq3e
	 EDvqKb5/AAyBy+xSkGVRJe7L/t1AGQfOwGU7j/asv8k8ZP3T8rOLizgnbuOaQr6B5F
	 1XohS/39RK2mxlWFLhzbd7fa/xjKHf/tpx9gJi9riDcFYY6GVzkVMJXWAKfGSprQ7U
	 k/lE8+Qp/k6CQ==
Message-ID: <sashiko-outbox-185192@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] s390/jump_label: Serialize text patching with
 text_mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261026120329.1792436-2-hca@linux.ibm.com>
References: <20261026120329.1792436-1-hca@linux.ibm.com>
 <20261026120329.1792436-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 12:16:22 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Acquire text_mutex around the verify-then-patch sequence in
> jump_label_transform(). This way s390 uses text_mutex like other
> architectures and does not need to rely on other implicit semantics
> (e.g. no kprobe can be set on a jump label).
>=20
> This is a prereq for removing the spinlock in __s390_kernel_write().
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026120329.1792=
436-1-hca@linux.ibm.com?part=3D1

