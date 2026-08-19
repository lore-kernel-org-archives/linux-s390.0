Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93808440635;
	Wed, 19 Aug 2026 18:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163898; cv=none; b=SPOpwvHftOSD8ViFddbYGY4vtnE0adO7gO4cV9gP5joYTZ+IYUT+RUHOTk0nepVcK1oRSxl+N0GaV3hZ+6/1pbVPHWQK9h43AGAXx0UwYFZdLSB629WWQmEcqhz6TxjDOGAI+8uTh1yDS06Xio7x/12Xy3pfjhiOjzA5MzlbY6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163898; c=relaxed/simple;
	bh=4Iw3rpa8l95Cumw1CTEuPHCRO+Bf6ByJrRoc+XcHTIo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bv1PA5iBnXwG30gwRDAx8IQvIkJyQonIsbSh0ssa37Kg/O7k2S/Jl5gDKGe+ssiQzQPrioQ8ikoyIhBLzfO1G9UuhcGpgKVo+808xr91NEUfSwkRdwTL5sF5hs8z4rxkSPXyfOHiahOYNDQZU5P1TzNIZkU0X3B3gfPy/XAIg8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zp7GJG7I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zp7GJG7I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5B51F000E9;
	Wed, 19 Aug 2026 18:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787163896;
	bh=4Iw3rpa8l95Cumw1CTEuPHCRO+Bf6ByJrRoc+XcHTIo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zp7GJG7I3+KxHsjMcjYLAszAIpyHvFMqCY8UmpwP2RBz13aG0hFDN4cyWH2zGRwnC
	 y70hNr2H7OFy3jAA9PU0fYvqzS/nITRaEqahB+AxEX0c7AeN/9QeHODtrFYpimQST7
	 XG7mqnKPT8SOZLV3UZuiTaceaqYX6AdVzangsDETRitq6/RQz+E+5YHeoBuJiv4ImG
	 nJ3RMwWOH2RKf3KQGdsAxRaHYyZH4cM2ncZ4jo/erYGOEue2CuBIj3Y5uA+pPDzPec
	 5x5PG2MbzmitHYyEtChp4LZfOn7dfZmrbM8HFHaspDofK8Cbr2l/GeSkW4l8ZdXXVi
	 3duC0tRIg2IAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 05/13] sysctl, parport: update register_sysctl()
 callers with template arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mauricio Faria de Oliveira" <mfo@igalia.com>
Cc: mptcp@lists.linux.dev, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, bpf@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260819-sysctl-module-aliases-v3-5-aab90569365d@igalia.com>
References: <20260819-sysctl-module-aliases-v3-0-aab90569365d@igalia.com>
 <20260819-sysctl-module-aliases-v3-5-aab90569365d@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 18:24:56 +0000
Message-Id: <20260819182456.8B5B51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Update callers with dynamic table/path to use template arguments.
>=20
> Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-sysctl-mod=
ule-aliases-v3-0-aab90569365d@igalia.com?part=3D5

