Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456FD3CEBB9
	for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2026 11:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373949; cv=none; b=AS1e6kExsrL8AjyENzRL8QFEPuckmGpG9YXH9rtXsb5RAE+6t/qK3TXhRZ0z3efPwZZKjyhTnu1KCCTze8Nb/YBvbXtR0K+LolGn5B4rOING/fwAioXFo38CfDpl3SzMpBnPTxt+Sn6jmJC+7+vcqyiA9TQfeo8BYwTOhUx+h2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373949; c=relaxed/simple;
	bh=TYphKzZY5M2oWmdwWNB+TIdyvomPt3oWUPfuSFRqhic=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=fMIpKZYvFFn7/Xnhea5ZmgNDD2IHv6dwt94bpzkN3m3G1PIWJlFoalnrcvj+L3BcCCh0g2VBdtYCsCgMPU5WJEho8BywaSnhTvtuiRPnCnp/zQzKUh67S8VHndl6zYlwlBRdjTleyJjvcYUNUapBUoi65YecKPG0Ag5bjaGUyjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwVylKP0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwVylKP0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95741F0089B;
	Wed,  7 Oct 2026 11:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791373930;
	bh=TYphKzZY5M2oWmdwWNB+TIdyvomPt3oWUPfuSFRqhic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fwVylKP09ZUVbZLVHzxIkyLTID0hHShg1LzeCb3ZM3eQis6/Dt719daBVl95pibPe
	 85QI1uvPa+sJWBqyGtuEUXwu+hp00ABEz1+LiIfpQWuaT8gw8pKxSsM57+1ofsTI4h
	 xqrfKyKrSVeJvWXNR5nZXtZOZMkkEv7ejXEJZvC8Z4K7ZTfvi3QZJHLpxAejexewMK
	 T8iBPQ1Vm7CmU5udBmMjU3N8MDxKv5ZT7HjSlVUoob6YjyQ8oqY1KV9PlT1wp60SF4
	 JXx5EXTuXN1YmtFHpW6Bxbl+WI2/wXtWvtl6JjwH0a+BjXAK6eTsyMuZyJTdnG3tXy
	 wOBbqTAOJSPIg==
Message-ID: <sashiko-outbox-162945@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 10/15] s390/mm: Cleanup pXXp_flush_lazy() routines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <964adeedfd20d4dbcc9a6341f57ec7aaac6c6adc.1791365932.git.agordeev@linux.ibm.com>
References: <cover.1791365932.git.agordeev@linux.ibm.com>
 <964adeedfd20d4dbcc9a6341f57ec7aaac6c6adc.1791365932.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 11:52:09 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Avoid unnecessary pgtable entry read in ptep_flush_lazy() and
> pmdp_flush_lazy() routines. Use the already obtained value of
> a pgtable entry instead of dereferencing it again.
>=20
> It might appear that the optimized out second dereferencing happens
> under mm_context_t::flush_count lock and therefore a race condition
> is possible. However, both routines write invalid entry bits to the
> pgtable entries and therefore no reader is allowed to interpret the
> rest of the value afterwards.
>=20
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791365932.gi=
t.agordeev@linux.ibm.com?part=3D10

