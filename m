Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DD51386AE;
	Thu, 15 Feb 2024 19:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025874; cv=none; b=OqPHJaB8noZ3k/ezR5l6ZgYmuXP6DFVtVaFQ64J1Mo/jkGz/OTGQMPtiFGeDvviT07+LrgEti4GZeoFLThY7OupgYYZAMxwJVhDMx9dy5qL2I5d0lwE4JyvS2MwNYHBx0IqmSg+XzmGYkY65ABVeL04zdITMPq+qXLT2PWYJGgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025874; c=relaxed/simple;
	bh=WXIARXXddfCsVR07+zyJ3q/HPdPO2/5lAfbkMserF7c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLTInbewcscjLtw2hdTQhOXWpr72hcpC4YyHmISu4Pn8gI6+PGtovMwl3n5pKPvQ7gXLdkEWl3fBBuMuBRsG8btSp7ytMe/JPTOMchjw0j485fXD7oBEmYhEjAMJ7DnIMUKCurR3XZfeteBz3jpDJYdyKqRbjWt93Gk857PVYiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gD3PqADp; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gD3PqADp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708025872; x=1739561872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hP7VaigpFFD7y7UzfJ+iUqewRB+4Xpb4jyQOfXFvD68=;
  b=gD3PqADp7z4mLZLSGHYp/L8T3mhJyNALbymtXCfZhp3cpVRXXcIEQ8yl
   jGUxUXeS862x+dIyfHJ7zHoI9ZsmwamMiY06jezGtsTViYjhI0tJwrWoE
   6EdAe4yHWQImSl/uygjxduanV0gPDnrOuqMellcpe/itdEvrlNwRLk/Ie
   4=;
X-IronPort-AV: E=Sophos;i="6.06,162,1705363200"; 
   d="scan'208";a="386859129"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 19:37:48 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:46876]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.174:2525] with esmtp (Farcaster)
 id 7f4c9c30-e282-4ae6-a84d-4a2491c20c50; Thu, 15 Feb 2024 19:37:47 +0000 (UTC)
X-Farcaster-Flow-ID: 7f4c9c30-e282-4ae6-a84d-4a2491c20c50
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 19:37:44 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Thu, 15 Feb 2024 19:37:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <matttbe@kernel.org>
CC: <alibuda@linux.alibaba.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<gbayer@linux.ibm.com>, <guwen@linux.alibaba.com>, <jaka@linux.ibm.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<linux-s390@vger.kernel.org>, <martineau@kernel.org>,
	<mptcp@lists.linux.dev>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<tonylu@linux.alibaba.com>, <wenjia@linux.ibm.com>
Subject: Re: [PATCH v2 net-next] net: Deprecate SO_DEBUG and reclaim SOCK_DBG bit.
Date: Thu, 15 Feb 2024 11:37:33 -0800
Message-ID: <20240215193733.11427-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <28ca6b01-248c-43f6-b20f-79ff39f03974@kernel.org>
References: <28ca6b01-248c-43f6-b20f-79ff39f03974@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC004.ant.amazon.com (10.13.139.205) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Matthieu Baerts <matttbe@kernel.org>
Date: Thu, 15 Feb 2024 10:58:58 +0100
> Hi Kuniyuki,
> 
> On 14/02/2024 20:54, Kuniyuki Iwashima wrote:
> > Recently, commit 8e5443d2b866 ("net: remove SOCK_DEBUG leftovers")
> > removed the last users of SOCK_DEBUG(), and commit b1dffcf0da22 ("net:
> > remove SOCK_DEBUG macro") removed the macro.
> > 
> > Now is the time to deprecate the oldest socket option.
> > 
> > Note that setsockopt(SO_DEBUG) is moved not to acquire lock_sock().
> > 
> > Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> > v2:
> >   * Move setsockopt(SO_DEBUG) code not to acquire lock_sock().
> 
> Thank you for the v2!
> 
> Good idea to have modified that in net/core/sock.c too!
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> 
> I don't think we need to do anything else, but just to be sure: do we
> need to tell the userspace this socket option has been deprecated?
> SO_DEBUG is a bit particular, so I guess it is fine not to do anything
> else, but except by looking at the kernel version, I don't think the
> userspace can know it has no more effect.
> 
> I didn't find many examples of other deprecated socket options, apart
> from SO_BSDCOMPAT. For years, there was a warning, removed a few years
> ago: f4ecc748533d ("net: Stop warning about SO_BSDCOMPAT usage"). I
> guess we don't want that for SO_DEBUG, right?

I was also wondering if I should add pr_info_once(), but it seems not
worth adding.

With a rough grep,

  $ git log -S SOCK_DEBUG net

except for the legacy protocols (appletalk, dccp, x25) that 8e5443d2b866
touched recently, TCP was the last real user of SOCK_DEBUG() and it's
2019-02-25 (5 years ago!) that 9946b3410b61 removed the use.

So, I think we don't need such warning.

Thanks!
