Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34839C4167B
	for <linux-s390@archiver.kernel.org>; Mon,  6 Nov 2023 12:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjKFMyO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 6 Nov 2023 07:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjKFMyM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Nov 2023 07:54:12 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAD6A9;
        Mon,  6 Nov 2023 04:54:09 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6CawB4002978;
        Mon, 6 Nov 2023 12:53:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Z59uTpa3jy4aUyo9xXHuAerZmvhNANO3hpdQ6OnxMHo=;
 b=fYy07Wq9OaB+uLU+CwbZjHVaOicSiztIvmxgncErhSmroIcLPzP4ajtrjZHuULZ+7g8+
 NDiP8FnBIk/xHaEQ+uyPwLVz596e9MiwdH4IbZcDoMDi44yaMS/+8rjpPEe/5yRIBbCO
 T/Td4ODknNa7f4lQvQRm3FMlTYcMD5m2BKWjDXh9SRMl1fHU0fdVK5duTknbCzBJhdNL
 J+hpb5AzAGO3aPJIYBZp2lVc9Kqcyd2k/MFMbUA2eVtxxtAzrmVT3dCJeqJTMxfqeZcM
 9OL8cmCEui1E2TSh73K3qWf7ztDUuerMHJ6Q9r3a3EW3c4RkvriEzFZ9ywwQTtl3yEfL zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u70a4rm3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 12:53:58 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A6CbPuS004799;
        Mon, 6 Nov 2023 12:53:57 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u70a4rm3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 12:53:57 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6ADb5Q016958;
        Mon, 6 Nov 2023 12:53:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u6301gqpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 12:53:56 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A6CrsPI7013028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 12:53:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CFA320040;
        Mon,  6 Nov 2023 12:53:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9CB22004B;
        Mon,  6 Nov 2023 12:53:53 +0000 (GMT)
Received: from t35lp63.lnxne.boe (unknown [9.152.108.100])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Nov 2023 12:53:53 +0000 (GMT)
From:   Nico Boehr <nrb@linux.ibm.com>
To:     frankja@linux.ibm.com, imbrenda@linux.ibm.com, thuth@redhat.com,
        david@redhat.com, pbonzini@redhat.com, andrew.jones@linux.dev,
        lvivier@redhat.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [kvm-unit-tests PATCH v1 05/10] s390x: ensure kernel-doc parameters are properly formated
Date:   Mon,  6 Nov 2023 13:51:01 +0100
Message-ID: <20231106125352.859992-6-nrb@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106125352.859992-1-nrb@linux.ibm.com>
References: <20231106125352.859992-1-nrb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oSzxgZUKdmWy1g36oG9LgHdcNMhd0xqR
X-Proofpoint-ORIG-GUID: Uu5beGkber_ARbYK4fRPhEfnRfby59Km
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_11,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=619
 suspectscore=0 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060104
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

In kernel-doc, parameters names should end in a colon (:). Add them
where they are missing.

Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
---
 lib/s390x/interrupt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
index 3f993a363ae2..75edcbfecb7d 100644
--- a/lib/s390x/interrupt.c
+++ b/lib/s390x/interrupt.c
@@ -61,7 +61,7 @@ uint16_t clear_pgm_int(void)
 
 /**
  * check_pgm_int_code - Check the program interrupt code on the current CPU.
- * @code the expected program interrupt code on the current CPU
+ * @code: the expected program interrupt code on the current CPU
  *
  * Check and report if the program interrupt on the current CPU matches the
  * expected one.
@@ -77,7 +77,7 @@ void check_pgm_int_code(uint16_t code)
 /**
  * register_pgm_cleanup_func - Register a cleanup function for progam
  * interrupts for the current CPU.
- * @f the cleanup function to be registered on the current CPU
+ * @f: the cleanup function to be registered on the current CPU
  *
  * Register a cleanup function to be called at the end of the normal
  * interrupt handling for program interrupts for this CPU.
@@ -92,7 +92,7 @@ void register_pgm_cleanup_func(void (*f)(struct stack_frame_int *))
 /**
  * register_ext_cleanup_func - Register a cleanup function for external
  * interrupts for the current CPU.
- * @f the cleanup function to be registered on the current CPU
+ * @f: the cleanup function to be registered on the current CPU
  *
  * Register a cleanup function to be called at the end of the normal
  * interrupt handling for external interrupts for this CPU.
-- 
2.41.0

