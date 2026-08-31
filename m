Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618542E7370
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 10:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788171682; cv=none; b=PsvvAazvK79iyu/xvKis08ekO4vWH1dO2iEnG/nS8leIfafsbcSLfsr4ErMGH8s6NNe2HW6jUVwxuhotoa65Gaaab9PQAFosu3xDpfmxAfNM/4nIe0ODYRsIwsfVsG1X/1GnSP3b+yAwYGQ4cgzyKu83s5+vEgJVpKJBSusGVhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788171682; c=relaxed/simple;
	bh=VI78HV0nNY60HLkUcwA7l1V+fUKpblvvwjQv0Q0BM5g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ixXg1WfU4Tdq5Yl5M0NE2Wy72AloTYKJHAlFltSq52u14zCydXxog0tKWCWF54fK6z+j3OuM8ErIEBL+6f/5AGhNyDIqENrnB4g5eeCdUrXUfpOvNEVTCX6Jdg6z4nNuZgy07OT7JsYyumM5zB7DVK4xnfcE1xj4Vrdy5d8Yipw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMFNzrGm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMFNzrGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0621F000E9;
	Mon, 31 Aug 2026 10:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788171681;
	bh=VI78HV0nNY60HLkUcwA7l1V+fUKpblvvwjQv0Q0BM5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oMFNzrGmFgYbJAqZtdmGWRbGjwRAzAzGdhiPbbfTivhHh01uIzZlaI/VXFYj9YyOD
	 KR/DfxSKNKxqI2uiI4O5NGYkNCxGPU+z20qhwYrohSoXEhWDV35nqgQMZJzwKgR1K5
	 6MNdgnQNhtK3ydC864cNBdYhnWLyKthN+b0mCgPEgUed/Keyn6TksPn5X50Q9CA/ON
	 MzOGuz+U+q7a30jvPlMlNwU44OmskoC8MNTnFJmGBDJxzp+PPTpwe47WBylj3/ro3z
	 aMxT4NjPaaLn42Gu6MhFgm9AvwvU966t1GaofXmS+RyLfOZpMngJUff5wA0ruJY3dI
	 BgHMnjEMZGd9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/3] sparc: Implement arch_do_panic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260831-arch_do_panic-v6-3-a1e170a9e7fd@linux.ibm.com>
References: <20260831-arch_do_panic-v6-0-a1e170a9e7fd@linux.ibm.com>
 <20260831-arch_do_panic-v6-3-a1e170a9e7fd@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 10:21:20 +0000
Message-Id: <20260831102120.AF0621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Implement sparc specific arch_do_panic() instead of using sparc specific
> ifdef sections in vpanic() code.
> Reorder arch specific panic handling, sparc's Stop-A messages are now
> printed after "end Kernel panic" marker.
>=20
> Reviewed-by: Bradley Morgan <include@grrlz.net>
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-arch_do_pa=
nic-v6-0-a1e170a9e7fd@linux.ibm.com?part=3D3

