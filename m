Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778223;
	b=Rs+jMBd5UBvCyDALdrqGdyzCw7l1vrLxH5FicAbSuXZXrcS5ozxgF7LuWks6vOsM3yvx
	 zDwwhcyjS+fjGoafUqV5wyRB4nsrBWXmyQUqiCh32oUxI4YDiMdwudUIfDt3FzeX9ZiKI
	 uH3BFJOt0FBtB0w2Z7K/ZxF2j87tBq+4wt+LCVx/bGenKv4ysLds+lHw1ptSIjvTVQkfU
	 6Nx4OxLv6I8iNurrlfkYszDpld3JD/eH/GQTRQFIMF5d0t+zVGiP4jwQToNfPM1ZcTlGw
	 PUqu+ubNeJ8yxiM8kcbjTLgVpAkjlZGjEvicEdUAcyPIOMOc5THnBgv1EtBtgXqwNcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778223;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6Jw9uCSZRxSggqm9YrH/jbJF1j9wfRLqeL1TtYmYAog=;
	b=40KYTzypfwqgsuXPS64joeaKyFj+MoUbidM2zZo42HfA+hQtRi1S0e8MwfsFpKuSvLkO
	 HC9lqwNNsW57lQ5ht0Qcb7VF4/f7+Vl0V8/sLPmYQ6tQMvsKr64W9ZgbABeE+QvMyUueS
	 /RmbErcbXnCModzim+I+ysH01ll7fVtRlLMtfpFLZ7BZhGPmnpt6zzMv+JJ2qi2ixfPem
	 rVWDI4mmPG8jlDG9BNhpoRtxeM6NrXb5Q/zeQPKEcg3lRgdkO3FUUuIOzahBmf7+IsE7L
	 91QK8R3Y3bRP0ba3R6BE09pbFAEvUfFrognjYd7cg9EVvHOJujALoFe3nUeJTq2FTFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJkJg54J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3CA606A326
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJkJg54J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78581F01825;
	Fri, 23 Oct 2026 17:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792778223;
	bh=6Jw9uCSZRxSggqm9YrH/jbJF1j9wfRLqeL1TtYmYAog=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kJkJg54JC9DSv//trFrBfVWpvW1JPztXaR5b2fxjLvbxjUQhq7uHUcKMRgOlsQM+1
	 lWWc61WSNRdUPQUitTMWPrcAL59nmPeMToaEG7SGY19LPYNTWNJmoNTDEgzv5QnL71
	 zwn8wkdXPKyG6PnPoi1vxL1w+MAkoyF+Hk3m0doHJm0qlqvT76iFaDo39L7w6FyqFW
	 ZbxPc/bvhlCO3h5G7+97eyjZ0W/x124t60NugcqAFbDSjxid/GeROuXPBuqEMmQjfs
	 o4NjZnAvrX01KWxwYrXnv8Dwcgl6B831hjiwnMjE85OzYTMVvtXu1rdiP2NU/5/BrX
	 WTPAFsbE69QWA==
Message-ID: <sashiko-outbox-183025@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 09/15] s390/vfio-ap: Prepare lock helpers and matrix
 init for cross-file use
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023174349.3545941-10-akrowiak@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
 <20261023174349.3545941-10-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 17:57:02 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Move get_update_locks_for_mdev() and release_update_locks_for_mdev() from
> vfio_ap_ops.c into vfio_ap_private.h as static inline functions so they a=
re
> accessible to vfio_ap_migration.c in subsequent patches.
>=20
> Add assert_has_update_locks_for_mdev() to vfio_ap_private.h for lockdep
> validation of these update locks across files.
>=20
> Make vfio_ap_matrix_init() non-static and add its declaration to
> vfio_ap_private.h for the same reason.
>=20
> No functional change.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023174349.3545=
941-1-akrowiak@linux.ibm.com?part=3D9

