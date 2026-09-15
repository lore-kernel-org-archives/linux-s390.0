Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24D949B208;
	Tue, 15 Sep 2026 23:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789516426; cv=none; b=Xcco2EOl3tcXBc39qU6xGpR74oRptF228stApfOXzH7nshhq1J4qFsvacnnrsjDcdrbSnlFzQhvFRzVGgcNelI3Q5cxrDGu9WS16NwJIX7rWm9naZ7zuMJ9DOkTeFXnQnzQtR7U3Q3ISWWzQ3+P/3pZjYpJ/Yb0w4l7UHFzLQcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789516426; c=relaxed/simple;
	bh=OPWCzUYSAJXN4K++8vT6w9N1hwOvTESTMHXbrKefK4c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KMXIw1J0gp2n0CJ1UhXpHwAwU03eCM6Zu+HP9ZqSJeN3w1hHrT0o4T0HxkeuoxBMYNDJuzncnsm5fGzV+sZBsT4zuPmDBjjbXDK1bouyZKyL2/Tt0ZeoiERgx92Hqt5H0yNHOxQ3o2xEtSRchA2xqIZ6foOPivgWYTjusghLwKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PplxQb5n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PplxQb5n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507961F00893;
	Tue, 15 Sep 2026 23:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789516423;
	bh=OPWCzUYSAJXN4K++8vT6w9N1hwOvTESTMHXbrKefK4c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PplxQb5nyQyaZ7w46hyW23hoFg3yKZvpD+woczhTgPfqovvmPhOTEFEJLwmWzc1gk
	 QAACR2sPNCs6atVacLPhG5TcNwXo3GnUk/zXpbCLCC6i/dNCC8v4FBIXpGo+ojwdgK
	 jt4X9lbnN9dEOPib8ge0m2BdeNY4LlmbZ6XI2nRMjzIHLDUF3OBCskvQbmqNp2qmmh
	 lK4IrtmZ81P6GLSolCKauWVvNPjjVnzC+3wmE7hLQtVrtcvR17KT9Q81+K6VP+F2fO
	 SLa9CSCvNFfMPCmkwMDq60hTsEBKdFK8FjyC+CTaT/ZkdbiFLj3CjevYjYGRl0F0n3
	 ln3J6ul31bpCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vmcore: convert mmap_vmcore_fault() to use folios
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrew Morton" <akpm@linux-foundation.org>, "Mike Rapoport" <rppt@kernel.org>, "Baoquan
 He" <baoquan.he@linux.dev>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Tal Zussman" <tz2294@columbia.edu>, "Dave
 Young" <ruirui.yang@linux.dev>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kexec@lists.infradead.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, linux-mm@kvack.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260915-vmcore-fault-folio-v1-1-a0cb6278670f@columbia.edu>
References: <20260915-vmcore-fault-folio-v1-1-a0cb6278670f@columbia.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 23:53:41 +0000
Message-Id: <20260915235342.507961F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Use a folio for the page cache page the s390 fault handler reads the
> old kernel's memory into. This removes four compound_head() calls and
> one of the last callers of find_or_create_page().
>=20
> The vmcore mapping only has order-0 folios, so the logic is unchanged.
>=20
> Compile tested for s390.
>=20
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-vmcore-fau=
lt-folio-v1-1-a0cb6278670f@columbia.edu?part=3D1

