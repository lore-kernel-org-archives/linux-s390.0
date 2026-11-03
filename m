Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793737630;
	b=AS85dqhBsvZ93wbskSXY0apYwqmpZDL4QejM6GW4Y3Mkr+9hVb+muuvJOiCD8LcyN/P1
	 SQLW6wWCska9CFUa3G1x9bXXWj7Hf7J4t38apHGp7uRmBaGhfQ6fbnFjoRIjM0ultcMV2
	 yS1I/pCTaNUV+jhm07towojs19qDUjJEvaggmpp+f/K6/yQTaj9SbVNmmGkDhNu5fAjhR
	 xqzPoKgrg2oZ7iwSxazjOn11m9wBMoXQokJsMWI7wDUJuI85dGn4VCQbzlF/lPi5tY3Db
	 M6JGZYdFRe9maz0Ltfw8ZtqXtAaFYZel0iI1NS9zI07xsUb4fhyYgy8M2vSJJQ+svzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737630;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=Cs/42Kl/t30L3HxFjgoCIiYXaRNlNAdJ3TsWsjzk5PE=;
	b=GCFsT7o94XKojuTwbfbBsjKZEJekJrKE0Nh8d2YLZ2F2VnTGSg1svBgqMyEsL6ZJsvnn
	 PBTnCwE6dlSHW+o2f4ozcdS6myNyzEAfUkrZ8h4TR+9CX9O8D4Q2TCdXLDltvGy0He25O
	 UUynK/rk3YxXhkUgIbZ9kR7qaHhJhHAPMD6/iDEMrUR7r+uMiGtmyb1hn9n6slkdp+DKT
	 RJPolGpzhfL4WbRz0k7fvJoqjP95Q2gxVm03yByafpthHtWHne02+XM41bYvJ8WGyUv5G
	 O99QbtoEr3VzK8dnPk4a3c7oGT/B7N1yMZAO/WSM7qwR3dYL47oAMn8AJIAuPHgDATw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IwitLGcF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C5C606A31B;
	Tue,  3 Nov 2026 20:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IwitLGcF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752131F00919;
	Tue,  3 Nov 2026 20:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793737630;
	bh=Cs/42Kl/t30L3HxFjgoCIiYXaRNlNAdJ3TsWsjzk5PE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=IwitLGcFtpFhnU0BryNLtD7K3IlR1Z24CzjxC+AKlTcsty5Gjf3KiIU9UKbA6/Pzx
	 CjZDON9KS9Ad6OHQoo9cTNCtmGuBQ3D4P9ieNXkQNHIBG94WLR0yK9aovGeUQjjzpY
	 0hUFiw6xZlNh/ijwoI8VIUnRC9J1zkMOlpu6sjwrJ1j4xe3XMSJr+muqk8B6GMzgyr
	 n03uzcMIEQpPEZwoEDaBML7ooncJm5F3shT5LypJZgDE9dc5iIbbpT3RR5gEmVdv/l
	 CZVnYL1jg1qexQJESfNx2L5vIR/ALEvoKcxw+M186CjvRnafQMRIwvwQ4zu8eEMlXt
	 Ho/Mj9BuFxGIA==
From: Thomas Gleixner <tglx@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, Heiko Carstens
 <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian
 Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH V2] x86/entry: Fix ptrace regression
In-Reply-To: <sashiko-outbox-192559@kernel.org>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.493733289@kernel.org>
 <20261022142425.3Wx-RrU5@linutronix.de> <87fqxx1r80.ffs@fw13>
 <87cxt11ktr.ffs@fw13> <1149A39E-BEBA-46EA-94F4-4DFFC4733EF5@zytor.com>
 <871p9g1s3w.ffs@fw13> <87y0boze95.ffs@fw13>
 <C6D7BF04-4CF7-48D1-93B5-E80D52C2617D@zytor.com> <87se1wyvs8.ffs@fw13>
 <87mrrvxaty.ffs@fw13> <87ecd4xwlr.ffs@fw13>
 <sashiko-outbox-192559@kernel.org>
Date: Tue, 03 Nov 2026 21:27:07 +0100
Message-ID: <875wydy82s.ffs@fw13>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Nov 01 2026 at 18:07, sashiko-bot@kernel.org wrote:
> [Severity: High]
> Does the inner if (nr != -1UL) statement in do_syscall_32_irqs_on() have an
> unmatched opening brace that leaves the function unclosed and breaks the
> build when CONFIG_X86_32 or CONFIG_IA32_EMULATION is enabled?

Duh. Yes.
