Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572027;
	b=V8PUy2U7m0K6ByvuU9Imew1PI2ouDfg7hlpIdcnEyCFGC6N54oa7IivgGJaaA4xJJcwK
	 PisdLg83zlqsybfkyku0UcoVqEuPxPxYvMvw1W+3hwvkVkinBN8Em7sogvBzJMsw7uzq4
	 g6IMvvySA22DgnRxf92764B9LoBcht9MMTf6VnW2aG/BrrLcCY15oGZ8luVLYkvdv9rlg
	 HbnR3+D197wusmM8qiyCX6ZGpi3JbvZ3nmtdueE3Qm+DS0OZjko6/Voa20qWFe6TbU8aP
	 XAfRkI8HsRzrm36YFqgZnOt1L2s7RzVnnIblAJ6Sva/0WKs8tmE7vvjWEe0SZVXXbpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572027;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dRazo+aONwH000YeXiAjJrPYBqW5oZw7qPVWEkT9qrg=;
	b=OrHIn4R6d5Esq3z4LUsl+fm5sfcMf//ybyXwlglYq1+mUvFXhX7fyrSIk8NUqM0dDEo+
	 VEZggXzBV/1+WxxZFEcQhCdQ4HGODJ7x23TSd+u+NRd8/pASFtii4EArOaKK0DXGrwu9S
	 /GPfZPWyMSQrQlLFo0gB2aRjkd3ejVceoBaB20csJi+FtxkqfG6OWz0Rcp0I24F20S6tV
	 DvSdLASkM4/6wqNZPoobpB5dLHqBSNpRFaoIL6WKlXlb4857SjJTMJKvallg0TS+ks1zs
	 4jShTgirqt53FuPjI65J1LNYBcAU5b+wr9BFUXzAq8I9mVqNsdfnuiBelZrgYqtmO7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UlkTTFes;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5311760A6F77
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 08:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UlkTTFes
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDEE1F000C9;
	Wed, 21 Oct 2026 08:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792572026;
	bh=dRazo+aONwH000YeXiAjJrPYBqW5oZw7qPVWEkT9qrg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UlkTTFes6Rli6nBZo1GW04jwFDcwVBKWMSHDlkuxx1FVMEnlX1h8oYYW6KzkHE7uA
	 BdpJw+C8Cg5UIs8YOwMfAAO6CAhJuMTfKJclrOp2FzIDlOSoDKYbE7irC/uuyyBQM4
	 XIvnvHGvmlJg4rT+wnnZaj6lghYr+r16fRYH3OfW4Ffv8M8A3XTb0G7O1TbdGGHSOS
	 jpdNDy6vOoBM/J+vQOGyTCY3wwagoKCeX49r0bv7Ncnvpplk0G55FumGWMcKQwekcd
	 L+UdFrOGAmdv5T2YSQey88MSXHmWNRpeVi+ULom0nQ4aGPCFfZ3/nRiGUyRYwOY79i
	 LjS9R7T5iu+zA==
Message-ID: <sashiko-outbox-179979@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 1/2] zfcp: Replace sg-list with sg_table in
 zfcp_fsf_ct_els structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "M Nikhil" <nikh1092@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261021083351.1626409-2-nikh1092@linux.ibm.com>
References: <20261021083351.1626409-1-nikh1092@linux.ibm.com>
 <20261021083351.1626409-2-nikh1092@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 08:40:25 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> The zfcp_fsf_ct_els data structure is updated to replace the sg_req and
> sg_resp members, which are of type struct scatterlist, with request and
> response sg_table instances.
>=20
> These sg_table structure reference the corresponding scatterlists
> (sg_req and sg_resp) maintained in struct zfcp_fc_req.
>=20
> These changes allows to track the original and mapped scatterlist nents
> once zfcp is converted to use DMA-API for mapping the sg lists.
>=20
> Signed-off-by: M Nikhil <nikh1092@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021083351.1626=
409-1-nikh1092@linux.ibm.com?part=3D1

