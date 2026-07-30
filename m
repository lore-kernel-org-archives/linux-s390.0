Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A495B430CC8
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785421554; cv=none; b=JCL63SAJx/zQirhj1rjDcB/XiOK2LUM9Z4ZUpKSfshte+DjoYM6D0P64rxBd+usK0eJW8356Kc7Byoy2hVr+79jk0c2q0iiTnBMwhC24FLqHYP5JJQGj6rl9J+/BrzJXBIiXMRSAGiN1xERz45NYymYgODdx5Kn5JLORrhITrr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785421554; c=relaxed/simple;
	bh=tU4tVsDB7Uml9E0ELwiEU7oyQoFxCa/bis9lHCv7d4o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gWvuLFMlzocQBbl4ww8Iz/zwX7PAFT/8NtH+lgfGhC21frFsnGLojuZF3X1Xh3QZcmdoFM2WC61G8OOpmrHk1+bjIQoG542nyQdmlQmdW5kUYq6RpXDAA5z3rzc+427/AoSOxDXtrtFpdXIx5JeIRkznK09JrDGoS88rZ60onCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CieYA+14; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CieYA+14"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397F41F000E9;
	Thu, 30 Jul 2026 14:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785421553;
	bh=tU4tVsDB7Uml9E0ELwiEU7oyQoFxCa/bis9lHCv7d4o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CieYA+14PkkBfxJp8SJ4OGUXXan+0xiwKoTSrR5UkqN6MNL6aieBz28R4BAUGRU2H
	 19Vzs3zodZvUN+ueVdaz56ZCh0gPJcW1kUM0PJD2R1Xy419+nPBSA7yGgd1wUYYTiW
	 6Rsa12PTvAEhAk69kzpeR2+DeYrvChxRrAxQsoCjFz4a9ySCHYFjE6rphDRaEXIXbv
	 XFNtfnE3Wn2ryWyiQ+aG2GP5AZPHrSuCP7gTdB326RyTApTB4y3yaezXaE5BAyhEfC
	 keiZtF9vfEhMW6fEj2bg9TdsvtwTH12MJPwlWukEaCEF2JgliMqAylPvwU+DvpzipJ
	 wEMmMkziOH28g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/5] s390/zcrypt: Fix CPRB memory allocation in
 zcrypt misc code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260730141509.205970-2-freude@linux.ibm.com>
References: <20260730141509.205970-1-freude@linux.ibm.com>
 <20260730141509.205970-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 14:25:52 +0000
Message-Id: <20260730142553.397F41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Both CPRB alloc functions in zcrypt_ccamisc.c and zcrypt_ep11misc.c
> did not round up the memory allocation to a multiple of 4 bytes as it
> is needed by the zcrypt layer to process the CPRBs.
>=20
> Now the alloc_and_prep_cprbmem() and alloc_cprbmem() functions
> guarantee that the base CPRB struct and a possible parameter block are
> aligned to a 4-byte boundary and the backing memory allocation is
> rounded up to the next multiple of 4 byte. Also the free_cprbmem() is
> updated and scrubs the rounded up amount of memory.
>=20
> Fixes: 9bdb5f7e8369 ("s390/zcrypt: Introduce cprb mempool for cca misc fu=
nctions")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730141509.2059=
70-1-freude@linux.ibm.com?part=3D1

