Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F6A43CE76;
	Fri, 24 Jul 2026 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903425; cv=none; b=uZ5X0KnmAQc8u2S+E1B+vwG+9vhcGmCWzfK/zuMHIiSyU0mXJejkk9gYUKqYRpO4DVSfzoPoKJhIjqf/CgxlUY3LAzpaxhdTmNZq2Y+wKmj7RlhfXAQAnHS63NizVI1sjKM0YY180xPRFZ3AU6t9o5dqhLwjsgbHdfbk09pyrQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903425; c=relaxed/simple;
	bh=G8J+jQlmqm0rCVNXLbPAR+dZonuOlRQVgps/Whqsy4c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IzUGG8c3EIu8rzYOZx3Vz3pJYhNpWDR7GoBjO0W6Cu0ieIChLgMxd5k+64janfQvBLqK1bsdfR+PYUQSqIbjv0F0NpUZ3j/nkWaQZFtEMHXuUdw9HtQVC3HmPB1KR10a7ZF5J+mIMVFErn7gr//ei7r+BIvF0GH0vtVoWNqQn9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X21LWDmM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X21LWDmM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF271F000E9;
	Fri, 24 Jul 2026 14:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784903424;
	bh=G8J+jQlmqm0rCVNXLbPAR+dZonuOlRQVgps/Whqsy4c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X21LWDmMjMhmgb6YPyB7ciy1CBKcdQddHmWUETYrb+F2g8MZjU3STEJNK3Xia0ruV
	 0/BG8U8y5A8L1mDzDf5i8ZHgq7NfxEYegqBzIWPVT4KMDMQC1imlv2B0DkMd0goJMG
	 vkyjxL8QmqW8zL2VXYiP6UjkSol0gXgE9QsmYBo0DIwGXNz3ajBoSieGYDmtCg1zfr
	 4R551Y+Xn0GkPOGHeizJ3iHn4TcWG25fiu11qEH5kqaFZmg2FY4dfMH9r/NqQL7S92
	 xJYQmXtGsao60Wa/Wjk+QkFcbCWjLaASJmniLJ390UHP2sod4chYrku0fkxzs14VFn
	 DFM24UMeE9YNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] s390/tools/relocs: Ignore __kcfi_typeid_
 relocations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260724141318.1037434-3-hca@linux.ibm.com>
References: <20260724141318.1037434-1-hca@linux.ibm.com>
 <20260724141318.1037434-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 14:30:23 +0000
Message-Id: <20260724143023.CFF271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> This is the s390 variant of commit ca7e10bff196 ("x86/tools/relocs: Ignore
> __kcfi_typeid_ relocations"):
>=20
> "The compiler generates __kcfi_typeid_ symbols for annotating assembly
> functions with type information. These are constants that can be referenc=
ed
> in assembly code and are resolved by the linker. Ignore them in relocs."
>=20
> Reviewed-by: Jens Remus <jremus@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724141318.1037=
434-1-hca@linux.ibm.com?part=3D2

