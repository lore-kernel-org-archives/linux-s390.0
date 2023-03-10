Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAEEC64EC4
	for <linux-s390@archiver.kernel.org>; Fri, 10 Mar 2023 13:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCJNCp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 10 Mar 2023 08:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjCJNCo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 10 Mar 2023 08:02:44 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8132710E257
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 05:02:43 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ACkhRC017809
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=tVSiyzvav82MvRWGiYZ5D3DqqwUsfIL34rIq1e6NsRk=;
 b=Wsv9cjFpbrUFCkAr8LFnngEhi15Mr7Pdyvuu7kIlH7dRkZ+OsiqH3RGPDP3//MdT/rdX
 jtW0tVF8TiGogXHFauqGP/zkDdFWJtJFmypznXa4JNUbartoJ5WKUxSYC6HN3kedxvZ9
 6xCtpcXXfjD2uMq9ASsCt7pM+CvrAC1Z96Ij6CdY07RlJ9tcb43WflpKME1SiJwV+dIM
 1rcostH3KUSMwunRecmZielqO51C+YArctmKt36EJB07GAV+VI4UM8Fku6qDydjccKLV
 2l3yYNjLKGZbNEVTMW7FwYW4JJq7BEbbpvTsxnmEhz3fQODWy/P+QxhwveCd08oA54Lq ZQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p84up8bxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:02:43 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32A8pIS2015924
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:02:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3p6g75avnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:02:40 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32AD2bbp590376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 13:02:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 125412004D;
        Fri, 10 Mar 2023 13:02:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC58420043;
        Fri, 10 Mar 2023 13:02:36 +0000 (GMT)
Received: from t35lp63.lnxne.boe (unknown [9.152.108.100])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Mar 2023 13:02:36 +0000 (GMT)
From:   Nico Boehr <nrb@linux.ibm.com>
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, mhartmay@linux.ibm.com
Subject: [PATCH v2 0/1] s390: ipl: fix physical-virtual confusion for diag308
Date:   Fri, 10 Mar 2023 14:02:35 +0100
Message-Id: <20230310130236.106661-1-nrb@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SSQsCvoU6GxGcEzKAKfNwUZn32vsdnIs
X-Proofpoint-GUID: SSQsCvoU6GxGcEzKAKfNwUZn32vsdnIs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_03,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 mlxlogscore=474
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100104
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

v2:
---
* add special handling for addr NULL (thanks Alexander)



Nico Boehr (1):
  s390: ipl: fix physical-virtual confusion for diag308

 arch/s390/kernel/ipl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.39.1

