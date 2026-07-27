Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FC5387341;
	Mon, 27 Jul 2026 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163094; cv=none; b=tDELhS4sAUtLKi+A1BBs1rm06lk7nRUfhxmsEeuWWT/DW9TVz0fKxEGer7Dgt1QqvRUhyg5nWEhhANnoNWSdNqF7qt8mAk6RCblEFgF2Jht4aafYgAr4Gm6M1wI4jDyAtWat8CHbq6yEKpLepoDuq8lg9xSu1JqQs1GsUykDLyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163094; c=relaxed/simple;
	bh=f83Id3MmeGSXq7ynlCZGqq2SotI0DGwbA3ayKyuDbHg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ur+V14bNLA412GfO1376yp2RJ8Pjz6lSdC1yfb3UjWOoErDIppU1vt1VxR7lsodfi13ypGzdQSGRhZaNCbuxhHFXpXyDalcrICktKM1i/W2vYM59+DDRp0k1Ctoyn68LV0xcmkXQ+xa4LPCyMSQiosx67loquZ64tClPCILUPes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKM8Hr1c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKM8Hr1c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BBE1F00A3A;
	Mon, 27 Jul 2026 14:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785163092;
	bh=f83Id3MmeGSXq7ynlCZGqq2SotI0DGwbA3ayKyuDbHg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JKM8Hr1c4cqz63aDKTa1dK0j/XVYdGm2h9siT6+TWSkS8u0fMwoDMkCdhvew8vGPN
	 jZRc2mw9v/UUIZ08W3RZUGonoblHiI60+nPb8QM5lmYLs63yG21HZHG3SvNLvK4QIM
	 MyhehtRYGc59Hb/mxFXNUodl3+zAh7P3f37mid757h7EjeiYgIzJ9YrdSF9Ufl2kVo
	 1xg/AY/AD2yyaj8SV0nQ+uFINzuWnRsDznJkmDCw0y1F37Zlc7exxPciQj9qDw7gcd
	 dO3BeX+5NKyyA8B6ZWByIK4Z8gMpdo0UG6EGC+yDHmywPxKV7wRLIfla3X/Seabb6g
	 ONSZtsjmDqdqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] s390/diag: Generate CFI type information for
 assembly functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, bpf@vger.kernel.org
In-Reply-To: <20260727140514.116501-5-hca@linux.ibm.com>
References: <20260727140514.116501-1-hca@linux.ibm.com>
 <20260727140514.116501-5-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 14:38:12 +0000
Message-Id: <20260727143812.68BBE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Use SYM_TYPED_FUNC_START to generate __kcfi_typeid_ symbols for assembler
> functions which are called indirectly. All assembler functions contained =
in
> text_amode31.S are called indirectly and require such annotations.
>=20
> Reviewed-by: Jens Remus <jremus@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727140514.1165=
01-1-hca@linux.ibm.com?part=3D4

