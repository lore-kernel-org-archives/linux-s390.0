Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85943C001DC
	for <linux-s390@archiver.kernel.org>; Wed, 26 Jul 2023 06:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjGZGTK (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 26 Jul 2023 02:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjGZGSp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 26 Jul 2023 02:18:45 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DF51BFA
        for <linux-s390@vger.kernel.org>; Tue, 25 Jul 2023 23:18:43 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q6GPJN028279;
        Wed, 26 Jul 2023 06:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=uWkUwfcERhB3oTTEAxNoldZAxz4r3AKVMjXN52IqwyE=;
 b=CyTOSscafr830zq3jfblolMuv4wLzpENKUycDvrY1uXYORU36QsN0hOb6RQ4Iv3xj8B2
 iMi285pPrrPG9Gsr0BO4NmlnzNB0FKKxG1FBvUlMvWobI4nPQGecw8qPy3IqTMZObX/D
 3RJeBCWHj2n6ic4ChoSar12WGxD3HcVUvR7y0pfOEPtE4oxqpRTg0JoNPhMW64UQtiv6
 6ai4pFnUPHrNfOIxg4bmkRopm0a9vV0ruhqzApqwcjap486X6156lOkmfZMEDaI6/L3Z
 fkGimPTaBB6Z7A/40kIa6HqEF503oMM1ZjSiOKGoQerZ/rU58/8TjEBnpS8/A/t3n/+4 aw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s2wqmgfmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 06:18:39 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q5G0pL014374;
        Wed, 26 Jul 2023 06:18:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0sty2s1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 06:18:38 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36Q6IZKS44565054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 06:18:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 432822004B;
        Wed, 26 Jul 2023 06:18:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1042420043;
        Wed, 26 Jul 2023 06:18:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 26 Jul 2023 06:18:34 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org
Subject: [PATCH] s390/ftrace: use la instead of aghik in return_to_handler()
Date:   Wed, 26 Jul 2023 08:18:34 +0200
Message-Id: <20230726061834.1300984-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oDu-tDqXmsqmdbxhSqXhr4NBhemqw9_t
X-Proofpoint-GUID: oDu-tDqXmsqmdbxhSqXhr4NBhemqw9_t
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_14,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=894 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260053
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Nathan Chancellor reported the following build error when compiling the
kernel with CONFIG_MARCH_Z10=y:

  arch/s390/kernel/mcount.S: Assembler messages:
  arch/s390/kernel/mcount.S:140: Error: Unrecognized opcode: `aghik'

The aghik instruction is only available since z196. Use the la instruction
instead which is available for all machines.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/all/20230725211105.GA224840@dev-arch.thelio-3990X
Fixes: 1256e70a082a ("s390/ftrace: enable HAVE_FUNCTION_GRAPH_RETVAL")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/mcount.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
index d2596e0df6fa..71c5fa05e7f1 100644
--- a/arch/s390/kernel/mcount.S
+++ b/arch/s390/kernel/mcount.S
@@ -137,7 +137,7 @@ SYM_FUNC_START(return_to_handler)
 	lgr	%r1,%r15
 	aghi	%r15,-(STACK_FRAME_OVERHEAD+__FGRAPH_RET_SIZE)
 	stg	%r1,__SF_BACKCHAIN(%r15)
-	aghik	%r3,%r15,STACK_FRAME_OVERHEAD
+	la	%r3,STACK_FRAME_OVERHEAD(%r15)
 	stg	%r1,__FGRAPH_RET_FP(%r3)
 	stg	%r2,__FGRAPH_RET_GPR2(%r3)
 	lgr	%r2,%r3
-- 
2.39.2

