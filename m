Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A369F1F942
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 05:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785390020; cv=none; b=b/QwrmYsbiaWadNe9pQUlJ6Qqxk/s549+iue92SsbSBQoTbU4Ne9D+4xnr7+7A1rhPVSnph/XTTvw4ViDss0YCvSxMYZmTHLqTuWMGe4VzXhApOKjPs0ohmF1MLVLq1KMyMKREylSBMR07X0claO5VdCUdVPwzSL/ztNRAqDJn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785390020; c=relaxed/simple;
	bh=zQAshiF3htu1qV9cBUsEySwvjrd9RI5S5qW7P/GC8O4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y8bnvajM+63D0n4HqFobOuMYNqDB10Mgh+Nv5G7AwhRoBsggYlvrd+B6HeYGnRUJoiNh3fIcBI18ogmh2E1BzUMnoL4v9zgjcLnJfy9z10lsHTZnns61wIrQye4Ox3Oxkqw2i3iy9cNhBioP/ctSXLMrr5e3nEy8Tn/UF1weiVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6GERlgC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6GERlgC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1281F000E9;
	Thu, 30 Jul 2026 05:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785390019;
	bh=zQAshiF3htu1qV9cBUsEySwvjrd9RI5S5qW7P/GC8O4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D6GERlgCNQl9X0lcWaVt0v57MSa3Xhf7uS9xrLPfCFQxwVZCL52LU6F6JodcXqpeb
	 HGhI2ZbdcZi0ICb/ahpB3dZO9BplMb3rsBWkd2IrVgwmXYZiQEtRjeV92z6BgW2x3+
	 bh2P/w5uCqhbZ1PMExbwiKCKBfK8aLGqq5Y3yAGCSKZ06OMcsyOYCsgJOycWAvTquP
	 4MuZtShkFZWmWbNMI2HCvDeiWo16GL5FfEb32pUGpVd5iAXLuHV96hrb7yG1+Ob9xV
	 OLjS1XOciruN7joc5HTqyMmG+O+qnb1JqLL3yWyMy/+lgntPew/5knEpjXPaX8Cfvc
	 iIcYqS8woWdyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] s390: Remove cond_resched() calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260730052907.2607026-4-hca@linux.ibm.com>
References: <20260730052907.2607026-1-hca@linux.ibm.com>
 <20260730052907.2607026-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 05:40:18 +0000
Message-Id: <20260730054018.DF1281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Since [1] cond_resched() is a no-op on s390. Remove all calls.
>=20
> [1] commit 7dadeaa6e851 ("sched: Further restrict the preemption modes")
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730052907.2607=
026-1-hca@linux.ibm.com?part=3D3

