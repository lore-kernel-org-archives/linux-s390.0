Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793213850;
	b=HvphrhzJG8q3oU0e8qafBiBKzdjZHzqYY4f0a2IqVdDRK56odRJuBY/qOcvRkc8IYhtD
	 sNwu0LNzsT8KtIPi+7EPmq+f7vVmQOx9ASSpDPs4MBE569RE6M/TCE086PKEFWQZpBq1s
	 smBwX1iPoS4NddQ9uBqVlmXSzxnjrxVwfLYv3mLunzzVqo3Yoc5rmBy1ldEknusKL0W2a
	 bnOdo/cPFYy4KmgmoTkBxzGNO0mZ8pea+inLiS+zsHkrPuPs2U7kT1p50y+u7zfo5ruED
	 Yao0qFH7r7ebufuKgTG5U334rx15fxRBOJBORAYy/bkp1zKU9RCc1v7gNKEMAyXLzWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793213850;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2jRkIDgZBZmv1PwsTOx11vFZApCpzJ+8Cgfr5caKFfQ=;
	b=WnU8qD8YkF+VonFu+LwpwdmLPNeZWjugd4HL/pgQYHK+euRt3wddMSaIUsVp1lHBNbwl
	 clu6bWQtNcmOdBchkD+zyie5sbd9600LP4Ccho0LNPXoYMNBgZMZ5GNOox6dW4utAtW3c
	 qODVBBA9XyonMMowwEU40gxJVcoTE7FyYp5jmERiLW7hgdPgnICSCl9ybuhZczX7OHK81
	 sMJvWxYCk3SDnrPZF/oRy4jKkyx8bqMfUOx+WxfrGwyYaZpuJGvvZNjh96llBACtNtcAO
	 FAGnCEi6wpA5cVw+cinH3hKOWUDFTT7acuGCkWNnm/Q5h2l1mmvQe3vULMvcYG4a2NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZkevPeiI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710C4606A31E
	for <linux-s390@vger.kernel.org>; Wed, 28 Oct 2026 18:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZkevPeiI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E062A1F031E0;
	Wed, 28 Oct 2026 18:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793213850;
	bh=2jRkIDgZBZmv1PwsTOx11vFZApCpzJ+8Cgfr5caKFfQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZkevPeiIvzaVBb//ImKbM5Dw02B6X6G4lDspZOFr8W9ZbW0IJ1lhkIQxOO4ydGliC
	 X9DLIVqX3CqgvzsLjmIJ3MpWgwXeE1JRlfeTjfKdK3kDc3+m05QQHCwxCEjsCy63nQ
	 cLbAwdCAaR+uHBdaqYdyz36kwzwwzOFK5gZfYMVhya+aQ6hAfNCVovxQrv3smbZiO8
	 eFZxyFmRuhUtfgUfQWv0OLcA6poRKogwpZ2yLluyBJtIdVxoUOLvi2WF0f6duFWCd3
	 lNi08WF/Q6QY1UnpZdxYeTNEysHoUqxsyWgjLIzBzAyZ6e1Yf0iJH3Fmzzt9nZ62F0
	 YW61m+OVCO5TQ==
Message-ID: <sashiko-outbox-188320@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/7] KVM: s390: Move some skey functions to headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028185422.272146-3-imbrenda@linux.ibm.com>
References: <20261028185422.272146-1-imbrenda@linux.ibm.com>
 <20261028185422.272146-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 18:57:29 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Move some storage key handling functions to headers, since they will be
> needed from outside, and they are small, so inlining is acceptable.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028185422.2721=
46-1-imbrenda@linux.ibm.com?part=3D2

