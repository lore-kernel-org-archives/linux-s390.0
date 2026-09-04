Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882681F1932;
	Fri,  4 Sep 2026 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551996; cv=none; b=t3di+LTXsfhDScbN+mf0J55DbMtyLxfvyP+kHyXGtV0tXcUCXvJCJHf8yb63R4rKrDzkd/T60yEXKFjlzRhPyD1MxyMLskYwzRt5K9ZkJBhfho7dznoy9teMaXdhkpMm0ymcY4N/nsRvKXXyeTzlgvE8x1fL6KKkDVDSgStYkrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551996; c=relaxed/simple;
	bh=AqvRX19FxBFQP7yASaLK1UV7nmZyyzamgPwH0W5lt9M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e+HxrMmyuqkq4hq988SJf/mM+5UopEnJD1l/ZhdKRxNGDDVnyTDNznkAH2RA8aaqsO5GjwcugnsI3NTkQNnhTL9QmzJn4byxw8x4Nl8Zxpimn2R2wkB4Yfcyc5zJat5uEle1AswC8D1UTGDh9Sc/HOC9jqoEqtTltDbja0+Bq4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4VCGw/O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4VCGw/O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9701F00A3D;
	Fri,  4 Sep 2026 19:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788551994;
	bh=AqvRX19FxBFQP7yASaLK1UV7nmZyyzamgPwH0W5lt9M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L4VCGw/O7E7V/me3kBmkLn5SC2oddHbo79WeKgmujEvXlzQlb0jPq6Qln8CD9Q/Nk
	 i44rgqAF2tYcKYCvF9hdTjOuXWmjizEbM6CBRZNbGLrbNU/i+TZKb0VBhIn8tst32J
	 +rfmJk9pTZLiGcsi/uAr/YNbM29u49GxLkNy8oFSRyGF8MPwOhZE609WXn5DMBpIDC
	 PtdgXwDaLlnO6fQTjfCU3pp/E4a94fw8rmzKpPaPXTj3MCOGV6RU0TQfRJBMKy2U9c
	 vvyOkPwDmib9hOfemrVpDmLuD+29HYNauv7UhIHqtcGOr64WZqaOVFLQc1p4yjtccX
	 Tl8I6RCDb8hNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 6/7] bpf, s390: Use resolved pointer for
 timed may_goto
Reply-To: sashiko-reviews@lists.linux.dev
To: "Siddharth Chintamaneni" <sidchintamaneni@gmail.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, bpf@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260904195132.141068-7-sidchintamaneni@gmail.com>
References: <20260904195132.141068-1-sidchintamaneni@gmail.com>
 <20260904195132.141068-7-sidchintamaneni@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 19:59:53 +0000
Message-Id: <20260904195953.9D9701F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The timed may_goto fixup now passes the resolved counter pointer through
> BPF_REG_AX instead of a stack offset and BPF frame pointer pair.
>=20
> Copy the pointer directly into the first argument register and update the
> special calling convention documentation.
>=20
> Fixes: b8efa810c1db ("s390/bpf: Add s390 JIT support for timed may_goto")
> Reported-by: Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>
> Link: https://lore.kernel.org/all/20260824213158.3755932-2-Jeremy.Jean@os=
s.cyber.gouv.fr/
> Assisted-by: Copilot:gpt-5.6-sol
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904195132.1410=
68-1-sidchintamaneni@gmail.com?part=3D6

