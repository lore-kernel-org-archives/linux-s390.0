Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0556314D13;
	Fri, 30 Jan 2026 08:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769761430; cv=none; b=iuSXubSMOl65cL54/9kLOjbpMkQ6/Q8PHm3t6vlFt29tRU1t7ia9gFfTCYLAxcSStP47DAjHmaJt4cTeCezPXuYSJ7FOeP9WEZe7H5HD5FJweE91K09qg+Q7micM2fivkIxYDlJzHaVKggB5FfljmRzRcLQk8QdGbIVn5R9gukM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769761430; c=relaxed/simple;
	bh=YgQLkb8jX1AH0tbkh+QGod/x7UP32YjFb2qPFDBVPr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7WC2V1oITZvRtbuPTNCvJNfTgWUwtYT85uhUGnjXv1M/AEhO1NeKmvtMB2VHe/1Y2pZyXM4Sja8dUa9uvMYMhO4S0t0vKTaPILJPaUx8AOhfZxGDrQlkQjyaehv2SfIhSekmJ5xdDJS5vWUgpycdyj2IM+9XcDP6DMnhX6y1Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lCY5wdKj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DVBc4VdE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lCY5wdKj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DVBc4VdE"
Date: Fri, 30 Jan 2026 09:23:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769761427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=chYIUBt/EugIr0AL9E0F3IgPc9RzQg0oeO5t8YDREvM=;
	b=lCY5wdKjIO3MK8kbGlbMUkDaALYyAEWlUiFPNaF1WgnTixxuoXJu5RM7dtG1PgS5jHU3Ht
	PQQ1iKP+G8yy/wIk8p2IpWjPV7eRZm1aWTTWs1rfSAzvtsDjdCaAaxmxSxEpUP4n9a5c+N
	ZbXm2AlPgDA91dYAGgVs+F/H6zH4zaqwSfjpzBgSMKY0/KOWhf8pvPeJDYikRYWH/Hhwm7
	9pR5Rs7VqeHOC6wsXIFs52nzocC3bLNcwbK8H7laA1d6PPXP9XVdr1K7pK+KABINGctqMc
	FaTHiKuvg++ebTkPdvcvychobShHN57Maw2ZaahlO1nkyYA7iQf6FxfXVaIPmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769761427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=chYIUBt/EugIr0AL9E0F3IgPc9RzQg0oeO5t8YDREvM=;
	b=DVBc4VdE9Ucp8bmBCDVhHHvEJ4Rdf4j0vFFrMDD4EVwC7yGODIWxsO4enXJjqWXWgJhUSw
	s3wZafA+rfQ0DZBQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Kir Chou <note351@hotmail.com>
Cc: akpm@linux-foundation.org, davidgow@google.com, geert@linux-m68k.org, 
	visitorckw@gmail.com, brendan.higgins@linux.dev, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH] lib/random32: convert selftest to KUnit
Message-ID: <20260130091838-33f432c5-8a36-4844-aa8c-bd71b7470f52@linutronix.de>
References: <20260124054134.71369-1-note351@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124054134.71369-1-note351@hotmail.com>

On Sat, Jan 24, 2026 at 02:41:33PM +0900, Kir Chou wrote:
> This patch converts the existing prandom selftest (lib/random32.c) to use
> the KUnit framework (lib/tests/random32_kunit.c). Unlike typical KUnit
> tests, this file is directly #included into lib/random32.c.
> 
> Only the file name "random32_kunit.c" keeps random32, "prandom" is used
> for all other places for aligning with the API semantics and avoiding
> confusion with the cryptographically secure random.c,
> 
> The new test:
> - Removes the legacy CONFIG_RANDOM32_SELFTEST.

This bit seems to be missing from the patch.
'config RANDOM32_SELFTEST' still exists in lib/Kconfig.

> - Adds CONFIG_PRANDOM_KUNIT_TEST (defaulting to KUNIT_ALL_TESTS).
> - Moves the test logic to lib/tests/random32_kunit.c.
> - Updates arch/s390/configs/debug_defconfig to use the new KUnit symbol.
> 
> This commit is verified by `./tools/testing/kunit/kunit.py run`
> with the .kunit/.kunitconfig:
> 
> ```
> CONFIG_KUNIT=y
> CONFIG_PRANDOM_KUNIT_TEST=y
> ```
> 
> Signed-off-by: Kir Chou <note351@hotmail.com>
> ---
>  arch/s390/configs/debug_defconfig |   2 +-
>  lib/Kconfig.debug                 |  12 +++
>  lib/random32.c                    | 173 +----------------------------
>  lib/tests/random32_kunit.c        | 174 ++++++++++++++++++++++++++++++
>  4 files changed, 189 insertions(+), 172 deletions(-)
>  create mode 100644 lib/tests/random32_kunit.c
> 

(...)

> diff --git a/lib/tests/random32_kunit.c b/lib/tests/random32_kunit.c
> new file mode 100644
> index 000000000..ee50205b8
> --- /dev/null
> +++ b/lib/tests/random32_kunit.c
> @@ -0,0 +1,174 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test cases for random32 functions.
> + */
> +
> +#include <kunit/test.h>
> +
> +static struct prandom_test1 {
> +	u32 seed;
> +	u32 result;
> +} test1[] = {
> +	{ 1U, 3484351685U },
> +	{ 2U, 2623130059U },
> +	{ 3U, 3125133893U },
> +	{ 4U,  984847254U },
> +};
> +
> +static struct prandom_test2 {

These arrays can be 'const'.

> +	u32 seed;
> +	u32 iteration;
> +	u32 result;
> +} test2[] = {

(...)
