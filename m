Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46286 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729681AbgEMHmo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 May 2020 03:42:44 -0400
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 0/2] s390/net: updates 2020-05-13
Date: Wed, 13 May 2020 09:42:28 +0200
Message-Id: <20200513074230.967-1-ubraun@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, kgraul@linux.ibm.com, weiyongjun1@huawei.com, ubraun@linux.ibm.com

Dave,

please apply the fix from Wei Yongjun to netdev's net tree and
add Karsten Graul as co-maintainer for drivers/s390/net.

Thanks, Ursula

Ursula Braun (1):
  MAINTAINERS: add Karsten Graul as S390 NETWORK DRIVERS maintainer

Wei Yongjun (1):
  s390/ism: fix error return code in ism_probe()

 MAINTAINERS                | 1 +
 drivers/s390/net/ism_drv.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.17.1
