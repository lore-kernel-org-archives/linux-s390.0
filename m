Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726059AbgESTKX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 May 2020 15:10:23 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/5] net/iucv: updates 2020-05-19
Date: Tue, 19 May 2020 21:10:07 +0200
Message-Id: <20200519191012.65438-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave & Jakub,

please apply the following patch series for iucv to netdev's net-next
tree.

s390 dropped its support for power management, this removes the relevant
iucv code. Also, some easy cleanups I found mouldering in an old branch.

Thanks,
Julian

Julian Wiedmann (5):
  net/iucv: remove pm support
  net/af_iucv: remove pm support
  net/af_iucv: replace open-coded U16_MAX
  net/af_iucv: remove a redundant zero initialization
  net/af_iucv: clean up function prototypes

 include/net/iucv/af_iucv.h |   8 --
 net/iucv/af_iucv.c         | 253 ++++++++-----------------------------
 net/iucv/iucv.c            | 188 ---------------------------
 3 files changed, 54 insertions(+), 395 deletions(-)

-- 
2.17.1
