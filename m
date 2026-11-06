Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987148;
	b=J47ztmhBRVi2bgGkATw/8u1KTsXKixgg1qpEHxtotrkHlCVDQPOTf53ed3TlPnVeEWuz
	 OvlKcPU3b+cdnv9puHmNrdg+KRFezZu5mSj4Xga8MHvVEKLsZ1QEd59YWJffRYvFwxTaa
	 QpkVRiSuXQVCYU9XMGY2k3KXdTNOGaplT2m2QnA7xtMyNmcB5uQ5bqnzO9cVMnMDRoWfP
	 UknZSfPpCkzWP840XOspN1x/Gkg5+UcRXBL1II1gJG9p3SUKroeZFQyPoaWDwjcvQ6rDC
	 WO3Bm6drs+irbLAbTkWyGYli4gI2CxZ6rgppKDYNZuyuvAFKFETNDcPgIZJosWDlDRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987148;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DMjQ9DC1pWykD24Du0rvBsCPdDYdbQmtaFNgbc3MGhs=;
	b=OY6oql9ndJxRzap1cFH7zeElR6uBSNtyVcZEdO6hB3Dt0pvj2zrr0zgGK7HTra2/XLFo
	 RUANcpmIHkgjisOa+4XX0gB5/KadYjEr7vzittpt+hZGhXHWZtyrWkyphgI/eG8JWuz33
	 MRryb/aIuAeO8IEEZnruGbYSQq5mSiNnc2Svd2Np/RkeoZydTLLOLB24/nAxuHNhD/EdO
	 t5mjKN2L4XgOeAODkaVfRJaVI6LxWZtXzJ00o3t2Z/PhDJL9iqDSb6ZtDSdzfWMxXQpj2
	 sFKQxfH6oacnWmMAqd7Nyy9rM3tgU5pH0q3F8mRlrWhDwMEx/J99P+x7oxUGxBvawEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=doQpBpqP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49814606A32C
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=doQpBpqP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDB01F0089F;
	Fri,  6 Nov 2026 17:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793987147;
	bh=DMjQ9DC1pWykD24Du0rvBsCPdDYdbQmtaFNgbc3MGhs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=doQpBpqPymCKRXgYRQ3E9tZ/aDYxX6IqOSBlhefE7RTpTPmzQUcBc+pCQg1gY++hB
	 kvGYp74SkZc7rsHPNSappzZowIYGmhDp8PmM+POGGH+Wx77dnjHfAaDcxzbGD8Wmrd
	 eqEMSamLAh/1Uli2edlntZqvyZy8kvJopt5wmKZOTZp2iQgYmn5QPMstvdqCgPosEe
	 QDa9UA0pXOSfESd09a4XfUP/uE6XOXscLpO+GPm0etawRvGvhWvTNFGnUCp/3Gy0Zd
	 pf8qOh4skpnFW+BRK9j/nwYGVYfocrDhli+fYRsqeH0Zm1CQcXWTNTs4uvhPEqPArP
	 LdcGb0RPft1hQ==
Message-ID: <sashiko-outbox-201965@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/23] KVM: s390: arm64: Query Available Arm features
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-13-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-13-75e95980fb10@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:45:47 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> QAAF enables s390 hosts to gain information about the support
> and handling of various arm features supported by the machine.
>=20
> Function code 1 provides general information about available formats,
> machine defined content of system/id register, and other various
> information for running arm guests.
>=20
> Function code 2 provides a initialised save area.
>=20
> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-sysreg-v3-=
0-75e95980fb10@linux.ibm.com?part=3D13

