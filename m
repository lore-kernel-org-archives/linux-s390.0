Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8565BC4167D
	for <linux-s390@archiver.kernel.org>; Mon,  6 Nov 2023 16:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjKFQiB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 6 Nov 2023 11:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjKFQht (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Nov 2023 11:37:49 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE8510E4;
        Mon,  6 Nov 2023 08:37:45 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6GCMXA012935;
        Mon, 6 Nov 2023 16:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=gzWXYgcruE5mVvn/QVP9cXprd3cnwRpByOUkWG5YFTc=;
 b=b8F2lT5Plvqe3g8XIPxR+9/etvSV+Ncb990Aq+n/UDV1m+ytJSJwn6HwK6C2jIUt2nLK
 pKd7O3u6NboYhQTmSWsRmDT1DENHNmau5sM1AtDkCvMOHXKQNxgyy7AkrBr1NfbBuC4F
 +sU4SkGBK7j8yxRSfvu5InzdlZRq/wezOHyiOR5HEjOoH1VhF+vQMItv/mJs+ip8Rq/E
 7Ky/JtQzscak680y04GqCf6fY28Jue+96mzJ5SexIy519U3PC1gbogIL8x6+HoDgbBsl
 lfw0dt5ooHZBovecuV7fFLYBOAgutpPgXXlk0dFxYtnkNpdE4CwAU4f0gUoMxZu6vy3r oA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u73f4gyh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 16:37:44 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A6GD36M017442;
        Mon, 6 Nov 2023 16:37:44 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u73f4gygj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 16:37:44 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6F2I3j028248;
        Mon, 6 Nov 2023 16:37:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u62gjt910-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 16:37:43 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A6GbeJF21561864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 16:37:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 868A120040;
        Mon,  6 Nov 2023 16:37:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42B3320043;
        Mon,  6 Nov 2023 16:37:40 +0000 (GMT)
Received: from t35lp63.lnxne.boe (unknown [9.152.108.100])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Nov 2023 16:37:40 +0000 (GMT)
From:   Nico Boehr <nrb@linux.ibm.com>
To:     frankja@linux.ibm.com, imbrenda@linux.ibm.com, thuth@redhat.com,
        hca@linux.ibm.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [kvm-unit-tests PATCH v8 6/8] s390x: add test source dir to include paths
Date:   Mon,  6 Nov 2023 17:37:28 +0100
Message-ID: <20231106163738.1116942-7-nrb@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106163738.1116942-1-nrb@linux.ibm.com>
References: <20231106163738.1116942-1-nrb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -N2NmcYNjehihb3lmk3JrtVv5E4kYPLz
X-Proofpoint-ORIG-GUID: J8fhgOcaGbvpWDZRdQaAlGnsIOEQ-2HP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_12,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060134
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Sometimes, it is useful to share some defines between a snippet and a
test. By adding the source directory to include paths, header files can
be placed in the snippet directory and included from the test (or vice
versa).

This is a prerequisite for future tests.

Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 s390x/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/s390x/Makefile b/s390x/Makefile
index 6e967194ae0d..947a4344738f 100644
--- a/s390x/Makefile
+++ b/s390x/Makefile
@@ -67,7 +67,7 @@ test_cases: $(tests)
 test_cases_binary: $(tests_binary)
 test_cases_pv: $(tests_pv_binary)
 
-INCLUDE_PATHS = $(SRCDIR)/lib $(SRCDIR)/lib/s390x
+INCLUDE_PATHS = $(SRCDIR)/lib $(SRCDIR)/lib/s390x $(SRCDIR)/s390x
 # Include generated header files (e.g. in case of out-of-source builds)
 INCLUDE_PATHS += lib
 CPPFLAGS = $(addprefix -I,$(INCLUDE_PATHS))
-- 
2.41.0

