Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851588;
	b=mxBradX4Fuq2rv57bwX3qagPdoSxrMRsqRTYVwpHE+3yZB8R2jfegFwC0hB0riCdHt0o
	 0NjKOCxiFD1TYbtaiN4TQZxRz/bnoFUE8erH1GKA1gm+4AOeL/D8M7O7dJQ9jNbPnlRaG
	 kuWSWFoWbJQq0AXSrTEGiiskuJBpR1QeReufDkIxc99v6z8SyhdZohtXEp60wV7t/C4s7
	 noE88fwv/j84CQwlSM61YLahzidMUskO63hEnMIU08Kh0De+PG2mZqBEihgA8OplSiDwP
	 03HsH8HAYh8BRGy3NVUO4P8NGBbQFVy9bk6NSSzqQwAxHYISKMl5GOdyn5sa/zaerJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851588;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zpbHg6lxx+iqkT8i9Zd1e2pFepInVeIGs6d9VZpctGU=;
	b=KdhAT8rTUlh4AGOhgXHuZPHi32XKqf1agMxZHK9rmAiONpmiSkLcX20icMU7s+pxX+8F
	 t+RS/UkF9eUVHAxz8VW2jh4VJJ3QA7TdyRrebWffnLWzyPcOtysVXMZXgzlOdqAcIWjPh
	 HVYMPJQCGYmpmkihICCSkgyB6p2Dn+Vx7EEuy//vxwZRd0juhPfVRa5X3PN31DkKc+XXa
	 S6gw0hDjVpC8pkV/3dv2FapPLqT5THuJgKe/2p91DkwoA+rK2mCqb6D5rAOJQaH1u2WOj
	 e6l9c44n9EyGrIQUgRAX4bx8+5bE0jNX91/kGkAICVU8tF6vcUUZAZU/CKrOvNd24HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XLNCTVcl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A377D606A885
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 17:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XLNCTVcl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AAC1F000C4;
	Mon, 16 Nov 2026 17:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851588;
	bh=zpbHg6lxx+iqkT8i9Zd1e2pFepInVeIGs6d9VZpctGU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XLNCTVclSDSQKyBLhFyQSzlTmYWW6dakOunp9lr6cMwhG9oW031nqYVtLFfh16+mE
	 pKO6qzaprFljtNJdphSCpFNoEnrQpCzaFNl/k9wjQmRQoyljwR33DL2Zi+UlyqrWMp
	 JN6H/uBo6vfhVJ/Q/g8nSRV2T3MQUlHLtVc6OjSoMkhtapgu/7teFIBCy6j/VSefC9
	 Or763k/djN+S1erS3CfW2XeXHjEw9s+diaM556qDZn5JEOQajXrsXsHz55McqHO9jf
	 lBz/moD8qH3Q7SKYbvwRpLoBp4P670Nuz23/bHFJgAIQCTxeOWcxY2Iutsy0F1nQrE
	 GKO2xc8VIq46w==
Message-ID: <sashiko-outbox-217452@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/15] s390/cert_store: Fix max_vcxe_length output in
 pr_dbf_vcssb()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261116143534.158375-14-hca@linux.ibm.com>
References: <20261116143534.158375-1-hca@linux.ibm.com>
 <20261116143534.158375-14-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 17:53:07 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Print the correct value for max_vcxe_length.
>=20
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116143534.1583=
75-2-hca@linux.ibm.com?part=3D13

