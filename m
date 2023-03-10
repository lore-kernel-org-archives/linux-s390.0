Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92426C6FA99
	for <linux-s390@archiver.kernel.org>; Fri, 10 Mar 2023 13:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCJNe2 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 10 Mar 2023 08:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjCJNe0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 10 Mar 2023 08:34:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D690108C24
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 05:34:18 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ACkYfp017103
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=jnKmA09taWfjlwlyuwemKq2L7Q9aE1ZTkEjKEKCUzpw=;
 b=ZuPlmDcMAz7XtCQnGZLIzH6uxicUVmtJHkFzwzOm865Q0odqxTKItQXDXZoprbRpK00M
 R1iZm7lJEEdlo1JJ7Tvif6vxdwaM3nsO9vLMeLjKvdqClg63LBPC1pmbBiuQZs9jvsay
 PcTUJFT3ZTAD1BrIdbWlbdyzOvx+AShZkl6myosKMQhANIJQ8DM8w2Qy6brDvW40L+uh
 t9v/plHY6sFRS5NLrPZ5jwjQsBgXeX+Kpey4yVVybFi0d41Agw6wuHdXdp8K5n9DN6bQ
 nL0Qvm0dSdyk6PuvCdiQMOQ+f11L9OT+RMdKcQyD562h7uqO1urTPnl1DpchLxa760MT Lw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p84up93eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:34:17 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32A80reH023054
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:34:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3p6fysuw7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 Mar 2023 13:34:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32ADYBuA36307258
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 13:34:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D381F20040;
        Fri, 10 Mar 2023 13:34:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8965920049;
        Fri, 10 Mar 2023 13:34:11 +0000 (GMT)
Received: from t35lp63.lnxne.boe (unknown [9.152.108.100])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Mar 2023 13:34:11 +0000 (GMT)
From:   Nico Boehr <nrb@linux.ibm.com>
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, mhartmay@linux.ibm.com
Subject: [PATCH v3 0/1] s390: ipl: fix physical-virtual confusion for diag308
Date:   Fri, 10 Mar 2023 14:34:10 +0100
Message-Id: <20230310133411.139275-1-nrb@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: X5nQMG6P_hDwRznOLtwEhuY6MiV6atqq
X-Proofpoint-GUID: X5nQMG6P_hDwRznOLtwEhuY6MiV6atqq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_03,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 mlxlogscore=622
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100109
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

v3:
---
* u64 -> unsigned long (thanks Alexander)
* improve commit description a bit (thanks Alexander)

v2:
---
* add special handling for addr NULL (thanks Alexander)



Nico Boehr (1):
  s390: ipl: fix physical-virtual confusion for diag308

 arch/s390/kernel/ipl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.39.1

