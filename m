Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685391;
	b=cDxRZ0j89S8FfOeAI+a+hSq7quUnfTjC9m71xiBZ81tMK1BilbSWHlcRjP9gsS5UQkiB
	 rI4Vxkuo10lFsV0NtWf5LB+SQk8oED6AeiUZdaTupY0SEGsDd7ns1SCSQ4p/1zf3VihHB
	 TXlmh5984nhYet7c1zfDoDfCUSselSnFC+uiySUYkcMUd289Yg4k0S6tJR275taa+EtgG
	 lTdmXYQWmLnSO4CVyyHbEz6MN6vnMSmHVat4qyAnFzPvdyxKTgfRAcIib1ImJuARv72fU
	 dA51M+JKVC030Qz6xZYPcQgdqL9PdzVWOpwMTU0tRMceFbTzbeovMGf8yjD/J7M+YNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685391;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=x+8ZDkHGFusaQ6LV+Sm4/zhyrdEs28pHcZNnc6m119Y=;
	b=CpgS9cP3QR4Wt4RRpQMkpS8+tAWIWRXOzxO6GfwVj9z2V63OLueP2jMwYQiqLZMMRhEn
	 lg8rxPFKtI5FfdpTnbfcSH6TqFNIFxEQR5FVznkbO3kCBTiWVifjrgO4XwKo5kU/FW8/J
	 fdIkWEjxLt8dGtp67hJqIwmqhGyXij233gM7N2WTeUzAwX6E22opJqWONbZHDfwOxoT92
	 Er3bCpwzZ6lIszyKaXogvqwExz3XYAghKe/QmH+HqWLIe0vccUKsmDyjRi3VtTh+DLxY4
	 2MOiUzH+lKXv2esu5ApC/+/LnAqFongwu1RGuRDB/wP4TaX99Pdv9/zUBXdonuoN5KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=frI+tnXH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A153E606A32A
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=frI+tnXH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99D41F01828;
	Thu, 22 Oct 2026 16:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685391;
	bh=x+8ZDkHGFusaQ6LV+Sm4/zhyrdEs28pHcZNnc6m119Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=frI+tnXHJSN+EmyRt+6mtLtZUw6FslLCLLLDPQ2E9BqkPFmKdQWpwZCCiv59xSguO
	 UTF71XN7po8aP1ZQNjBwVirDCrWF+yZKtGVNr4ZmKfTBnixm+3CSTsEUX3y30JOa+k
	 mmCvwmdSltPlN1hx6DBwHvfqKKVzOrnTgClI5WViuTWcoJkMY7eA/t6YvjEK3yhkFd
	 HrhxtolNqWreh5Cvwh4BABjZFfN5KoWJPqodjHFYCpSF/3nDlv7EDqskkRY4gWcBLs
	 94rpBkQs6nd/LYqXWSgIC43jJIn6xE+0p1OO2trf0HCdajXTe0u+qLancEDWHQhyqm
	 YdcbH0cnb2ZBg==
Message-ID: <sashiko-outbox-181759@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 05/10] KVM: s390: Replace ASCE usage with a struct
 with more flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261022155531.204593-6-imbrenda@linux.ibm.com>
References: <20261022155531.204593-1-imbrenda@linux.ibm.com>
 <20261022155531.204593-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:09:50 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Replace usage of simple ASCEs with a struct that contains the ASCE, a
> pointer to the table, and some flags.
>=20
> This way, there will be no need to manually pass the various flags in
> addition to the ASCE where needed. Walking the DAT tables will also not
> need to first convert the physical address to virtual.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022155531.2045=
93-1-imbrenda@linux.ibm.com?part=3D5

