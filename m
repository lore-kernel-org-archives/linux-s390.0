Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E17C28EA;
	Wed, 16 Oct 2024 00:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729036990; cv=none; b=jmx41DODyRHjvF3TZ943ZrZXKvPOVXaA7vBcwTS1xHHcJ+GIG9iejxx4B+7t7YQwOyuZnXEJbY5YhnPDuk5NLjDWFntlFNehfv2pn4zdj96hbpbiQk+rozjT/Pv1WVxNv+zxRyDScZFd68CM2P4yOB8wZ5kquwEpZveeCutWiHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729036990; c=relaxed/simple;
	bh=EsQUlY0iIVqr49EUFFG3JKe16MmGbUs8PhKtWDaafzI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/u15PSmjO/A6xRYQ8+1anKjfxgiTAJoGRIF1nmyIY0zo4LgGVZ5a9p1BGwKv2UDSGaOE5psug8OVx5zvTl2B3Jj5aivEYZPer1IhgcBZdSU2Q/WovEVluGrPrpwBznoK08uq3Zcvr8mfRVbSfsk1O+kHr3gPdEGMWotETgCQRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=q0G8FTHO; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="q0G8FTHO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729036989; x=1760572989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4E+/Rqgrgl4WKr4CdpxCbdJJMyhPANBPQnK9tayaHNI=;
  b=q0G8FTHOHeVVC+spUGv9ZPqHz1JzGBd5KgEWnZoTwwLERNUlK8GufsOE
   YCQx3uioIBt9YA4azYzi+SZd8OKmnMSEIGdSEnW25dlyn4XppOPru+u09
   udNU183jIBpIR4wuWIidUIjJDvtQtr3bF22+lpKAq6KG1TUOtlx6dLz9M
   w=;
X-IronPort-AV: E=Sophos;i="6.11,206,1725321600"; 
   d="scan'208";a="461102459"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 00:03:08 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:12286]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.26:2525] with esmtp (Farcaster)
 id aa6e0dc7-036c-4370-99d9-a7c022c5ce00; Wed, 16 Oct 2024 00:03:08 +0000 (UTC)
X-Farcaster-Flow-ID: aa6e0dc7-036c-4370-99d9-a7c022c5ce00
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 16 Oct 2024 00:03:07 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 16 Oct 2024 00:03:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <danielyangkang@gmail.com>
CC: <alibuda@linux.alibaba.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<guwen@linux.alibaba.com>, <jaka@linux.ibm.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com>,
	<tonylu@linux.alibaba.com>, <wenjia@linux.ibm.com>
Subject: Re: [PATCH v3 2/2 RESEND] resolve gtp possible deadlock warning
Date: Tue, 15 Oct 2024 17:03:00 -0700
Message-ID: <20241016000300.70582-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <c2ac8e30806af319eb96f67103196b7cda22d562.1729031472.git.danielyangkang@gmail.com>
References: <c2ac8e30806af319eb96f67103196b7cda22d562.1729031472.git.danielyangkang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Daniel Yang <danielyangkang@gmail.com>
Date: Tue, 15 Oct 2024 15:48:05 -0700
> From: Daniel Yang <danielyangkang@gmail.com>
> 
> Moved lockdep annotation to separate function for readability.
> 
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> Reported-by: syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com

This tag is bogus, why not squash to patch 1 ?

Also, patch 1 needs Fixes: tag.
