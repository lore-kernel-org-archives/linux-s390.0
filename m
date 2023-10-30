Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4E3C4167B
	for <linux-s390@archiver.kernel.org>; Mon, 30 Oct 2023 16:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjJ3QEL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 30 Oct 2023 12:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbjJ3QEI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 30 Oct 2023 12:04:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206B7DF;
        Mon, 30 Oct 2023 09:04:06 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UFvnZZ014560;
        Mon, 30 Oct 2023 16:03:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=P15pKw3iO8U9apMdKV6iYWUbiOqdU/+zz7bKOfbipt0=;
 b=GYxQY4ivH25zAwaiKAQYsMun1MgCSvuUT8XAtvNPn2514W71tF3j7ut20bwPagPy+GQM
 0NjIoBtAeTWUMv+qZ0UX9udok5bZvy9a/gfoDbDf8DSuEVRILFvrcSnUy6Mt1A5rx+4h
 uPjvVQKybck5q6oUsdnUspdNozCZGI5WSBJIw/d0jhTPl4c5iYr//SmKOQFXDx1dd3LZ
 e0kN5GnZRI3YQoSLvlSk4krpC0B65xeIRchGf8d8xKnO1qRBdSYBLuJxKoKDxpTMq9SG
 gLgGpB0nmKR6IoiizDWV6l6jJ5iEdHiIMUxkoYYUXssWEqQgf428xkEUJQ1VNDYpj6kr jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2ex09cea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 16:03:57 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39UFpapb025242;
        Mon, 30 Oct 2023 16:03:57 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2ex09cdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 16:03:57 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39UE5BHB020321;
        Mon, 30 Oct 2023 16:03:56 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1d0yac1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 16:03:55 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39UG3qsU1245728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 16:03:52 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B03482004B;
        Mon, 30 Oct 2023 16:03:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C7E220043;
        Mon, 30 Oct 2023 16:03:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 30 Oct 2023 16:03:52 +0000 (GMT)
From:   Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        =?UTF-8?q?Nico=20B=C3=B6hr?= <nrb@linux.ibm.com>
Cc:     Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Jones <andrew.jones@linux.dev>,
        Nikos Nikoleris <nikos.nikoleris@arm.com>, kvm@vger.kernel.org,
        Colton Lewis <coltonlewis@google.com>,
        linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Ricardo Koller <ricarkol@google.com>,
        Thomas Huth <thuth@redhat.com>
Subject: [kvm-unit-tests PATCH v3 04/10] s390x: topology: Fix parsing loop
Date:   Mon, 30 Oct 2023 17:03:43 +0100
Message-Id: <20231030160349.458764-5-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231030160349.458764-1-nsg@linux.ibm.com>
References: <20231030160349.458764-1-nsg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AC8gdVCjsKUq8T_OgJgIfywxXVjHSTpK
X-Proofpoint-ORIG-GUID: fPBA4dnvOmrFYQxdd4y63CYc8iR4AJ3k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=889 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310240000 definitions=main-2310300124
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Without a comparison the loop is infinite.

Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---
 s390x/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/s390x/topology.c b/s390x/topology.c
index 032e80dc..c8ad4bcb 100644
--- a/s390x/topology.c
+++ b/s390x/topology.c
@@ -468,7 +468,7 @@ static void parse_topology_args(int argc, char **argv)
 		if (flag[0] != '-')
 			report_abort("Argument is expected to begin with '-'");
 		flag++;
-		for (level = 0; ARRAY_SIZE(levels); level++) {
+		for (level = 0; level < ARRAY_SIZE(levels); level++) {
 			if (!strcmp(levels[level], flag))
 				break;
 		}
-- 
2.41.0

