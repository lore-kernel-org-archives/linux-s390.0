Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DC730D404
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851169; cv=none; b=GXnit6tNNBR7ZTFv2+asW/HP1uLlEKFQLcfVRo8IzM6d/JeVmznOINCtH2oMMhmnmm3EG8hUEMRJdlD6C1KuMEBZ485NvspPGW8xTjFMTdh5pt4duMmSS39Yjesx3xdthJ1rN5TPJmFqFvveKrTMFnKDQA/+cPr573lNaQ8FM94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851169; c=relaxed/simple;
	bh=/nr8WozW91RbwCOCK5HewJZFn2XDliuIpwISwt5+xU4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DOMhl510R0ByzTqdJH9mx6LFUL9FU+U8bbNfTT78X8ORIKHtjum+ZQPagmvpzqiJo/c36NmOcVRkk031MnOUvsi/+sEKVB8yOhf7AE791DfqqVxoBDD5fOP5k8hvBVs9a1NlCDrkR+z2hwItKB4edP9SXEo6tGY2dLaAa1vmEfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHWU3vQp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHWU3vQp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3641F00898;
	Thu,  1 Oct 2026 10:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851160;
	bh=/nr8WozW91RbwCOCK5HewJZFn2XDliuIpwISwt5+xU4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iHWU3vQpCg+sDqzImR3Q3l3l4cAL6fnvYLkf4ax3qnCnGFR4+2nhAWypBhk2KsMdb
	 BvBXGC7kGHP6flUWIHlDqdFf4vxyapbqiZEo5p6V280fmrmZvlMhoY1hoDp1VE56al
	 eHVA6zn0WMU+L3LMsgxDDSoOzvqBGMAUsd1o0v4A24iS1sYhnR8ayN+Cuj9iHjBUUW
	 cZuecBmneaQ53d+gvheJhYD4SydiqhJbK7EbLe7wuKa7aLFWxKDgQs7EZU/hwlhAup
	 QPmgj9Emf4/NdXu4iozuXvC6e9trVfXGcaNd6ClszUB6qCIyFnN6HvzO0vBoql0Krv
	 Nb75YPtGP+8BA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 19/32] s390/hypfs: Convert inline assembly to
 EX_TABLE_INSN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-20-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-20-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:39:20 +0000
Message-Id: <20261001103920.9D3641F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert the diag2fc exception table entry to use EX_TABLE_INSN.
> With EX_TABLE_INSN entries always point to the faulting instruction,
> so nopr padding is no longer needed and removed.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D19

