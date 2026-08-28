Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4115370AEB
	for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2026 23:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787959673; cv=none; b=VfEEvecfeMhNUxYdEnSfMwIVKfOU8bl/bTcOVRQCRi1zM05FAktQAKLc8PefEcPX8ftKG60msQeLpInZvabMnWCH8YTNCrnPWq0Nl9uX6VotZmX3kElbcRBkZAyqjiEQ/g16ywhBLxxMU6TuV1dGxEeeOOrCwxaCb8iYUyB0IOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787959673; c=relaxed/simple;
	bh=iX6gLYxuwNhdtgTLoYvgFmEaJdJUNcFSwqX0yKi/sNw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AMBd7rXJK5ZCn0bK+gKlUIeKwpWqTpcmz3aMmbrJdjQsjWWWy3aiHaeA+9EhWKj8IH3ROzTur6nDckHZrNsAms4mWEuuWClOXIifCBdxtUIYQA3GZrO/5TTvYXUXy89i7TOcToXiNTDYmq8qHmvv20fUBEonfYA7AZyutKOWDaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKMTJ5Hf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKMTJ5Hf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C13C1F000E9;
	Fri, 28 Aug 2026 23:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787959671;
	bh=iX6gLYxuwNhdtgTLoYvgFmEaJdJUNcFSwqX0yKi/sNw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mKMTJ5HflUqL+HZlIokZ1dSm4D3a3lHKwZw3c38XGVSm85J/N3Gee+6NpKizjGKVI
	 pQpljLawNISEpqeb0ZMubj22ZS/07CwAL/zZr7U3V52BJAN367jvZsA28CXjtjDvIP
	 HvF43ynqyOaQ27+Gh7U0lnwQDCQZHeGNwKCUFdn7dQZizySQ0IKmEv4kTh5AJRuG94
	 /O/al0pLI5bG7OY94aYNWaK52krXCL7O4aWm0xcf9CrLpGxkMf14doKel1IOSKajpx
	 GDys1S3uvcXhfMl1v1TDCgJZf2lAbbkyrP4qQMi3XDQjt61SiqoNAAqW6grno98Wh6
	 ktItIyVDEpUHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/13] mips: Remove duplicated syscallnr.sh
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260828-tonyk-syscall_table-v6-7-fdd358456cf1@igalia.com>
References: <20260828-tonyk-syscall_table-v6-0-fdd358456cf1@igalia.com>
 <20260828-tonyk-syscall_table-v6-7-fdd358456cf1@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 23:27:50 +0000
Message-Id: <20260828232751.3C13C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The common scripts/ already have a script for generating the numbers of
> syscalls file. Use it and drop the custom script.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-tonyk-sysc=
all_table-v6-0-fdd358456cf1@igalia.com?part=3D7

