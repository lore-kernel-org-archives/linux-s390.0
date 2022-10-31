Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FB0FA3740
	for <linux-s390@archiver.kernel.org>; Mon, 31 Oct 2022 12:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiJaMfR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 31 Oct 2022 08:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJaMfQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 31 Oct 2022 08:35:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B436E0BE
        for <linux-s390@vger.kernel.org>; Mon, 31 Oct 2022 05:35:12 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VCHPco004577;
        Mon, 31 Oct 2022 12:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=wCfnS92n/gsV+00cOx3YcrEm7HM8vw8Z+u23nw7dZhs=;
 b=XToOlBZFV0hsdUpwui6iYWXg/xmhqOkUy3I5rdYyeOPelQ76w6jWU7//EPYT+ck/jErg
 +lckk2YAxSVt2SjPiXJgM2Or0gTIA9zSUpk9Xb3moatYFop8Dcxtn6iqE0y+uUO6avw0
 HwuVaTXCBP8NMUCiH5BpKy8WDGYj2YpvQfStWuPrVbSIJooTVdr75UuPAACjRRAZiyPK
 wqwZ1jocwuIpsMVjvqnKAGWR7ReoVzTEf63JX44ah31M2/NnPeQAhRovJLRT8LVrTXtw
 foRLEwbvt1kx3T+Jz2B+oi/6ROIB/jq8ntmvpd11jw8cMpgHYxEjk3nSCluYlcRfgqIN Jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kje84gggn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 12:35:03 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29VCJjrT015231;
        Mon, 31 Oct 2022 12:35:03 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kje84ggfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 12:35:02 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29VCMefF000549;
        Mon, 31 Oct 2022 12:35:00 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3kgueja69v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 12:35:00 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29VCYvOp34472606
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 12:34:57 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C9F042045;
        Mon, 31 Oct 2022 12:34:57 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1150A4203F;
        Mon, 31 Oct 2022 12:34:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 31 Oct 2022 12:34:57 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH] scripts/min-tool-version.sh: raise minimum clang version to 15.0.0 for s390
Date:   Mon, 31 Oct 2022 13:34:56 +0100
Message-Id: <20221031123456.3872220-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2zBzafdfKc5WaqDzgVsice-tQaqNAdzA
X-Proofpoint-ORIG-GUID: gsWiCZEf86g7uHe6hl8_1PmzzBrbtg7E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_15,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015 phishscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210310079
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Before version 14.0.0 llvm's integrated assembler may silently
generate corrupted code on s390. See e.g. commit e9953b729b78
("s390/boot: workaround llvm IAS bug") for further details.

While there have been workarounds applied for all known existing
locations, there is nothing that prevents that new code with
problematic patterns will be added.

Therefore raise the minimum clang version to 15.0.0. Note that llvm
commit e547b04d5b2c ("[SystemZ] Bugfix for symbolic displacements."),
which is included in 15.0.0, fixes the broken code generation.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 scripts/min-tool-version.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index b6593eac5003..201bccfbc678 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -25,7 +25,7 @@ icc)
 	;;
 llvm)
 	if [ "$SRCARCH" = s390 ]; then
-		echo 14.0.0
+		echo 15.0.0
 	else
 		echo 11.0.0
 	fi
-- 
2.34.1

