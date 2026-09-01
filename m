Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A695334751B
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253412; cv=none; b=ePp8WsC9GYFCgUNdMYdzWefNxOxQUsBtkiV+/YrDtjju+w92wHGwSe1ywYdWQPSK2jb9OpOl/EFTVeA7lTFbQVJBOtTtKHF9dXrTOgayZqi8dhPjRL1OE6XO1dj3bvSryH1DeZIn0ivdumsbRkVIMlYYNHUxotJmZe38ZE6GbOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253412; c=relaxed/simple;
	bh=c9FEZiaVRx9KEiqWemK1mJ7FV05WxkuRog0LPXXRfKY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CUD2H27/V0MY10OturYDyuaFRBtKsi75E/xqedGs0m65bidFglmfmt8282FFA6Uh6QHg4RYQb+jCp9pras0ZmA+jS3qqeEx2J8u0WokJWxCfwSxffrsOiuCH8JJePM4Sq9ham2Hqfnh7iW5M+iy2TIw1N3kJCMQDS2m87y1MEuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAX2R445; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAX2R445"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6891F000E9;
	Tue,  1 Sep 2026 09:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788253411;
	bh=CstRL96Epbo1JlYlEexfYcRiElaILfQdFtZfoumagK0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TAX2R445Tq4iVfsd5sEkYbtTeTbeB7BmJLzA2Xp2oe9G7CwGls2d6vBTLn8SeBsIB
	 XsondwWkRAAkaIHIbUyE66D0hP8ww7EiNYpmXufXyDVF3SCvBPW2tiPL5S0dtPLmdI
	 5ZZjw/Bq7TJV2/Q/p5wOqDt5vEgg1KB6/tRY22K0dRCcOMs/LxmaqbMLQFWTFYONqz
	 vwJFZqKnv/B0rBd0ygjDmfH+eFLPiN6vPAe9TFzmAJSTPGem0vofQ50GxeFDGqhEq9
	 ysZnPEy+p3HJw+L+WABjauP2po3zFZ/OXGzcWpO682oW3c1yiMJ2Bm4aT6AjE7VVqa
	 /D2a1nnxyR4iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3 v8] s390/pai: Support CPU hotplug for PMU PAI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260901085448.2260658-4-tmricht@linux.ibm.com>
References: <20260901085448.2260658-1-tmricht@linux.ibm.com>
 <20260901085448.2260658-4-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 09:03:30 +0000
Message-Id: <20260901090331.0B6891F000E9@smtp.kernel.org>
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
> Cc: stable@vger.kernel.org # v6.19
> Fixes: 582cc1b28e8c ("s390/pai_ext: Enable per-task and system-wide sampl=
ing event")
> Fixes: 9f66572f2889 ("s390/pai_crypto: Enable per-task and system-wide sa=
mpling event")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901085448.2260=
658-1-tmricht@linux.ibm.com?part=3D3

