Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40858 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729562AbgKIH5V (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Nov 2020 02:57:21 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net v2 0/2] net/iucv: fixes 2020-11-09
Date: Mon,  9 Nov 2020 08:57:04 +0100
Message-Id: <20201109075706.56573-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hi Jakub,

please apply the following patch series to netdev's net tree.

One fix in the shutdown path for af_iucv sockets. This is relevant for
stable as well.
Also sending along an update for the Maintainers file.

v1 -> v2: use the correct Fixes tag in patch 1 (Jakub)

Thanks,
Julian

Ursula Braun (2):
  net/af_iucv: fix null pointer dereference on shutdown
  MAINTAINERS: remove Ursula Braun as s390 network maintainer

 MAINTAINERS        | 3 ---
 net/iucv/af_iucv.c | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

-- 
2.17.1
