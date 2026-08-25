Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF6C3D2FE1
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787643430; cv=none; b=YyWjUgQ7v6pWcRfUcu75S37Ncly6SCRA5qvoSDWVf+ptTjARKsDSExOwnEb9EMTutWs6YYM62obuYFE4tLZ17RMgB8zJ8xZD9fNqpZvhXNcNWmdjbbqR+8og/nRVomU1z0VBElkgYfwK7ftOlgnw3dEPTTsENueYDBibQKhO7EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787643430; c=relaxed/simple;
	bh=dx+GlyM9NCbK8ZBe+ewYtoEV+y+z6AKUvY6oKrCPjFo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JDfMn0qOUZRkkufqRZkg0xJ5ymDRdkgW7z1iVOVd5bLoOPLS4OiCt6Ggg8EDFwYQmOM/D5DSFLgLN8FU3aZDQVJeG/qBfftTQVDQLA32L6BDAeNiheTbotLXAtfc5lIx1qRpZ58DP496vneHE7kbJB8vv4BONe0Dxs/5VL9JtVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHdi5xWF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHdi5xWF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81331F000E9;
	Tue, 25 Aug 2026 07:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787643429;
	bh=/U/CvVs2WBu7Jsfj5KSc92rKzOruUz4x5ruF6dt78YE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XHdi5xWF3zuT/V8Td1Tm5TkPZRIw4ERgZrMtHHK+WrGM7uTVtzkWxlRL3Rr/ZoHBe
	 12uNGNJY6WXoO3CRtRSrblOecaiEc6Gcnhz/ABdHyRga5hkVlZcVAkXfe9sgVvS4oj
	 9i959e5ae6bZl85qt4e64SvG/WwmukrbIrjlZrLw4vYrH9QG4vQ7Nn5XFCBbzXHhwt
	 tQXfXRQfkacXNMss7Hfs1JsPI4Oz6xUJLxOxyqNsRvNW579r0GTJVpTIRZzGf67Jh/
	 IkcEGNEWW3Eykv8CkcNSxPYecK0hC6brOp2PhLZ7IlPFhAVpoDtaaHUxTWWP7Bm/Dc
	 dfNb4e8GRm9RA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3 v6] s390/pai: Support CPU hotplug for PMU PAI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260825072931.3738180-4-tmricht@linux.ibm.com>
References: <20260825072931.3738180-1-tmricht@linux.ibm.com>
 <20260825072931.3738180-4-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 07:37:08 +0000
Message-Id: <20260825073708.E81331F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The command 'perf stat -e pai_crypto/CRYPTO_ALL/ -- <command>'
> crashes the kernel when CPUs are hotplug added during that run.
>=20
> Root cause is the missing allocation of per-CPU data structures
> for that new CPU. The allocation is dynamic and the first
> event that has task context creates such a structure for
> each online CPU. This is not sufficient. CPUs may be offline
> during event creation and can be set online during the
> perf run time. For example commands
>=20
>  # echo 0 > /sys/devices/system/cpu/cpu1/online
>  # perf stat -e cycles -i -- stress-ng -t10s --matrix X
>  # sleep 1
>  # echo 1 > /sys/devices/system/cpu/cpu1/online
>=20
> [ ... ]
>=20
>  #Cc: stable@vger.kernel.org # v6.19
> Fixes: 582cc1b28e8c ("s390/pai_ext: Enable per-task and system-wide sampl=
ing event")
> Fixes: 9f66572f2889 ("s390/pai_crypto: Enable per-task and system-wide sa=
mpling event")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825072931.3738=
180-1-tmricht@linux.ibm.com?part=3D3

