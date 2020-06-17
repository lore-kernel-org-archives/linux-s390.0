Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726540AbgFQOzE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Jun 2020 10:55:04 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 0/2] s390/qeth: fixes 2020-06-17
Date: Wed, 17 Jun 2020 16:54:51 +0200
Message-Id: <20200617145453.61382-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Dave & Jakub,

please apply the following patch series for qeth to netdev's net tree.

The first patch fixes a regression in the error handling for a specific
cmd type. I have some follow-ups queued up for net-next to clean this
up properly...

The second patch fine-tunes the HW offload restrictions that went in
with this merge window. In some setups we don't need to apply them.

Thanks,
Julian

Julian Wiedmann (2):
  s390/qeth: fix error handling for isolation mode cmds
  s390/qeth: let isolation mode override HW offload restrictions

 drivers/s390/net/qeth_core_main.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

-- 
2.17.1
