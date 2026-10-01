Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08B84BD0F8
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851321; cv=none; b=Z8ZRoL8CMkhSoLJ2rA7VhffnloXxPa+V+++Sp2N/UB5fdeJQdx9oH/f9X/jDl+/lEj3XyPENPQpuPYS15cDvVXhYCmp6ybObItEU226cfuXrAa9YKqu96yafYum9ZNJnD3FjP1UpkhvTh0+ZmQXlkwwNsiZFzWOEILOwvTR7Aas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851321; c=relaxed/simple;
	bh=oNJaN54yJYEwKiIm4J8WirKQUXqkdv713CScBn35YMg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bgIYCWvl/WJg/XNJqziHr/oJcOx5K6jW3kS944xYw9VD2pKjl3jL1bv0W+rO+X9sWCXtP59moNzImfbu69B3voIVOx4Zvc9yVOa7Mp168LGPqBWg4YD4x7hseG8Vg1zrL1bGHRPSlfLgoJ/PKyfaCPd8JouDYQ+xihESpzIgg6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5oJ6+b9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5oJ6+b9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1471F000FF;
	Thu,  1 Oct 2026 10:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851314;
	bh=oNJaN54yJYEwKiIm4J8WirKQUXqkdv713CScBn35YMg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I5oJ6+b9kRd2NWOdpbvj/T/Z92NXvisrUdz2YbgtBohZHSDA4K9hdvW2HCo/kXzfK
	 h7a1FuPepNAg5TVAOZGONnQyPD3xtNP3nTos7m7WEuDVFJ7R8E/do5WRYTzboKGIhy
	 axq+DeKGW8JiFHCWlW7wAxTskRxzvTQRzh72a2OWRoQIicpM2KBJ+qXNRoaZh/V5MV
	 v9y9jU6qQNsWonHBLYRoRWf7S3EdhdOTn9O9BemEXDqzN04eVl46snfVmbeg2bc4tO
	 hW7RUtcGGITDFJRkUQz/dSRxEyqDH0OuZNyFQm8rFLyQ/gh+wdMF1gYdMfr1HrZi/Z
	 AgFHb4i2Rn7Lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 22/32] s390/traps: Convert inline assembly to
 EX_TABLE_INSN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-23-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-23-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:41:53 +0000
Message-Id: <20261001104154.3D1471F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert the monitor call exception table entry to use EX_TABLE_INSN.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D22

