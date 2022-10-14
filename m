Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77992C433FE
	for <linux-s390@archiver.kernel.org>; Fri, 14 Oct 2022 14:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiJNO0T (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 14 Oct 2022 10:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJNO0S (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Oct 2022 10:26:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA7A155DA1
        for <linux-s390@vger.kernel.org>; Fri, 14 Oct 2022 07:26:18 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29ED6rjl032103;
        Fri, 14 Oct 2022 14:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=L6BeFL5wVFsB6jItEFwXUUiwnfVZ3ajPya+hJFicxdM=;
 b=eKfuaBSrvLh7VKDSlp71z22hFdmJ9WydCPQW449gBtAze54KxMqq90ge+2jPBJ/OZD2O
 FocPNe57CqsaIwsie6deiMRetOp8waGw6ct2PQSFmqyDxn522mse+yqMT8wvqgTsqo2+
 kFS4HaEiHb4yi06AbiqXVvQjIqPKamKuIJD0Jy2I32hgsa/l0tLRY2+HO7tQEgTmtKaW
 qfk3og4MTh5mPjdP0+EEKpFX4U0NmNTCIgKSnh7BnUsDnifKfSOhrRV+POII10iTYcex
 OhkM6uyTf1lnDXMUAnu+Sy22fd6NU7/IaZXkfQN0VJHmxcdPbAIgOkGI8/OrOrRhsV9u iQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k6nax3ags-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 14:26:17 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29EDjL0c002822;
        Fri, 14 Oct 2022 14:26:16 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k6nax3afn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 14:26:16 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29EELDfG008070;
        Fri, 14 Oct 2022 14:26:14 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3k30u9q6nj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 14:26:14 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29EEQB9u28902080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 14:26:12 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFAEEA4055;
        Fri, 14 Oct 2022 14:26:11 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE4F3A4040;
        Fri, 14 Oct 2022 14:26:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 14 Oct 2022 14:26:11 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
        id 8DF09E0221; Fri, 14 Oct 2022 16:26:11 +0200 (CEST)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     linux-s390@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH] s390/cpuinfo: prevent warning when reading /proc/cpuinfo
Date:   Fri, 14 Oct 2022 16:26:11 +0200
Message-Id: <20221014142611.1145407-1-agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -jeEWt-KhpYKLGu9gh2Juhk34unNVvfb
X-Proofpoint-ORIG-GUID: zJwggHm6dx8yNOoSN7KWNXYW0D3uw6Ti
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_08,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 clxscore=1011 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140079
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Commit 78e5a3399421 ("cpumask: fix checking valid cpu range") has
started issuing warnings when reading /proc/cpuinfo and config
DEBUG_PER_CPU_MAPS is enabled. Avoid calling cpumask_next() with
the cpu index equal to nr_cpu_ids - 1 and ensure no warning is
generated.

Link: https://lore.kernel.org/r/20221012081905.1800640-1-ajones@ventanamicro.com
Reported-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/kernel/processor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index a194611ba88c..908a0be900ea 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -334,6 +334,8 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 
 static inline void *c_update(loff_t *pos)
 {
+	if (*pos >= nr_cpu_ids)
+		return NULL;
 	if (*pos)
 		*pos = cpumask_next(*pos - 1, cpu_online_mask);
 	else
-- 
2.34.1

