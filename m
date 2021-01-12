Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39024 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405066AbhALQYS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Jan 2021 11:24:18 -0500
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 0/2] net/smc: fix out of bound access in netlink interface
Date: Tue, 12 Jan 2021 17:21:20 +0100
Message-Id: <20210112162122.26832-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, netdev@vger.kernel.org, linux-s390@vger.kernel.org

Please apply the following patch for smc to netdev's net tree.

Both patches fix possible out-of-bounds reads. The original code expected
that snprintf() reads len-1 bytes from source and appends the terminating
null, but actually snprintf() first copies len bytes and finally overwrites
the last byte with a null.
Fix this by using memcpy() and terminating the string afterwards.

Guvenc Gulce (1):
  net/smc: use memcpy instead of snprintf to avoid out of bounds read

Jakub Kicinski (1):
  smc: fix out of bound access in smc_nl_get_sys_info()

 net/smc/smc_core.c | 20 +++++++++++++-------
 net/smc/smc_ib.c   |  6 +++---
 net/smc/smc_ism.c  |  3 ++-
 3 files changed, 18 insertions(+), 11 deletions(-)

-- 
2.17.1
