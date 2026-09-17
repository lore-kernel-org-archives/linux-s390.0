Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B5C49EC6E
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 23:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689553; cv=none; b=O6Fnv81eCzdkyDU1j4Lm3ca69Squl3uBj6CkF2ajTKG1nDw2Xw/4QnePPRSi3cDWZgH4NqzCS892kgzgEiVhk3QbYjEhhzOathJEjhz6B4oyes2s7HPPuv0Wo7R0I3jCyqBOWhlKVkMdhiBUbpor2rhwmzAF/+rImDbfqI7n8X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689553; c=relaxed/simple;
	bh=DAQQduOFHMDMAaDx9qaQzhURWOaxo2qJLcttaKAlyvI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nx5ycS8nacddfyntsTb+kTMd8gaMaDiFikvO9YovprCivO91eGjjW5NKlj+3wkVivZQJIU1QTfYrfMbQkEU/v0tK5F9/gw9B7k/S5i32rNHwYsorOOPi14DU3EsnCo8iSJ5Migj4s0rqE73kXZ8pPaADHQEjmFqCTmpsjJhl8vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zdpj4/ut; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zdpj4/ut"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B921F000FF;
	Thu, 17 Sep 2026 23:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789689551;
	bh=DAQQduOFHMDMAaDx9qaQzhURWOaxo2qJLcttaKAlyvI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zdpj4/utlo7cJcIvkIWGPrrEMqMhZMonvH8s6SEGF8sxWFQxbItYPpykb2X7JK1iX
	 yb/GIU6aruTt31jgCnG4cHk1FvuLtFRTOj5NUeAfGWtynRWjYmtNtTgG/RQZ6CMb1J
	 0bll2YXn3vm1otvcLzR1bZ4v6nPJy2G5/23x1tN4AgnAcRDpoisnhZQJA4INucNV+c
	 XdPsprNfZudTnBNmeG5OWytsIt+rZ+RC2ErJsEQXZYYhskEU7ONBW0xfVC/P06dpVL
	 PxyPcl5vzGfM9wlECz51o5pV9UA0Iwbd+bcObaPd7GpF0GH32Juxl2msMD65BF/jG0
	 ktB4HaB0XbYOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/13] alpha: Remove alpha_ prefix from custom
 syscall entries
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260917-tonyk-syscall_table-v7-12-f4cd8f8e3265@igalia.com>
References: <20260917-tonyk-syscall_table-v7-0-f4cd8f8e3265@igalia.com>
 <20260917-tonyk-syscall_table-v7-12-f4cd8f8e3265@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 23:59:10 +0000
Message-Id: <20260917235911.57B921F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Some architectures need special entry points for some syscalls (like
> clone3). The current approach is, instead of having a special name like
> arch_syscall, to name if as __syscall. This is enough to different the
> common entry point to the architecture specific entry point.
>=20
> Change alpha special syscall entries to do the same. This makes easier to
> join the syscall tables. Leave alpha_syscall_zero because this syscall on=
ly
> exists in alpha anyway.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-tonyk-sysc=
all_table-v7-0-f4cd8f8e3265@igalia.com?part=3D12

