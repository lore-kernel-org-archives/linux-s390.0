Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B7D1B012A;
	Wed, 14 Aug 2024 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640920; cv=none; b=k+ChCtHMDq0LSH5ntZxvIJ9LJBott2Ezw/m8VqRsWssHYxmJrkxzDna9KygBmJbqArzwe/9npu27AI5hA5bInkwFeiIRWnfkKosInxn3OJxl8fQh7EK+H7vBX6PWFxBsZT/Xkn+ONW3x4hPwbpmYSfleLCsITxt4HaUt9C/MNxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640920; c=relaxed/simple;
	bh=C1QXmAb5awmgtUbSLUzO4ZM5vxb43iMYoyesmXLeBG8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t+jw57f/+/wQNRQ8hrFIfEmZ5jfTwkV6Jqf7NlHdtwmZBtlGRwa9fQ8K1bcEoFJ5bt3H5r5+ZUOUdRXfKP9IBgm4te9dF8t1wCb6orcmT8mZoho4dCC8CTCbMbLsSKThWVVpBup6SnD3OMX/0Z1Snx6zPzOM4H32EJPrU9cQH+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=u3PeH0rd; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="u3PeH0rd"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723640909; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=7FgzcJpB/wpgVSm+fy4fQ0U0lAMVZkWuLXhsSTMu6ho=;
	b=u3PeH0rd0FQt9s1DydvFDquMWltRQLycOxN0DwTXFysg43az7fu2Rut5kLkiJrlP9hxrP0r+D9MAFVOHpD4IvKvGDR7Dcc2U9cy/owVEAeLEibgC0QB3BSVfAug1xRisbMYss+9Gud38eDZbU5cKOFPIiF4gfaTB7/ArqGv0Vbk=
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WCt6n1E_1723640907)
          by smtp.aliyun-inc.com;
          Wed, 14 Aug 2024 21:08:28 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 0/2] net/smc: introduce ringbufs usage statistics
Date: Wed, 14 Aug 2024 21:08:25 +0800
Message-Id: <20240814130827.73321-1-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we have histograms that show the sizes of ringbufs that ever
used by SMC connections. However, they are always incremental and since
SMC allows the reuse of ringbufs, we cannot know the actual amount of
ringbufs being allocated or actively used.

So this patch set introduces statistics for the amount of ringbufs that
actually allocated by link group and actively used by connections of a
certain net namespace, so that we can react based on these memory usage
information, e.g. active fallback to TCP.

With appropriate adaptations of smc-tools, we can obtain these ringbufs
usage information:

$ smcr -d linkgroup
LG-ID    : 00000500
LG-Role  : SERV
LG-Type  : ASYML
VLAN     : 0
PNET-ID  :
Version  : 1
Conns    : 0
Sndbuf   : 12910592 B    <-
RMB      : 12910592 B    <-

or

$ smcr -d stats
[...]
RX Stats
  Data transmitted (Bytes)      869225943 (869.2M)
  Total requests                 18494479
  Buffer usage  (Bytes)          12910592 (12.31M)  <-
  [...]

TX Stats
  Data transmitted (Bytes)    12760884405 (12.76G)
  Total requests                 36988338
  Buffer usage  (Bytes)          12910592 (12.31M)  <-
  [...]
[...]


Change log:
v3->v2
- use new helper nla_put_uint() instead of nla_put_u64_64bit().

v2->v1
https://lore.kernel.org/r/20240807075939.57882-1-guwen@linux.alibaba.com/
- remove inline keyword in .c files.
- use local variable in macros to avoid potential side effects.

v1
https://lore.kernel.org/r/20240805090551.80786-1-guwen@linux.alibaba.com/

Wen Gu (2):
  net/smc: introduce statistics for allocated ringbufs of link group
  net/smc: introduce statistics for ringbufs usage of net namespace

 include/uapi/linux/smc.h |  6 ++++
 net/smc/smc_core.c       | 68 +++++++++++++++++++++++++++++++++-------
 net/smc/smc_core.h       |  2 ++
 net/smc/smc_stats.c      |  6 ++++
 net/smc/smc_stats.h      | 28 +++++++++++------
 5 files changed, 90 insertions(+), 20 deletions(-)

-- 
2.32.0.3.g01195cf9f

