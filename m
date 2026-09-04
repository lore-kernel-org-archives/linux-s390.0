Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E0D42640C;
	Fri,  4 Sep 2026 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788552095; cv=none; b=fLWGH2AiUGoDvgrWmjelZt7SVdy/4vggvNC0rnQsUg671Ft1PGdHj2UnjCXDLim1zZzgQrOOBPXleGdSvTg3ZKcIsroDxc4HBTXVOnfJhSJAEmmxYwsb2ykkgQLVEfDQ9qW8f1LVOa9SIzlnh3p1Sci2wqWRni0aUfrTSYwvgJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788552095; c=relaxed/simple;
	bh=MvW6mScfSB2YZglB+IWa018TmGtascV60jj2wUUur4w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C816aGeasAxHXbMIHfP5PweyCCspapmj2kmJ1bvC632SVb2yjPTV7QV0gApydggETe3Emq7/riAQRdh2swoYNnpr1mReOxuPs63tw8oUHwDP77FM9BIjJYbcem7RBI1XaqX8r1rlw1ZwZU3Kslj2Aam0KW41JaQOwYJE9N+Q2N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORUUPMzG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORUUPMzG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE781F00A3F;
	Fri,  4 Sep 2026 20:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788552090;
	bh=MvW6mScfSB2YZglB+IWa018TmGtascV60jj2wUUur4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ORUUPMzGPQkInHHE+JmCnYIzxGlu4bC/a2MYhv3IO5eZu2NWqcoxNARgdTwfwNpLH
	 QGjU3iPn4Mswc1+8Sbd8KozUbmPM87ZRCYBernaAbQ88RN0csXIe0eIA529mtVFkDj
	 I2yA3k3d/DKR8h4+f/4Hm6tBexvJ926bz5WVXnEJJXeSPPc/9zOPdiYMbzRk+3V9VA
	 RaNZf6bv4H+ssK0m+UcSvKKgDF06m//fMseatq49HOY8CgMucoHJUKfRBEuFGrOaFQ
	 j1ek9Pqv973hKqmaU8F/hhFCONEARnR+p6zZV66AuM0O/nic1m+kjRLC8H+qnpEWpQ
	 fp2WqK42wkHsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 3/7] bpf, arm64: Use resolved pointer for
 timed may_goto
Reply-To: sashiko-reviews@lists.linux.dev
To: "Siddharth Chintamaneni" <sidchintamaneni@gmail.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, bpf@vger.kernel.org
In-Reply-To: <20260904195132.141068-4-sidchintamaneni@gmail.com>
References: <20260904195132.141068-1-sidchintamaneni@gmail.com>
 <20260904195132.141068-4-sidchintamaneni@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 20:01:29 +0000
Message-Id: <20260904200129.BFE781F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The timed may_goto fixup now passes the resolved counter pointer through
> BPF_REG_AX instead of a stack offset.
>=20
> Copy the pointer directly into the first argument register rather than
> adding it to the BPF frame pointer again.
>=20
> Fixes: 16175375da36 ("bpf, arm64: Add JIT support for timed may_goto")
> Reported-by: Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>
> Link: https://lore.kernel.org/all/20260824213158.3755932-2-Jeremy.Jean@os=
s.cyber.gouv.fr/
> Assisted-by: Copilot:gpt-5.6-sol
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904195132.1410=
68-1-sidchintamaneni@gmail.com?part=3D3

