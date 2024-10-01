Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DB8BA37;
	Tue,  1 Oct 2024 03:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727751854; cv=none; b=FDr+JIoiK4GQ6oAtIYz5OjLKFf1ksHdJin+2WyxcY7pzx/NEZzg13U5W6QrQbU7tLnmvLOgOzYJG3Hw20uUA91GOHqN7UxQkOuNAkgVl9g37zWolencZH8a25xek5BkAdT37a8F49rgy5DwUWzZ9ueVjs05bI8VSTv5L9yLu5go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727751854; c=relaxed/simple;
	bh=3HBKm0szRipJx4TF0Kii6pAIM0b4zlUKu0U+ZxeJMM8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gj64tq/qNX+3E5aty7npjwxBFH/InNyRQdoCPiSgxASpZhUS29/hVG48NLYE2Kmw+hQpc9gxJvkz80EBXguEL+KyBCyxE6tVP5ra3DxMbyNNS8twqFOH0ROiiwW93G0/nNCEvk+FeIb2xMGb8OeY1jNMOl+7qSYNIkdKeD4DWQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ip4Vo0G3; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ip4Vo0G3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727751853; x=1759287853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KHc7Jdhr39unMwPsimFxyr4ljpx199unonBSQXjCDcA=;
  b=ip4Vo0G3bj7wZmLMfQhXcvgHElSCLK/Feh4hR8hivlXSmGeD4hMJJMJy
   9tqCQbBuS42Yfe2PRxv1q65U0NldWAw3upIpGd6igRPfPI4DV3hnfLECI
   EyxEqwSkWu6Q3dPIGdKzqzkq3Bm6evEN8/LKCsNI1qDgsDYaREAsf65CD
   U=;
X-IronPort-AV: E=Sophos;i="6.11,167,1725321600"; 
   d="scan'208";a="437281082"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 03:04:08 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:56907]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.100:2525] with esmtp (Farcaster)
 id f664d073-6eb1-4843-a13b-d57f24137ae8; Tue, 1 Oct 2024 03:04:07 +0000 (UTC)
X-Farcaster-Flow-ID: f664d073-6eb1-4843-a13b-d57f24137ae8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 1 Oct 2024 03:04:06 +0000
Received: from 88665a182662.ant.amazon.com (10.1.212.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 1 Oct 2024 03:03:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <danielyangkang@gmail.com>
CC: <alibuda@linux.alibaba.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<guwen@linux.alibaba.com>, <jaka@linux.ibm.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com>,
	<tonylu@linux.alibaba.com>, <wenjia@linux.ibm.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH] fixed rtnl deadlock from gtp
Date: Tue, 1 Oct 2024 06:03:49 +0300
Message-ID: <20241001030349.97635-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241001015555.144669-1-danielyangkang@gmail.com>
References: <20241001015555.144669-1-danielyangkang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Daniel Yang <danielyangkang@gmail.com>
Date: Mon, 30 Sep 2024 18:55:54 -0700
> Fixes deadlock described in this bug:
> https://syzkaller.appspot.com/bug?extid=e953a8f3071f5c0a28fd.
> Specific crash report here:
> https://syzkaller.appspot.com/text?tag=CrashReport&x=14670e07980000.
> 
> DESCRIPTION OF ISSUE
> Deadlock: sk_lock-AF_INET --> &smc->clcsock_release_lock --> rtnl_mutex
> 
> rtnl_mutex->sk_lock-AF_INET
> rtnetlink_rcv_msg() acquires rtnl_lock() and calls rtnl_newlink(), which
> eventually calls gtp_newlink() which calls lock_sock() to attempt to
> acquire sk_lock.

Is the deadlock real ?

From the lockdep splat, the gtp's sk_protocol is verified to be
IPPROTO_UDP before holding lock_sock(), so it seems just a labeling
issue.
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/gtp.c?id=9410645520e9b820069761f3450ef6661418e279#n1674


> 
> sk_lock-AF_INET->&smc->clcsock_release_lock
> smc_sendmsg() calls lock_sock() to acquire sk_lock, then calls
> smc_switch_to_fallback() which attempts to acquire mutex_lock(&smc->...).
> 
> &smc->clcsock_release_lock->rtnl_mutex
> smc_setsockopt() calls mutex_lock(&smc->...). smc->...->setsockopt() is
> called, which calls nf_setsockopt() which attempts to acquire
> rtnl_lock() in some nested call in start_sync_thread() in ip_vs_sync.c.
> 
> FIX:
> In smc_switch_to_fallback(), separate the logic into inline function
> __smc_switch_to_fallback(). In smc_sendmsg(), lock ordering can be
> modified and the functionality of smc_switch_to_fallback() is
> encapsulated in the __smc_switch_to_fallback() function.
