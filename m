Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513767;
	b=OCLmGjqAMZhXNZBmVPez8NHxXXmpQ9KPOs7I7KV5q1sQJGTgn6YoahlFhjB/DR/DQE7i
	 XZYVdi09jRnzyLOMZZe2oyt1naHuLQyXYp03/fnl22FUhBc2ab7bO5w3X80sYv6ncsrqa
	 fGVnfGLl9cdY+NZcpndf/q1j120B/DQrN+7+mPdWpE9ngYgC+uYSIhvZAac55uMhIqxGO
	 3BL9u7TsnT2puetkRdmxBCicvNhUm508Udsdc61iWxrzOVqgLZ0oCCpBmSPgBLheidj02
	 BHb8qCk9uV+8OII/SfUq4k1vWXZfAuHXGk1/ngKG3d5OTqoDYm2YhxqgfzlIv2q+EUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513767;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Bx1n1bnz3xR8HY77WOusYdkfPbHF74mOinLzTE0dkzs=;
	b=XzqcvyJp3YhDTBd0jULwOJPyrOps7dEJx1AhZjBHNFthNOXAbWSbLdASd1J/6ra6OsDY
	 +2FEog/uupJ5Sh4KBHV5f/oTt9VjGHrUQg/uKs8nZiJEoOqE8zVrBBizQMazhKCAOd5Ci
	 jK9iL0L/OZkoJJUZO/ZY6NGOK1MWhtWyU8FCFLFBxV3ZAsQWo/cV8Ajh+QsVZFWToHUvK
	 1XkG7K420xKoiiZUXYbVJfwPyaI9R3BYZ8ztPsfPfVeFN6QvpkKv3IejtcAHqgAf9mWBP
	 hMqD5gL/RD5OhTlP8KzBJ5tyOISuG2qQgFM5liolxo0SCySrYPpZ9ywsDdDUmAGTyOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N1aUKZzl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B385606CC11
	for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2026 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N1aUKZzl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5411F01824;
	Tue, 24 Nov 2026 09:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795513766;
	bh=Bx1n1bnz3xR8HY77WOusYdkfPbHF74mOinLzTE0dkzs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N1aUKZzlytSMUoYv93xsUvnU8n7WwOg0QXtdiA+BlrDo2ipWp6f4t61aPaXZTCr2x
	 W/Rg97hyNsO97WTtErZzF/UMt/1Sgc/puWr65myH4MPiRY9wtkgbQEBjnpwUFvYuk4
	 TUsPEqZsG36r6GNglt2xyAjNw+BcwBVTSrYNZUTQM6cs3iqaoCrKcWhgkEkQqesaV9
	 eu2kMiRuLSiYfdz11pGS84orcoW+aV6fccqEZIbKgpVUyEqK/P/XO5Qu0SlWKz+lIg
	 mseV7KMBugh+HCMr/1XJsSlID8TGTRVsSIhKqHryg6IU2dSky9wRmQJvh5TSMtnW0r
	 bShC6AhlGLZ6A==
Message-ID: <sashiko-outbox-230883@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 00/15] exec: Remove AT_VECTOR_SIZE_ARCH from UAPI
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261123-at-vector-size-arch-v3-0-d342dae9e843@linutronix.de>
References: <20261123-at-vector-size-arch-v3-0-d342dae9e843@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 09:49:26 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 15-patch series:

- Patches 2 and 4-15: no issues found.
- Patch 3 ("asm-generic: add an in-kernel auxvec.h header"): 1 potential
  issue (1 High)
- Patch 1: skipped (not reviewed).

A detailed review has been sent as a separate reply to patch 3.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-at-vector-=
size-arch-v3-0-d342dae9e843@linutronix.de
