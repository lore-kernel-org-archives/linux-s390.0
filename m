Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9783C4167B
	for <linux-s390@archiver.kernel.org>; Mon,  6 Nov 2023 12:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjKFMyL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 6 Nov 2023 07:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjKFMyK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Nov 2023 07:54:10 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6487CBE;
        Mon,  6 Nov 2023 04:54:07 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6Cp86P025480;
        Mon, 6 Nov 2023 12:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kT3lV5JuFSt/YxV5WLZctOiL6Pw0ODBLwGBBV/93KJA=;
 b=eGRSpUevxne4JNqu5QfeymQXZs3W82JxmQsVBcVE87dUDUpSyBl16wIhgxm0pEb3ml/n
 pjhR2Y+xT3D0Lf/JXO6C2LjM2ZSaNGrht5krluJlcUW64Pw0t2HGpyduIkBLUWPsBKpN
 OmEG97LlTBWQg5HaJC3OqW0aMv9s0XVrdKd/4F0+JdgVNl28hqJQ4yKsrafF2OSCGGJu
 MuXRNcYXmi90ILW9sS+k2rsfUvoiGp2EA/vYkz3bFcG0mMJz1TtHspKb8sURYZKPJq1G
 OXo6l8vDkCnTwKuuZc/6g5KPEFGrN0FWEfgryuJ3NXfW00I17+ZaLBBH9DtUwjOD938I QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u6v2cge17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 12:53:59 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A6CpU3d028267;
        Mon, 6 Nov 2023 12:53:58 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u6v2cge0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 12:53:58 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6ARP5T012790;
        Mon, 6 Nov 2023 12:53:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u609shhjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 12:53:57 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A6Crshp7013032
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 12:53:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54FB920040;
        Mon,  6 Nov 2023 12:53:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14A0D2004D;
        Mon,  6 Nov 2023 12:53:54 +0000 (GMT)
Received: from t35lp63.lnxne.boe (unknown [9.152.108.100])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Nov 2023 12:53:54 +0000 (GMT)
From:   Nico Boehr <nrb@linux.ibm.com>
To:     frankja@linux.ibm.com, imbrenda@linux.ibm.com, thuth@redhat.com,
        david@redhat.com, pbonzini@redhat.com, andrew.jones@linux.dev,
        lvivier@redhat.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [kvm-unit-tests PATCH v1 06/10] x86: properly format non-kernel-doc comments
Date:   Mon,  6 Nov 2023 13:51:02 +0100
Message-ID: <20231106125352.859992-7-nrb@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106125352.859992-1-nrb@linux.ibm.com>
References: <20231106125352.859992-1-nrb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L65yXVvGIy9BaYNHiqV95KzkUEB0shne
X-Proofpoint-ORIG-GUID: yyGPwGcjVy3iHl7IWgBhnwpx6_2uTdjb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_11,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxlogscore=993
 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060104
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

These comments do not follow the kernel-doc style, hence they should not
start with /**.

Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
---
 x86/msr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/x86/msr.c b/x86/msr.c
index 789f23f8de78..3a041fab160a 100644
--- a/x86/msr.c
+++ b/x86/msr.c
@@ -6,7 +6,7 @@
 #include "msr.h"
 #include <stdlib.h>
 
-/**
+/*
  * This test allows two modes:
  * 1. Default: the `msr_info' array contains the default test configurations
  * 2. Custom: by providing command line arguments it is possible to test any MSR and value
-- 
2.41.0

