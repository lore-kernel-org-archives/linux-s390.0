Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7825A4D6C28;
	Mon,  5 Oct 2026 17:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220581; cv=none; b=KuB2EQPNvMQkuwnDehiI6Wf/tHD7uKVxqauD8aDx6GsplWPz2/XaTOYsOUJIUZbz2P+tjNEHj9ifdoZJdBo5kJcBY/HI8WGNfaG7ua58xsHTfHqbvPxaPIa++hHbhUxRWTRpIOsuiP7gV79zVmytosym2l1WIMCNNMeiZQ1TV1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220581; c=relaxed/simple;
	bh=ky8Vrl1jKCoNSQdQXobgZO19NxDdMPncu4cfwXWENZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gj3lZLp67GchH+oNFs4fnJVSYj5AkaQ8Oe5y+lQotNmKNIsqiGyIhD4SQYnrtIRfUuuzxSvbmvrO3su9fHz/7HCxSnd1QiOsZMQvc4GHAt/2OO234pfTRJKZJ1hGYwywjOhfHKt9nsK3py04DGb4onM+IebTWZJ1UmtpceyuDaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGco3/Pl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGco3/Pl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E951F1F008A0;
	Mon,  5 Oct 2026 17:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791220580;
	bh=j4r8rOsU7klHGaFmR7hksUffdzAZxslaDtYoNWOJEFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aGco3/Pl3atnnMnTvXXwDDyNPj5qKCympwryBMMXrPAltnzVMHdLfcitgZtQC600X
	 /vs6+Ta2sz8MWrGQxrc1OrVcrLCBTRq/QTRrYtMZKe+PLOx7yIIkN2Qeya0DGcDeT2
	 ab62NpUlTB1+Wm/dv+Ud3XExyrjkCsQB7FxGBZukFicMSHHU7IHLhEylKbb62iE2x9
	 xHqfFw/iidcdx1rUhmx+EONN/SxGdexaVnnU4e3fnRAJStGKk6F0yPXY1oefeuOc27
	 rld93AE9sd6YEQpjNtNvavcoP/HYp/A4yelGE6MB9eNHXcQORd41iBgT1VQblWjCI0
	 kPiq8r/Ko7z3g==
Date: Mon, 5 Oct 2026 18:16:14 +0100
From: Simon Horman <horms@kernel.org>
To: Nagamani PV <nagamani@linux.ibm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, wintera@linux.ibm.com,
	aswin@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
	svens@linux.ibm.com, kees@kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net v4 1/2] s390/ctcm: Fix timer corruption in
 fsm_addtimer()
Message-ID: <20261005171614.GC83879@horms.kernel.org>
References: <20260930070234.569500-1-nagamani@linux.ibm.com>
 <20260930070234.569500-2-nagamani@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930070234.569500-2-nagamani@linux.ibm.com>

On Wed, Sep 30, 2026 at 09:02:33AM +0200, Nagamani PV wrote:
> fsm_addtimer() calls timer_setup() unconditionally before add_timer().
> If called on an already-pending timer, timer_setup() re-initializes
> the timer's list_head fields while the timer is still enqueued in the
> wheel, corrupting the timer list.
> 
> The timer is already initialized once by fsm_settimer() which calls
> timer_setup() correctly. Multiple callsites invoke fsm_addtimer()
> without a preceding fsm_deltimer(), including ctcm_main.c
> ctcmpc_send_sweep_req() and ctcm_mpc.c mpc_action_side_xid(), making the
> redundant timer_setup() in fsm_addtimer() a real corruption risk.
> 
> Remove the redundant timer_setup() calls from fsm_addtimer() and
> fsm_modtimer(), and replace add_timer() with mod_timer() which safely
> handles both pending and non-pending timers atomically without
> corrupting the timer wheel.
> 
> Fixes: e99e88a9d2b0 ("treewide: setup_timer() -> timer_setup()")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260803182736.2356374-1-nagamani@linux.ibm.com?part=1
> Reviewed-by: Aswin Karuvally <aswin@linux.ibm.com>
> Tested-by: Aswin Karuvally <aswin@linux.ibm.com>
> Signed-off-by: Nagamani PV <nagamani@linux.ibm.com>

Reviewed-by: Simon Horman <horms@kernel.org>

