Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792772618;
	b=ErODDBtplJyT1hSzc7/4RDYmeUQabA2TQRVdIDzqPtJG4MJ/y5Cwb7wa6tqaaeovmpge
	 bybysrE2pvoWNf6TFg6rSBztdrhICpkLucwA9lA7Xqcjmry7WPrmb1j25lzAa16K2FUxo
	 uMP0Xt7injHcTPRQ5fbLkJb0hSwkWA2mEhY4p+4ztF592m5bPySUFKIqHYc5vkpjjiIBw
	 hO+avPcGIqTHDrERyBIszB7SwgBP+zpCn9OxDj6qRRNUoXKrM1jYAnIaS0Die5CjOzgbZ
	 fM+t/nyA/Xm3vMhVWGPfSi8fqo7gQDwR71NbQLKbjKPT8VuwvxDlmR+PhnPp6j0dkfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792772618;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OGfwvdrR71ck5Y+rKdwgKOLZ1IRo2q59oFJ08f6gZHU=;
	b=HSaDp4yTB93tdgB40kxUAWO70kzVkkpEjQ+jaQvFgXdX8Ga0DpHmZYQBq4CqfwkTSUDN
	 PU9jIv/oorxCayijQb9ch6MvcghZEeBysvcvDXvNV2saSg2hnQCYr6BQ528/WSFhqLLiZ
	 dxOfvdLnOKU/1my/Rmkv3ksxJ0DzPHravVZy2xv8aJrIDNJXwHau7n9yjJsmvi65sS5Q3
	 kd5iEzLNkfSazbTS0To+14OGyn+xvLPxHqne6uf3TdfeBTy1X8QYojn5w8L4OSmiKpVVh
	 MTucTC1Hc7ugbX1V2Dt2sMUVexb16GS5G7jg9dCSP33ZeMr+lK8ibwffTpRGqpx5xqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L7zNX1RZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862C3606A31A
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L7zNX1RZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71351F01829;
	Fri, 23 Oct 2026 16:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792772618;
	bh=OGfwvdrR71ck5Y+rKdwgKOLZ1IRo2q59oFJ08f6gZHU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L7zNX1RZeeQpy6c/Yw4HpYhoacUz6+UAKO14QnHgLj0+vrNnh9H759LAuEKfN4/oh
	 6IrNmcZUvqMD0bq7AAR3BfdPAuD4tZBJFvMMx0bBkJDoS/8LvTx+A2/yKdKxtpXO0/
	 HFREqTCTjbblIIbAYHu/p5/H3fz1W7FnrO5zu8mFe9cAIsu5asU8+Cxhg1TmtiO842
	 h9qsyL5E8yjlvsG99l5JHZG8ncAsngDeUMq1mgdiybtxWTkdiOfowdG5fc//LtF2dD
	 yaAId0yWNMRN0p4ZYXmuY43g7Ju6lkjYaO1nodnnAoNwOGgqG+D1khbf47C9CESuwq
	 06zfl3Nt0oEDg==
Message-ID: <sashiko-outbox-182946@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/10] KVM: s390: Refactor and improve DAT tables
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023155531.206113-3-imbrenda@linux.ibm.com>
References: <20261023155531.206113-1-imbrenda@linux.ibm.com>
 <20261023155531.206113-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 16:23:37 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Refactor and improve functions to handle gmap DAT tables. Handle
> machine_has_tlb_guest() inside the helper functions; the callers won't
> have to worry about it anymore.
>=20
> Add crdte_pte() to allow using CRDTE on ptes.
>=20
> Fix idte_crste() to add the missing table-type bits and the missing
> "memory" clobber.
>=20
> Fixes: 5a74e3d93417 ("KVM: s390: KVM-specific bitfields and helper functi=
ons")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023155531.2061=
13-1-imbrenda@linux.ibm.com?part=3D2

