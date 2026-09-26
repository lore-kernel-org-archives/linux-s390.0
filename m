Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B4B411F90;
	Sat, 26 Sep 2026 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790431629; cv=none; b=NXb1OaZnEnDjESjAs4x3CMdK6womH+T5dAKTPToEaQ7BSFjSGVxcdnpiWi2qDLa+vG4s++JIwMsNE1TlEstOxcsrfIFxHmA31V6ovUR3It+63rNSGNfSineeisthM/qd9YkvgvXWQ4559eMl0wbyqiIyBUtwjuGXyOrNFiNpKCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790431629; c=relaxed/simple;
	bh=Ub/OLy5tl/44WQLsEe8jKiMFd6lNEFGsWbxg0mqickQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fxpIGdXP8upxMQSLqXvlsTXNkwdhUeeR8PIhp3fxTeBQFhYqsX7LtuFlYsVNegsyoqHOALYYkIGsVWU0C0mvptgSbvobUWJfKs3b5hqO8Ap5jeTRqe+HrNle2S2n8mg1mU6TqfsUcJOT3sBhcVRcu6QrEthtEhxSivIxaNWoUZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z875iNn5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z875iNn5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2069B1F000FF;
	Sat, 26 Sep 2026 14:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790431627;
	bh=uUiHAdJd1rvA25cmx7JRPV692fT6D9tYYA3sif2HeBs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z875iNn55dpNqIIa9kHxoSuikgzh0k3uZ6EZpZwExOWnvLLpzqnoPya/7nSaO+x5O
	 cQNPqnk81C63ukb8KOHFD6eVT2u+Z5uGAf1am485c0P0odeioKoB0F5i94fZkqBYai
	 11quxZ2ejwN9HkCHgdLWzkx+ibEOwlKwZBN+b3HvAtzUJQyIyrcDhmRHuw6djj+9xb
	 CPVU2kIXaibF8HmwaC/unq74kB9GqLGfGwfLXrmX6o5LqcTLLGIYZRoTQmt9umcw1h
	 MH5eO46NftDYUoPZ2MuRXjgwB27Tg++1I2fjL4xTkddiGMZiEvgz5kM2OHwojfDXET
	 9Bh/kAwOwF94Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v5 1/3] bpf: Wait for an RCU tasks grace period
 before freeing trampoline progs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RmxvcmVudCBSZXZlc3QgKEFudGhyb3BpYyk=?= <florent.revest@linux.dev>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, bpf@vger.kernel.org
In-Reply-To: <20260926135605.1217928-2-florent.revest@linux.dev>
References: <20260926135605.1217928-1-florent.revest@linux.dev>
 <20260926135605.1217928-2-florent.revest@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 14:07:06 +0000
Message-Id: <20260926140707.2069B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When a prog is detached from a trampoline, it is freed after an RCU
> grace period, or an RCU tasks trace one if it is sleepable. This covers
> the tasks that are running the prog, since the prog's enter helper takes
> the matching read lock before the prog is called. On a preemptible
> kernel, it doesn't cover a task that was preempted in the trampoline
> just before the enter helper. That task holds no lock yet, and it calls
> the prog after it was freed:
>=20
>   BUG: KASAN: vmalloc-out-of-bounds in __bpf_prog_enter_recur+0x3a5/0x3f0
>   Read of size 8 at addr ffffc90000055040 by task candidate/110
>   CPU: 1 UID: 0 PID: 110 Comm: candidate Not tainted 7.3.0-rc2-00014-g150=
71f2a1263-dirty #2 PREEMPT(full)
>   Call Trace:
>    <TASK>
>    __bpf_prog_enter_recur+0x3a5/0x3f0
>    bpf_trampoline_6442509193+0x37/0xf1
> [ ... ]
> Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
> Reported-by: Junseo Lim <zirajs7@gmail.com>
> Closes: https://lore.kernel.org/bpf/aqdrwVpanH3WGurX@omen-arch/
> Assisted-by: Claude:unspecified
> Signed-off-by: Florent Revest (Anthropic) <florent.revest@linux.dev>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926135605.1217=
928-1-florent.revest@linux.dev?part=3D1

