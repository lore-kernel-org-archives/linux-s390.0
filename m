Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0081FB1;
	Sat,  5 Sep 2026 00:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788568979; cv=none; b=iKrX6BSp6VRQm6QVrhmbyI/ialG3ZP8hZNCGjlga76AfVMrlRTgbkFAZ74OmQMMl1SD1RvAltZ6M+kMTdMDgensvMqUAcvyVGiIxwG13R4bnFyDHkVdihmf8pbNo/SnFBifMyeJNUtzj2eKfsC7Qc5tmDAZL0jG6D/G9jgzo2bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788568979; c=relaxed/simple;
	bh=Zv1r3FIV6pbmYSAwd1bOTjGOlyPD1z7k1E4/q/elccI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kw9L4YZol4t0tjifOy9rpzD53+xHtiwbFQQYXNaj6tjPK6UJBkOEeCLdxHOpqOCglTNYajnnWfC4KxecU0HAaDF1k8miXAXPRLIGr6s6K9xbePxVP93d1vcxuZeEWjVKh6J/PWYhGjqVhh98xnVPbAVORKhGMvDeumV0u6/s0Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TxE/3w0B; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TxE/3w0B"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788568973; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=rXC4fBzFvtgZ7XyuwFm+it0/0aIEWSMMEm5oqcrJXGI=;
	b=TxE/3w0Be39Uzl9tuYQ2Lrvc+OXyBcfQoncQ2mKFK5oDZtn2ChMGWRmQzG18bcbg3QP+857b1KWwwoS2jwUDsN2LhmS/JPUIVDx5OW1ALz4P20wP7rVvATFNqPJ0c2T1iuq5J0bMOs8dKexGkXtnR45Fy97Pj/M3W+qflX4VJkg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0XAJoxoc_1788568971;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0XAJoxoc_1788568971 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 05 Sep 2026 08:42:52 +0800
Date: Sat, 5 Sep 2026 08:42:51 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next] dibs: Avoid inconsistent lockstate warning in
 dibs_lo_move_data()
Message-ID: <aptliyYaiprd90jE@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20260904094446.1342654-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904094446.1342654-1-wintera@linux.ibm.com>

