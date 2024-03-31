Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DB98C1F;
	Sun, 31 Mar 2024 05:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.65.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711863425; cv=none; b=VU5sqT4EZDNDIhhJDcEsRmUyK6xfLEfFs/2kDpHkMaqSndvQee+UlyPyQ9pAlCTr9tUHekrlOAk7/8M9QMn+Ozphl5D0Crk/T6wslqghXq6sMHjNK1LGGJw0FEv37pYGqPXJUMlI2uxvsCPVliyJAlvq+eE2k8E6gnodxx7wMN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711863425; c=relaxed/simple;
	bh=hpjQo0KhGps9/VGEa1fBWiX7PTL1ct+EPAiqsmg8ihw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hcedxsIgUnex9W5qPm6h4B/RVb3VxToczR7yicqDvE04hFwnPDaShPwcd+Ap0ehUo5OvEBExAfFUa3CLmV5Duc+um0+KAyFF12SzvgSkjRfwVbj5m3f3/ph7rGN1Efe8WS1eBCTb1Ana7TRsY8URmqHoWvrCFrglxe8L6pfV0ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp82t1711863322twj5416u
X-QQ-Originating-IP: 0rkeoEkh2HalCCEoJiJGaDTGlkyTZd6PhYBWh2BWtmk=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 31 Mar 2024 13:35:20 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: znfcQSa1hKbRHAcLRCv1mDsVAG5bHbuYuRsE+M8xuRHH6h2E+rlsyWbE1dXtv
	UQZFNYuvIRN7KJrZoV1geRqrKHmHP4N5lK23noYgSby8/HP6Uh+yb0lP0JrpeYiYuGmJDDo
	bQIsdMn0ZZLIdPi7rOkxDKv/Lon9JsOwUgzfj4hZgCMnrV/viuHyuqhnra9S7sz5rIyd2GA
	YqKJbGSTX0jZxt7WDMzxgMXgKg/TFUGjUdZqIE8ObYckJvG7rSuCw7zD2WXtT4Re1JR+1dG
	2B4c9DKNZJ4mzNCzpbR978qR6wHulvH1ysDRAD6aD5b1sT8kAtQgke+IrvxML26dgr6IU3q
	upE7QoPxntRWx9ZYSOipUsBFfxz7gRbhUDvDRYi7cH7UTiQDaY=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 1667159541051008534
From: Dawei Li <dawei.li@shingroup.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ioana.ciornei@nxp.com,
	wintera@linux.ibm.com,
	twinkler@linux.ibm.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH net-next v2 0/2] Avoid explicit cpumask var allocation on stack
Date: Sun, 31 Mar 2024 13:34:39 +0800
Message-Id: <20240331053441.1276826-1-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi,

This is v2 of previous series[1] about cpumask var on stack for net
subsystem.

Change since v1:
- For iucv_setmask_up() which returns void to caller, just make cpumask
  var static which is protected by global lock iucv_register_mutex. [Eric]

[1] v1: 
https://lore.kernel.org/lkml/20240329105610.922675-1-dawei.li@shingroup.cn/

Dawei Li (2):
  net/iucv: Avoid explicit cpumask var allocation on stack
  net/dpaa2: Avoid explicit cpumask var allocation on stack

 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  | 14 ++++++----
 net/iucv/iucv.c                               | 26 +++++++++++++------
 2 files changed, 27 insertions(+), 13 deletions(-)

Thanks,

    Dawei

-- 
2.27.0

