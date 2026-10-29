Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793304997;
	b=mCTbHNVc8eBwgIzhq+hQ9J2WuxWTJyHIT4wbb8nl9OfpHWMa7AladL85B6Hjq5xjXpJ0
	 99vtuF+cTgbPWZdcFe9V4ZWIWb7rECS/5xs2HGa0w2VkQpnE84dplM2PfE/wGj5w6+Q3W
	 4CuCxeIA2xVDamOBWWpiU2kIF58Wn451RwgSJMFvfJB8FJOO9W1uS7LO8qL/BA7UTFR9g
	 f2lqOWDtUuyvLmi0vTsgS8IofFQPRZT8V74AutBzpeRo+cSHMS/qi8jslCJDaTuY4WAal
	 85C+HMXjGT4qAfZg7fb+LQSQnfQ4JHY0lVC2O0ns4GHnWz0iKe8DgspAaChKkA3qr7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793304997;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2ZgkjScb+0OD9v26VHxT1ff4wS3soVAyGNbtaNaBaFU=;
	b=g+FkjAdPhmFegsX8E9Wrfgsomb6M3FZxUkWkPRiExZd1djRaNlhYW6PDdiVCCFAOMMbM
	 Q0CSjuiz/vmsMean31rkdSgGdzJS5FV6ckMzTxazQT8uLrQ/Jieqy1Kti5kypDJM2uwij
	 ZT4sCOcIPY+pBZAstf7HTL+muQrKKbqAMSYob7ljMW9q+39U2tzSofiAqMkhw5wyB03vs
	 6Jha4NrBTlPa0pU9YaTXKhWV0SAltoPfIWvdYEABcCFbUT8ixHO5Rvj/QSUILcVaR4doH
	 K/y6Gvfhqg5pjIXhQHjeGJ7kQr+Kbf0G+H1t5GwrIu4uD14f/K1rpy/iRa2yRYh9pKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EOocZ/x2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100C7606A31C
	for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2026 20:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOocZ/x2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C9E1F01816;
	Thu, 29 Oct 2026 20:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793304996;
	bh=2ZgkjScb+0OD9v26VHxT1ff4wS3soVAyGNbtaNaBaFU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EOocZ/x2foPyhub1OxrymFy/dVAcS1XnJONRSADh8daKeX9xDUgfMHryHN9Ul3YhS
	 PpeyGM/mRBNt8+rj9td8QnMxA0BWzWrsjx9IlS5+SN20FxFEh4qjiEmNRSaQT6SXAi
	 LZz6nmK6n8rZmWlIuh6p1twy/lEuaC2Pa9JLtiElG+ycTmQyYrQ+6Qij/rSC2Gt6U4
	 DQPMap/OhhSKJLQ4NPt+P3f6GTzqV4mzNyrILjKy32CWPUt0GB5AX4TNPZb9a+gt9V
	 CEi35SepJZq/BIKaoSlRLTQRCOfiF22klw7LCvXZpHnwC3LGoXqPwCXwdFENhVKtcY
	 99wsdxSrVbFBQ==
Message-ID: <sashiko-outbox-189913@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/15] mm/hugetlb: fix reservation leak on min_size=
 mounts
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RGF2aWQgSGlsZGVuYnJhbmQgKEFybSk=?= <david@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028-fixes_hugetlb-v1-13-a0a033db180f@kernel.org>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-13-a0a033db180f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 20:16:36 +0000
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
> Failed allocations for CoW mappings can leak reservations on hugetlbfs
> mounts with min_size=3D and no size=3D. The leaked reservations survive
> unmount.
>=20
> HPG_restore_reserve makes free_huge_folio() restore the global
> reservation without returning it to the subpool. This assumes the
> reserve map holds the reservation. However, a CoW mapping may have no
> reserve map, or the map may already account for another folio at the
> same index.
>=20
> Commit 58db7c5fbe7d ("mm/hugetlb: fix avoid_reserve to allow taking
> folio from subpool") allowed owner CoW allocations to consume subpool
> reservations. Commit 51e1de00acdb ("mm/hugetlb: simplify
> [ ... ]
> Fixes: 58db7c5fbe7d ("mm/hugetlb: fix avoid_reserve to allow taking folio=
 from subpool")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify comments and improve description; updated Fixes ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-fixes_huge=
tlb-v1-0-a0a033db180f@kernel.org?part=3D13

