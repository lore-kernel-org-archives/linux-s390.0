Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773ED48CD55
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721708; cv=none; b=kNlSie5a2uXZ5xvBV9UsrtSA6aH5xX+ITBjE032iGtYtwnMe3mklXQX9ywSmdlhv9m0XfYUwcsm3xYpdRYqOhEf8S09kdulvxXXUqKMdmxPf3M3Ni7xUBGKPGlmJhjym5DZr8jxeI1xrdWuRRiNfcW/bueLkXCFjPl9hdrG9+aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721708; c=relaxed/simple;
	bh=6OoSqnC2X3wPJd3jYCAqsu56GXkyRddCN5JcVxAn8qk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pBKSPeCRtmex2i+cz9zSoy/XTirq9m9a1isuEl8KIfd9hw/PEj8nV8n2Fhoc9f1C/XuIloQOwtPKFImR12uUgU896DG+R/qtbcpEBRg/+kRaopBDT28wmCG9t33bOjGZhHlQcUC2rqiAhhpOs09Pe7c42TpY7HMsfZ4pVcfx6vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzxXfFbV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzxXfFbV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDEA1F00893;
	Fri, 18 Sep 2026 08:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789721706;
	bh=6OoSqnC2X3wPJd3jYCAqsu56GXkyRddCN5JcVxAn8qk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jzxXfFbVuLBwzNolj13kmTRxPF+JGodwxTblhBDsZKqC89kJOy1KJFhbO2XhjTd4b
	 tY70ewH2GY9GiSx2UfzcaIRGWL0NLTuDQtPU9pZavvVfE4RhdhIkas8lWh+3ytTtVG
	 9n7PtTS/4iWBFTbg3PvF7Plls1CZu6tQVre/4rszFe0cEGwVanRdIR/86gSikb7nij
	 MNBvEKgimQ64YAAg74w0WsWgm9jgosvw11N/C6LRa9Z7KjP3fvTxl3Iye9lIhZSdtG
	 iF0F6lbnhdRi+VjiACrc9OYTRIv9kgikjhKwZYOZ2HggveuH0mJu9bEjvi+1EkRUAw
	 hDVWCx8hCc/uQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/12] s390/lowcore: Remove _AC() from
 LOWCORE_ALT_ADDRESS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260918084842.2333237-4-hca@linux.ibm.com>
References: <20260918084842.2333237-1-hca@linux.ibm.com>
 <20260918084842.2333237-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:55:05 +0000
Message-Id: <20260918085505.BDDEA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Remove the _AC() conversion from LOWCORE_ALT_ADDRESS. This changes the
> type of LOWCORE_ALT_ADDRESS from unsigned long to int in C code, however
> looking at the current users this should not cause any changes.
>=20
> This allows to use __stringify(LOWCORE_ALT_ADDRESS) for inline
> assemblies, which otherwise wouldn't work because of the UL suffix.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918084842.2333=
237-1-hca@linux.ibm.com?part=3D3

