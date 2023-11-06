Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089C7C001B5
	for <linux-s390@archiver.kernel.org>; Mon,  6 Nov 2023 12:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjKFMyN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 6 Nov 2023 07:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjKFMyL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Nov 2023 07:54:11 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB48112;
        Mon,  6 Nov 2023 04:54:08 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6CGQuX003553;
        Mon, 6 Nov 2023 12:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MB5zzyTKI3NQnXnkb7csPHpGCdQPKaVXi6iIQx/RL28=;
 b=bTUEg/PWr4cRzT6Trs8QiUHQ17qM3hl2M7lt1/dlO4ScDn1Jgn4r4ThypT+ZCagDsgR5
 /2sxvNqxaPt/yIlhWPdRdP660I2vLs33qjp8XtJOodfVXkOgW86nK1L5YpO77JOClkVh
 ZUKnbnNCVBvMgTFB3lcw0MT6n4XsGBwsyYy3LXLROis++0RcgpKYwVvbJQwhvgDzedzL
 pTBJ2Utwr4ngaoBIfiyUCncqfjYAOmKvv+gLgyRXv2e5OLU2MJID3MFhfFuuYSRKKKh4
 20gjfC7ZGR/DVMC6qcOAVSQRNFXzgzpCzq4UXgetRh7hn9txC5qzQ/yybXfijAn+fHH9 dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u6v0cgndm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 12:54:00 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A6Cn7c4014273;
        Mon, 6 Nov 2023 12:53:59 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u6v0cgnda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 12:53:59 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6AHcAJ016950;
        Mon, 6 Nov 2023 12:53:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u6301gqpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 12:53:58 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A6CrtVL12386842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 12:53:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 747F820040;
        Mon,  6 Nov 2023 12:53:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 342382004B;
        Mon,  6 Nov 2023 12:53:55 +0000 (GMT)
Received: from t35lp63.lnxne.boe (unknown [9.152.108.100])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Nov 2023 12:53:55 +0000 (GMT)
From:   Nico Boehr <nrb@linux.ibm.com>
To:     frankja@linux.ibm.com, imbrenda@linux.ibm.com, thuth@redhat.com,
        david@redhat.com, pbonzini@redhat.com, andrew.jones@linux.dev,
        lvivier@redhat.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [kvm-unit-tests PATCH v1 10/10] add make format
Date:   Mon,  6 Nov 2023 13:51:06 +0100
Message-ID: <20231106125352.859992-11-nrb@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106125352.859992-1-nrb@linux.ibm.com>
References: <20231106125352.859992-1-nrb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: es1FkEYpYr98geEir2AxQHBtm8ax_g08
X-Proofpoint-ORIG-GUID: jhqQgK9FUYgmB6eJfQR-d4KcEfP8hvFv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_11,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=660
 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060104
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Add target "format" to the makefile to format all source files with
clang-format.

This currently assumes all architectures want to opt-in to formatting
with clang-format. Maybe they don't want that, then we can move the
target to architecture-specific folders.

Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 602910dda11b..b5509c74ad5b 100644
--- a/Makefile
+++ b/Makefile
@@ -147,3 +147,6 @@ tags:
 
 check-kerneldoc:
 	find . -name '*.[ch]' -exec scripts/kernel-doc -none {} +
+
+format:
+	find . -name '*.[ch]' ! -type l -exec clang-format -i {} +
-- 
2.41.0

