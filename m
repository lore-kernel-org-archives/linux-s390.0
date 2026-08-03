Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E3339479B
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785746555; cv=none; b=apBA1b4pxAghkR2LCFMdHd3ZQeOAi6oXAbEDo2PAQbj4wBd3N70+GlROc5ImataopcSNpuJZhX/SuLWew9Ce+QZ21IzlboMC9UIeThR4vn/Pn712amFMo1nlSkZ8AO9gVS3JSbIP+6MtlGoX8N9b/omiAoHi6IKzbhLNDHRvZr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785746555; c=relaxed/simple;
	bh=Ws+cbxEcXAU6yASQ4dymEJPJbC3kBmuBHKUMn+xrOos=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XzzQlUoJ7XL8/9vMgzF1SujXP9dhOMbECGLsMdDqWVXbtOB81ZPW6VHcIzDmqhceK0jJAN8PYT3V/jGk5S+0ygOmynJ829xNzSL8tuOxL9f9g+u8sPCnCzuudn09/hFz+Fc5z9Y5n3gOxbrbXI8oZSbUWENDjhyyWVa0FJvucBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohEFz+66; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohEFz+66"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E64C1F00A3A;
	Mon,  3 Aug 2026 08:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785746553;
	bh=Ws+cbxEcXAU6yASQ4dymEJPJbC3kBmuBHKUMn+xrOos=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ohEFz+66RYgGSHWRdFAW5XqgxAnPeDP5/tKscN4bJzDOwok/hw939QlSUOU52xknL
	 vMUgrTWZi0ZycdWOIDA+xJVOl/sLPpeIvXelX70yprqqHdpQC0TaeXZPr1XsgWACDT
	 +pI8cHaYICT7a6BTYN68GbfZFPEdS4cxSp/uzgQjdyKJxV52rQFOJh81JgqnZ3jxov
	 juRW6emSVKB8BMXt4Jm9HP3sej3RJc5YK6Rf6L9MOHoqMouOBsbm7OBdA6nRPJWUSp
	 ePnEuyP2oMVt77EHqw4dQ6nONMKgIpPgG24p9oH01JvLWMUSP3KW8nFHufNTGRs0T9
	 F05b0Suj4PCeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/5] s390/zcrypt: Fix CPRB memory allocation in
 zcrypt misc code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260803083339.212885-2-freude@linux.ibm.com>
References: <20260803083339.212885-1-freude@linux.ibm.com>
 <20260803083339.212885-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 08:42:33 +0000
Message-Id: <20260803084233.7E64C1F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803083339.2128=
85-1-freude@linux.ibm.com?part=3D1

