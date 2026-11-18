Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794977516;
	b=4A3JVRI3515kDUNy4DmXAWkkcBkSkWhFYr+SNZo9U+MF3rKIeMJfl5PN+7ZfmAjvAfwb
	 JCv430CAczuLcJR6YXmsxr5lyL2EuJGsGIY2wkNKwiNHnL1WFMifJXZNxSC8LOWQ7rjC6
	 MSGwwD04sSnw85hkT73/TJWMmr4ARm00ZIiFpxHA4vVfTnHKEsv6x15CY2q6aVmGMtwOX
	 fi+PgE8abCp7CLMCJAxvs+2JAT4E6pXGcfO4mXDS2qMrLf00YyWIqYu3eh1itsJ+D836d
	 CVa++4zcMG2rfB8g8Rsg4z3IeeekWpZEUY9ORiMhv7vpX+NFQe2Rdz2npIOJ7kK1QnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794977516;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=zKnXRqX2v+aT3gYlNIv7K2osO8pX6mgOgfzS7UFgtqc=;
	b=Rq10/kDxTfRhVLgfJZgfNgXxbsxk6kXF3WJBytNVhcekwfZlu+j4XgNAiGwm8aJpmhzh
	 7MUJgb1eA4VAlozA6a2CU72pEXN+gWxr8spmN0fINMDJFIetGm5SILShiVy1i+qs5QP7V
	 vJak8E9uqAqBCNgEXxLqoqwSLnCiILcJjpQ5QAxP4WT+mZ0YDcbv6NwvDQbxopNljN4Qq
	 AftkbgoJmYtLt5388YDfOb+vIGgmrYdUs19NHzshFwhaxUroGvuq4deNoJ/NsKBiNZjM6
	 XZVnC4KyJXn40t672yNRdFPMo79AFBQXi16jEm4QGQyrLfHs53Ses4h+Xc9mmldRjGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fuLZ5nSZ;
	arc=none smtp.remote-ip=91.218.175.41
Received: from mta0.migadu.com (out-41.mta0.migadu.com [91.218.175.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53345606A32F
	for <linux-s390@vger.kernel.org>; Wed, 18 Nov 2026 04:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53345606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fuLZ5nSZ
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5mvBnQTVoVHqhHsi3OfdVHP7eNZFTOT0ltruB/HvWm8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794977513; v=1; x=1795582313;
 b=fuLZ5nSZFMJVVN+PLvCjAN/lSG7vK6WXGu9NW8aTIyTwA0Z9SzfVxr5YXXfNxgU/c2hnB2ZU
 WESNvtOAFFRAlfXYkPsiVvn1TRoH0eBa+z0afaEDChozcP9W/ZcByOyzBPC0eQHcroUA7TKon+B
 Uw1bcSf5cQRrTHl9uQ/JTEp8=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e2317ad5862a2ec7;
	Wed, 18 Nov 2026 04:51:53 +0000
X-Mizu-Trace-ID: e2317ad5862a2ec7
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Allison Henderson <achender@kernel.org>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-s390@vger.kernel.org
Subject: [PATCH net-next v2 0/5] net: annotate data-races around sysctl knobs
Date: Wed, 18 Nov 2026 12:51:15 +0800
Message-ID: <20261118045137.174026-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series annotates data races around a few sysctl knobs under net/.
They are read without any lock while their handlers update them with
WRITE_ONCE(), so add READ_ONCE() to the readers, and WRITE_ONCE() to the
handlers and netlink paths that store to the same fields with plain
writes.

There are no Fixes tags. Done one knob per patch this would be well over
a hundred commits, so I grouped them by subsystem and feature instead to
keep the review manageable. If maintainers prefer, I can split it up
further with a Fixes tag on each one, as several smaller series.

No functional change.

v2:
 - only resend the patches that got a Reviewed-by or Acked-by, with the
   tags picked up; they are unchanged
 - netfilter patches are moved to a separate series for nf-next (Simon)
 - calipso is sent separately as a fix
 - the other patches had no review yet and are left out for now
v1: https://lore.kernel.org/netdev/20261109025425.328445-1-jiayuan.chen@linux.dev/

Jiayuan Chen (5):
  inet: frags: annotate data-races around fqdir->timeout and
    fqdir->max_dist
  ipv6: annotate data-races around icmpv6 reply sysctls
  mptcp: annotate data-races around pernet sysctls
  rds: annotate data-races around core rds sysctls
  net/smc: annotate data-races around smc sysctls

 include/net/ipv6.h       |  2 +-
 net/ipv4/inet_fragment.c |  2 +-
 net/ipv4/ip_fragment.c   |  6 +++---
 net/ipv6/icmp.c          | 10 +++++-----
 net/mptcp/ctrl.c         | 18 +++++++++---------
 net/rds/recv.c           |  2 +-
 net/rds/send.c           |  8 ++++----
 net/rds/threads.c        |  4 ++--
 net/smc/af_smc.c         |  8 ++++----
 net/smc/smc_clc.c        |  8 ++++----
 net/smc/smc_core.c       |  2 +-
 net/smc/smc_tx.c         |  2 +-
 12 files changed, 36 insertions(+), 36 deletions(-)

-- 
2.43.0

