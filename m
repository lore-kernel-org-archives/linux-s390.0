Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398DC13A89D;
	Thu, 15 Feb 2024 20:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708028206; cv=none; b=QnjxWdqm7IdNmf3O6/TKg9GZ13/FPZvVjN8eZQr7pRTqDdY0NZGemf9SFEoo8B0ASrPDiQItCU+6hAclDA7KKcs5NDm3uTO8SXCwKacUqiPK+lV5/4SHZlLh8wElJNxKDIZ9wn+vvW38LHjeHwTyWGuUxnbC7Zcg9de3ONr3KbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708028206; c=relaxed/simple;
	bh=qEoishFH9LSRy8HKcQT4KXqD7rpsFJk2tkkb37zTSQg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdhnNvI6XpXlXPt3JwczEBm4C1DCC1KLVE52fWIMkDED5/GcGw8Q1vxuFLeGDSgmFABsGBKQ96fFZbfIWz53qicrgQZrFDlm5M9gFmgdSySDd3xM3bn2bV3nefF+rF12H8Yn46JKf7ldcCJmhjyB/PABljDQH/OuRhGuvsv9tZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=RWejxXsq; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RWejxXsq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708028205; x=1739564205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YBjtAKZ77n9OzAqyM18gje3GFkDj2C2xPunRe3LSwdE=;
  b=RWejxXsq9zUWRFHl4oHihpRhXJ39V1A90fmfOnqT/8UtLAlsykdRiu6d
   1XDCXlznSjj3F/cC5XwlfkjBiqGeI/dha7SYfa2aSfnQyWzohmmxJsYBs
   2g+mZqorBBJ+H3ixBW1Y3rIfoe2jTi7NsI4EJyQ4rz5I2/8gJa8vpFSaL
   E=;
X-IronPort-AV: E=Sophos;i="6.06,162,1705363200"; 
   d="scan'208";a="66349554"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 20:16:42 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:14292]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.209:2525] with esmtp (Farcaster)
 id 1a26d7d8-1842-4416-a8a6-b81504bdf866; Thu, 15 Feb 2024 20:16:42 +0000 (UTC)
X-Farcaster-Flow-ID: 1a26d7d8-1842-4416-a8a6-b81504bdf866
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 20:16:38 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Thu, 15 Feb 2024 20:16:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ncardwell@google.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <jaka@linux.ibm.com>,
	<jonesrick@google.com>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <linux-s390@vger.kernel.org>, <martineau@kernel.org>,
	<matttbe@kernel.org>, <mptcp@lists.linux.dev>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <soheil@google.com>, <wenjia@linux.ibm.com>,
	<ycheng@google.com>
Subject: Re: [PATCH v1 net-next] net: Deprecate SO_DEBUG and reclaim SOCK_DBG bit.
Date: Thu, 15 Feb 2024 12:16:27 -0800
Message-ID: <20240215201627.14449-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CADVnQykqkpNTfO30_aswZEaeSkdu5YNuKag++h-RSguALdeohw@mail.gmail.com>
References: <CADVnQykqkpNTfO30_aswZEaeSkdu5YNuKag++h-RSguALdeohw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 15 Feb 2024 12:57:35 -0700
> On Tue, Feb 13, 2024 at 3:32 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > Recently, commit 8e5443d2b866 ("net: remove SOCK_DEBUG leftovers")
> > removed the last users of SOCK_DEBUG(), and commit b1dffcf0da22 ("net:
> > remove SOCK_DEBUG macro") removed the macro.
> >
> > Now is the time to deprecate the oldest socket option.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> 
> I would like to kindly implore you to please not remove the
> functionality of the SO_DEBUG socket option. This socket option is a
> key mechanism that the Google TCP team uses for automated testing of
> Linux TCP, including BBR congestion control.
> 
> Widely used tools like netperf allow users to enable the SO_DEBUG
> socket option via the command line (-g in netperf). Then debugging
> code in the kernel can use the SOCK_DBG bit to decide whether to take
> special actions, such as logging debug information, which can be used
> to generate graphs or assertions about correct internal behavior. For
> example, the transperf network testing tool that our team open-sourced
> - https://github.com/google/transperf - uses the netperf -g/SO_DEBUG
> mechanism to trigger debug logging that we use for testing,
> troubleshooting, analysis, and development.
> 
> The SO_DEBUG mechanism is nice in that it works well no matter what
> policy an application or benchmarking tool uses for choosing other
> attributes (like port numbers) that could conceivably be used to point
> out connections that should receive debug treatment. For example, most
> benchmarking or production workloads will effectively end up with
> random port numbers, which makes port numbers hard to use  for
> triggering debug treatment.
> 
> This mechanism is very simple and battle-tested, it works well, and
> IMHO it would be a tragedy to remove it. It would cause our team
> meaningful headaches to replace it. Please keep the SO_DEBUG socket
> option functionality as-is. :-)
> 
> Thanks for your consideration on this!

Oh that's an interesting use case!
I didn't think of out-of-tree uses.
Sure, I'll drop the patch.

Thanks!
