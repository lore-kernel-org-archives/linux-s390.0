Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C1223D7F0
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785516834; cv=none; b=hp378bor25mao2D55XU7/7L4lBjmu1z1qVPvYAK2+14exhI9zeBGFjN1liZsHiK/xl43IEsxtVEHeXj3H4hKE+ix0mkLPMV40P9zJ8NZTpeui3Ly8v+ERSW4JV5WHA2dLwwptMx0mwySrbITxuXdF0sCQdFzGp7DJP3Qqte9CuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785516834; c=relaxed/simple;
	bh=UC6x9cdJz3mQSANAhF+1762RIb0RgpWBwUzdDMqgcYI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hrQZrZyI9+b2sbblZ+/WntxOnxXQv/JInF7pMpRCIdypM+3Em+QVHJ3uzd1hNWtr/+Dkm2f/S+/2OgwSTGjZC94Rdd23USl0RD+hTYVyIx+30dVSLVwfp/mXDE9AcgLsVLeL/1Vfo9z62nJQXuIsqpGLIAV91RzkCBA5ctTOdWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kw+M+mI1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kw+M+mI1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261E31F00AC4;
	Fri, 31 Jul 2026 16:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785516833;
	bh=UC6x9cdJz3mQSANAhF+1762RIb0RgpWBwUzdDMqgcYI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kw+M+mI1GfRBs9LogDxF+qyt3MYcj5iChnpHzmOvwRaSNT3OK10howV+9lThjfOJl
	 qlfS+5lChQ2jZKyQp+VXG+r4e7DGpMBxApUy5FASux/Ja3ZC/AGeQFDK1pJZhJ9CYd
	 Tv0vzGkHVESo8H4df9hi+FV50TFLiCBe9iMU+pOjq5w0c5zJFif7XlUemsl68gkbZN
	 J0PMVk+gjXHO8C5o2zUCTjj9dHHGLEZ/sWLtYBIKj4stcblLYCjRdkwKkB+VUXkLTr
	 PhpIcK3vYE04c7KJUQn6GbdrulsWFIeNNGK/YLOYuyZA5f90fAVcJrjUhSTk2ETq7A
	 NSdKNboiz5hIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] s390: Remove cond_resched() calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260731165004.2758105-4-hca@linux.ibm.com>
References: <20260731165004.2758105-1-hca@linux.ibm.com>
 <20260731165004.2758105-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 16:53:52 +0000
Message-Id: <20260731165353.261E31F00AC4@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731165004.2758=
105-1-hca@linux.ibm.com?part=3D3

