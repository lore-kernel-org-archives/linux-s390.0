Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC90942BEB9
	for <linux-s390@vger.kernel.org>; Tue, 28 Jul 2026 15:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253474; cv=none; b=tOBxWzG2I/1xKLCq2KVFBWfnBP1EqGSTzKCKcMIDbfcUrB1DCkQE6uejfbs3zVYxKTD5fabVozeZo78Cs4tBOkk1AR8q8YPw7kykRyh6MUyBZxH/btnNWERhiRrEYl17FzvUToPA8lgA49YuwpQWkilUEEADwzvJM5TBzm2P8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253474; c=relaxed/simple;
	bh=PdHuwz8IHoInd645VHGLJvSMP37Lve7oYJ2TGjgljw4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XrOpT45HPaKh9qboXCI46ClNY4S2Nh9vzydloJ1wxATKh/TRjuvDs6kU5p1TZJ6hLZ5LCkSsUYbwjvvipQo4VS05boc5klBvmU/9lEkfnSWcHPy5/nXyU80v9F47M/19C+HWl5fHzN1GDb13cT2Nb61t6pII7kKx0f9q3b4/NJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMUjT9B+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMUjT9B+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D3A1F000E9;
	Tue, 28 Jul 2026 15:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785253472;
	bh=PdHuwz8IHoInd645VHGLJvSMP37Lve7oYJ2TGjgljw4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JMUjT9B+1wp+dMewn9aCCidE2hgkKIbLvX/MdzPij5vxjS2MZAhq/8lJyCYRq93qn
	 54Y+rF49hBbWta7BJcvmhCI2Hc59xl3XaZWoFvOTKRs9eRo8tAe3hs6rIvlTgWee/4
	 O/XhhASd9pKt9dSWU4ufMmHXkdUJcIfGyUFgQSzyzTrdv6RZjTU8xvJC7dOBe3r/so
	 PSiQurEzC0DBk9Tuirz+tq8qCIgZUHOXUMkOKUc3Q7N2HQJ+ed8OJApfUSvXeXxJN1
	 y8VuxeMBxo1N9/EL8KYJjUDbQ2CQmdhq3LfNjUcibsJlk1mbYl6pa0q2aBKbab0oXE
	 6z9jnXydpWe5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] s390: Remove cond_resched() calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260728150412.3893933-4-hca@linux.ibm.com>
References: <20260728150412.3893933-1-hca@linux.ibm.com>
 <20260728150412.3893933-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 15:44:31 +0000
Message-Id: <20260728154432.40D3A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Since [1] cond_resched() is a no-op on s390. Remove all calls.
>=20
> [1] commit 7dadeaa6e851 ("sched: Further restrict the preemption modes")
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728150412.3893=
933-1-hca@linux.ibm.com?part=3D3

