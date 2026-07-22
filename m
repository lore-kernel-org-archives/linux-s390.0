Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B1833936E
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731040; cv=none; b=Ea639QBRoRuVp6hZmfFtniNMI2SmhRv9LYUb4vScxa7mZbkg4NbfkjN3RUPeGLbYZlXMhKP+DmyGkPU5UjkiulEjemFeMcdluk3Xk2sDqaPBP1vGBEyKfhsa1/BVALLx+3cjXvlLZuD+41zRPjDDE/OSI/9UQ1dHtG9S1fBbhZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731040; c=relaxed/simple;
	bh=CmVf75ZYGojjUPg0RXyQ2Dojs9lIk12INCme1tREgAA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TEl1eeVt07x9DnI8JTI/pigXKHrFHle2uRgrgWnjGssofIc7RsuZEhaQVhQN4lzYT+kIMzFwfgd5Wc1UsCu0bZd3fQVYOr4krOLI2z83Xu5BmBclb5n5mKC8+wavJgzWHjrbZ7yb0OmQp2MKKy1AZYjERUugmLggMkr5nbg0qLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqQhebsN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqQhebsN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC8C1F000E9;
	Wed, 22 Jul 2026 14:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784731039;
	bh=CmVf75ZYGojjUPg0RXyQ2Dojs9lIk12INCme1tREgAA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jqQhebsNS7STlr/cw+FKkbHUzNTnar76RiHZyKLxadsepP3L8NMZBRxHZc+WZJ2Jf
	 LCk5Prs0OyQ1H9XdIcecWZgssqaDVOUaTsr5OqnDw2StmZq2KKRu9AUuCgCjyU4LlY
	 pShFePStjMan5OEJz5AfWCUTsmaCC4RobeGnVgOWPV8CveIXX75SMzwakxJ2Zz5XQd
	 48lMV9SZ89ed+r2fhLu56eMf75Q0muIn3fuGiz7Cg4K3uDcDhxIv3Fo2M5mkL/xAcx
	 EUAlSuVDcNGRRnSn6NnnbmFyDYmPX0rObxxEvtEgnQjNmP3n5Is8beUTOLuMPeijQ5
	 5X9GMJzux5WxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/1] s390/pkey: Rework ioctl functions error paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260722142947.109588-2-freude@linux.ibm.com>
References: <20260722142947.109588-1-freude@linux.ibm.com>
 <20260722142947.109588-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 14:37:18 +0000
Message-Id: <20260722143718.DDC8C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> With the pkey rework there was the suggestion to rework the error and
> free paths of the pkey ioctl functions. The complain was especially to
> rewrite the failure handling with goto instead of all repeat the
> nearly same code (kfree(), kfree_sensitive(), memzero_explicit()) for
> each path. This patch removes all this duplicated code and introduces
> one code block at the end of the functions which is jumped into via
> goto out or executed on regular exit. As some helper functions return
> an error pointer value (which is NOT NULL) make sure on the error path
> there is not by accident kfree() or similar called on such ptr values.
>=20
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722142947.1095=
88-2-freude@linux.ibm.com?part=3D1

