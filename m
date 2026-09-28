Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6452D7BF
	for <linux-s390@vger.kernel.org>; Mon, 28 Sep 2026 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608896; cv=none; b=OuVGvBmwODbiZah36ovFw/X1KY46r0EkBRZ57MQEvADI9ZyvesN0Lj7kDbngAMBdhnkhAAg4uoSFKVleJYSqEa66svmwp3DNy2Bsy7dfPUWwjS4b2ZEmOMkqC5lNowln8VGIGvP709N4T3VtLVJ/Li8SNnfldi2siBEn411gQ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608896; c=relaxed/simple;
	bh=sShmxE4TqwrDDxbKZv24kmBGKejy5B1DChSftkoLYS8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xmt89NlBEkqY/77k4PHxRUy7zScp3DUjYUGmNq4qKjNVXYplx0Q/aZtw2QtS/cw+SSKrzGNSzOUry2GJCcJX+4mwkg289xEeCbpvd/0N4JoK44R9KQByQCti+UYljzc3ZZMSa5k7tYxj5yUPofbtj4zdgDHHlv01PsmLPqBpJLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDaTGsgT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDaTGsgT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D431F00893;
	Mon, 28 Sep 2026 15:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790608894;
	bh=sShmxE4TqwrDDxbKZv24kmBGKejy5B1DChSftkoLYS8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MDaTGsgTBxNd8qC6JXP/GAKRko17fKRkfMf2kZzXeFHulMaGpmtb5CAUhtX+VzH5P
	 BpDGNvUITgS9hrvmrbzmglCMcRiK5i9AmlrTrDIFKVy0fPzOJRYnLMB2zZiTI/JLOb
	 vE95uYgxi/eOAthnYFM2elp5AgwVkS7m/CAoISJNg93yhxUkvRpJAuCxEXjJHl2/Zs
	 Y0wufhMSB0bRNbte9jKHPrTe0q32R71GBUI+n8gFDhg1bu7xvPyNYvPLkENd57VZyT
	 SU+aMQ5dWbDcyI7mjhNvdKGjMftvLS1wzpwD8rdhhaxTAC/2UXYmd0hLNu6dThgAHL
	 RELNsoMCKK5IQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] s390/ism: Zerorize dmb at allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexandra Winter" <wintera@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260928151420.383105-1-wintera@linux.ibm.com>
References: <20260928151420.383105-1-wintera@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 15:21:33 +0000
Message-Id: <20260928152134.67D431F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Sashiko reported [1] that 'Missing __GFP_ZERO in folio_alloc() causes
> uninitialized kernel memory to be exposed in the receive message buffer'.
> An ism dmb is receive-only, so the data is not leaked to a remote peer. In
> general the smc kernel module (dibs client) will only push newly received
> data to userspace. We still should not have uninitialized data in a recei=
ve
> buffer.
>=20
> Since
> commit 750afb08ca71 ("cross-tree: phase out dma_zalloc_coherent()")
> dma_alloc_coherent no longer required the __GFP_ZERO flag, but when
> commit 83781384a96b ("s390/ism: Properly fix receive message buffer alloc=
ation")
> switched to folio_alloc(), it should have added back the __GFP_ZERO flag.
>=20
> Add __GFP_ZERO flag and state in dibs.h that register_dbm() provides
> a zerorized buffer (dibs_lo already does).
>=20
> Link: https://lore.kernel.org/linux-s390/20260903143746.A5CC41F00A3A@smtp=
.kernel.org/ [1]
> Fixes: 83781384a96b ("s390/ism: Properly fix receive message buffer alloc=
ation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928151420.3831=
05-1-wintera@linux.ibm.com?part=3D1

