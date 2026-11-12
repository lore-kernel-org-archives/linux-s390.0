Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483056;
	b=s1H9mVEvYhVIVUxPHxsf0LhF1OzKVX+OaQBnGzbw6J0bLPIfiRtvpNFbUUUY85RDVZMj
	 f1XOnzVlBTMtT4uXXcR1jmCqfWLqFK68rzlom3kQB7r5SmD9qfRlWAnxguug0suyL/nYb
	 tWzZyX+MGPkX3rfbMGhXjN4KGT7Q5+1yE6YK9+wHvez2UO7aATS5bK0/9R0VmwcZurfeA
	 ssAGV1ySerzeFpDZRuVaK1AB3+CDLTKqwozhARp6FwuPoH5F5XmI6Vnpa9KSHUNh8nHpT
	 vj4s+9U5mljZaN3zlEBN5DIZ5V7AhqWjXAYMyLMZYge0E6NORWj9RXTZOy7hpq7ySkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483056;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Oy75uPWa0jCFUOquVgVgwNWJp0hYJYnupyTZJ8t3hMc=;
	b=koP2Ls7Tvv+SWtDPxILPw8c4QYJm+3W72bSPE2kPzN3P+0A4bCpniSGzQDa89ik97zUK
	 3oo37HhnEH0+QT+33mGCDcY9RgC2TIX6TFmKatCNtKn/xaCKwGb9sHDQgdC78NSk4XiqI
	 ml3CZzIFOz65S3eACH1KanyDayzhX7RKmP7WbmYQEcQN4dRZyEI4ghrvwWJxiXgLEIkvE
	 td5bcaoRq6h8Gvs4vSLMfrjma8e02WuH0hMjbYwF9eQnaT8HdAa0pm52JUAHBhrtIUwO+
	 3dC8caqrSFRxYMiS5ddo9n4+XpE0dHSAQLU4PVJgzIJlv1UnO4/nZSNqPm9VxGeINXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cGkxg11U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6F3606A886
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 11:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cGkxg11U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A311F00A08;
	Thu, 12 Nov 2026 11:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794483055;
	bh=Oy75uPWa0jCFUOquVgVgwNWJp0hYJYnupyTZJ8t3hMc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cGkxg11UfkX84uQlzbchqtsWcMgBYLBziAdRu4TJyBY+M/qnebZ3xGmgHMNZ+eAU1
	 nZza4HqP9ZQ8FYmg7AFoPoXU/ohrA03yGnZGkWxWwiIa1bH/otY3pGmDBWx+RrmMr0
	 IPxeB+sMFtHlTknFamgmyVvlWJYSYr7Kx9czWbMun4DeuZrRhC7Zk8FwPtpoYJ+DVZ
	 5NtMZPhinKxLDiqdklpDbe0LGWSN5D/+RIvQKCH+nV1LAWGngwvI3g3f67Pgp1kbiB
	 GbuCMFg3a6if1An1YpgtELUaN2aSboVOER5ZZsjW8C2rRQwudJrKC4OH7rXlNGSmol
	 RAWfClZvWExOw==
Message-ID: <sashiko-outbox-211020@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/8] s390/kdump: Enable crashkernel CMA
 infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Zaslonko" <zaslonko@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Ilya Leoshkevich" <iii@linux.ibm.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Baoquan
 He" <baoquan.he@linux.dev>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Dave
 Young" <ruirui.yang@linux.dev>, "Jiri Bohac" <jbohac@suse.cz>, "Jonathan
 Corbet" <corbet@lwn.net>, "Usama Arif" <usama.arif@linux.dev>, linux-s390@vger.kernel.org, kexec@lists.infradead.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112112105.1169118-2-zaslonko@linux.ibm.com>
References: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
 <20261112112105.1169118-2-zaslonko@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 11:30:54 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Select ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION to build the generic
> crashkernel CMA code: reserve_crashkernel_cma() and crashk_cma_ranges[].
>=20
> s390 keeps its own reserve_crashkernel(), the CRASH_* definitions in the
> new asm/crash_reserve.h are only there to satisfy the generic header.
> arch_add_crash_res_to_iomem() returns false because setup_resources()
> already inserts the crashkernel resource.
>=20
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112112105.1169=
118-1-zaslonko@linux.ibm.com?part=3D1

