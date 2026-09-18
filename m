Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365C050128E;
	Fri, 18 Sep 2026 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744962; cv=none; b=TAq2X9CPk4NvKWKJPDjVlFqDUcTl5lYm8JPIFNKuFv/H0jzyKLxd2YvUa32hJTrr8tWUO24b2MqXA8tAOBcaWD3CK/YW4RIUINAHNMKc3tpsnxLaLyXh0Rn7uVPGcrEBS3PURMMnWOeVyPVmCS3OT8Lht0AHP4m376SLa6g5Jno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744962; c=relaxed/simple;
	bh=Un9g0Tvih51tzFRcfZVHGmtikHk1rk3H2nxZ5EihBxg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZHNZ50xB/6H+5ILjTsR4JOk8HcccuKqBXXnXcF4mPqTOMiMw8MiWlPWfPMHHih0/rcTSMIxGrRWGqtb5zTrX+LAbno75fKfBHjPFFTuxrsyxNqIiUZgFVt62wB6+A0M0xewUtcAnDQmAKuNvZOtPWBUrdABJCEdiHzHu1p4ImD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etzBamL8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etzBamL8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D00E1F000FF;
	Fri, 18 Sep 2026 15:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744960;
	bh=Un9g0Tvih51tzFRcfZVHGmtikHk1rk3H2nxZ5EihBxg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=etzBamL8P5YSeM29xwcAfbpfBnby5Cqm3V/UvgbmdRsHm4/8/zs373s97J8JBCSok
	 SzLFdIti/3gjZccKvzgozGGMFz7r7m76T9JXRpUd9SKJvkRhUIn3UITtuX/E+5Rgrj
	 Kivdsl23mGkiyOEwfDXjMUioC9w6oqy/rPmprfPU253GmaCH6vvq96GEDTB/OSNjV3
	 1UYhlX9vRmVEehTlm0QhQhNlhU3Ij9ewLsy0XUqcDYMdrIzWJBv9yXPgEhWYGzK+YL
	 3Vi2mayl0P0rFyA7kNeTZtKKiRp9JarAu0xA5w6NTxwV+zqvAWrqcoqr9UnNmxtOKV
	 d6Fh+rvwDfPSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/21] KVM: s390: vsie: Refactor
 kvm_s390_vsie_destroy and extract reusable methods
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260918-vsie-sigpi-v7-10-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
 <20260918-vsie-sigpi-v7-10-f39806eaae37@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:22:39 +0000
Message-Id: <20260918152240.4D00E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Create a helper method release_gmap_shadow_safe() to simplify releasing
> the gmap shadow of a vsie_page and a method kvm_s390_vsie_destroy_page()
> reduce nesting.
> Both methods will be called from multiple places in upcoming patches.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-vsie-sigpi=
-v7-0-f39806eaae37@linux.ibm.com?part=3D10

