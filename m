Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4C53B42ED
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851613; cv=none; b=bBdRAld2vXUBx46a/9o8ikLB6jFwgFNEDypsl+D9+mSGxSt04B0Ovp4sDGPgDTxXqshhfMfHiT9Inxb1rMVLbS3Cle/F6kXdY8dPBDJ+JI0UyrRQzkEfn1VbXe2yI4VroaMDps2rVZe6/klPppWKz+JEyuccZv6Mp0lQb9bzZwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851613; c=relaxed/simple;
	bh=91E9Dh6p1I1ZYNbEZHnkMEUc0ArkQi4z3dRo2Wh6wcs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XDEqzdtVfTS9k+giTtKQP0d9rrj+ahgxj2ozxr9s0kzV4ThG5MMtAWKcQbi6dqXIHcoxoR2h6RiwSVKotLbzLIguRW8AcCl65tG1Umi2QAV/+KUymN8CbUQHYJicWktihbSDx9JB1J2UB0IDdHgWRSserket97XExnZMyAq4Ji0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVkvhBca; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVkvhBca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDDF1F000FF;
	Thu,  1 Oct 2026 10:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851611;
	bh=91E9Dh6p1I1ZYNbEZHnkMEUc0ArkQi4z3dRo2Wh6wcs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lVkvhBcaHZNuWsALD7Jrt5COD+NyirbSRNQsziUoqCb9LvezXoOksglFTtiKDgBDB
	 UkxoT9jagZpbpN8FACk4ptMJ8ebVeE/BUgGWn3LhA3x9b+O8Qclal0iRbBGI8iczJ/
	 PCpbbFaBtfE2Su8c9sfxMvKkxlCZ/U46xY3qMBY3WCCaD/gSgcTmbxGWSJCz+cNVvS
	 6e2NiQQ6o+tD2RfdG7ezVdU62qkQSXQRYqk4LLziMPtHJ9GwAYTrhvXYZnRMdSb1RD
	 4OrWuodOhDpx2+g3GI/ATRjRkaO1Lf43ujepVkWO/hqfZk0th7ZdF7Attv0JoVNQ9e
	 o5+1XMNaVy56g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 25/32] s390/pci: Convert inline assembly to
 EX_TABLE_INSN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-26-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-26-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:46:51 +0000
Message-Id: <20261001104651.6DDDF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert all pci exception table entries to use EX_TABLE_INSN.
> With EX_TABLE_INSN entries always point to the faulting instruction,
> so duplicate entries are removed.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D25

