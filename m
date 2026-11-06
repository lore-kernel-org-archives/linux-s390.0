Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997221;
	b=cmF+EC6MJdNDi5JNruboEMsn76cz9cq+k7iNaaVn8skQCEAFlP31iDCD8x3q5me+Jb/F
	 HI+Acj5/fyS3yM1XyJLndIFyVuXC5mu5Ct758bfVqd2KMX7di6U9fitDv0q/FOH0aD4Ji
	 KLclvcZ9kdmasef/rZ/fWBq+qTM+2boNEvi54I6xNTfc1zZCdJgADEX+pSrTi3FCHGtzJ
	 iA4ti7vCHekMSLz87zC7DZI7OAXJw0KDYFx53Cu5b+zDw//S5NOkm+Xjtnvm52tyQdFuM
	 maJLgSAwa0QKQb/eE9zuaotMu/qh+wlviGM7nSRy9KYOT1nZezNiaapymSQJDdaEtZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997221;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0IHaW5GwwXjDDhF4J/HrSfBXZQUtgzdWlgSKuUbuekE=;
	b=D+2asS/wQ/2kBWVqiIezFg1Z/LtGkv39tWZXxV++reQ1nccXlOcs+CyEyL8hvDUU1R/w
	 5D7VmO79NjOpi9pDJbPd+UZLrJkavejNb99ovoRRtrRztm23VjLDzvqlAexNSQ/DBr4xM
	 pwlJG2CvkkLoEko9T9H3p1W9uRb8zp6nyLL5w+lLdppR7Sau1dgLoft+DBZ6Z4Q/7WiHp
	 PStvi+/qaO7419JI2qRV/n/EBGQnsRsJ7+tlAixvypaXb0t4CjKp+4zpTfvJ1xGJi4J63
	 637zXsU0BdrGV448GCiI/nehnBIzNXvikUBUTW6aSbubfGfPnWt7ZqzcC+azp1Sm5gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eS73N3lx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80024606A326
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eS73N3lx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A9F1F0089F;
	Fri,  6 Nov 2026 20:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997221;
	bh=0IHaW5GwwXjDDhF4J/HrSfBXZQUtgzdWlgSKuUbuekE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eS73N3lxDi4EIYnBiLxt2sybsmPTNII1i3Jh2JFT9meOg2/hUzVFRo6sZKKdbwoA7
	 XV+ku8dMqpDWbnGoB61OpKCe7xbFkIFjwfA/9+BV3a5kxr/jE1M/qlLb0SY20q8rD8
	 GWGpGJZk9Tcgq7BtNEvgvmaenrGPIzM3u2Jq5wtFpqF7XH4ejxH4ninKzEEqudWEpo
	 oWDEH2DnT3MKJwL8WE8D8Rk7YQ2/0MbXfBa3n3HMboHtQfb9STu1m+ocL2RqX8laE/
	 GMmwanQ3s8XU3IBj9wIzRyCP60VqD4gvqWiaTeow2UkiuEGfML8uV2qIYsCuEnJDFw
	 Y544B7CcJ/j4Q==
Message-ID: <sashiko-outbox-202222@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 09/15] syscalls: Add an option for offsetting the
 common table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-9-8d1275885d9c@igalia.com>
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
 <20261105-tonyk-syscall_table-v9-9-8d1275885d9c@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:33:40 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> To better support architectures that doesn't share the same syscall
> numbers, but have them in the same sequence, add an new option to offset
> the common syscall table numbers by a value. This make it possible to reu=
se
> the common syscall table for alpha.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-tonyk-sysc=
all_table-v9-0-8d1275885d9c@igalia.com?part=3D9

