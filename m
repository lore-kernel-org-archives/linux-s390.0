Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1454119E0
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059963; cv=none; b=vFAIuBzCbm+DPGyJw6MvthSgi3k2lB3vu1wcAiQLNCc1Hv1BQkg1ttgWC1sxcAsA+fW678z9xqGuYkFynn+3F5BmOzQzUp665QSH+2NY1SabiFk1slgA0iMucgpAiDF2rDiil2JUR10yfc1Pe/WmwSw7AopJChY0ykdBVG6KVhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059963; c=relaxed/simple;
	bh=wd9TnAWLX+Rm5bhAcmqgRCRFYGbh/EerSKp3ETTem9o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F53CpAwNyhjfu2MzQxuIos2C80HWUogP/rjGNm5AMGsd9oVxzo/gsRyz9F5rLKsX2JJvU5BRCsHC/016BgKnG9eBN3gQGEsk4+2p/prWDcr4oyZ5klufJKE/sl5NTMxidCZmVUFNaNJsiXJDk/d/20VFnZkMgoYZ5aTPvINI1y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zkadw5U9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zkadw5U9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0221F000FF;
	Tue, 22 Sep 2026 06:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790059961;
	bh=wd9TnAWLX+Rm5bhAcmqgRCRFYGbh/EerSKp3ETTem9o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zkadw5U9grIHtSVfzFjlVSPT0YrUHyy6CbFWS1pOCAsYcnVNBhFAC2HnG0e0MVkjI
	 /0ZgSoAeZk+6//3U7nmUGp0Hb7Ycc003PPvl318Fu2Hz/K5BkEVTLEWf0AGhM/9ITs
	 GBUbvM3sldojGMOxrZzqCOelBHsDQSEfn5P2ibk5byivz9aPikCfJgI54ZJ5yLZfGG
	 QFcMTBhJjhkePXD27FDg4shBnlq9/LOzLyi5mK+hYoU7IH20M/ozrdl/87BaiH2al3
	 xuuar+Qn03lv0TX3mmyFZhcKkc4cFGKXiDJYRikwCL/TqDgiHKxfR43QYju6ZTh7aZ
	 BNmse5ukj1dCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/5] s390/sclp: Ensure no callback gets called after
 sclp_unregister() returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Egorenkov" <egorenar@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260922064303.524293-6-egorenar@linux.ibm.com>
References: <20260922064303.524293-1-egorenar@linux.ibm.com>
 <20260922064303.524293-6-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 06:52:40 +0000
Message-Id: <20260922065241.3C0221F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> There is a potential race condition between sclp_unregister()
> and sclp_dispatch_evbufs()/sclp_dispatch_state_change(). As a result,
> it is not guaranteed that the callbacks registered with sclp_register()
> will not get called one more time (and no more than one) after
> sclp_unregister() returns.
>=20
> The basic idea is to use a single global wait queue which is woken up
> when no SCLP WRITE_EVENT_MASK and no SCLP READ_EVENT_DATA request is
> outstanding. If both are true then it is guaranteed that no sclp_register
> callback could be in-flight. Once the struct sclp_register given to
> sclp_unregister() is removed from the list sclp_reg_list, no further
> callbacks can be scheduled for the given struct sclp_register and it only
> remains to wait until the SCLP driver becomes idle.
>=20
> With this change sclp_unregister() may no longer be invoked from atomic
> context or registered callbacks. But this represents no problem because
> this is no regular use case and no driver using sclp_unregister() requires
> this at the moment and likely should not require it in the future.
>=20
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922064303.5242=
93-1-egorenar@linux.ibm.com?part=3D5

