Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954F0175A68
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 05:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785389801; cv=none; b=OL/IHmyeA4fE0qtF5vJWI7GsddDWZRORe3YO1CJJHGMbMz963v2Hu571f8AAEWlGUcLEOuRZkzFBOcVMYkUSVlQdSWcZ71ueLZxT/NerhSZYh8udeMa+Ec1vjCSt5BxREFPSiGLdwJCb1ILzHZrB28wPLywEXd0Nu78/e/8WfRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785389801; c=relaxed/simple;
	bh=906fGhlN0H52RxAt78Bi2IZsjXYbsLgWFoKOHX03dTw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SCKAARwMXsQ92KPL5lndxT4TcU8+peA+G4VajXf6MDppNjA7RGUY8dRXzo8kMgWxCtbJUCBioCuUaygh3WUk0MyozTL/V5JZSBiVgKqSn1m9BP2Aj3SD48KXuxRBmEzGRMx0dqEs0MPcajz/ZmgxAj5zSiXmiS6QbRoLQ2dtPF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+YyWgLT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+YyWgLT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF171F000E9;
	Thu, 30 Jul 2026 05:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785389800;
	bh=906fGhlN0H52RxAt78Bi2IZsjXYbsLgWFoKOHX03dTw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j+YyWgLTUvcHPWtuqj4jPIjTKw0tGiQhcZyMiYxT0MLUYAyUs5CQa0KzlZoP6b3yk
	 dDAIU3O2+PF+xRFl99BU+fSb1HOxOKWF454XzhVOd0zDLa9MwywhVYsq2R1FozAWDV
	 tJCI90e7ssCiKGlzcfSUFd/bhreD1Qdck9aWE5GTNl7yeJlxHlNky7uD75K1Mdqfeg
	 o0GQNrRrXl4Yk/gjhOpuX9HnnOI3j+JPWbwj+6Q4583yZkDMNd3ZV2P1yMfnGVVSIR
	 c6o5Cgc8VG/L9zdLiZhkJq8MkrcvU51Ewo6LaA5RBRrJW3u1b0AQSSMsPsVc9qVAyO
	 KGISubb1keZKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] KVM: s390: Remove cond_resched() calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260730052907.2607026-3-hca@linux.ibm.com>
References: <20260730052907.2607026-1-hca@linux.ibm.com>
 <20260730052907.2607026-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 05:36:39 +0000
Message-Id: <20260730053639.CAF171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Since [1] cond_resched() is a no-op on s390. Remove all calls.
>=20
> This also entirely removes uv_call_sched() and replaces all call sites
> with uv_call(), since both functions are identical after the removal
> of cond_resched().
>=20
> [1] commit 7dadeaa6e851 ("sched: Further restrict the preemption modes")
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730052907.2607=
026-1-hca@linux.ibm.com?part=3D2

