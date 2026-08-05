Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177A22737F9
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935873; cv=none; b=ArfFozrNzP4ppq5HTUqPw81JyHOQs2nwK8yOtBqV7GDM25Az3Zq0fGWHw6GRU3XunZbrS81FS6GsbufJx3Sn8J5tetrSJuiCP/uXZ0IJm3V8VAkLaol32vhrqSPw50lbXv9j16fg+cBmYzFSsbfp8KW5zW7DXFaX59++Wtvyce4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935873; c=relaxed/simple;
	bh=XfhUFm00th+FjVGOXuTtR9URPlN0lrp5L+KZh15vR24=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fu4sdecIq8YKS8scj2WzDEB9wyv4Q8Liqk87oAnKhL5mff5C6XgVIO+oX5723pz9Qu+qllGqaUB9fQgshdCs6xmbS16nYvtAh1arwUvtbEZAc5kqgniG7/q4WLaym7BCrx8NAML4vwF7fXce7PDUM2NilsiAQpMe+DfgaiiCIdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnjAfivP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnjAfivP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD4A1F000E9;
	Wed,  5 Aug 2026 13:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785935871;
	bh=XfhUFm00th+FjVGOXuTtR9URPlN0lrp5L+KZh15vR24=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mnjAfivPQZuZVhcdboCQWzk1RoCXToEs+BljH8nGPtEPmwVQsOyAXGdIq/ChNaNWS
	 nucJv8vMg8i+pddc/zznzeButmiEJCIRTLmmZBDClqxWCDtI1rT8V+y6CNQjc7jL4V
	 X/wp4wI8bbrYbxM3jmBSXwi4bIEL/YCEfd8RlZMGGaudsvyovsRENYLLLC+wej/xAC
	 qeWCM5rIauLOUTBwcnWQg+loC8RAGoeVA2t5RosMCRYslJfpwCbuu1JQX8FRWAsPFn
	 kpprPTfRg7zHDw/x72T/qZOHLW2mVDNjbOywsso8QQ3o2x/wSjTeBA+OyGqmu2DZsz
	 FRdCh0MBhXBbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/19] s390/dasd: Use GFP_KERNEL in dasd_alloc_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260805111612.1285190-7-sth@linux.ibm.com>
References: <20260805111612.1285190-1-sth@linux.ibm.com>
 <20260805111612.1285190-7-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 13:17:50 +0000
Message-Id: <20260805131751.5BD4A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> dasd_alloc_device() runs in process context (device set_online), so its
> pool allocations do not need GFP_ATOMIC. Use GFP_KERNEL instead, which is
> more reliable, especially for the larger DMA allocations that later ESE
> full-track work adds here.
>=20
> No functional change intended.
>=20
> Reviewed-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805111612.1285=
190-1-sth@linux.ibm.com?part=3D6

