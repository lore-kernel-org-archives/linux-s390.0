Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6390223DC6
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757541; cv=none; b=hnB7L9iSeEk6MH79VTRbGW5U8FhDKlv9thSqyKod60qlwPL+3/BpTUfbAW7fT4bDKqegcp2TN6BCrXo6+z+HIORueRMJXE0veeRsJX7Io3tELzEAKb67hwgqwWGACCCTQzf+IxEmgO6A5VY5PisflL+AHbmHcMpQn15C9bqrs4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757541; c=relaxed/simple;
	bh=BPAHkvhpz6pwsS7TpWoVllhafDaVyBc0DTMlMCW81xI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MuD7LhlM0T5Exe6WQw7xbBhq/xEg1Y+Hp7jpVfPPzpjA4o7YnJrmTM0exFyCuusqyxN38xVBTX9BscQI3U8tyTFzAWY/KPqRxE0+k7w4Va3hUcfRbEeuPejxMzWxpR0qsqU9MamSYgDraQxMUa1X10v64hHnzy4F46od6aQi/JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9CMAr81; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9CMAr81"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CFC1F00A3A;
	Wed, 26 Aug 2026 15:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787757539;
	bh=BPAHkvhpz6pwsS7TpWoVllhafDaVyBc0DTMlMCW81xI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z9CMAr81ASJCO85qKoFKf5wDgH8rvSrK7r6wsRf5ZpFQHGToBUfer4W7WS0fLOlC7
	 FKg+NLvfeOTfZaaZoPyuPHACsXYXy8Kphi5z21qocuMr/ifok2w2DNeeQ5ZdPvBpdp
	 XwW1n3FH8Pf73nfM1RNv743HeSs1yvabt1oRauEoG4XKrtKWk8Zdrz+x0Locla7j/F
	 +r5Yv9JOMYHwAQ1G+go4+Trlo7QVXmiuIrr27d9LomGSD45UeIMxXLkIpo3b5p/3f3
	 XmNX1W098Qkkj4cvIc2kDwnoKc7lA6x1E96jrSG+7JTcB7yPi1tQ1j7v1viOoSALvV
	 LxgYVuR/8Dbbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] s390: Warn if kernel command line contains
 non-printable EBCDIC characters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ilya Leoshkevich" <iii@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260826150702.949956-1-iii@linux.ibm.com>
References: <20260826150702.949956-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 15:18:58 +0000
Message-Id: <20260826151859.03CFC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Users may accidentally add multi-byte UTF-8 characters to zipl.conf
> parmline, for example, by copying snippets containing non-breaking
> spaces (\xC2\xA0) from web pages.
>=20
> The kernel will then interpret the entire command line as EBCDIC,
> making it unusable. Distinguish this situation from the legitimate
> EBCDIC conversion by looking for non-printable characters and issue
> a warning.
>=20
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826150702.9499=
56-1-iii@linux.ibm.com?part=3D1

