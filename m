Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547FE2D2382
	for <linux-s390@vger.kernel.org>; Tue, 28 Jul 2026 05:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785217352; cv=none; b=tEOH2qvwJ+5F/dkiWU8jfua3/iyiVYd3NxDLmRZ+UliapH5Qwjfd1y9cc41ycie/FBSFg5sZ8fqFXgBePvaGzA4kRjNLDXrym7NXscaAuY5cFbNpbb4UMtZuFiw6/CKblLvqqWfzULTS9IMbT1qCN1gm1GiLI18LHQAqnkflCjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785217352; c=relaxed/simple;
	bh=SNKIuOovSMlJviVaUBzkxl+W6CX9x9aCFMELHJJ84PE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tAUsZlYFIPBGnxCWaJvoWvO+redomwu6Qy05IryK7ym8O/ZWNqKvJ+sbX4ebNmV3GoErBKk+KNEFlfiS3dbTv/D4rz0AJ5NkynAYZq5WxgI+jozELKGHcWJIvYgSz0YtRxw04K1/ISb+ryK/tdNy+rFh2w5gPM8tZRB4zcgl9fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYmMPmxC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYmMPmxC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A877C1F000E9;
	Tue, 28 Jul 2026 05:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785217351;
	bh=5hapgXXue4VpBGjpVhorSGiRuw+XKTVCbbDxiAo4gUk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FYmMPmxC1e9KtwGfHSR/XPJYeWhR4NEAkJ+X/tWUHrH81Gl8wSkr6lYbwj/9+dz/t
	 hUH9gQsmSnCuEyywNuGAmlAlKzPB11hErmmgoSciUAanl7pzXYhInsoEKDPKAEacU7
	 d9dwYOxKOHL3gATaLQpKhjo6Yj0Fb96FcRfTSwXdHOnSUcTudsy1PMcSd7C/BNkdDB
	 BY4Xn0Un5ZAfo6ZvutWwgWGQFKYHizYf0sDrTRkdoLQ66vRLvz8Vfm4OkjJNT8Q89t
	 rgD0b9aRR+FWdOTJHn042zJfuL38ObNHBD4M9RrtOZWK51mUHiOWYucnIj7/4GlNc8
	 dekNOO5eHS0Kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 8/8] futex: Use runtime constants for __futex_hash()
 hot path
Reply-To: sashiko-reviews@lists.linux.dev
To: "K Prateek Nayak" <kprateek.nayak@amd.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260728052540.4728-9-kprateek.nayak@amd.com>
References: <20260728052540.4728-1-kprateek.nayak@amd.com>
 <20260728052540.4728-9-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 05:42:30 +0000
Message-Id: <20260728054230.A877C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Peter Zijlstra <peterz@infradead.org>
>=20
> Runtime constify the read-only after init data  __futex_shift(shift_32),
> __futex_mask(mask_32), and __futex_queues(ptr) used in __futex_hash()
> hot path to avoid referencing global variable.
>=20
> This also allows __futex_queues to be allocated dynamically to
> "nr_node_ids" slots instead of reserving config dependent MAX_NUMNODES
> (1 << CONFIG_NODES_SHIFT) worth of slots upfront.
>=20
> Runtime constants are initialized before their first access and
> runtime_const_init() provides necessary barrier to ensure subsequent
> accesses are not reordered against their initialization.
>=20
> No functional changes intended.
>=20
>   [ prateek: Dynamically allocate __futex_queues, mark the global data
>     __ro_after_init since they are constified after futex_init(). ]
>=20
> Link: https://patch.msgid.link/20260227161841.GH606826@noisy.programming.=
kicks-ass.net
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de> # MAX_NUMN=
ODES bloat
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728052540.4728=
-1-kprateek.nayak@amd.com?part=3D8

