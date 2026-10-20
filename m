Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519779;
	b=qNyTI60nDphIY4vlK0Oxc7SA1eTwbgsNrryqED4XyZl4U/iXUd1YQ5hk1Blzxm+vXf6k
	 W1kxwUhnpNEgkAdjIX0u0YdzKLllzrj/RbySr1mbg+MKer3jIakEZRBduP0wvEVZlCEKn
	 qe+FEgSaTbskc3wlychgq0D9fKknTHfciRrMzge0PDrxpt1e0vhE04I3oJ/hzwWIpozmu
	 HrCLvZuj+3LYOFUJrPbfBTM6rOSyPtQ519YJRTPJ3cRNrf9qFFVOL0MRHw5VUAkOrXZOg
	 iPB+KfkMFkMMrJEVN7TGmAkjAQZYPrXlHztzjnsyFoiNvptvbaln5Km9eS57A9vUklw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519779;
	h=Received:Message-ID:From:Subject:Reply-To:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XlkY4R8UppfCIBirOHKY+kmFhZ5qWGmpWmrER97kNQ8=;
	b=F2Q0cs4nuAQldJX6CzUcA+JpuOID2LtG7YjHQx0Lq5lWwzQl03tsup96ppibw8+Y3yUK
	 V1Rq/0Oh1HaB+89sOz/pVzdkEqgaHUWZSW1j9xLX4+/vlmR7fJiBhYS29xeY+iFxI9CMz
	 Pfmvj6pXFNcX+kBlKBRRPWWMkmAye+LhyEOsa+mrwt8aYvTv8uFa6dBhb0REr0lK2qf1D
	 SM/2gv2K+0wUa70oZsdLs1u/0L5TpDxhUXYSMVGeIMikKf1NSsIvQNK40Lhuu/zcMeB1/
	 +4ZDX4KXWmQemgB5cW9NSxsoXrR3xlFlSTvsBVwQUIyr7itxqmVZOkMdOtYgSCv9lhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FA1606A319
	for <linux-s390@vger.kernel.org>; Tue, 20 Oct 2026 18:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977791F000C9;
	Tue, 20 Oct 2026 18:09:38 +0000 (UTC)
Message-ID: <sashiko-outbox-179454@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] KVM: selftests: Test that KVM_RUN fails for
 unresolvable host faults
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261020175818.375700-3-borntraeger@linux.ibm.com>
References: <20261020175818.375700-1-borntraeger@linux.ibm.com>
 <20261020175818.375700-3-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 18:09:08 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add a test in which the guest writes to a shmem-backed memslot beyond
> the end of the file.  KVM_RUN must fail with -EFAULT.
>=20
> On x86 the guest enables interrupts, and on s390 the test sets up
> pfault, so that KVM could handle the fault with an asynchronous page
> fault.  If KVM mistakes the error for a fault that needs I/O, the vCPU
> retries the access forever, and the test fails after a timeout.
>=20
> The test is not built for LoongArch, which handles a failed mapping as
> an MMIO access.
>=20
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020175818.3757=
00-1-borntraeger@linux.ibm.com?part=3D2

