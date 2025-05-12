Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473532AE68;
	Mon, 12 May 2025 22:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747087849; cv=none; b=fo1i3yAesY5v+61tYVXDEdPxYtDk4F/hLVVtb99b4/ftO0iQwt938Sznv9yh4aWlURcpTZ9F8HQmynENYqSSIB1R4B+vy7zHB9ecJYRcreellvXNIy46tUHvXWnRb59h5epAzijlWdSFI2FcbWPjbo3gQ5oGprAgbXYh5hWkodQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747087849; c=relaxed/simple;
	bh=Tw9uGkMbDXao8DIVFN7rA2XNqQCc+VGWbBiGjIYgypk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iP4Z+GmCIZ9cYdZkKT16XMT4W4hKGVI/xFt4KOLEZo27nl5vSv1CJAnnt4KGDogKrsPAviIq0FcMrMvBdCHh+4fEcNmYYo7pugrkUOHOUrJ/AEJ/4uKtiqLNGzKtFVMzoKDwmzeamffjd9roSPGSBovHSYA+Z4QymxAOtoqN9PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=iPCQP+Lx; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="iPCQP+Lx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747087848; x=1778623848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7tN0DJOjCDbYyLG3fBURerzunikZ2GPsRRAIeI9irw8=;
  b=iPCQP+LxBYb7wAjnnNnv/yDijmUFzAxn18VHr3wO8YF6M74XQZ3pMBwf
   QnkgkWCPE5bQPdd6Aqw409DiO9y+VbypZ8XUlTPpsWhJMRvGhb5szwXmR
   hd445yEUR0sJFnhopKeb+LHcDgaMAdjtzIxpKvYoFV9D63q9lFz+4/QGH
   tOAh2Nfz10iVp6+T3WiDAGrgch5MWsvyH04iEo0VKujC/gdqRdyEBe6Ug
   S5XH+dXV3i9hHi2jmzT9w7GqW++fJF+EawTy4M8PPwRpMNIJFRhv5+siJ
   mKI7DneLySAEEkCkdrLnKkayiqYSQi/L1AuWiPM5y7vw/JQGZFx3ktPiP
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,283,1739836800"; 
   d="scan'208";a="92404891"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 22:10:43 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:17316]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.68:2525] with esmtp (Farcaster)
 id dc358a6f-7c1b-414a-9827-10a9fec784f8; Mon, 12 May 2025 22:10:42 +0000 (UTC)
X-Farcaster-Flow-ID: dc358a6f-7c1b-414a-9827-10a9fec784f8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 12 May 2025 22:10:41 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 12 May 2025 22:10:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com>
CC: <alibuda@linux.alibaba.com>, <danielyang32@g.ucla.edu>,
	<danielyangkang@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<guwen@linux.alibaba.com>, <hdanton@sina.com>, <jaka@linux.ibm.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <laforge@gnumonks.org>,
	<linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<lkp@intel.com>, <llvm@lists.linux.dev>, <netdev@vger.kernel.org>,
	<oe-kbuild-all@lists.linux.dev>,
	<osmocom-net-gprs-bounces@lists.osmocom.org>,
	<osmocom-net-gprs@lists.osmocom.org>, <pabeni@redhat.com>,
	<pablo@netfilter.org>, <syzkaller-bugs@googlegroups.com>,
	<tonylu@linux.alibaba.com>, <wenjia@linux.ibm.com>
Subject: Re: [syzbot] [net?] possible deadlock in gtp_encap_enable_socket
Date: Mon, 12 May 2025 15:10:26 -0700
Message-ID: <20250512221029.56357-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <68221ce4.050a0220.f2294.0070.GAE@google.com>
References: <68221ce4.050a0220.f2294.0070.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: syzbot <syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com>
Date: Mon, 12 May 2025 09:08:04 -0700
> syzbot suspects this issue was fixed by commit:
> 
> commit 752e2217d789be2c6a6ac66554b981cd71cd9f31
> Author: Kuniyuki Iwashima <kuniyu@amazon.com>
> Date:   Mon Apr 7 17:03:17 2025 +0000
> 
>     smc: Fix lockdep false-positive for IPPROTO_SMC.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=140462f4580000
> start commit:   9410645520e9 Merge tag 'net-next-6.12' of git://git.kernel..
> git tree:       net-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=37c006d80708398d
> dashboard link: https://syzkaller.appspot.com/bug?extid=e953a8f3071f5c0a28fd
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16215ca9980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110c6c27980000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: smc: Fix lockdep false-positive for IPPROTO_SMC.

#syz fix: smc: Fix lockdep false-positive for IPPROTO_SMC.

