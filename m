Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63FFEB64D8
	for <linux-s390@archiver.kernel.org>; Wed, 21 Jun 2023 13:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjFUNtm (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 21 Jun 2023 09:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjFUNtj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 21 Jun 2023 09:49:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA2319BD;
        Wed, 21 Jun 2023 06:49:36 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LDlXBT019905;
        Wed, 21 Jun 2023 13:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=JRSjk50Pdm2AxUUYSZo6tju9ZwjTKw3ZzwEqLw8+CLw=;
 b=EMX9C5Jmy8F4CvadAH9VIwCks4hh//5Q0C7TBGZ1M+03fe1cwFS50bHrJHXNSyF3QaqF
 wN7kTDZgp39PXZSsTMGpHkp1YdZxxgBYEkzVlK+ELA+73xGv1prfuq2ZL9RW7n7D+7OY
 6QkoN2gUm/UC1Gx+s1nwvXzYY34+FhwBFa0n58WtOZLE4Fza2baeRW7/XhPFnoXbXc6x
 LPfExrIjIZvT3OSaR1Jv8jSXwhcVdY0LuTIyXjijH9NjJhUkHgtsVRC8q1hKU7DQMhTa
 01QCuU5/foxsBAb/CdC30Cr9MZa58mqbIV5PkHBJD5PARwzXQtAIUFrGyp3avsuLd3H7 QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc2d9g12a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 13:49:33 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35LDld4A020062;
        Wed, 21 Jun 2023 13:49:32 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc2d9g11q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 13:49:32 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35L2m5Cw016438;
        Wed, 21 Jun 2023 13:49:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3r94f5astv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 13:49:30 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35LDnQuN15008288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 13:49:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE39E20049;
        Wed, 21 Jun 2023 13:49:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA9DE20043;
        Wed, 21 Jun 2023 13:49:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Jun 2023 13:49:26 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
        id 7FB4AE09B3; Wed, 21 Jun 2023 15:49:26 +0200 (CEST)
From:   Alexandra Winter <wintera@linux.ibm.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Jules Irenge <jbi.octave@gmail.com>,
        Alexandra Winter <wintera@linux.ibm.com>
Subject: [PATCH net-next v2 2/4] s390/lcs: Convert sprintf to scnprintf
Date:   Wed, 21 Jun 2023 15:49:19 +0200
Message-Id: <20230621134921.904217-3-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230621134921.904217-1-wintera@linux.ibm.com>
References: <20230621134921.904217-1-wintera@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Z2FPLfMs4Rw6v-DIdEAbyYBAji7wLUcv
X-Proofpoint-GUID: eBmhP0syuMESHMTKPxVFTOmwq9K8cuto
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210114
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Thorsten Winkler <twinkler@linux.ibm.com>

This LWN article explains the why scnprintf is preferred over snprintf
in general
https://lwn.net/Articles/69419/
Ie. snprintf() returns what *would* be the resulting length, while
scnprintf() returns the actual length.

Reported-by: Jules Irenge <jbi.octave@gmail.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Thorsten Winkler <twinkler@linux.ibm.com>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/lcs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/lcs.h b/drivers/s390/net/lcs.h
index bd52caa3b11b..a2699b70b050 100644
--- a/drivers/s390/net/lcs.h
+++ b/drivers/s390/net/lcs.h
@@ -21,7 +21,7 @@ do { \
 #define LCS_DBF_TEXT_(level,name,text...) \
 	do { \
 		if (debug_level_enabled(lcs_dbf_##name, level)) { \
-			sprintf(debug_buffer, text); \
+			scnprintf(debug_buffer, sizeof(debug_buffer), text); \
 			debug_text_event(lcs_dbf_##name, level, debug_buffer); \
 		} \
 	} while (0)
-- 
2.39.2

