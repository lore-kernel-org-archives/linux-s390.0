Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A9113A269;
	Thu, 15 Feb 2024 19:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025993; cv=none; b=EvG4JydewjmV0C6gZr6lZEz/mChfFb06mpVTKhzt0vN/gmi5mNbZ4nehlPwz8sgOOlCX828BDTDcEcV8fzs93ExOc5ZQhBU7kpNtRgi7ly5q++8CfvvEuwTHMp9kjcYSE8SLSwIBh4mczbAHgeEr6VpaGpBeZiHT9iAIAdApyK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025993; c=relaxed/simple;
	bh=mxGvIxh+iIRYgYnQjzQuynxi8bB++4HoaOAgzmo40TU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OLgcw6QbP/3JZL4HlOIDGHK3+o6m/Ut6cUgLL7PGZ4SB4dD1XhiaZ1x8szis0a0RcIo6Q9n+YrEHOsgME5V1vFo9ZhuOkluG/NfqLMwrBJg84funcJTrSgnza9WfYKsLA2+l0j0ieg5lGP6+knKdT+ufBZwcCY5Hue6Z1AN+5Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ecZ5V/PC; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ecZ5V/PC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708025993; x=1739561993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gaGiIbS9VmtsGjWz4ZQNSA4F+854Il8c4on0pDDYXtU=;
  b=ecZ5V/PC6mjTh6qjcYHCX6J+y93mmUcCUg2PSN3tnUbGmjc4VvIOm7Y5
   5rpoQywFbdiip12GaW9NiJ5X5v0Izwitnd9RMCzBoiu/w6oCpndceaSyB
   kHGXdekpMCbzSdfLhMDT5RSKN+UPcq9fj/JgtcAO4QUTEQvqE43/yyUec
   0=;
X-IronPort-AV: E=Sophos;i="6.06,162,1705363200"; 
   d="scan'208";a="327275543"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 19:39:44 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:44149]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.119:2525] with esmtp (Farcaster)
 id 788a42ab-f86b-47d6-85ec-cc3a62b19aa8; Thu, 15 Feb 2024 19:39:43 +0000 (UTC)
X-Farcaster-Flow-ID: 788a42ab-f86b-47d6-85ec-cc3a62b19aa8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 19:39:39 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 19:39:35 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <wintera@linux.ibm.com>
CC: <alibuda@linux.alibaba.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<gbayer@linux.ibm.com>, <guwen@linux.alibaba.com>, <jaka@linux.ibm.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<linux-s390@vger.kernel.org>, <martineau@kernel.org>, <matttbe@kernel.org>,
	<mptcp@lists.linux.dev>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<tonylu@linux.alibaba.com>, <wenjia@linux.ibm.com>
Subject: Re: [PATCH v2 net-next] net: Deprecate SO_DEBUG and reclaim SOCK_DBG bit.
Date: Thu, 15 Feb 2024 11:39:28 -0800
Message-ID: <20240215193928.11785-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <020edf58-c839-41c1-a302-4a75423a1761@linux.ibm.com>
References: <020edf58-c839-41c1-a302-4a75423a1761@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Alexandra Winter <wintera@linux.ibm.com>
Date: Thu, 15 Feb 2024 15:14:21 +0100
> On 14.02.24 20:54, Kuniyuki Iwashima wrote:
> > +	case SO_DEBUG:
> > +		/* deprecated, but kept for compatibility */
> > +		if (val && !sockopt_capable(CAP_NET_ADMIN))
> > +			ret = -EACCES;
> > +		return 0;
> 
> Setting ret has no effect here. Maybe you mean something like:
> > +		if (val && !sockopt_capable(CAP_NET_ADMIN))
> > +			return -EACCES;
> > +		return 0;
> 
> or 
> 
> return (val && !sockopt_capable(CAP_NET_ADMIN)) ? -EACCESS : 0;

oops, thanks for catching!
will fix in v3.
