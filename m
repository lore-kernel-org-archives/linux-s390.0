Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C826A2EC0A4
	for <linux-s390@vger.kernel.org>; Fri, 16 Oct 2026 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136430; cv=none; b=ON5eEr7bKP+5vtIu861XtDWuiR99spbzQXL0rq22QaA9mf9IfwTcVNH8sx5S3lEWM6aiS5V7G8fy5FwLx9Fl/LSplzYvpBME2z1w7Pl4jTBRu8KfgSRQ2vKx4gXyquDwg/wWPJS5rXAiZoOlmYu9+LzB5Mg1wAQc64u0O6QB9iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136430; c=relaxed/simple;
	bh=ClYuYu2CzIkHiUY6Nj7GAqJjS3mfujx8+xttusic63I=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=SMY8nc/LjN1k2DAxt9g/a91Fj3fh/lYb0l7a81miw4wQ8YXvJNbEOeltUugFdeuzL1WP5iGEgnew7+6HLlEgi6q7XhsGbr0wpIU96ciA7cC88Wlvp/YXG2thB/ARYl6jimAzF13tta7y+xPGzxiQtL034/cq2DNcBxMRJBYjGF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKqdkpGr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKqdkpGr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB6D1F000C4;
	Fri, 16 Oct 2026 07:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792136428;
	bh=ClYuYu2CzIkHiUY6Nj7GAqJjS3mfujx8+xttusic63I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lKqdkpGr8SvfV/O9AnG9RZTdCGjUcR3RcE3+yU9KQRsBQzVxGTDnn77Uj7K8B/vRb
	 FbdjYNtGmj/iX2noEXvit5jIN/T2L0Q3EMReG0Cpdi9LFf6/Th4x/1XBC8/NcxP/bi
	 ftdPY8UzyQ5qn6ftSkMdpVmSxw05hUN9z9Eiqxskzc1m94dJN3Glb8dJEL2Ga8SEtX
	 ugGTuq307mPR5xU8oBUxjo2E0IPIXWjNoVOwDGqIE3hMwa85UD2P38k+enUp+q0pWY
	 kTkshSGqGnkgjlk9SXDdoSZT2mN3naPgbMIpXFBPiXKj1G2bELEeybHdE24dmLAeZF
	 g7YDeTcqlKcMg==
Message-ID: <sashiko-outbox-173950@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3] sched: Replace nr_iowait_cpu() with a bool accessor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Loehle" <christian.loehle@arm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261016073341.575472-1-christian.loehle@arm.com>
References: <20261016073341.575472-1-christian.loehle@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:40:27 +0000
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
> Also convert the remaining open-coded idle accounting checks to use the
> predicate, as suggested by Prateek.
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016073341.5754=
72-1-christian.loehle@arm.com?part=3D1