On 2026-09-04 11:44:46, Alexandra Winter wrote:
>dibs->lock is acquired in process context and interrupt context
>(ism_handle_irq()). So always use spin_lock_irqsave() in process context.
>
>Note that this is not a real deadlock, as dibs_lo devices don't have
>any interrupt context.
>
>Example warning:
>[  153.760872] ================================
>[  153.760878] WARNING: inconsistent lock state
>[  153.760885] 7.2.0-15871-g544d85de4dc2 #16 Not tainted
>[  153.760891] --------------------------------
>[  153.760896] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
>[  153.760901] python3/5134 [HC0[0]:SC0[2]:HE1:SE0] takes:
>[  153.760909] 0001222c0fe72428 (&dibs->lock){?...}-{2:2}, at: dibs_lo_move_data+0x1ce/0x380
>[  153.760932] {IN-HARDIRQ-W} state was registered at:
>[  153.760937]   __lock_acquire+0x59c/0x15d0
>[  153.760947]   lock_acquire.part.0+0x11c/0x290
>[  153.760953]   lock_acquire+0xb4/0x1e0
>[  153.760959]   _raw_spin_lock+0x58/0xb0
>[  153.760966]   ism_handle_irq+0x80/0x3f0 [ism]
>[  153.760974]   __handle_irq_event_percpu+0x282/0x920
>[  153.760983]   handle_irq_event_percpu+0x26/0xe0
>[  153.760989]   handle_percpu_irq+0x10e/0x1a0
>[  153.760997]   handle_irq_desc+0xa6/0x100
>[  153.761003]   zpci_floating_irq_handler+0x3ca/0x610
>[  153.761011]   do_airq_interrupt+0x206/0x500
>[  153.761018]   __handle_irq_event_percpu+0x282/0x920
>[  153.761025]   handle_irq_event_percpu+0x26/0xe0
>[  153.761031]   handle_percpu_irq+0x10e/0x1a0
>[  153.761039]   handle_irq_desc+0xa6/0x100
>[  153.761045]   do_irq_async+0xec/0x150
>[  153.761052]   do_io_irq+0x150/0x2e0
>[  153.761060]   io_int_handler+0xec/0x118
>[  153.761066]   arch_cpu_idle+0x120/0x130
>[  153.761118]   arch_cpu_idle+0xbe/0x130
>[  153.761124]   s390_enter_idle+0x20/0x30
>[  153.761131]   cpuidle_enter_state+0xb6/0x440
>[  153.761138]   cpuidle_enter+0x64/0xb0
>[  153.761144]   cpuidle_idle_call+0x174/0x380
>[  153.761151]   do_idle+0x16e/0x250
>[  153.761157]   cpu_startup_entry+0x70/0x80
>[  153.761163]   smp_start_secondary+0x36e/0x440
>[  153.761171]   restart_int_handler+0x72/0x88
>[  153.761178] irq event stamp: 46536
>[  153.761182] hardirqs last  enabled at (46536): [<000127b697450a90>] __local_bh_enable_ip+0x140/0x270
>[  153.761193] hardirqs last disabled at (46535): [<000127b697450b20>] __local_bh_enable_ip+0x1d0/0x270
>[  153.761202] softirqs last  enabled at (46532): [<000127b6185f82c8>] smc_close_active+0x438/0xba0 [smc]
>[  153.761232] softirqs last disabled at (46534): [<000127b6185ee998>] smc_cdc_get_slot_and_msg_send+0x218/0x370 [smc]
>[  153.761257]
>               other info that might help us debug this:
>[  153.761262]  Possible unsafe locking scenario:
>
>[  153.761267]        CPU0
>[  153.761271]        ----
>[  153.761274]   lock(&dibs->lock);
>[  153.761282]   <Interrupt>
>[  153.761286]     lock(&dibs->lock);
>[  153.761294]
>                *** DEADLOCK ***
>
>[  153.761299] locks held by python3/5134: 3, last CPU#1:
>[  153.761305]  #0: 0001222bab975f50 (&sb->s_type->i_mutex_key#11){+.+.}-{3:3}, at: __sock_release+0x7e/0x230
>[  153.761329]  #1: 0001222ba5450378 (sk_lock-AF_SMC){+.+.}-{0:0}, at: smc_close_active+0x438/0xba0 [smc]
>[  153.761360]  #2: 0001222ba54508a0 (&smc->conn.send_lock){+...}-{2:2}, at: smc_cdc_get_slot_and_msg_send+0x218/0x370 [smc]
>[  153.761394]
>               stack backtrace:
>[  153.761400] CPU: 1 UID: 0 PID: 5134 Comm: python3 Not tainted 7.2.0-15871-g544d85de4dc2 #16 PREEMPT
>[  153.761406] Hardware name: IBM 3931 A01 703 (LPAR)
>[  153.761408] Call Trace:
>[  153.761409]  [<000127b697366190>] dump_stack_lvl+0xe8/0x140
>[  153.761415]  [<000127b6975ccc8c>] print_usage_bug.part.0+0x2ec/0x3a0
>[  153.761419]  [<000127b6975cd454>] mark_lock_irq+0x714/0xa20
>[  153.761422]  [<000127b6975cda52>] mark_lock+0x2f2/0x790
>[  153.761426]  [<000127b6975ce2e6>] mark_usage+0x136/0x1c0
>[  153.761430]  [<000127b6975ce90c>] __lock_acquire+0x59c/0x15d0
>[  153.761433]  [<000127b6975cfa5c>] lock_acquire.part.0+0x11c/0x290
>[  153.761437]  [<000127b6975cfc84>] lock_acquire+0xb4/0x1e0
>[  153.761441]  [<000127b699d02a98>] _raw_spin_lock+0x58/0xb0
>[  153.761444]  [<000127b6992ca4fe>] dibs_lo_move_data+0x1ce/0x380
>[  153.761449]  [<000127b6185f0912>] smcd_tx_ism_write+0x182/0x250 [smc]
>[  153.761469]  [<000127b6185ee4c6>] smcd_cdc_msg_send+0x156/0x410 [smc]
>[  153.761487]  [<000127b6185ee9a2>] smc_cdc_get_slot_and_msg_send+0x222/0x370 [smc]
>[  153.761507]  [<000127b6185f8370>] smc_close_active+0x4e0/0xba0 [smc]
>[  153.761526]  [<000127b6185a293c>] __smc_release+0x4ac/0x6a0 [smc]
>[  153.761546]  [<000127b6185a2c6e>] smc_release+0x13e/0x480 [smc]
>[  153.761565]  [<000127b6994544d4>] __sock_release+0xa4/0x230
>[  153.761569]  [<000127b69945468c>] sock_close+0x2c/0x40
>[  153.761573]  [<000127b697e57180>] __fput+0x2f0/0x880
>[  153.761579]  [<000127b697e58440>] fput_close_sync+0xd0/0x1c0
>[  153.761583]  [<000127b697e4b3f0>] __s390x_sys_close+0x90/0xf0
>[  153.761586]  [<000127b699cdc19e>] __do_syscall+0x1be/0x5a0
>[  153.761590]  [<000127b699d04c7a>] system_call+0x72/0x90
>[  153.761594] INFO: lockdep is turned off.
>
>Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

Best regards,
Dust

