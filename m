Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979015;
	b=cfokDihjuiO0M/IRLA1cbDTipN7oj4AJ6O0l4312gkRnXn4ERAA1iKk/mKYn4Go3IFXE
	 VdTP+3QT/cQz0e8ja/kgKuc4CYuR+0oHqnO+yHJHWlnqKJvRzWUA2xRdgW9JIP7DLZRvL
	 3a472H9wWEvrt8IsZ+YQ7LOQ0HuaWd2irlOjd7tQBl0530IssjtKKDyQkeq9LUZ+u2ai8
	 kwlw/0KjrA39H2fpzoLcqMDxV/Y+l7TM5x7L588OgdaLaTdz0yqD3qNix4yqpI4vN5kAj
	 TFTJhA5Agf+1Sj7Y+AAqg9vn0Q+05pn/EFWd/OgSb6xTlyJi8PDeOFC5jPHI+cMrUbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979015;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/QVC/UkETG+h+C/UdQkqpPZ9YILWocr8FAi82i+L5aM=;
	b=o9NYQFk/m6B3xGKeO0qtmRkUIg/4rV3hhiKJvYmYQlrm7+aPjTsGa47/ytJ/iSGY2OAy
	 5gq99s6v6k7pVf7GsNm5vY9FfScrRJZD4aTnKS+PM/7iVKgEBflhvmsWtfm/KXeJ/b+tL
	 e+pPHuBCmNYtKXmupfBnFfRBntnO9hy+aYmvTedCC+QAAtotf+kIH2n0c8fZOpSDCI+Ln
	 u4XXezbnVDAY7EJrstMa58TjhnEYJYQDBfEopJE/pa77CboptZ30x22ABjwBMB0ZDlTOK
	 Ld5yCSVTOktp/e0yrfpy6xMaYs1Id1rU6UZJvuOqi62X6mskS6+8iGBqf27np0mejCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g335Z+tB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED999606A329
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g335Z+tB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA291F008A1;
	Fri,  6 Nov 2026 15:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793979014;
	bh=/QVC/UkETG+h+C/UdQkqpPZ9YILWocr8FAi82i+L5aM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g335Z+tB3MJIq6OU4uCip/1TRpJWa4V2vi+AhCdApTnKPt0ceEKbcRmlqn9MOj9vz
	 KU8SCyf4Z6rptIY3TEifzG7kvEcGGUdZFyVsR9FqJlcaOrqk2XymEtYBCqKCbnHC9s
	 d8BaV7J+sxy078Jb568i1260nyAmKAyIwTsZkjYHhKNH9Wwg99GNfIrHCHRP+UaUCP
	 0B4Nu7DxEw1ad6VfdJeZw84krA5yIsgiklheRYV8m7ykgFHpVmugnrHOnIn57a+h2P
	 FDSK8q8+Ss2f03VBKemlVUAkvG6S3G8zCiutY1f5GiTXBoYl33Ma+uStxg1AGLv/Ap
	 c7lkWuxN9nW3Q==
Message-ID: <sashiko-outbox-201695@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 02/14] s390/vfio-ap: Data structures for
 facilitating vfio device migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106152259.1360651-3-akrowiak@linux.ibm.com>
References: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
 <20261106152259.1360651-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:30:13 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Creates the data structures used to facilitate state transitions during
> vfio device migration.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106152259.1360=
651-1-akrowiak@linux.ibm.com?part=3D2

