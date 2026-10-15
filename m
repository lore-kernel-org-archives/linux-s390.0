Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76100497B98
	for <linux-s390@vger.kernel.org>; Thu, 15 Oct 2026 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053601; cv=none; b=IUqLLroaITtPZiFWmBlshoxwH/aEjlZ/gos5Utq7VRl9MbH0iQcYwKbWQAJM6BljpdXoLSozPB4ulJZ+dlSAtwdnU0NzGujyPWxOJJn10AWfyPTIomKhdN6RjPI/g9qctSLd9MD3nsI2u4+WTYphynigbhqkyljOIVgbaFgmdqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053601; c=relaxed/simple;
	bh=IIp1Dmu97nHwUrXO9/9BjSDqyTUdBMQ3xhrQcXUIjeU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hrPqgels9sURCORJ7hkhdssW6GmwMoLoG/qZzfsPUovfj0T0tswbMqSFnwo9MbSq41Hr9eySbvaaP1yF2Wq4Yl7A2hZzm/XahxhkOWCZw59XssMWfkUKeWfqSQ6Z0M1gqSU3zYTlUpt/QU752I1ieGn6CNt9VwRPiYMWRCG6Gu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3KQMglL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3KQMglL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D231F000C4;
	Thu, 15 Oct 2026 08:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792053600;
	bh=IIp1Dmu97nHwUrXO9/9BjSDqyTUdBMQ3xhrQcXUIjeU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a3KQMglLaYbEWG7OfRsBNzBfihUveT4g+nUd6oVVOl8rejp04nrkDkH6alqZU3T0p
	 lRgWna8BtUS8JUM952t0aQUOdhHbxNX9mWipl5O68/UmORqfYeOS179sffTIpD5Xed
	 FSplWlXzBxUMQBjP2txgz05J55LuJ4pihdjURPBobG1fHl1oGcCaZWJz7zM6isjJpS
	 dYSjbZJ3Te0yDGfYGjxwC03TxH3rj81DHFisyWZUDmp95akQPNtU4Opmd0CuBsO0ti
	 kJPAzreX0/0l6uuZT7bKYRtjF+NQBpXQMhvNdVnh2iuZucSOzdvySmJVQaa/cVqGzj
	 5J7mr/S3rkuVQ==
Message-ID: <sashiko-outbox-172506@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2] sched: Replace nr_iowait_cpu() with a bool accessor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Loehle" <christian.loehle@arm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261015083317.3733733-1-christian.loehle@arm.com>
References: <20261015083317.3733733-1-christian.loehle@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 08:39:59 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The menu governor was the last consumer of the per-CPU I/O-wait count
> that needed its magnitude, apart from nr_iowait() summing it globally.
> Commit 38f83090f515 ("cpuidle: menu: Remove iowait influence") removed
> that use. All remaining per-CPU consumers only test for zero/nonzero.
>=20
> Replace nr_iowait_cpu() with bool cpu_has_iowait() and update the generic
> and s390 idle accounting callers. Have nr_iowait() read the counters
> directly so that the global total and existing accounting are preserved.
> Replace the stale menu comment with a description of the predicate.
>=20
> The conversion was done with coccinelle:
>=20
> @ predicate depends on patch @
> expression cpu;
> @@
>=20
> - nr_iowait_cpu(cpu) > 0
> + cpu_has_iowait(cpu)
>=20
> @ callers depends on patch @
> expression cpu;
> @@
>=20
> - nr_iowait_cpu(cpu)
> + cpu_has_iowait(cpu)
>=20
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015083317.3733=
733-1-christian.loehle@arm.com?part=3D1

