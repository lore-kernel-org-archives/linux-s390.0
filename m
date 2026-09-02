Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699C14AE8D6
	for <linux-s390@vger.kernel.org>; Wed,  2 Sep 2026 21:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384617; cv=none; b=rzygDeRhy5jg0dCWHdbiOSENXyZ0mtRw0Qk9/rs1KT4PlRUAl3DI3Sd34XlR2gtS40xnnisXnkpQQVaivfZ/dUzfIZ4V6/aEI2hU5OgWVrakRfDdIMdPHBX2EQpM7FVCqcbTkf8i8E4BToKvISbRAQXxetXOLfWXQbff9zuLSFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384617; c=relaxed/simple;
	bh=UTpdEAG7TkThwV9VxnuWsfq/YPx5cGkVT+WhfAE84To=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P/vViJmLkvE++OcU7faaJhzWHHeMZN6hNaVVDSMYOlqqnFssuEoYYixXr/jsEv+wi6ykplVHwcqZrAsPXBX2DB8c3wJCq7MZXbAlWsEKappv1OFJzrfha3hUcV5lmS/IgfeFlxCflWN4/4JgZvTsUUbitHY3I0XI9vw3fnAQFQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWy9pXPR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWy9pXPR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0810E1F000E9;
	Wed,  2 Sep 2026 21:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788384609;
	bh=UTpdEAG7TkThwV9VxnuWsfq/YPx5cGkVT+WhfAE84To=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gWy9pXPRELKv+fUys7DmpO84tYJsPUhtBZ9MV5gVxeIReWw2ZY3kzCgH/SiKeeiZ8
	 4xlfXvH6aWyYi9boNO8too6lcj92gCS5FdNZOUbtlCqXK8zeyZkDT9GbtQP1vXExt1
	 kOlL9B6jc3pxoreP8BsJtJph6d8pArKXHr+OADChDJYMaY1cGkDHLcuXi2jhAKZDEb
	 NCooT7HRsfeJifP014n1AG0lIQdXhnDDRqfZbb/xFFlZsxFO4nKzB3hS6w/idg25K+
	 VNZFQVBDVDaNOLRCWGkrq5HfQPkALY44g9o6vUTTlEJp7v2tGnrHyX4EDqj1quviVi
	 lygtSMjrxtmJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] s390/ebcdic: Add character classes for the ASCII
 subset of EBCDIC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ilya Leoshkevich" <iii@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260902212400.674450-2-iii@linux.ibm.com>
References: <20260902212400.674450-1-iii@linux.ibm.com>
 <20260902212400.674450-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 21:30:08 +0000
Message-Id: <20260902213009.0810E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add _ctype-like array for EBCDIC characters. Mark only those that also
> exist in ASCII, loosely based on invariant subset of EBCDIC [1], but
> with cent, broken bar, not sign, and plus-minus sign, left out.
>=20
> [1] https://en.wikipedia.org/wiki/EBCDIC#Code_page_layout
>=20
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902212400.6744=
50-1-iii@linux.ibm.com?part=3D1

