Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40D72E762C
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 23:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689436; cv=none; b=N+JcusPTx/6GxpIsaOjrpseGLMW5Shr2AW9JwISXd6LJOYj+b+o5sAWxg/+B9DcpCV6m4zfjSmfHMY7N1vU6c4CFseA2SlneJnmY31eTGHJB3xNq5am67qUrcz1g7PTh3ob/D/V24tPFdGgRmG4mLBxDX1wo+rSj1OOZMseLp6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689436; c=relaxed/simple;
	bh=kqgu0XjJwqUBKbnA/mYGoBG+suACv48kdkDGzm9pzMw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DtFL8ZtMJxZv/+XAkYo6UC0+VFd/ayw0UUHdsaD+OcjU2ev1VBtbOOkuQSPkKcK/+GJb1GVhOI4Edqtw2S4Zvq4WbTuYrGbxKTCf70epJJH9xP9e8cy/GotU31dDLWWNhBbaxQ83b/ATmLlwU/zZaPV1I5UmJJuKDiOy8jEzFwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoWu0/MI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoWu0/MI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083CE1F00893;
	Thu, 17 Sep 2026 23:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789689435;
	bh=kqgu0XjJwqUBKbnA/mYGoBG+suACv48kdkDGzm9pzMw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SoWu0/MIqHsBnNrfIRvcWNeFH2g5mDZ9st3F4q8/0gCgns8q0/G3fneDV1ULhAbZY
	 66/JGPA35BuC5sF1M/Pn9+cu2dRJNXWlsfDXTcWUnA6/QFEfR0Y+wMrv2RK4ya3TbZ
	 g9IiBYoEC/LLcwz3S+vanBM1/vUW/+Z5PAWjKS1QSxTc/puBzE8REmrqW/V6tD3wfF
	 MZwbRPHT+dG1+yC+cYroPqw7toGt0xaakEHWKzLkzwkHp4rZkc21wA32UpAC5Gu1/6
	 /0/1D0rRMZ8UP3FUphaEcZ7DsboOpzmaIvixtdViLR3jvikomewzU4c0GBqOK50ory
	 YT7c/h5I8wQkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/13] syscalls: Add an option for offsetting the
 common table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260917-tonyk-syscall_table-v7-10-f4cd8f8e3265@igalia.com>
References: <20260917-tonyk-syscall_table-v7-0-f4cd8f8e3265@igalia.com>
 <20260917-tonyk-syscall_table-v7-10-f4cd8f8e3265@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 23:57:14 +0000
Message-Id: <20260917235715.083CE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> To better support architectures that doesn't share the same syscall
> numbers, but have them in the same sequence, add an new option to offset
> the common syscall table numbers by a value. This make it possible to reu=
se
> the common syscall table for alpha.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-tonyk-sysc=
all_table-v7-0-f4cd8f8e3265@igalia.com?part=3D10

