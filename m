Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F97C4332B
	for <linux-s390@archiver.kernel.org>; Thu, 18 Mar 2021 12:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AAB664E86
	for <linux-s390@archiver.kernel.org>; Thu, 18 Mar 2021 12:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhCRMuw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 18 Mar 2021 08:50:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230408AbhCRMud (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 18 Mar 2021 08:50:33 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12ICiAjn013582;
        Thu, 18 Mar 2021 08:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=27jgHEWQsE2tGa6PgzumrpphZFRLUHhCxry1FPK3/Ts=;
 b=GHqrI+C4ThuywBeTGPZSRk3RkQJu2/Amc+Jffk5g+LwvYtUB0a0/BTgVfzq0JRX53Vj9
 9IiQYt6gZcPXhPStMFS6GyEoHq0S39YXVFIVzqZWCXmEmEMaQRB18ULNs8u/tGqBk0FT
 VTeQMJDm9H4yZtLVG9G53nY1ufLoB3LtoVzwDKNueJ57nq9bBd6e0a2NlJPIikPyUkRf
 Dd7sNSa20PdtvbEAl6qyrW28i7hMEowz44AePrUusyLSqgN3K4O+elm0gJxqzKRvwCP0
 DZi6TdNLNeEnRMifPkkfj3Gs3dOvl4qHyNHURQcGV34oQHPICBMIY4oaHCvNOLLX77iN jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37bnrf4v4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Mar 2021 08:50:33 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12ICiNER014406;
        Thu, 18 Mar 2021 08:50:33 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37bnrf4v3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Mar 2021 08:50:33 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12ICmLUs031714;
        Thu, 18 Mar 2021 12:50:30 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 378n18ahmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Mar 2021 12:50:30 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12ICoSj234275672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Mar 2021 12:50:28 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89EC0A4057;
        Thu, 18 Mar 2021 12:50:28 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8969CA4053;
        Thu, 18 Mar 2021 12:50:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.24.61])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Mar 2021 12:50:27 +0000 (GMT)
From:   Janosch Frank <frankja@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
        linux-s390@vger.kernel.org
Subject: [kvm-unit-tests PATCH 3/3] s390x: run: Skip PV tests when tcg is the accelerator
Date:   Thu, 18 Mar 2021 12:50:15 +0000
Message-Id: <20210318125015.45502-4-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318125015.45502-1-frankja@linux.ibm.com>
References: <20210318125015.45502-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-18_04:2021-03-17,2021-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103180095
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

TCG doesn't support PV.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 s390x/run | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/s390x/run b/s390x/run
index df7ef5ca..82922701 100755
--- a/s390x/run
+++ b/s390x/run
@@ -19,6 +19,11 @@ else
     ACCEL=$DEF_ACCEL
 fi
 
+if [ "${1: -7}" == ".pv.bin" ] || [ "${TESTNAME: -3}" == "_PV" ] && [ $ACCEL == "tcg" ]; then
+	echo "Protected Virtualization isn't supported under TCG"
+	exit 2
+fi
+
 M='-machine s390-ccw-virtio'
 M+=",accel=$ACCEL"
 command="$qemu -nodefaults -nographic $M"
-- 
2.27.0

