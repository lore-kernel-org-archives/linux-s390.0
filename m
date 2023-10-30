Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D135C0018C
	for <linux-s390@archiver.kernel.org>; Mon, 30 Oct 2023 16:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbjJ3QEN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 30 Oct 2023 12:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbjJ3QEK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 30 Oct 2023 12:04:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D788DB;
        Mon, 30 Oct 2023 09:04:08 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UFermp026986;
        Mon, 30 Oct 2023 16:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DxwOxLTaVIOxqj5rHYlkclCvDezNc43Dr8HDZdxQzik=;
 b=JLFu+/f2mPiVSZobTrG/LgOVqk/4Ph+vaM0a1oQlhsl9WDW7QEvRq/BqxyHjqR0ZSSwp
 Th+V9SJVFw9ngg02U/qRQE1TL0wBWS6fLBnn9x97NCdj/w/LE14WjT/C/J55auLuxyxw
 O/E0CbHjCRyo165R3MfNQ7qbUG4v3TJ5xL9eJddbRn1nUFXUxx6FQkdyptDIW6kwpeGF
 FaQ3mgAmspzG+SfW94GnUBTyKJ/i1Rp2OMTjYT5X0VkYE0oaYtd5w+vFK9jUg7E5qvTH
 /hPZHWmsR/UwjLtXC75qqgggHKK8I6qv2eRCL+aW3RXc7O1s0Q4kddOa6j0yttRF7di1 pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2ex09cdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 16:03:57 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39UFqSDS029007;
        Mon, 30 Oct 2023 16:03:56 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2ex09cd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 16:03:56 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39UDoceJ000597;
        Mon, 30 Oct 2023 16:03:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1cmstea0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 16:03:55 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39UG3qKR1245726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 16:03:52 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C5A820040;
        Mon, 30 Oct 2023 16:03:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 367BA20043;
        Mon, 30 Oct 2023 16:03:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 30 Oct 2023 16:03:52 +0000 (GMT)
From:   Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To:     =?UTF-8?q?Nico=20B=C3=B6hr?= <nrb@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Ricardo Koller <ricarkol@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Jones <andrew.jones@linux.dev>,
        Nikos Nikoleris <nikos.nikoleris@arm.com>,
        Colton Lewis <coltonlewis@google.com>
Subject: [kvm-unit-tests PATCH v3 03/10] s390x: topology: Use function parameter in stsi_get_sysib
Date:   Mon, 30 Oct 2023 17:03:42 +0100
Message-Id: <20231030160349.458764-4-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231030160349.458764-1-nsg@linux.ibm.com>
References: <20231030160349.458764-1-nsg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D7_LiQFYCQeUwliYcCbGnyEoTkA2oZ9G
X-Proofpoint-ORIG-GUID: 26lTKJzBkhHk-vpRg7w0oxSi4Gmv1eyD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=980 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310240000 definitions=main-2310300124
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Actually use the function parameter we're give instead of a hardcoded
access to the static variable pagebuf.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---
 s390x/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/s390x/topology.c b/s390x/topology.c
index 1c4a86fe..032e80dc 100644
--- a/s390x/topology.c
+++ b/s390x/topology.c
@@ -324,7 +324,7 @@ static int stsi_get_sysib(struct sysinfo_15_1_x *info, int sel2)
 
 	report_prefix_pushf("SYSIB");
 
-	ret = stsi(pagebuf, 15, 1, sel2);
+	ret = stsi(info, 15, 1, sel2);
 
 	if (max_nested_lvl >= sel2) {
 		report(!ret, "Valid instruction");
-- 
2.41.0

