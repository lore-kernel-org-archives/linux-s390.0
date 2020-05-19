Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22648 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726348AbgESTJO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 May 2020 15:09:14 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 0/2] s390/net: updates 2020-05-19
Date: Tue, 19 May 2020 21:09:02 +0200
Message-Id: <20200519190904.64217-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave & Jakub,

please apply the following patch series to netdev's net-next tree.

s390 dropped its support for power management, this removes the relevant
code from the s390 network drivers.

Thanks,
Julian

Julian Wiedmann (2):
  s390/net: remove pm ops from ccwgroup drivers
  s390/net: remove pm support from iucv drivers

 arch/s390/include/asm/ccwgroup.h  |  10 ---
 drivers/s390/net/ctcm_main.c      |  40 ------------
 drivers/s390/net/lcs.c            |  59 -----------------
 drivers/s390/net/netiucv.c        | 104 +-----------------------------
 drivers/s390/net/qeth_core_main.c |  31 ---------
 drivers/s390/net/smsgiucv.c       |  65 -------------------
 6 files changed, 1 insertion(+), 308 deletions(-)

-- 
2.17.1
