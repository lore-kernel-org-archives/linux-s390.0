Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CBD4562BF
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 08:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980272; cv=none; b=IsSpsy9TUvl80ZMX59f+DV2RmAlsGLLh+Yp61wcjADINk+fX9/EyyqQge2U/hk2SIxkEeR8wQnSQ5HgWaE4k+Mzn+h/Rxttu++GamYcP4A1DO+mgTTpefvvNe0Wb8BrWd9L2mW8Jh5ziB7/7ezACwkzftH4z5C7xFfY3SIqV/kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980272; c=relaxed/simple;
	bh=Q8nLHExkXWds00BlsaBsizkFDF+f7hVNMsve+XUsXC8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CdOPa0tRYsDCySWXzspz8y49ZhIDcPDCD50xquhPn2EeePt+aiQa1nPLHBPGq+zAzXqk6Z+qJ1SHTN8ceZc3k1rRQ/4FMTNrslghVQhzMS+cP6+U4MUdHClU7Ef4fqgWw1OVlS+boR2wA6Gub8LUhWlT3BdplFBlN5FTBjx/XOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGHxSWfi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGHxSWfi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9260E1F00893;
	Mon, 21 Sep 2026 08:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789980267;
	bh=Q8nLHExkXWds00BlsaBsizkFDF+f7hVNMsve+XUsXC8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZGHxSWfikVI0myjS5Kztm4mWv/w45CmQw895xfeB+LGrlypt1I04dEwB0Z5izRy0e
	 2BqLG3eUqxHYFL5MQXiGzGurf8urzLTNc4IwSwOTwBTSvHGOkpD6f5VcFsLnR1Xbz/
	 Q7VPK6RYLiwLKW7KMwJwHh0FS3CXV/mUdFin0V28U7c57qm6Xi2fqJC2ccHGjcbMwq
	 W5QbS1ruiUq9fff74OElk2uH7uKAnQl3PFaQrJq3ZEdU7Z5aex34pnByBS+KFB2zS1
	 +3H75CbFLGb8r7t/77g97RSYu+bbdBvgBnxYHv1m40lA0hy8SppGc5HlEPUxLzVkBh
	 zXHycjclAVV7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/11] s390/percpu: Rename inline assembly symbolic
 names
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260921084005.4022574-7-hca@linux.ibm.com>
References: <20260921084005.4022574-1-hca@linux.ibm.com>
 <20260921084005.4022574-7-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 08:44:27 +0000
Message-Id: <20260921084427.9260E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Rename percpu inline assembly symbolic names so they match (more) what is
> specified with input operands. A trivial change which is supposed to make
> the code a bit more readable.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921084005.4022=
574-1-hca@linux.ibm.com?part=3D6

