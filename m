Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C064AEBC6
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 08:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721707; cv=none; b=vDmPn91vd0DlCDsRg/ZQ8z7Hdd/JyKVFVs6ooE6W4+LI2eL5Lh7WMpiQGRWgabB4eBTfcZHlE0F5+NQ19T5ZzpSpbBf7g7B2LpkgEWY/IqlXOy2265F6wUP4wguVrUKUJLE2TJwawqtFMrSZ+4t8lnE4MhprDrNKsNu+KEkW0TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721707; c=relaxed/simple;
	bh=uQnZbZlHP+9FmGLWPaMYiyKUhmmxzYyIlVGbz3lize0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jX8Xt+yiycFockf3vHnD0MshzVrbuYacaPecv3BKUJkg3h8JZWz+2Ps8pyP1uOcsLa2Uivn5/zY4Wrz5Hjrs1fI79WmFwsqAk4mJmPweG7qRZqDZlSOtO8ZC2p+bnDAJYKbHPCFZ2xoY32CD8eh8wrQOkbhvihWseOQnw41XpF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZUucUgt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZUucUgt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBB91F000FF;
	Fri, 18 Sep 2026 08:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789721705;
	bh=uQnZbZlHP+9FmGLWPaMYiyKUhmmxzYyIlVGbz3lize0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GZUucUgtY3abG7t1kGpkT1Kkqzpq9IlEwwlI7/F4u765mcnDfMaTcEGrIr9CAhPzP
	 oVtRIus37J7Uf2yG9QMjc0tZeFiHvU1ifyWlJMMD17y07xW/jWZjKZbWmYRknBePIR
	 2VHe15fcfVhPZ5/sfKbjywpYqUk0Xdr8cSp5Wn54HjZ1f+MrDPeGaMmuHwBMfH+dZt
	 0I/KXhb2lZEMvKzWR4qVELIMQ/04YKxUxjH5bnE5/7wjY4ynfkxagasOSrTflfgy+X
	 IO9WcOtNJUM1eF66KgWwoFCqJKQO22p12PFQekXenwxHs0jkK/xzQvi17NNzlqHuUo
	 dsYdOPDhyWmuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/12] s390/percpu/lowcore: Add and use LC_PERCPU
 lowcore offset defines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260918084842.2333237-6-hca@linux.ibm.com>
References: <20260918084842.2333237-1-hca@linux.ibm.com>
 <20260918084842.2333237-6-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:55:04 +0000
Message-Id: <20260918085504.DCBB91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Define LC_PERCPU_OFFSET and LC_PERCPU_REGISTER offset defines and use
> them in percpu code. This shortens the percpu inline assemblies and makes
> them a bit more readable.
>=20
> Note that because of header dependencies it is not possible to use
> asm-offsets. However to avoid adding more dependencies to asm-offsets
> it seems to be preferable to use the current approach in any way.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918084842.2333=
237-1-hca@linux.ibm.com?part=3D5

