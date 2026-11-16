Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855915;
	b=c9WuZnJVroSvCRrg/SSzL3cjWzpL6B5rsiHLVNXYcc2gyt2n3fPklsIC8ecpsSY8Gbl4
	 TdG6UqMNcnCsDQ2hjVvYTiRVm1LjOBEJzTIxFsvKKWw1ighga92GGspe1Dz7UVz4gYTi0
	 0y1rV5vLohqitOrOThyZAfrWrCvwdOrfu50ehdYC1dpOagvJeEVmpdzwCtXqsrjg0m0yh
	 rEaTdKiGcvXdrk24O3NZ++6y1a5qL1E83SWnfJxsRWyOE7b24lbFDwJjObVkliovsm088
	 kypm5N6lHQQmQL8x3Hd57pEn3uV7wbbooCO88xCWiy3YSmQ/XCl56TKpzoWReJ3eMYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855915;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hQMyvlUDDpZq+isIjPVMWQxFOYkJetCUfOz7fLnlOBM=;
	b=4NMQW7Udpi9Y1Rxd9L3tdj1rLT6BRhWOUw+frhTLluB+uOxZD2znHCTXtxOFypjDz+He
	 hUonz+SIE1SWYn1P83450k43Xvrp4CjV9fGjLKLIw+G9o9kAUdTifTBvpakoPxGPaEJlg
	 1istulR941eWrnw9hFXxV1oTCqQ8RDzTWMTiwKF31UCZ0Gg6O4ZWSvcrwIktjgpvgOzwM
	 nGO6NuVRfSTJblw1Bte6lnJbjYbhaDG6ASZEakg4ZUzrEMfjy4AP1N+C14aizGmBGDM8z
	 JtnSYLRdLN2Derxo/5WSQPpOMAHbVg6lXTKBkxYwtXmcK5DKGCx3gZvk0vk9wpMguww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=St0u2DJW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C71606A33D
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=St0u2DJW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6535E1F000C4;
	Mon, 16 Nov 2026 19:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855914;
	bh=hQMyvlUDDpZq+isIjPVMWQxFOYkJetCUfOz7fLnlOBM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=St0u2DJWPYjshaFXAgSS5Eus7obP8pf5q/hi/4UlTTQnTMVcDo2vc24Eu77VupfbL
	 7s283VgHA3fL3x20U6kzvQcC1VlVn9eDV8K/zzwPzwK3cs/fEAYB4/fz+TSTNtoBuV
	 gsVv2FOCD5Rx5XFAY8Y01Bf/F6VLdQIzxeL6iieUdpFuY+BNNvMSvxELO8zWg4RPFF
	 KDZsAMLgY5MGglfaWQ8H3URAYZpgOXtmR3gjjPHL9YH6pdVkM1T2lcB6klAJ68/gJv
	 BAVEbXvU2D2m0yNCecjoHcS4ByRIBD+w349pGqbly6Pr87c/0bn5DP/ZKeWuHEnRxE
	 XCZBbqVYOyK/w==
Message-ID: <sashiko-outbox-217538@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/15] mm/hugetlb: account restored reservations
 before freeing folios
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261116-fixes_hugetlb-v2-14-4dd9e94ea9ac@kernel.org>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-14-4dd9e94ea9ac@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:05:13 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Unmapping an anonymous folio restores its private VMA reservation
> immediately, but the global reservation count is only restored when the
> folio is freed.
>=20
> If any folio reference delays freeing, closing the VMA or refaulting can
> decrement resv_huge_pages before it was incremented. This can underflow
> the counter or hide another mapping's reservation, allowing an unreserved
> allocation to consume its backing.
>=20
> Increment resv_huge_pages when restoring the reserve map instead. Detach
> the folio from its subpool, since the restored reservation now owns that
> charge. Leave the restore-reserve flag clear so freeing the folio does not
> repeat the accounting. The folio only becomes free after its last referen=
ce
> is dropped.
>=20
> [ ... ]
>=20
> Fixes: df7a6d1f6405 ("mm/hugetlb: restore the reservation if needed")
> Cc: stable@kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-fixes_huge=
tlb-v2-0-4dd9e94ea9ac@kernel.org?part=3D14

