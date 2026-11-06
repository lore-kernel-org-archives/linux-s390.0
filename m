Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997219;
	b=n6gQR95YhRhx0SJcnxhMbJh9A/rDyOYJGkalaaUertlRke6v/IHVigljE4COQ9TG80ly
	 +IXkLfmXcnfn1KOSi8HNZi3PcPUNdtPVL4BB8f5JTu41uF6D+ubB/alihQn0DJXHkrEmJ
	 YjzntoRd4P9bNC2+5fH1eEYsZRTJAoGL02k4Ms62AAp3GYPCvCHqKpMIx8KtCr5FXU3Ss
	 0PQ7k11KxhBxUJWJsA8eVckmWT58fvK1G1a5XU3A5dlFhWm2rAtg0VxSBqrz+1u1JoAc/
	 4Qgt7P483VyDArMPCV/DJDaZ5smbAvDs1xNFxtVNslM4fydHM0ditbUKjzTE6BnFQdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997219;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BR+vwTsB5dgR0tSS00Ix788x7GFjnubLjghgvpEh5ZM=;
	b=XXXEUqQKQUarjAQNZmJZrARIxVXwzvOFPcWp+lf6rxsWLelFVg0bClJJyVJ5Mw1IEWml
	 ViliBlqJt1hi2O3Q7AiPClcaGqYPG5KQWvxUvyZo0FCbCY5PcV3PWA+OYzZPDgrVHiZwW
	 9o9J9ioWLO2Sofqy80X3Z/Mz+kaEQKIIyR5QtOFhViAdyvRt04S+el0ANPn08IzrLw86b
	 MSIU3D11i78e2hpvj/n+0ulF61Xczecn9c/ABfKWhMpMUvm4tXzkZVo3IDu5u50hcBqm6
	 fB0VsdtxnOLD6az74/eJULUEqoqAn9NjzRPXOk4Slt53YGE4RnmXkjCquVCiYtodp1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y64UJPaz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08AD606A32D
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y64UJPaz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B87B1F008A1;
	Fri,  6 Nov 2026 20:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997218;
	bh=BR+vwTsB5dgR0tSS00Ix788x7GFjnubLjghgvpEh5ZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y64UJPazuEAlzSb7jTT3FhOXVM1yXM3YacCl1PvwY5sANS1WMC8+FOUdAq3kXYXwI
	 lhc8nQXqd0fcs3ijkZUlDEMebXHNLtnqzxsYL/xioEFn2CtD0GNiRme0pAQrzxDdAG
	 ozEfc1V0Hx2QA7BEVaKzuJEUdk6pa0GwxWQGhzdR5abe4oh94K7O3MB2yb6Dm4I8K+
	 s47Q9LgoBfw6ShWYQJHlA2yUXipmOYs2rDu7+CsxWJ2uAnebbRhSYlAGfu80dk1wd+
	 9qv6KNgDjGAztMXdyvN9B+mwi9rzEq5mmqAXiPzB3Ee7v4WQ9Fx9xT/L9/A9umnBa2
	 ASXblk/YgaulA==
Message-ID: <sashiko-outbox-202219@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 06/15] mips: Remove duplicated syscallnr.sh
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-6-8d1275885d9c@igalia.com>
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
 <20261105-tonyk-syscall_table-v9-6-8d1275885d9c@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:33:38 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> The common scripts/ already have a script for generating the numbers of
> syscalls file. Use it and drop the custom script.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-tonyk-sysc=
all_table-v9-0-8d1275885d9c@igalia.com?part=3D6

