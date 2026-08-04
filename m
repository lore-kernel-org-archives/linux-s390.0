Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EED84519B2
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785841366; cv=none; b=FhlHoYVeRfzFFwH9oy8+i/KizP5A3DiMCHPcuujgmljzugBQ68UywgjPrwA/D3xfc3P72WmJfdmSXj1eKCPffJXcBtVX9qDk80Qvgai3yfjsOyCaYLAjDfbpmCLsdnHt2wh4uGeqso7X0yPpOVj+tvEYUhbeqNge5BjGdDqbID4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785841366; c=relaxed/simple;
	bh=jTJOdshfWeumZ96jV2WdvF1ngmmi2wY98LEeyuCG9kA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=etTttR0pfCZGBxAG2jIz8ysLQS4y2eVdboQIobSYZwChrDoj8tyMNGkJuG1lRP8nKTg7wXZQN+CxDCLr3g99PfuOf1K+FezJJS7iJn9TeBmr9binV6YrH08i/ukAMsQj3a3npvTAuUXN9Q38zRU/4ePGVy0KFvXhTSF43LmSZHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9eSCdnV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9eSCdnV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8FC1F000E9;
	Tue,  4 Aug 2026 11:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785841365;
	bh=jTJOdshfWeumZ96jV2WdvF1ngmmi2wY98LEeyuCG9kA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a9eSCdnVlVKFSbxru6AJIPpSZOY1CuzPUUfXdg6ChVUkaxxaMs39qYcIuLyrflZxM
	 CQ0tW95CDh6f6SJsPTm+693IcFj7cQeJHa9VJ9CznChB9GQ8sWMrBuCERJy2p8cXED
	 5c/2t8hdQUEOmu5z/fCf+zf9St7FPGEjYvz6GSpfaJzpeTyhOtA3DxLPkS0M/v++71
	 KSCyeWi1h8XjYPmTEgkdnjPyYtUUx4oEBAftQoL05zST/yq1vvtAqFyCPqpiYaAxFN
	 ftXP8P6BsQtXshaRvrPUEoLlxpWG2azAwBps7JLJN6ch2RtrmryUoQNFODx5GZbKxq
	 fTSpj+7tScXcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/1] s390/ap: Fix MAPML computation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Finn Callies" <fcallies@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260804105811.17744-2-fcallies@linux.ibm.com>
References: <20260804105811.17744-1-fcallies@linux.ibm.com>
 <20260804105811.17744-2-fcallies@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 11:02:42 +0000
Message-Id: <20260804110243.EB8FC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When the TAPQ subfunction of PQAP returns a value between 0 and 3 in the
> ml field the Principles of Operation states that the MAPML size is to be
> 12k bytes.
>=20
> Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
> Signed-off-by: Finn Callies <fcallies@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804105811.1774=
4-2-fcallies@linux.ibm.com?part=3D1

