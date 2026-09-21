Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0A83B4404;
	Mon, 21 Sep 2026 23:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032522; cv=none; b=qPVtxK3PaMy2TTx5fXKposvafu9cXOIC7xG/O0bMc7jj2DTvKNd/nHS4jyuDmfahlTK/XHL045ZTLMg0ZWGNcvkYgkm7w9cl6AhR/1S9vgmOGgsmCMi19A0XOxG4F+3gPyyz08xOkv3/Ulohr0ldCC2aC4WqkptP5Rh9uokf3lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032522; c=relaxed/simple;
	bh=OY4b74Cv4pudauJdHjz5vL4UbHr7YKa7dMBenbGun3U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S1DmD77hMvvhaIr7kcOImmEX8KVnkecfvau1S5rodKEuqkZ3C8A3inE8ECxlUXoyVitMzoEsO9YJvrwyxNHOOxWBZyo+UKgznvOQuWgogoRRGz1r0gmXcAlEguVaootzG/EJyw+mB1F8GbQ0ZT/NkgHEQG+KE2uMhl7H5Nja9rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8y6L5Eg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8y6L5Eg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FA41F000FF;
	Mon, 21 Sep 2026 23:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790032520;
	bh=fvDka7Ykxs/yoe0YlGGDGW0r9OYOGXwGtAQ7CcMIEG8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R8y6L5EgcYN77jzzTmyOd3SedZumzyONT51BLt4w3BPUO7TwnUmXRJGBG2J+2qx2F
	 eVgkz7qiyWqjgFCOtIOzk4AzhqCtR9bNqwqhlqvxjuC0xo6OTC5UIK5u/yqZXMo/N4
	 7q9x+L4ceqM2cUM7O0LiFU0IJY5jaXg0WpLBT9yrwBF5ISuTrS8dHxtgw05oIUP6P4
	 m2aDstR8nukve+DEE9U8TB+lbCvBVuwBTjk15kGcNYzK+FSVc4HKC/zVOXs9v+RQlv
	 4Avw011bvBjITkHbYHMR1JkmPcZAtc+fwQ5F8Teue1fnF6IiddeSqNGA8RD/PeTkDL
	 G1SFV9vQWr4TA==
Date: Mon, 21 Sep 2026 16:15:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nagamani PV <nagamani@linux.ibm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, wintera@linux.ibm.com, aswin@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, kees@kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] s390/ctcm: Fix timer bugs in fsm.c
Message-ID: <20260921161519.17f77cae@kernel.org>
In-Reply-To: <20260916132149.4185912-1-nagamani@linux.ibm.com>
References: <20260907144511.3810194-1-nagamani@linux.ibm.com>
	<20260916132149.4185912-1-nagamani@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 15:21:47 +0200 Nagamani PV wrote:
> Fix two bugs in drivers/s390/net/fsm.c found by Sashiko AI code review.
> 
> Patch 1 fixes timer list corruption when fsm_addtimer() is called on
> an already-pending timer - timer_setup() re-initializes the timer
> list_head while it is still enqueued in the wheel.
> 
> Patch 2 fixes a use-after-free in channel_remove() - timer_delete()
> returns before any running callback finishes, leaving a window where
> the timer callback can access freed memory. Fix by waiting for any
> running callback to complete before freeing the channel.
> 
> Changes in v2:
> - Patch 1: fix function name ctcm_send_sweep() -> ctcmpc_send_sweep_req()
>   in the commit message (Sashiko netdev-bot)
> - Patch 1: call mod_timer() then return 0 explicitly, preserving the
>   "Always returns 0" contract documented in fsm.h (Sashiko netdev-bot)
> - Patch 2: add Fixes: and Cc: stable@vger.kernel.org tags
>   (Sashiko netdev-bot)

Clashiko won't respond because of the unnecessary threading,
but there are 4 high severity findings needing your attention:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916132149.4185912-3-nagamani@linux.ibm.com
-- 
pw-bot: cr
