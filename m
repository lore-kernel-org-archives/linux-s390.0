Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4891C4534A7
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 08:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980311; cv=none; b=gqMrrKjWNtomCpMcAdKAfWdcYGJOx2RZPqi+YOvXPhzW+LU30Gvi2JhQUcTS3ovmfE6VnqtLE/ALgVGoJcffcM2diGwEUwNUBrKkcgm4CzJF6h8TYWEW8/QaAkLtIOYXynGW4FfLYXHUL0pJET4jFG22oPFVXvqcjlrHKU//z6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980311; c=relaxed/simple;
	bh=U3j6qSEjknADPC4BV3B2hQyKOtjldf9zcINjLcEB8eM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a+UBVpL2JQRt7BAev2j+yze5l25O8jMsKurGZHPGNCL2uI1E99vIEEaSEHB6ho72VxCC16cQGzr5BOr49RqsTpkp772e79qnuCCv0UIls6LGr639mCH+I1KaJlmGuw25S3c+UFR8VnECJzQv0snZUT2Zbgj2xZRPLo2Sgu+0d3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zs+XTx6E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zs+XTx6E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854F31F000FF;
	Mon, 21 Sep 2026 08:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789980309;
	bh=U3j6qSEjknADPC4BV3B2hQyKOtjldf9zcINjLcEB8eM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zs+XTx6Er5BX7XDLocuFRAj454jytp/kTgDSlAFElN4Pid32P80HzxgnoFJE+T7sL
	 hV1zZq7Q0a6uSTWweBcWmsF3vV5SpsBqUV+U9SrHXei0FyWeOFTt3MPAra+DFB0uvw
	 dTK7OCOQEJ2y7X97HdWv1qXE5gQMljMkHjtkYEeaDf1z1nLthRtATpDsOAtJyPft63
	 Zq7wCpt+2E2s7l8DfLcPJxEAGx6EqHn0ucZuHCRPer69YOKJXCQxWeAtiVw/YfuuRy
	 5cB3QoSHpHTl7fic3GN6dyETDyCCvYft+LAz89BgmVvSMcedR/81sYAprElC75cBdY
	 5d/Kbvw2SgyQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/11] s390/lowcore: Remove _AC() from
 LOWCORE_ALT_ADDRESS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260921084005.4022574-4-hca@linux.ibm.com>
References: <20260921084005.4022574-1-hca@linux.ibm.com>
 <20260921084005.4022574-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 08:45:09 +0000
Message-Id: <20260921084509.854F31F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921084005.4022=
574-1-hca@linux.ibm.com?part=3D3

