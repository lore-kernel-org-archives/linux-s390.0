Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CB336403B
	for <linux-s390@vger.kernel.org>; Sat, 19 Sep 2026 00:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779280; cv=none; b=lGqUL1KWuOXGYHSXBYYBdNHGQTixcPbZ+ovYY/N9fdHV+1+QLEKfWg35k1G9I3QiMI7k4vACo3w0XKnqUUZ/2tJJxiQ0S4pVdQhIq/vp5gdOq9luxGwW2+qqR2Eis0s1JUVAsu/p/X8PE0eSRtP8PcPKkirdzsC2FnZSXirN2js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779280; c=relaxed/simple;
	bh=CYcRcvXUtld4xflVnHNRlCQCY+1+ortmL6emeTjDjIU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SF2t4At5xPKkHyHsPr/xQ8YbUcH0KcybD2r+CRTej8uE49/+PBBVQglS6U0Msqpu1PoZ0q/QvLZRnylj2AC3UZtHywFUW9URkTUiCEiYLyUZR3kfIVDuXrd/+fnIGsTV7iagLnSVaNcIHedAO2PYRs3X5f4S+XlV6uQKkdjSQ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFmrkE6v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFmrkE6v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE1E1F00898;
	Sat, 19 Sep 2026 00:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789779276;
	bh=c5dudqEPisQr8lAC+lGoHDDRfix3HoQChQmS6/egCP8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EFmrkE6v98wk9lj1lhiHBcpegPNVCLmSy6gLrcHch52aoZeJcrd488cYO6yz0VWtY
	 jIFLeYaky56urcz8W8DAx8TOa3ZWBeP2F64Btvxdj6wfCnd3NCfuThVlK2TFNaFNzq
	 s8hTsApgSsDMyimg7CkF02zXPylHzIzSbFl9z7zAZksSJ2PLAk4/2nOztrQ3SwwGG1
	 VJWMMVWuWSbB+5+hN3Hl45M3WrIZbkb1olMHQZxrjhRb8d0yR2pTPfFSY2m+6DhV68
	 SHF11Q+YTBwZU0l7rV/ecLcPqQyLCRqsm4A8iOLz8WmPot7YgsQo21yj/EQKkVeula
	 Db2l3+Nb0tzrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/12] mips: Use the common syscall table
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260918-tonyk-syscall_table-v8-8-0e2d60cad13e@igalia.com>
References: <20260918-tonyk-syscall_table-v8-0-0e2d60cad13e@igalia.com>
 <20260918-tonyk-syscall_table-v8-8-0e2d60cad13e@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 00:54:35 +0000
Message-Id: <20260919005436.2EE1E1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Syscall numbers from 403 are shared with all architectures, so move the
> toolchain to use the common syscall table and remove duplicated code.
>=20
> The generated files are not exactly the same as before, but they have no
> functional changes:
>=20
>  - For O32 ABI, the syscall table would have entries like
>  __SYSCALL_WITH_COMPAT(403, sys_clock_gettime, sys_clock_gettime)
>  which is equivalent to the new entry __SYSCALL(403, sys_clock_gettime)
>=20
>  - For N32 ABI, the syscall table would have entries like
>  __SYSCALL(413, compat_sys_pselect6_time64), which is equivalent to
>  __SYSCALL_WITH_COMPAT(413, sys_pselect6, compat_sys_pselect6_time64)
>  given the new __SYSCALL_WITH_COMPAT() definition for N32.
>=20
>  - The above applies for N64 ABI as well.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-tonyk-sysc=
all_table-v8-0-0e2d60cad13e@igalia.com?part=3D8

