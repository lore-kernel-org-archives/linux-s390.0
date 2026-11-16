Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855913;
	b=K0z6eyRRwzQ8LP91yXzF++4IXZmiaca0Fd6eIv9tsKabAS8iRWO2I/wYWFynQUly6QBa
	 tKjtqECZ9Hwlyyoke42hUTTxJvNloBfAvKH+BE+sn/llYkMGY27wQ6Tz9c3iQMwqJ2UaQ
	 ET6NMCGLk9o37tcx0CHMCxM5BAYm2+8njhbBHCGvT/zNQaKBES754WHAx5yLz7A3ODaE3
	 ZYdKlUggzArSxqfelZYm50ajG+3uosnO91HqpWgwkK/nVCWj57jp7WiWcGVRJmDwd3287
	 DFjibq8oML+MCEWM7BVgZxNo1TN7Q39ODBDir0qjmQ4LuB+TNgNS7QZ4Q9OiTUohYpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855913;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=c4v23hdlmiuikYFvPf9OZGJZaDadH2SRYyYl8XmlS8I=;
	b=2JOK7HN7ZemvuFADMRR/j3NTXXwWQz6TMYlKs9Pd/NnQkvSvcMGzREh/H+anXcGIv+b8
	 1PCq7Qshxd3KOAUl0C3xIEJiyxq6L2273C97PH0WIHVgrLgsT9wg82N3i+AjVpe2wHxIS
	 OoNG2nzPv3XflNRyYY7N/CVEpunCaaRdYIm1QohWkUnWc4PRMDNCZlnGH+QMSqOVQoh+Y
	 pdW1aGZp/lCK3ZTm3s0Yns61ZH31p6Uwr1RAJKUxVFEYliRCDFGRqarYou/NRPlSH9DyT
	 s42UDO8A/XlLnaD/sxMtFCUKs3IRb5iDti95dUTIBC+nKPfIIWye4W0qnJRSXaHIydQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hMO5WTW3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E18D606A31C
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 19:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hMO5WTW3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE60C1F000C4;
	Mon, 16 Nov 2026 19:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855913;
	bh=c4v23hdlmiuikYFvPf9OZGJZaDadH2SRYyYl8XmlS8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hMO5WTW3nI/UZut87lByp2RJU4uS+jnNL7l5KLt72MXWAhpc1z6CAZfqa6viARg/g
	 cLMOEU/m4O0fVHNNBxV6+RdpXZt0RO1AwXFobNG7TVrc87SRmUjM5Ur4GkmNRLrCFv
	 N23502YgkVBSWd+DdxBE3SjLcMF/ouR5oMZpZjFTQyIYRBVkL/9Oao77xY3yS1dTKs
	 BEGGn/uwhDQl8P+Zf6NSIiBN+QQ5w2eyXxr+qa9pdPut8BVjwYTwH178r/tEWjnuXt
	 ouDukDEATtKR8ioV3qVYAIKi9G8woMha2yxyIwtpE6MIUCPHZIrKbzRkwwE6Y3NHk/
	 w5bOs7DcCF/aA==
Message-ID: <sashiko-outbox-217536@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/15] mm/hugetlb: keep surplus folios that are
 reserved
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261116-fixes_hugetlb-v2-12-4dd9e94ea9ac@kernel.org>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-12-4dd9e94ea9ac@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:05:12 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> From: Chris Mason <mason@kernel.org>
>=20
> free_huge_folio() may restore a reservation, but still returns the folio
> to the page allocator if its node has surplus huge pages.
>=20
> For example, start with no hugetlb folios and allow one surplus 2 MiB
> folio:
>=20
>   1. Mount hugetlbfs with pagesize=3D2M,min_size=3D2M. This allocates and
>      reserves one surplus folio: free=3D1, reserved=3D1.
>   2. Create a 2 MiB file and write to a shared mapping of it. The fault
>      consumes the folio and its reservation: free=3D0, reserved=3D0.
>   3. Unmap the file and truncate it to zero. The mount's reservation is
>      restored, but the surplus folio is freed: free=3D0, reserved=3D1.
>=20
> [ ... ]
> [ david: simplify comment and description ]
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-fixes_huge=
tlb-v2-0-4dd9e94ea9ac@kernel.org?part=3D12

