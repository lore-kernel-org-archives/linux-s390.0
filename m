Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510639;
	b=CXQqOaBTE3++AtZrbHhfCrGoaoyBV/jfgaI37mJ1bYiJEsTX+qW4MkRhQGpVUUORm4Qy
	 cdseybKzQczQ7CpmWOqmmwpIbzEBfTz2RY7ww+3rgMJR4sImamnX2uIrpl2qWBw4fePHD
	 bnUgqg2eJtmuzwA0iML1SwrgWRBJza/c8VZCtFipGnXEcD0WgMplEPuPVCXSDumf+PQLz
	 vWnspb2/SNKgVaegYE/lxkMxvGrTJBHHivipu5OhdsHrLkHUmRB5e/DN/thj4qsDDeG1R
	 knufWPFSBUEXOCYaRbE6yp/f1H3QdLR+nPfT7cZfwXl8Eha9sZC+eT6c6LtWAlfdY3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510639;
	h=Received:Message-ID:From:Subject:Reply-To:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ulYvdd46PNJGGyJnI6JxDYjxAIUwqBHne+86rLKRklQ=;
	b=nIine/TdTZ1eDVA9jlzL2LbsS5kHO3JGpvmbgBU7/DETHAfrXSr6GceD3M8R79d1ee6x
	 98w9tAIFqu+ViTSs6i8FH0YXmztSlL3mbOk5W+QboeYKjrKU4h6MVLTMjUNdZVYRoZHIT
	 TioZkpcKtEWBE6LLLLY7RRQ8wfN6AVahpHN5/4YtmquUZNJvzDFxcsvmwRsFWx+7pZ5yW
	 YvrvA6dClt1szPFyrf20zl/lm0YGRefOC7vNz070pYl+d+you99pfd7naobIvoM11VIj2
	 72NwIJ3EO22SLJogJr5Ilmoi7PhoKByIoQVQv3yrWIJq8snJf427duyRx1lpab40+Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B447606A333
	for <linux-s390@vger.kernel.org>; Tue, 20 Oct 2026 15:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956C41F000C4;
	Tue, 20 Oct 2026 15:37:18 +0000 (UTC)
Message-ID: <sashiko-outbox-179263@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/3] selftests/ptrace: add a test case for
 PTRACE_SET_SYSCALL_INFO syscall skipping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Renzo Davoli" <renzo@cs.unibo.it>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261020152945.575664-4-renzo@cs.unibo.it>
References: <20261020152945.575664-1-renzo@cs.unibo.it>
 <20261020152945.575664-4-renzo@cs.unibo.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 15:36:48 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Check whether PTRACE_SET_SYSCALL_INFO syscall skipping semantics
> implemented in the kernel matches userspace expectations.
>=20
> Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020152945.5756=
64-1-renzo@cs.unibo.it?part=3D3

