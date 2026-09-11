Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D11421253
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 07:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789110611; cv=none; b=BjdjPJK0HvvvtrfinfZ+eGxdb6cVhbGGDJv2CXTZHSE4q5VJEVb7SJ8XDLbqgOijj6zQNrW5ntJ8uIepXtR+CvBEjRSZXVCcu9t6NtQMefjSTqzU6sxn97SXaWWFX4SWqBMZqNNopXOHyO1s7fsdkoAYUt7DeU68yEuWWC28JGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789110611; c=relaxed/simple;
	bh=yvLFnqS0HpZ0rMFW4Kd+dXqPuu/Dkn7yhda63YMPqEc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UOaDPL57bUuWv7Um4YJQS5xD0VQRj9fWUscb3ZhyXBpfV3nU5CHe2bgdLkeYcyX4EX75uDiAf0zQgHURGSL1SZzG313rn9PIB8yqCqfunnCh4/bjBzWP6Y6wUz+gRApXYf5FwUXs8wWTtfFCJTbMux7BVKkdx9ZcWlfCfLULTGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDWFRb2r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDWFRb2r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3321F000FF;
	Fri, 11 Sep 2026 07:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789110600;
	bh=yvLFnqS0HpZ0rMFW4Kd+dXqPuu/Dkn7yhda63YMPqEc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MDWFRb2ras2Mj2qqcDOrJd6QafCRhHl6Ee2XZy/NnGO+n2Spltl/v2arq7oT5F9L6
	 Lx73C6N+KdcRzw70P0MBG1Wi1mqPQKO795eYR0XF4kvdFTC8jVfoFLUzQFb1Q8YZ8o
	 Szo9MeWgkEBCIC6HxNy9GjqhfOu0BSf4seZ4ZWDP64pWWZGqojOjJRBYgjgt9kn50p
	 Qn5PG6Otrju3QwH3ptfEaObmbl8ZxsUx2YcgGKcXgUMFLRPOVJbR9z/7v1edzG4+TO
	 qXAJlMIaNDVEPbWaZbvSb7GAHR3MwA9GztPyk8AkwabjjeK81OTIxj/U0/3nj49k6a
	 sArZBclN9noxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] s390/word-at-a-time: Instrument
 load_unaligned_zeropad()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bill Wendling" <morbo@google.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260911070346.801948-7-morbo@google.com>
References: <20260911070346.801948-1-morbo@google.com>
 <20260911070346.801948-7-morbo@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 07:09:59 +0000
Message-Id: <20260911071000.6C3321F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert s390 to the arch_load_unaligned_zeropad() /
> load_unaligned_zeropad() split introduced for x86 earlier in this
> series, so KASAN/KCSAN also see reads through load_unaligned_zeropad()
> on this architecture.
>=20
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Bill Wendling <morbo@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911070346.8019=
48-1-morbo@google.com?part=3D6

