Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011484;
	b=c/uGokuCEc4g9AB7zHeq/ElI9QAnwKBNYhbChcF+d4agrDAZx6szrGp+W+BCpNCpHlt/
	 HfAUvMJffr41kVyO3tEQ/3Ca9tKpEDY55wRnL+3cdiAqgBkFbgypBA/ztN2meLT93h0F8
	 Xbx05483xmxOZVsFcPAcqQt+V0LukidJXoXjwxZu9RZxlu+8yarhE/qDyYuESZkIAm6Sy
	 atIRppSREghdGCwfNfvrf552J9v08r+5+6rXSgTPfvPhHb4pjAKCJjztNGCGmr3iQhFHi
	 E9HW1HLDic/u7fRfp3DAArczfS4jWHVin+AuoPLVQjX88hZPAgh0pOi6WeyhJWPsUcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011484;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KoUJhQP41cHREP7Mk5xVXtaHi/99d0NraciQaLTlOaU=;
	b=1VYaPcQvms7NYIDDj85AZpY9qXvbQDlt76Ze3Q7lEQDYThfU1A/VngBPhFHClifgqlzl
	 2D0T9XJxFvLtKQNKbYLgnidzg1Z0vLCUGYX5tW+T9M575cNSy4HXnVxwFElBeKTU+D4oG
	 yzII1SFKvkP3sqiqg2Tq7pKh1il1FNNZnuUTxNjHO3tkMwGj6tgNYJv/GYcs8kbwv8W5E
	 BQVSDB+ikj6ppna/dPkP43qPcwKB+KAueac2TSz8xpkBOqysSCt/GnT6DIIIAtmud7g3b
	 aOtC2xKBrgQI3H5uqm88Xcs/kZ6bidxwDIZQ4yJiQG56h1WYsyj8TFK5C+uqocBIMNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kFVk7ZTX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081BF606A31A
	for <linux-s390@vger.kernel.org>; Mon, 26 Oct 2026 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kFVk7ZTX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5109D1F01825;
	Mon, 26 Oct 2026 10:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793011483;
	bh=KoUJhQP41cHREP7Mk5xVXtaHi/99d0NraciQaLTlOaU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kFVk7ZTX4XgOeS4K7o0/fa09dqa2o//9M8vQ19K4z0o8pTAuB0fBe3n51AkXlln/c
	 FGt36ZBUk4lNnvC+wqQjqMkiHv1TxW4YB5B4enCEvUESjnTWtF+dH/CvyxCwH/1ryW
	 VJG9Gu5IWclzR0JUgEHHp5Fj/OP0pdu2YXZouhcbBMLSKxT8Hq4CHYsjt6Dz1RAXn3
	 j9lKuYZbi0/dVKesOnnF0r7G1SarDj+bZzOWVQDUwn1ke9AjoS9pGBqUZU3CKe4CFa
	 UsVyOIETgikAUL/yHRJnwZYMKzs6NimVcJOsuK+hJgcIG1ItSX6F5cxfKyySabCAFY
	 iJ3Vyal802b+A==
Message-ID: <sashiko-outbox-185003@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 1/2] zfcp: Replace sg-list with sg_table in
 zfcp_fsf_ct_els structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "M Nikhil" <nikh1092@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261026101301.3543163-2-nikh1092@linux.ibm.com>
References: <20261026101301.3543163-1-nikh1092@linux.ibm.com>
 <20261026101301.3543163-2-nikh1092@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:44:42 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026101301.3543=
163-1-nikh1092@linux.ibm.com?part=3D1

