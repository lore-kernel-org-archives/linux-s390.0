Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13514 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726067AbgENLpY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 14 May 2020 07:45:24 -0400
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 1/1] MAINTAINERS: another add of Karsten Graul for S390 networking
Date: Thu, 14 May 2020 13:45:12 +0200
Message-Id: <20200514114512.101771-1-ubraun@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com

Complete adding of Karsten as maintainer for all S390 networking
parts in the kernel.

Cc: Julian Wiedmann <jwi@linux.ibm.com>
Acked-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 85894787825e..391e7eea6a3e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14655,6 +14655,7 @@ F:	net/iucv/
 
 S390 NETWORK DRIVERS
 M:	Julian Wiedmann <jwi@linux.ibm.com>
+M:	Karsten Graul <kgraul@linux.ibm.com>
 M:	Ursula Braun <ubraun@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
-- 
2.17.1
