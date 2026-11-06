Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997224;
	b=xnvHAFxVSMj1A91xsqzxCJ3SgySUpmFv3ugQGZUkQE8Q+JyA5HHvQiEJhpa7XOA6M+9b
	 aBbTEaQc3p2u/Eu3RLu3aCWFL1EL+waZQV8mSfL66uFtMBBtMonaNawjA8/XJTpidqEHl
	 +WWySafExXj8sCDolp/TYbw+GEY+Eq6wQ4jbRlZRPd0TAk8niZbRsj3BBtFaRSZzdSyUQ
	 ZaT63LPD+GsTn1KlxlYL4OR08IFAztP7QgmqhipLxrm0dMnJAajPauwIbx7XxzYUKSlEQ
	 8knK69qFyAUApOcw+TaghGtYHPyZK8nZNvjujXZ7/TcBjHWOdrKyFWD4EdO962Kkgiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997224;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q84ZmGJ78bCW+NX5g3nLOKOcOhOR4i+tGv4jimnPh9E=;
	b=iMyDZlq1XTQFGWVAZc34+4bCFPFnQLWIWNSsAkQrrFEY9B8RS8IO/MMTrFCpCvc7TzDK
	 GaPrCjJE5yDSP48zLLJtx1bFNW30184DwexYTEdcY4qdRHkoAZFj5zxBLGkMYfDiuVwkW
	 3pksxjk7RnkTtQzmA+92/Tq7ALDDQ46erHhJg/JtJKC0X10Z06iIsxGA+LJ2PhGqrs0n5
	 nhfXWEdkUsi5WcgNWq1LS4kNNhUnCkJCSsGB0Qwui+Q3LAbomX6Z7RxPJXEVIjzgyr7Z8
	 yGqvQMVhspxVmVYUMUmppMScxUebMkO/qpBtZLbP3kTG5LWt9iB5EVMDK8u7xA+juSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=frZRGfGw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDED606A32E
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 20:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=frZRGfGw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EC91F008A1;
	Fri,  6 Nov 2026 20:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997224;
	bh=q84ZmGJ78bCW+NX5g3nLOKOcOhOR4i+tGv4jimnPh9E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=frZRGfGwOAYAi1Kf8mbO6HamR6DKY+JiIsO7nB938ONUlFusYCUupuTdeQ5/fCJLS
	 1nWH6pAq3ZIZiMvPRff/DwXEkTm6k8P9QPS8G8FsBin4Aljo9+osmi0Lm5YDakbxoC
	 e3l14uT7L5OIf+XX/D6KlrewN8JdIQY6rtr82ZbhP24Vk2nYeHCxMM9A+xOidVgnKi
	 zCkfC4Jc+tGSGSP0SrBgqmo3sZVHOcTUbdQd3YgS01Uueu/brNz+8TEuXF1GchGDau
	 cz+VsmhiL/pKh5mKp6IOHe0jsdjGtjeWG/P6weFfQH5xoHjQGRLvhyHJhHasoOnMYG
	 hfPJ1ZRwgSD5Q==
Message-ID: <sashiko-outbox-202225@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 12/15] alpha: Use the common syscall table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-12-8d1275885d9c@igalia.com>
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
 <20261105-tonyk-syscall_table-v9-12-8d1275885d9c@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:33:43 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Remove some of the duplicated code by using the common syscall number
> table.
>=20
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-tonyk-sysc=
all_table-v9-0-8d1275885d9c@igalia.com?part=3D12

