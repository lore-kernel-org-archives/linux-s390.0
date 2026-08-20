Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F8D40315B
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 12:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230378; cv=none; b=g7rEEnaYbolav0oCoTzkoDCjThGDRRUGTyZiT9H/Ke3yDThs5H6Z2nZC9JbipzBlAcrtxQLx6cl7XWLR3jzeg1y5FwO7Frp62+Xu22Ybzcc/s1U/7+MGmCTo9C+OhhjP3kpfKYRhh1chmHO9MxlpKpe+aDb9FLSY2zusQzszwmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230378; c=relaxed/simple;
	bh=gVqI1AAdRhO+ApNZDctqffXAQ2c/0WfWo6rjGChEBgQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jdp8BuneCPdyplvyn+SiO4A5ZabRkDRPr0Za306/ewhsupx90+Ezgn7OxuTWpBOingHYh46LfO6FrXi1nZO/U6f0z7qYDwJ7wNZXjS94oqZLlh3ltT2mkzPSzXUxxgOSZd0g3mKQCwdUHEw+vgwm+i0L+RYqhAthYKI2Diy6izA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+J9NGV8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+J9NGV8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB1B1F000E9;
	Thu, 20 Aug 2026 12:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787230377;
	bh=gVqI1AAdRhO+ApNZDctqffXAQ2c/0WfWo6rjGChEBgQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M+J9NGV8DZDAySZaatmSBjscrDo95qZGPJvqukzTJPrglYDplX+9rf37Nq5Eq1CCx
	 qkNzCR9cw6hPYpizSd/eR9NzlrJlP8sK+zYBHNonG3t2xTymbwKXha8J/CJjfBUKV6
	 FU5udOiI21BbS4o0IOX3g/owP7f5qmXjfZpvEMVhd9rsBng9A3g2djgSAQ/nkqoNYo
	 lH+Rj74ZGW8Its0F3stZnpxzEGQVw2yeZUi/LzMkCtuoRsp8t+nFo+gr/zpGN4meMk
	 IN62ByZ29kVttPB1BK96A41gEEI9aPcpxyKSN9SWIN45tmhIoeG7qJPMJAkBD3hOEk
	 zj2BfMuU7DkFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390: remove unused setup_profiling_timer function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Iliopoulos" <ailiop@suse.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260820124649.143863-1-ailiop@suse.com>
References: <20260820124649.143863-1-ailiop@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 12:52:56 +0000
Message-Id: <20260820125256.AEB1B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> setup_profiling_timer() is not used by any code at this point. Since a
> default weak implementation exists, there is no need to keep this
> arch-specific definition around. Remove it along with the now-redundant
> profile header includes.
>=20
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820124649.1438=
63-1-ailiop@suse.com?part=3D1

