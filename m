Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140933;
	b=mnZ/ebBXYcnpZ40nJRUY6qakFD5YwOYb1zOSIt7bY/aJ4fZElQ68hpYLc1JwOwSIM26d
	 LDs0DsEekxbBFPq0c6q2YGUwlbHX9iAIXe9ByJ6G0dO7XsDEtmeJ3j/1qb1rP67XSy0Ir
	 z2eL0f+9EYdRL5WylofoA1CC8d1uxeCVQZ5LjSFEdgCeCyJfZR4y1hGV+5FcPX7lT2A/H
	 h9c4yBhqjWHUGEx8kXeotlxc4XuFdg441eZhqbKaCTASgkGw5fNgFheWWarpKkg0K5I++
	 eDNvqbmzle+XTkSTi8aIqaw2eIeKvZoG0Yzz46evA233M5N/HdQNHctCmOb4+hQv6rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140933;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hcQw5+GJG6FYx8VoqiFqOCza58NC3Zufcy5AcTGSdn8=;
	b=wDB+Gi1ZpGXaLrcyO5rPLLH2VSnFdFoomOsflGYhTgRAyUKYGNkPBxiURngb7EbMO7Fa
	 gRs3BJd5NpOa9R+6AxzgtuEQ5seDYXKah42Whpt9uC/1Ku2JNJtmToPht7MGcXB58QSN6
	 x7U3EysuPIKIv+NbvleLzIm0lZvN3Vmtvq/cs10YCn70NgPv48lZFI0l8HscYQjPzNmog
	 jOCbL21XhaLMvaSwK4mKqIAjcuiERQSaD5oMJyRF/8GBvElMe+iyfI0Crea8pY6tPId8L
	 ElMBV0q7vA9facyZd4tXAvtpFSgh1TUnxX6OzLvlSjkTqDuX6hSLxy7S+4GC0gHkfYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FLPwDEt4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3B3606A31A
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 22:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FLPwDEt4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D6E1F01825;
	Tue, 27 Oct 2026 22:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793140932;
	bh=hcQw5+GJG6FYx8VoqiFqOCza58NC3Zufcy5AcTGSdn8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FLPwDEt4QN/hKKhwjqBLfaM8GdIWJpt9cHMFxmSlImQ1zmO6BhoLSaSLU2YZtmkzh
	 PmCE+KbsDOyz+PrL0mZ/GI/2zDsAlGuzf+6Mra8iz7EQ+mQS0/LKxxUWzOJbFC7L3c
	 u/nHoi/fEVA/xhwyvtzKpYYM0LhvSPZKNTR6OIa6FJIzq2xgCQJBnzTWbqHY1Qlutx
	 5PnGPwDkFdTJeDUHK8kM1s5Q1Cccz3rEG7BC08Fr3wxBXWooIjSsypdLHcq4SCjdIK
	 zA0HjIpivUHvk0+kCmAonT3RQTVtcM2qJ0yPmAKLNAbijG7zfhL0hDHIsgaz01f20f
	 a6sPr8o4bEY4Q==
Message-ID: <sashiko-outbox-187170@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/9] xen/sys-hypervisor: Add release callback to
 hyp_sysfs_kobj_type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261027223847.652884-7-irogers@google.com>
References: <20261027223847.652884-1-irogers@google.com>
 <20261027223847.652884-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 22:42:12 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
> with kobject_create_and_add() (which allocates a dynamic kobject using
> dynamic_kobj_ktype), and hypervisor_subsys_init() in
> drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype with
> &hyp_sysfs_kobj_type, which had no .release callback.
>=20
> Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
> kobject release behavior.
>=20
> Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027223847.6528=
84-1-irogers@google.com?part=3D6

