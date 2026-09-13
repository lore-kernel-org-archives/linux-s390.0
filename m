Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119F63E95A4;
	Sun, 13 Sep 2026 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789306957; cv=none; b=avxTSpK2yXXYPXlCzxw0HNb9qCfDttcwroe22ip930nRhfo7MzLBJLZrnA22AaF5yg+U40LVfvPvjEzC4YqTA0Adv7aaDoYT4AaFCxkjb9Q2NqAHZCblgnCo0muRh3WKTrecwwEu82KS+Sk8WmxGJPuqhhF+Bid6rRL1FHMXt9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789306957; c=relaxed/simple;
	bh=/+BKfmb7S2w6JiMBVF8GoMH1Mw+py3N81GEAc9IfoEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCjtNxXXdC+6+6EF+wToSRDVpUiczsbWAmtN8xL7YDSnskE7tJ0XNHm/diaYFxbwFTLZkL0KD1QAhAQdpi2pmvRb3+mixft6BM4P6sbvek/cX0rvUjdOEq+6zCv3MgBKyTiCtUKqLMqFI6mqkP2IxA9ZqFU1G1HwbNAQnV+B6Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+l0AZMK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+l0AZMK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B251F000FF;
	Sun, 13 Sep 2026 13:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789306955;
	bh=1SlS52xY0D62VH+cuPRLNsO8lHT3IoLYgxS8n4WrnDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P+l0AZMK7tp0QooYpXiYgGQPov/+euyBg3dMHxT85IcLS0tS65g3hAsJ6uxIRRwmt
	 T+7GEy+2ukKRk94t2icQ1SHEaSq2YstA0DiAqx5XRaHhNMdxdyBWqceU243U7eM801
	 FPOJxpvyYzthoynHCUTG5t4lni1QTgQS6w64PVrILen5Ea2Hc0KrdknA5oPFAhjKVe
	 xVx717x+REDIRl+Uky1PNWCEEHcVd7/AHEmJrPXsWYeLcYNTlylmA4j9TWT+nRD2h6
	 +ZedKnzm9IIFy8lo2MA76y2oHruVa0O3541oEuRhrlRhmWFKiKWdiWJ1F2A2dwngyN
	 ZN4KQI3V/a7+A==
Date: Sun, 13 Sep 2026 14:42:30 +0100
From: Simon Horman <horms@kernel.org>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Bryam Vargas <hexlabsecurity@proton.me>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH net-next] net/iucv: Add lock nesting annotation in
 iucv_sock_close()
Message-ID: <20260913134230.GI48209@horms.kernel.org>
References: <20260910162919.2100124-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910162919.2100124-1-wintera@linux.ibm.com>

On Thu, Sep 10, 2026 at 06:29:19PM +0200, Alexandra Winter wrote:
> iucv_sock_close() acquires lock_sock(sk) and then, when the socket is in
> IUCV_LISTEN state, calls iucv_sock_cleanup_listen() which acquires
> lock_sock(child_sk) for each pending child socket. Moreover
> iucv_sock_close(child_sk) is called on the pending child sockets.
> 
> Avoid lockdep warning by using lock_sock_nested() in iucv_sock_close().
> Split off __iucv_sock_close(), so iucv_sock_cleanup_listen() can call it
> without nesting.
> 
> This is a missing lockdep annotation - not a real deadlock.
> 
> Example warning:
> [ 6690.906930] ============================================
> [ 6690.906935] WARNING: possible recursive locking detected
> [ 6690.906942] 7.3.0-rc1net_KCSAN_KASAN-00240-g641d03105cc0 #23 Not tainted
> [ 6690.906948] --------------------------------------------
> [ 6690.906953] afiucv_test_loc/5183 is trying to acquire lock:
> [ 6690.906959] 000601ad13f20a78 (sk_lock-IUCV){+.+.}-{0:0}, at: iucv_accept_dequeue+0xdc/0x340 [af_iucv]
> [ 6690.906984]
>                but task is already holding lock:
> [ 6690.906989] 000601ad1c115278 (sk_lock-IUCV){+.+.}-{0:0}, at: iucv_sock_close+0x82/0x7d0 [af_iucv]
> [ 6690.907006]
>                other info that might help us debug this:
> [ 6690.907010]  Possible unsafe locking scenario:
> 
> [ 6690.907014]        CPU0
> [ 6690.907018]        ----
> [ 6690.907021]   lock(sk_lock-IUCV);
> [ 6690.907028]   lock(sk_lock-IUCV);
> [ 6690.907034]
>                 *** DEADLOCK ***
> 
> [ 6690.907038]  May be due to missing lock nesting notation
> 
> [ 6690.907043] locks held by afiucv_test_loc/5183: 2, last CPU#0:
> [ 6690.907085]  #0: 000601ad137a5550 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: __sock_release+0x7e/0x230
> [ 6690.907109]  #1: 000601ad1c115278 (sk_lock-IUCV){+.+.}-{0:0}, at: iucv_sock_close+0x82/0x7d0 [af_iucv]
> [ 6690.907127]
>                stack backtrace:
> [ 6690.907135] CPU: 0 UID: 0 PID: 5183 Comm: afiucv_test_loc Kdump: loaded Not tainted 7.3.0-rc1net_KCSAN_KASAN-00240-g641d03105cc0 #23 PREEMPT
> [ 6690.907140] Hardware name: IBM 8561 T01 703 (z/VM 7.4.0)
> [ 6690.907142] Call Trace:
> [ 6690.907144]  [<00061ab555fd6208>] dump_stack_lvl+0xe8/0x140
> [ 6690.907151]  [<00061ab55623a110>] print_deadlock_bug+0x340/0x350
> [ 6690.907156]  [<00061ab55623f768>] __lock_acquire+0x11b8/0x15d0
> [ 6690.907159]  [<00061ab55623fc9c>] lock_acquire.part.0+0x11c/0x290
> [ 6690.907162]  [<00061ab55623fec4>] lock_acquire+0xb4/0x1e0
> [ 6690.907164]  [<00061ab5580d6b96>] lock_sock_nested+0x46/0xf0
> [ 6690.907167]  [<00061ab4d66e38dc>] iucv_accept_dequeue+0xdc/0x340 [af_iucv]
> [ 6690.907171]  [<00061ab4d66e541c>] iucv_sock_close+0xdc/0x7d0 [af_iucv]
> [ 6690.907174]  [<00061ab4d66e5b62>] iucv_sock_release+0x52/0x130 [af_iucv]
> [ 6690.907177]  [<00061ab5580c5b24>] __sock_release+0xa4/0x230
> [ 6690.907180]  [<00061ab5580c5cdc>] sock_close+0x2c/0x40
> [ 6690.907183]  [<00061ab556ac7a00>] __fput+0x2f0/0x880
> [ 6690.907187]  [<00061ab556ac8cc0>] fput_close_sync+0xd0/0x1c0
> [ 6690.907189]  [<00061ab556abbc70>] __s390x_sys_close+0x90/0xf0
> [ 6690.907192]  [<00061ab55894df0e>] __do_syscall+0x1be/0x5a0
> [ 6690.907196]  [<00061ab558976a7a>] system_call+0x72/0x90
> [ 6690.907200] INFO: lockdep is turned off.
> 
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>

Reviewed-by: Simon Horman <horms@kernel.org>

