Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EBE530E0E;
	Tue,  8 Sep 2026 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873076; cv=none; b=hqbaiy5McfAj6LJimfQqt9A0kaVQqeeCzr1NhU6SV30vKlOqTpzlIOuLaX9jsDsN5NC6ZzXSEKuKH9SX1L3LTB5ysGLnpKnNIURUFIFkoB/vuc669giPSMnv6sSIrwlPKdpW2Gw6/yzOQvhCMJeR9Q+cUIlfhmdv5TeKR82QpQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873076; c=relaxed/simple;
	bh=gQ8mYYJDIuYHjewvxPDKrgNsHhjDlgb/NoroyBv9/GU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cvKUqlsddE3wFK0UBbysg82Xl8oKunZcAjrKigdLk7Rpz4cw5AmZgkDmJ843TfOzGQ9cZDvhGa6Hfu8LrVvwLTtHx45cLHmWTDWWgH82Chlbb3XMRlK62Cn89nq07tNYPkNzgZi3eEAdrOY2dfW+01jm9eBBvSl9LjwK8juuAOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1G1AsQu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1G1AsQu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7174C1F00A3A;
	Tue,  8 Sep 2026 13:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788873065;
	bh=fPNM8jnmepODnLQ1RBc+Jey3UcMaPZE9G43eGiUr/Ew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=B1G1AsQucImQiypfy4OI+6Rc3deVs4yAKNk3w0Sgo1PUFp8PDkS82AuVMEzcoYe7u
	 syCAy39vLVTbIVHOWVvEWXsNCB7ySoM7EHUzvaRsgYg5BqUMhxKTP/mn1d5a9HnqNq
	 XbzyWSNkPNqrtudw5bK+IWksZN894ZB33H5uI5+48WBMkNnPNxstHfXiL2CQmRXncz
	 GOn8pZa7TwZ0hgXnPaEJXCpRRjFNSmukesVRGe6RIdiiV2CUDHKaq9bFrqr6YJMug5
	 ns7IZlVPTnUdBdRKaHftON0QVZHql5PtFNk3/heGyPhi3GM4CUnArmMaaxM3DRz0C1
	 wsMfkcAZ/1RdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5691A39EAF40;
	Tue,  8 Sep 2026 13:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dibs: Avoid inconsistent lockstate warning in
 dibs_lo_move_data()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178887300426.3520282.16943020551089972455.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 13:10:04 +0000
References: <20260904094446.1342654-1-wintera@linux.ibm.com>
In-Reply-To: <20260904094446.1342654-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
 sidraya@linux.ibm.com, mjambigi@linux.ibm.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  4 Sep 2026 11:44:46 +0200 you wrote:
> dibs->lock is acquired in process context and interrupt context
> (ism_handle_irq()). So always use spin_lock_irqsave() in process context.
> 
> Note that this is not a real deadlock, as dibs_lo devices don't have
> any interrupt context.
> 
> Example warning:
> [  153.760872] ================================
> [  153.760878] WARNING: inconsistent lock state
> [  153.760885] 7.2.0-15871-g544d85de4dc2 #16 Not tainted
> [  153.760891] --------------------------------
> [  153.760896] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> [  153.760901] python3/5134 [HC0[0]:SC0[2]:HE1:SE0] takes:
> [  153.760909] 0001222c0fe72428 (&dibs->lock){?...}-{2:2}, at: dibs_lo_move_data+0x1ce/0x380
> [  153.760932] {IN-HARDIRQ-W} state was registered at:
> [  153.760937]   __lock_acquire+0x59c/0x15d0
> [  153.760947]   lock_acquire.part.0+0x11c/0x290
> [  153.760953]   lock_acquire+0xb4/0x1e0
> [  153.760959]   _raw_spin_lock+0x58/0xb0
> [  153.760966]   ism_handle_irq+0x80/0x3f0 [ism]
> [  153.760974]   __handle_irq_event_percpu+0x282/0x920
> [  153.760983]   handle_irq_event_percpu+0x26/0xe0
> [  153.760989]   handle_percpu_irq+0x10e/0x1a0
> [  153.760997]   handle_irq_desc+0xa6/0x100
> [  153.761003]   zpci_floating_irq_handler+0x3ca/0x610
> [  153.761011]   do_airq_interrupt+0x206/0x500
> [  153.761018]   __handle_irq_event_percpu+0x282/0x920
> [  153.761025]   handle_irq_event_percpu+0x26/0xe0
> [  153.761031]   handle_percpu_irq+0x10e/0x1a0
> [  153.761039]   handle_irq_desc+0xa6/0x100
> [  153.761045]   do_irq_async+0xec/0x150
> [  153.761052]   do_io_irq+0x150/0x2e0
> [  153.761060]   io_int_handler+0xec/0x118
> [  153.761066]   arch_cpu_idle+0x120/0x130
> [  153.761118]   arch_cpu_idle+0xbe/0x130
> [  153.761124]   s390_enter_idle+0x20/0x30
> [  153.761131]   cpuidle_enter_state+0xb6/0x440
> [  153.761138]   cpuidle_enter+0x64/0xb0
> [  153.761144]   cpuidle_idle_call+0x174/0x380
> [  153.761151]   do_idle+0x16e/0x250
> [  153.761157]   cpu_startup_entry+0x70/0x80
> [  153.761163]   smp_start_secondary+0x36e/0x440
> [  153.761171]   restart_int_handler+0x72/0x88
> [  153.761178] irq event stamp: 46536
> [  153.761182] hardirqs last  enabled at (46536): [<000127b697450a90>] __local_bh_enable_ip+0x140/0x270
> [  153.761193] hardirqs last disabled at (46535): [<000127b697450b20>] __local_bh_enable_ip+0x1d0/0x270
> [  153.761202] softirqs last  enabled at (46532): [<000127b6185f82c8>] smc_close_active+0x438/0xba0 [smc]
> [  153.761232] softirqs last disabled at (46534): [<000127b6185ee998>] smc_cdc_get_slot_and_msg_send+0x218/0x370 [smc]
> [  153.761257]
>                other info that might help us debug this:
> [  153.761262]  Possible unsafe locking scenario:
> 
> [...]

Here is the summary with links:
  - [net-next] dibs: Avoid inconsistent lockstate warning in dibs_lo_move_data()
    https://git.kernel.org/netdev/net-next/c/73db35350c5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


