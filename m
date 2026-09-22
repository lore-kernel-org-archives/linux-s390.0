Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CE337207F
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790060092; cv=none; b=AmBcsRUKx258d9TEYyxi00JiKXABjmVnrmq8nMvPLp1NxRoMnSLT8kX9FdYHyuZhje5kRmyomnyKkqK8EbimBZFSC/SIjoC8S6PA3BIVVnBsSCJDb5T4E4n9LZH3gtquBDUGYlJcqQMiddLOGGZDPSvBKStZx7hlN85bZaSyU9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790060092; c=relaxed/simple;
	bh=g4PZvq1GEDuUOD9KLwmnjmMFl3PH5xdFgsGVYpWCg/8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gku0yT9XR8DOL3e95lNboi9Y7pcqCn5UrbI/vgvvAFUOd9J6KX5fZBVsHvuvOvK1P8lr4f/5petsFEvHURE37Ets42EvLlTc1K8nB7+f7uA9Dyva7L6OuMDJMwKI5fTgFLFbUiMWQuqcyo21wXICSARn83pLTjlkKllQbsGbjZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bN+ls9Xq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bN+ls9Xq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417B91F00893;
	Tue, 22 Sep 2026 06:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790060086;
	bh=SX+cDW3aBCuHW8OHJ+uQjfFp4WpY/wc2al4AvaymIRU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bN+ls9XqFkBJ6wxdHK+M4sJjztYgRniUj7g3u4f6jMVxwEK4hL+sarjn5sCkcO4FD
	 0hdjpSjvk1kNueS8xHolvKKT7wRuoGvyQK1Fl4ojgN+CNNOzPzvfIFhbgQhDwwbSOQ
	 JAqrGGwT9FO7TLTRrXNF1+Y78/DUE1lxNSeqppCdxzeAMwOn+NouqHmeuJOuQ7A0bx
	 WJ67WQUBozzB2/5aJ9DpmWcCmz0ZAzwOLZnfCIvareKvVNIdqB4qj4rCzNeaftAYR7
	 mskoOQ8HSwxtbV5Y61EixzFUTZHAUT7OfKeNhwz007b70MpAYxbUE7vGJmuicvhETY
	 1TxvG0Cn0NTxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/5] s390/sclp: Introduce macro sclp_gds_for_each()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Egorenkov" <egorenar@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260922064303.524293-3-egorenar@linux.ibm.com>
References: <20260922064303.524293-1-egorenar@linux.ibm.com>
 <20260922064303.524293-3-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 06:54:45 +0000
Message-Id: <20260922065446.417B91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> sclp_find_gds_{sub}vector() does not deal well with malformed event buffe=
rs
> consisting of GDS {sub}vectors. This can result in an infinite loop or
> an out-of-bounds memory read. Therefore, abort with NULL if
> * the next GDS header would exceed the given end boundary
> * the length in a GDS header contains an invalid value.
>   A valid length value in a GDS header should be at least as large
>   as the size of the corresponding GDS header (2 or 4 bytes)
>   but also not lead to exceeding the given end boundary.
>=20
> Use the new macro in sclp_find_gds_{sub}vector() to iterate over entries
> of a GDS {sub}vector in a safe manner bailing out on the first invalid
> entry.
>=20
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922064303.5242=
93-1-egorenar@linux.ibm.com?part=3D2

