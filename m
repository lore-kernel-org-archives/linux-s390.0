Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691455;
	b=aHuckQzicTOj4IoMxW8pxfW5RIyyxhRu446S0EE0W5MY0PL7Dgsoa5cxOBVfU9TeTPtl
	 GF0O3OcgKCo0ZCqYAELZhqlXYaG2/BebjzchV3zO5XMf2GK6C3i8oVI1KLVgFudFftV0k
	 UNWFOoB9sOFi3c8s6BXjTqNkLuZbzug4ut2jx2ud8QhmhRfUzTmwRtYC5IAAbsnNu4wJy
	 XZ579uhOAX7vadECEdc34FqjccAYGD/ECRdOB6V5cW1tGowlj3VCWKQaaCNdSRVXdf24f
	 kAg74x7N0RkuCRzPwx3v2kQ6JpCABlEC8yyGZqXwE5F+HElm3CzQAnhKVRfRJm1CBeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691455;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=C7WeszgSrrCUBiNVvRUrIK7Tpo0h94DIXNxPLpYeD3w=;
	b=30FP6DFwYvZtJ3HahHpDCFDpPWzrka4v6O5bc4FT9mnAIVetQXzHqu+hkebrrjrK3kzX
	 EqeiLoYiZZ1V/8jGiEQlZIDQKz3tHQwhg0RGcc+9Iw6glgBquc28yJmgK9c5Y2C7tr74t
	 WdgbK285qNrn9ebiFBFa6zBjbtzpIFtSnu68tYcVgq3uwv7qhSdLD8rSBziHieJNpRmr3
	 jVYnLlaAoxTqq5kZvkxb5TLJRcCOBDbtDpBUj29QH3KVmA0RtfKvGqMyD3uBFn0znc8AG
	 d/TwhLwPc3+UbQyY2BnaQFK8dtAbTxqIZjZf6iPo4/Dvgyo4gtSBGFmkZ75d+Y7eGYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YuX2B37n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C94606A31C;
	Thu, 26 Nov 2026 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YuX2B37n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2171F000C0;
	Thu, 26 Nov 2026 11:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691454;
	bh=C7WeszgSrrCUBiNVvRUrIK7Tpo0h94DIXNxPLpYeD3w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YuX2B37n3c7thHekrWtd7WZXob2EqAVYk3VeW45ljMfIHTtZH/SkwajeOZMYfWGmX
	 DCJXNwsSkif9TLh3+PYzJAsz9lYi/f5IpbbQcl/6dGxLWFx97kl9kXlt5oVpD4ps1F
	 tfUeMnGlAQZmeXDUDYki9r9pKuoH2HBT6Q0hrpGl/BRudqg7YqdxwHXZwJnQqoXlvF
	 /pLdmbXJuvyts0pSocD2zlIVgIWZYj6TPbd5etiieXFVD+ooCUNXTPVbRVO310Mm6w
	 J2tyfBWd8xsfYn96vmHrkhI537oS4d4MnUtXhAIbDWDLGoEvKVebddsEDRsTPxrjPe
	 yTADQMiMJQw4Q==
Message-ID: <sashiko-outbox-235348@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH slab/for-next v2 00/14] mm/slab: mandate
 SLAB_MAY_ACCOUNT for __GFP_ACCOUNT allocations to avoid wasting memory for
 slab metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SGFycnkgWW9vIChNZXRhKQ==?= <harry@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-0-7c680f02a734@kernel.org>
References: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-0-7c680f02a734@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:10:53 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 14-patch series:

- Patches 1-13: no issues found.
- Patch 14 ("mm/slab: do not set SLAB_MAY_ACCOUNT for all caches"): 1
  potential issue (1 Low)

A detailed review has been sent as a separate reply to patch 14.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-memalloc-p=
rof-dont-waste-slabobj-ext-metadata-v2-0-7c680f02a734@kernel.org
