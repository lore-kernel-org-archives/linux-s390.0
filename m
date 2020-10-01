Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26680 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732213AbgJARVg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Oct 2020 13:21:36 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/2] net/iucv: updates 2020-10-01
Date: Thu,  1 Oct 2020 19:21:25 +0200
Message-Id: <20201001172127.98541-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave & Jakub,

please apply the following patch series for iucv to netdev's net-next
tree.

Just two (rare) patches, and both deal with smatch warnings.

Thanks,
Julian

Julian Wiedmann (2):
  net/af_iucv: right-size the uid variable in iucv_sock_bind()
  net/iucv: fix indentation in __iucv_message_receive()

 net/iucv/af_iucv.c | 2 +-
 net/iucv/iucv.c    | 8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

-- 
2.17.1
