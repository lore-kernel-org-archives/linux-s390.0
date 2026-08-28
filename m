Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1687512D1F1
	for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2026 23:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787959931; cv=none; b=Aa5EgIDbuUeu0FJ7/v6YqmK4BinftO8xon2v+7Ew++258qfUGwjvgafQiL0ZeH8ZGcvJtn7F2dK9BygfHP4cofkGsxRKsv5mpk+j1TU2oQ2wzDdAUfFfi/3EJpdak9JBfdJpmC91MeU3wzZpYmRiRgWZdElKkEDj6sMBKjAwc9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787959931; c=relaxed/simple;
	bh=n9078icArrMMU0OhuDdNunvgQSTVEazgznzpxhqMWKA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qWdv+bFeyYC3j0wwKumAD97tbU+hgplhJxkOcEIQYDGBMz0YvkrpRM5QiND+L7Fa3pfsem/bg/r8o9+BoKdZu83tAFhQNlUUklhuIuVxXbbuXZqJfiwS950VUl4xnzP6y2WdL8yvRz9RF4xf6GIE9m+Gkkjv3Qvfatb6Uu2VMMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6ogTNO0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6ogTNO0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6739E1F00AC4;
	Fri, 28 Aug 2026 23:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787959929;
	bh=n9078icArrMMU0OhuDdNunvgQSTVEazgznzpxhqMWKA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R6ogTNO090Tq7xfIb5RK26hhTXvWGTWL9hRhqWNrnkdheEaUrcfkXmUMHMvOL0Q2h
	 Hmia9SHIrUtxD9YtOwuPqPpKTa4cqb0HoaVJSr+dBxJCoSNKwpijpQ7w4ImzXer9Nu
	 NyxMv917mvjUC4Aca5IGwm9v5cC00D4dJuS5tfpdY887F8aQfw27kpHtc7z7iNcM5h
	 X2N44TvVE0e1yGIPp09XVH77KDS2dTGMme1uZZr0ptJKC3vvUUd4f73W95cYdO7zJV
	 Hs5Bozfd8AItDGpwOIxVKfsBdEwbAKaa/LB3gvur8WO4J+x2QsAnejQLD1OClX+0XW
	 oo1dIbx884Zyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/13] alpha: Define entry point for
 set_mempolicy_home_node syscall
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260828-tonyk-syscall_table-v6-11-fdd358456cf1@igalia.com>
References: <20260828-tonyk-syscall_table-v6-0-fdd358456cf1@igalia.com>
 <20260828-tonyk-syscall_table-v6-11-fdd358456cf1@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 23:32:08 +0000
Message-Id: <20260828233209.6739E1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Instead of explicitly defining set_mempolicy_home_node as sys_ni_sycall in
> the syscall table, define it as the real syscall entry point,
> sys_set_mempolicy_home_node. As per commit fdb7d9b7acd0 ("alpha: remove
> DISCONTIGMEM and NUMA"), alpha doesn't have NUMA support, so none of the
> mempolicy sycalls will ever be compiled for alpha, resulting in the
> COND_SYSCALL() fallback being used to result in the sys_ni_syscall.
>=20
> There's no function change here, but this step helps to unify the syscall
> tables and create a common table to rule them all.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-tonyk-sysc=
all_table-v6-0-fdd358456cf1@igalia.com?part=3D11

