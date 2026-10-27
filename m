Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793141204;
	b=reJKt53arCRPcYT8pXy62fddNdCpqnKYvcI9J6aC+oaRr5OKBKbdIr2/nwK9bOHb2Ql1
	 vHvboagoAHLVsdVyDiM9dFkGPK141af3MSQYFDr6v6dSIRy1Fym99EjV0l1Kkcdwo4jI2
	 FyGed0FV30zfSvc3zsII4lAPwI/0eF3LwMS0N851YQLgLsluuWgM4EcqpRG7F3AQKxUM6
	 aV2SZnmEh5o3dNukfW4Wws2HiqssheXXDeF6bKjuLXB1Tc9cLIjiH3fk6Lv+EijN/yi1v
	 JRiHNvxX435xezC2RxPQRU2JphOKqQjvtxvs03yckA4movGny2WwYGvdjEKQHawKp+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793141204;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/uk6JupM8Byrf64fuiHJP9a4C46EbyQvEREly9GQGbM=;
	b=3jipvLpJkILe9RoQ7gxseX/sDnmr2hMI9Sp97v2za2WlWfm0QjlyYTULI8MVsPfrddLa
	 wIL4HBJ2KQnfLWAOXlizyK01r6aSouXSbzOAnq49uzan07TSouO4skWgFQUncyFP0jQda
	 9PMhNylsOlM33HV54bpbczaAMqgmyYoX5tJQ80xIftI93++n/83t39w3AqwrFpGYuR4VS
	 u24K0Wn5rlJm74CHgtlSvQ0ynuMGxoSTVBjUASJM7N66Vn/qzRMlt0AwX+oz/5h16FKOt
	 Z181R5q43xyJmKmU5l58HEyKD8QYK426AVa9KKIu6G2qdNXZGCYF1bBEkeZhZbgpRdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bznfQ3Ko;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05102606A31A
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 22:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bznfQ3Ko
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5871F01825;
	Tue, 27 Oct 2026 22:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793141203;
	bh=/uk6JupM8Byrf64fuiHJP9a4C46EbyQvEREly9GQGbM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bznfQ3KoLrTHBpe5ljzU9HrXOycMl3xocZuG0FInYWZML3vu3m3GuizFNl863eV3W
	 4iSQiwCFW1TdrNeVOVCYsp0aVI/z49RQHiN3BSO1mv/kK4e0GWuLNlmVs9cPTEzkuU
	 yorPqs9rZ/z1x3n27CesWV8PPG9h4ANts85fJuZ2WRD19v/XMmWYm9c4hE/SpBoZSe
	 8SoJDnMPmqlfdDrXBPMGVTwEQCBER6tpkWEcajikD2zawuWMbJe3Rfg4p3wMHXeCaM
	 9NjHyRqSqrDlpsjVvBttAmHZpKU5JlRhJsoq+Vv6RvTDmslisMcRVnj60MZysPBiur
	 MJFUtZ2jZeOcg==
Message-ID: <sashiko-outbox-187177@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/9] sh: sq: Add missing kobject release callback to
 ktype_percpu_entry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261027223847.652884-4-irogers@google.com>
References: <20261027223847.652884-1-irogers@google.com>
 <20261027223847.652884-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 22:46:42 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> In sq_dev_add(), sq_kobject[cpu] is dynamically allocated with
> kzalloc_obj() and initialized with ktype_percpu_entry. When
> sq_dev_remove() calls kobject_put(kobj), the kobject is never freed
> because ktype_percpu_entry lacks a .release callback.
>=20
> Provide a sq_kobj_release() callback that calls kfree(kobj).
>=20
> Fixes: d7c30c682a27 ("sh: Store Queue API rework.")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027223847.6528=
84-1-irogers@google.com?part=3D3

