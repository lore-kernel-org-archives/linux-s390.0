Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23D1EB64D9
	for <linux-s390@archiver.kernel.org>; Tue,  4 Jul 2023 14:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjGDOlz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 4 Jul 2023 10:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGDOlz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Jul 2023 10:41:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F42B2;
        Tue,  4 Jul 2023 07:41:53 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 364EUDT6015334;
        Tue, 4 Jul 2023 14:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=nChxNNSHb/syOCZ/ct/RYuUp1fIn+QTX1UNXCOOtrQE=;
 b=ORX0qPnBWrvDuZfUM2MYqPjy30NvJoB6xVYWhCSEhDkqPkf8WPHhdviXZFf2NX9NNLJd
 nXbbc/Yq9X09tKR47xthzezHtgQnZn7exhgdVeQDYYPrRkO+KTkT5efBxvWX25Nwj8T6
 pJReDdT15VybjLwmhNbDEYl3uLKgKWWbYJKyS/GlQM/W9cBe0tj8TBzQD6ztbGOOI4Mg
 z8qoV9iRpD5m6VTMEDuuN5EeibeyGgCenRsgnhbkJOsqkiTA/bWutXIMYRMO/nJ5EOgh
 ChaUu7EKboO/xe6s8vqr3zdAQdWXxO1mdt9NxtXAYL52Eao/eqemacUK8axG2BRuvIL3 /w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmn840bkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jul 2023 14:41:49 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 364EXEfj025123;
        Tue, 4 Jul 2023 14:41:45 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmn840bbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jul 2023 14:41:43 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 364DOQXQ020983;
        Tue, 4 Jul 2023 14:41:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3rjbs4sgsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jul 2023 14:41:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 364EfXqx40895174
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jul 2023 14:41:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76A0F20040;
        Tue,  4 Jul 2023 14:41:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60FEA20043;
        Tue,  4 Jul 2023 14:41:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  4 Jul 2023 14:41:33 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
        id DB779E092F; Tue,  4 Jul 2023 16:41:32 +0200 (CEST)
From:   Alexandra Winter <wintera@linux.ibm.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Subject: [PATCH net] s390/qeth: Fix vipa deletion
Date:   Tue,  4 Jul 2023 16:41:21 +0200
Message-Id: <20230704144121.3737032-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: l0pHQOnuZXIDIGiVAi2gIaQIiREUWrZP
X-Proofpoint-GUID: _C5bJKoqmorlVZrgNTNytMccNNMblXVu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_09,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0
 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040125
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Thorsten Winkler <twinkler@linux.ibm.com>

Change boolean parameter of function "qeth_l3_vipa_store" inside the
"qeth_l3_dev_vipa_del4_store" function from "true" to "false" because
"true" is used for adding a virtual ip address and "false" for deleting.

Fixes: 2390166a6b45 ("s390/qeth: clean up L3 sysfs code")

Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Signed-off-by: Thorsten Winkler <twinkler@linux.ibm.com>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_l3_sys.c b/drivers/s390/net/qeth_l3_sys.c
index 9f90a860ca2c..a6b64228ead2 100644
--- a/drivers/s390/net/qeth_l3_sys.c
+++ b/drivers/s390/net/qeth_l3_sys.c
@@ -625,7 +625,7 @@ static QETH_DEVICE_ATTR(vipa_add4, add4, 0644,
 static ssize_t qeth_l3_dev_vipa_del4_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
-	return qeth_l3_vipa_store(dev, buf, true, count, QETH_PROT_IPV4);
+	return qeth_l3_vipa_store(dev, buf, false, count, QETH_PROT_IPV4);
 }
 
 static QETH_DEVICE_ATTR(vipa_del4, del4, 0200, NULL,
-- 
2.39.2

