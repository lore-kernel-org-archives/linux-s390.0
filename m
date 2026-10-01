Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6903F164E
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851472; cv=none; b=ZkJ237kiCeILyDVILsL6apH6xjNNLQe1tRZ/L/TjCZrTKy7j6B5undBuXBEK0IOXBRAW7YoZl6x9yYkFM/B1Hn7czS/HoNJ0ZWn8SQXg+3Y1AujGhpC7R4CCQpykJN0SwguFk5IvrDQC9H9z0f8oqWtYS9nQX9B17TCXGcvbFw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851472; c=relaxed/simple;
	bh=QDI9PjOPnnml1HHSnTUSiZeLUmh52UXAavbhSSGqWAE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mmGGp6we8VgYn7uNaxG+svOxSTPrfJT8QlZNjC5tQfsho0YIOpJObxKSE4xONE0QYLRdsQZPlu3Kbt+gsaB9wdr37rfEr4flbxNXAavBxcjpMEXhVS5ZCl2ncf7Y070MIagmyKH8rjO3jEEO8cTP4YFQP6v1cMFQEPQmBP7KLWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lxrdrsk7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lxrdrsk7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0821F000FF;
	Thu,  1 Oct 2026 10:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851471;
	bh=QDI9PjOPnnml1HHSnTUSiZeLUmh52UXAavbhSSGqWAE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lxrdrsk7OiriUIm/XR3Ihv/uPb8/BPdUUK0tWX7ZpNKx99oU3djXqOzOdDJeYaTB5
	 pLGJ9BZrwDWMW1Jwn0s3jFhyeyegNj1pnQw6vsNvBRVs/UxWuLpVCp/ZSpwkWmnAFd
	 BMKg7R2sR1St5bgPERqnuj40WC3fc1+Ri6b4BYsPqmsNjIoqcpVr27I/cAqrbl5+Eg
	 nKA0HT2ykouVHOQnjMgF91CFct2l8RvDwkzVfryY9ooyKY8HpDv6utx49mcoXLEuzC
	 fjmcbWIo9VVcPjJnRu79ZxpibZhg6dGgmIjuEUrqzUKVKBfNnuECiGr0HDO+T5FuwO
	 SBcwVwosDKG4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 32/32] s390/extable: Remove EX_TABLE macros and fallback
 extable search
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-33-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-33-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:44:30 +0000
Message-Id: <20261001104431.3A0821F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Now that all exception table entries point to the faulting instruction,
> rename all EX_TABLE* macros to EX_TABLE_INSN* and remove the
> EX_TABLE_INSN* aliases.
>=20
> Also remove the fallback extable search via instruction_pointer() which
> was only needed to handle the old EX_TABLE entries that pointed to the
> instruction after the faulting instruction.
>=20
> Add a comment above the EX_TABLE_INSN macros that documents the usage
> rule and describe the difference to the previous EX_TABLE macros. This
> might be helpful in case of backporting to old kernels.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D32

