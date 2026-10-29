Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793304989;
	b=rRKUgbNI8k59od2mDpfEZ7N9jSxVbQC/ZymWljuhGnNvOPVuv52d0eGt1cY0j9zqcCX3
	 TGedaM3mnri491j/iER2/UNlmhocJW+cWbf9Fw4ME8Erh5sBRuAYhIXAYG04yPB9/zewF
	 BQOOoV9Avkj7ETgOiI9GWchl56XWWSHcMw+wdRlZgwSZVfx3KlrsdXqMiagNEQsEnplBc
	 nGHF1OeRYKAiGE7pnzng8wf4SHKSfnJv74W6fCGYBMf4lx8e5GJgbdg0p7MZXX7BBB0Hj
	 IvMWitz9hZ2v1X+RkNXen+NycF1J/fNp5nmMStw473Er2hEG8/M1xm7r/vqN9W1YM/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793304989;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AxNmwJBKlxecny9YVwqV2JoVO4w6PJHdqtVtUqCq+wA=;
	b=ADGyCkd2GbeyzBpP1Xe2TMmuxFE8X8B6YlDwHQscvoJP1GAZW+mhtzLIIixduVKFLgGC
	 IwihFEKLac+ERo30FycHcjEKE+QW9F1V2VBJM2p8HFzPkm2XPM3RzY8TqQpOIDnQZYt2o
	 j6qQnL/tgCbItMtKLAmR/QbUzyLQXNCkRG9tXsRBAFC+ncR9lcR1na7xfGsfOU2tDqwd8
	 p0g9xovdfmdCf9FY2Ct6E6OGynLCayu6i/9k4cpGuI+fgC/DzZA5ayaN665tahX46NysP
	 VfYaT35XRE32RgfCjdECUn4H1Ru/6h/TrK2AnyfkSEH/tKjZUUcqRgg8pw3gFYCEc4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3XpYeVB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993AB606A31F
	for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2026 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3XpYeVB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16C31F01816;
	Thu, 29 Oct 2026 20:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793304989;
	bh=AxNmwJBKlxecny9YVwqV2JoVO4w6PJHdqtVtUqCq+wA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V3XpYeVBbdCTx7FvBCKqHb0zy6pfsc9YOdzknYyyo2eVTLie/p3/s8IvpocKpgmAI
	 rgsttrpF+tkp5V6JWLLtHSoplklp4TbRrCBecrti+dQR6e4280Ya3/LPUAOjpqeU8z
	 fm7y11fHLjcUrCqA3I5kCMkGrHj/XTSdLd0qhdh4zTsXQZGgQ4J3qRYtk3HvXVFRys
	 ooZZwcNczJ60OSH5HXSJCjCskH7KnOEhO8aCezmRWKytw8Lhzlxn11z4987BSP0Ywc
	 +bibwapFKMjpKrPNKQlvfLhG6RlgD0bGeHMgXBC7obcWbPwj6MOL9XGlrg0KLKWjOt
	 m39uVPiF6bQ8w==
Message-ID: <sashiko-outbox-189903@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/15] mm/hugetlb: preserve reservations when shrinking
 on HIGHMEM
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028-fixes_hugetlb-v1-3-a0a033db180f@kernel.org>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-3-a0a033db180f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 20:16:28 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> try_to_free_low() drops the hugetlb_lock while freeing lowmem folios.
> set_max_huge_pages() then resumes freeing folios using the
> min_count computed before that unlock. Reservations created in between
> can consequently lose their backing.
>=20
> Collect lowmem folios on the caller's existing page_list instead. Keep
> the hugetlb_lock held through both selection passes, and free the combined
> list at the caller's existing unlock point.
>=20
> Likely not stable-worthy.
>=20
> Fixes: 1121828a0c21 ("hugetlb: call update_and_free_page without hugetlb_=
lock")
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-fixes_huge=
tlb-v1-0-a0a033db180f@kernel.org?part=3D3

