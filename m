Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8084B04AC
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111580; cv=none; b=Ld/yqymS3NOofB/+IE5HErKffHwbUoEBAJUBqNhfUbl8j7Yx1aBywOwM1rbaEQ8sXydSfFiqTi4uCILK4MD3deBPtud9avNH+rD8DsGUvyJXLkixnF8tCAocTENVjozQCINE3bHmwKzBZ7pQA3PjeDbPzudX0WI37LgDz5kIDI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111580; c=relaxed/simple;
	bh=EcVcXCSnbJlDp/QRtCPIcYYsitIlB7jcLzrV9GbooU8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=edNvKRb80dlXdjjktpRq2W23IhfoornlWmEpufvqZr5kfZ/BSp1KKr9oM4ZClYuTBJHXiQGqYmbEMA3PlV/HAEKMwE+g33wMZyt6PenXD0rTqjBvw+Kt/89Go1GOFnqYGt/Pk69ck5NQBE5tCI1Z9hYixPTA/6m9QNdv5tpyXeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZsGoihP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZsGoihP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250E81F000E9;
	Fri,  7 Aug 2026 14:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786111579;
	bh=EcVcXCSnbJlDp/QRtCPIcYYsitIlB7jcLzrV9GbooU8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TZsGoihPRu9Hb3ZdibWVHu8z1SpAC8KoPjkHTWLhOgJnX/CtWx4uTKPdtmvUBJ1wv
	 0ZcBVdENm2M0MTvRkmHNYh6NeSx2PgJOEX7i+jGwXE8UWel5TMYU2zswQjyJ+5pB77
	 jXJrEK5ZF1J9ocMlBO3VvEo1qjjPd13A5Az+HGKmT4U3kAMf3ni8fSKGvE3j6tVWJ2
	 aommN1tOMmPmh5GCK3Qhg52SKaotDLY7BIFz6PX8GPTimQlaIJVnIVyHAHyrrIRzwA
	 OOOZLlA+660scI38DyG/AebMXxKHC1JmG82/7Smv0q3dlpVgQkPG//+skvF7hTCyu5
	 0oICVh34eg10g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] s390/crypto: Fix skcipher_walk return code
 handling in aes_s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260807135440.35888-2-freude@linux.ibm.com>
References: <20260807135440.35888-1-freude@linux.ibm.com>
 <20260807135440.35888-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 14:06:18 +0000
Message-Id: <20260807140619.250E81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The return codes from skcipher_walk_virt() were not properly checked
> before entering the processing loops in ecb_aes_crypt() and ctr_aes_crypt=
().
> If skcipher_walk_virt() fails, the walk structure may be in an undefined
> state, and attempting to process data could lead to incorrect behavior
> or accessing uninitialized memory.
>=20
> Add proper return code checking to ensure correct handling of the walk
> initialization and walk advance and eventually return to the caller
> with that return code.
>=20
> Fixes: 7988fb2c03c8 ("crypto: s390/aes - convert to skcipher API")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807135440.3588=
8-1-freude@linux.ibm.com?part=3D1

