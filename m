Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726635AbgBNH7O (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Feb 2020 02:59:14 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01E7sOKQ052166
        for <linux-s390@vger.kernel.org>; Fri, 14 Feb 2020 02:59:13 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y4j88d3jk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 14 Feb 2020 02:59:12 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <kgraul@linux.ibm.com>;
        Fri, 14 Feb 2020 07:59:11 -0000
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 2/2] net/smc: no peer ID in CLC decline for SMCD
Date: Fri, 14 Feb 2020 08:59:00 +0100
In-Reply-To: <20200214075900.31624-1-kgraul@linux.ibm.com>
References: <20200214075900.31624-1-kgraul@linux.ibm.com>
Message-Id: <20200214075900.31624-3-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

Just SMCR requires a CLC Peer ID, but not SMCD. The field should be
zero for SMCD.

Fixes: c758dfddc1b5 ("net/smc: add SMC-D support in CLC messages")
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_clc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 0879f7bed967..86cccc24e52e 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -372,7 +372,9 @@ int smc_clc_send_decline(struct smc_sock *smc, u32 peer_diag_info)
 	dclc.hdr.length = htons(sizeof(struct smc_clc_msg_decline));
 	dclc.hdr.version = SMC_CLC_V1;
 	dclc.hdr.flag = (peer_diag_info == SMC_CLC_DECL_SYNCERR) ? 1 : 0;
-	memcpy(dclc.id_for_peer, local_systemid, sizeof(local_systemid));
+	if (smc->conn.lgr && !smc->conn.lgr->is_smcd)
+		memcpy(dclc.id_for_peer, local_systemid,
+		       sizeof(local_systemid));
 	dclc.peer_diagnosis = htonl(peer_diag_info);
 	memcpy(dclc.trl.eyecatcher, SMC_EYECATCHER, sizeof(SMC_EYECATCHER));
 
-- 
2.17.1
