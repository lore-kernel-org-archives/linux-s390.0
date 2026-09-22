Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E04149159B;
	Tue, 22 Sep 2026 19:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790107133; cv=none; b=D7olBqKLlbgaKtzssqLBgIKeiICI1PP7cIF11I4Kf0eipzlhvRSh4CpZkZtuNJVU1MRqd7IAND82H4NMCREuBExFfcsZmXh10KxJ+dq+exTRufb921mYYe34Mr2LvcUZoilAG3RHMM/4+v/3WS9n1tqQB4mZfeKYiGbfC+NfkCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790107133; c=relaxed/simple;
	bh=hpQJmXWlb+uY0hJcEhOGpGhfffRnCl2wpzxG3bnWQ3c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OhhhU4O62pALlmCFsOp8xFSRBDIUY129ur1bQSuR9Nmxd9yuzR7JqDuUROamwk0OYFb5qKvqOfTGt0BB0pTDSB6uG73DymgdFGjvTHI0w1ldbgNyFWHLbL+1fepg+JIAKlgcxHUlOt9q3kHPqoUbl8W1RrLN9z7gFFZ7LOIJoE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQYO1ihF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQYO1ihF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AA41F000FF;
	Tue, 22 Sep 2026 19:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790107128;
	bh=hpQJmXWlb+uY0hJcEhOGpGhfffRnCl2wpzxG3bnWQ3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aQYO1ihFPsFLeqnZodCy27XMClitao7LrpoWQ9BXg0v+wHNcQ/TJ1p6msr3WGE+Al
	 uHcufCR6uo1Xhc6Dv0PeBlOSV9TvOIYO1F3nYyPlSNORC1T6qI1QoWQZzxVp2KD3sl
	 KHMFGb0kcRwZ7ZAGr8L6dGI1SiEfm6XazKMxDLbRdla2CRmuOUN/6tAGrDYzQr/0US
	 +NXhlCVBPibrqo2tVMxTl77gLT/UUaQcWPJ8/sOdckADL6crFgxnIBcn0CWK1Udbyz
	 pLWBZu2Q9/hvYynS6Fht6Ty+bpeqpqwu8BcQyF4beKxo+dLNnt9jxXidoW2nj5PubA
	 JLx+zAOJ++erw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/4] s390/pci: Fence FMB enable/disable via debugfs
 for passthrough devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260922195141.94548-4-oelghoul@linux.ibm.com>
References: <20260922195141.94548-1-oelghoul@linux.ibm.com>
 <20260922195141.94548-4-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 19:58:47 +0000
Message-Id: <20260922195847.93AA41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Introduce a fence over enabling or disabling FMB via debugfs when the zPCI
> device is associated with a KVM. This will prevent processes on the host
> from tampering with the FMB while the guest is still using it, which may
> cause partial counter resets and inconsistent reads which have no parallel
> in the architecture.
>=20
> For VFIO devices that are not associated with a KVM (i.e., for userspace
> drivers other than QEMU), this fence does not take effect.
>=20
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922195141.9454=
8-1-oelghoul@linux.ibm.com?part=3D3

