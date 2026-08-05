Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772B640A955
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923119; cv=none; b=brWD03rjmtpPZ57CkChO1F+mIk+rkYywHCSZG5cu0qdEMbIdwi7ZvPbaijcBUDSmiZIw18zFEAl5Mkn+VAVKVo/OWQ7j1A8stspj569v4aaYd4kOLdSIaGIjNiRNui2ra+T+cjePvgEEEvIDg0EMzuBONagKC85iqvPML1+k4bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923119; c=relaxed/simple;
	bh=eFHiiKg5fws91nwD9q6uEdiMiukvJTIB3pzACYlTt4U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oORjrXRtFhYTyFZX3C8bYA8vG30C6o3r+YdCnWv7xlCZKEfqoSI9VkGxzFFrJlxoiW0QpkNI/8UtIFTYqZvr7g58SU08eJvvzKbuwnmJ4n3KhCkQQ5zIRgqzG8eDPgjJUWYJADcPufBp39/SqgvgZBN8L+ibFZzric/FQSmnD54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohruBizp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohruBizp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860BF1F00A3A;
	Wed,  5 Aug 2026 09:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785923118;
	bh=eFHiiKg5fws91nwD9q6uEdiMiukvJTIB3pzACYlTt4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ohruBizpJx435erk4rJ5Tnge2fmMooy+aCSFV37hlvrUoB+vy0577sYzNnT5TXLnO
	 SEaLBHgXiVmMRJD5mU+rIjE/abXAe15kqNMMzwZ+KJhZfEO0LQYN2FTXawmIYzCkii
	 wMsOPtdF/LLhFVWBL9/4X4IQEAIQtKarAf/kx1EDM9roi162peJvhM5SrvHJeqwKfJ
	 LDGQ9wtf6wDXWHY/lZP2BrM0Lsc0MqbnlucaRGwV1W2bQFp83TUqQwdh5RvQHIMObb
	 OrQ/nmi0eE8DdLhBM2/tWGVGtAe7mP9nvVTDqpPS5AJRb0Xa7MbQIkKHHvlv9/7Cum
	 +CmvTE1j7LNDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] s390/ap: Fix MAPML computation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Finn Callies" <fcallies@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260805092928.26932-1-fcallies@linux.ibm.com>
References: <20260805092928.26932-1-fcallies@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 09:45:16 +0000
Message-Id: <20260805094517.860BF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When the TAPQ subfunction of PQAP returns a value between 0 and 3 in the
> ml field, the Principles of Operation states that the Maximum AP Message
> Length (MAPML) must be 12 KB.
>=20
> The previous code incorrectly calculated smaller sizes for ml values 1-2:
> - ml=3D1: 4 KB instead of 12 KB
> - ml=3D2: 8 KB instead of 12 KB
>=20
> While no current hardware reports ml=3D1 or ml=3D2, this fix ensures corr=
ect
> behavior for specification compliance and future-proofing.
>=20
> The fix ensures all ml values 0-3 correctly use the 12 KB default, with
> only values 4+ using the formula ml * 4096.
>=20
> Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
> Signed-off-by: Finn Callies <fcallies@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805092928.2693=
2-1-fcallies@linux.ibm.com?part=3D1

