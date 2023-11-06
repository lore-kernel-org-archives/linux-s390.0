Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC3BC4167B
	for <linux-s390@archiver.kernel.org>; Mon,  6 Nov 2023 16:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjKFQh7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 6 Nov 2023 11:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjKFQhu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Nov 2023 11:37:50 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E98F10E3;
        Mon,  6 Nov 2023 08:37:45 -0800 (PST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6GHLJ5008305;
        Mon, 6 Nov 2023 16:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=y5LAWXVV6GMZQvE4YLbew6zsj0MpwUtLHHrpzO7a6Us=;
 b=aXoxc/R21fjnRsD/wejh0UZKVtsaBTIKUINH3W+Oa8CPk31P/ku1f42Jsg5swXbatqlW
 HRM2ERNZfgrkE57yOSHm9Enn7WG45DY+QDkmKcdz/cP20ooyXyKFfkJuGsA/cXGe6muD
 raqsrp/AL2EKDgjYPuf5hxGRhjjgPNbG7O6Qr3ZW3tJelYePwhSl2o3ZQhIKyRLfEz0N
 Z+eNdIjtPtYQErvhawUWDJJg27cwtt9HaubewItTUYGPBqc8Wo0GD3khSA3ng4fdgz6r
 q25a2BvzWaNxqyALc71BQOoEY5lYnnf6lodzQyEPALXzhZJqkv5nTSwVc6JTSfvWkJq/ 1g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u73hg8r9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 16:37:44 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A6GI27R012773;
        Mon, 6 Nov 2023 16:37:44 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u73hg8r8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 16:37:44 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6Eb4hq007827;
        Mon, 6 Nov 2023 16:37:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u61skafty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 16:37:42 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A6GbdRT16777740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 16:37:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A255C20040;
        Mon,  6 Nov 2023 16:37:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6752D20043;
        Mon,  6 Nov 2023 16:37:39 +0000 (GMT)
Received: from t35lp63.lnxne.boe (unknown [9.152.108.100])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Nov 2023 16:37:39 +0000 (GMT)
From:   Nico Boehr <nrb@linux.ibm.com>
To:     frankja@linux.ibm.com, imbrenda@linux.ibm.com, thuth@redhat.com,
        hca@linux.ibm.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [kvm-unit-tests PATCH v8 3/8] s390x: sie: switch to home space mode before entering SIE
Date:   Mon,  6 Nov 2023 17:37:25 +0100
Message-ID: <20231106163738.1116942-4-nrb@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106163738.1116942-1-nrb@linux.ibm.com>
References: <20231106163738.1116942-1-nrb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y23M_fSmYj2rKG18ruC2pAWv81a-dta9
X-Proofpoint-ORIG-GUID: IWaRCRNBHqRR8xVB44eCK0kcIBL0i5kI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_12,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060134
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This is to prepare for running guests without MSO/MSL, which is
currently not possible.

We already have code in sie64a to setup a guest primary ASCE before
entering SIE, so we can in theory switch to the page tables which
translate gpa to hpa.

But the host is running in primary space mode already, so changing the
primary ASCE before entering SIE will also affect the host's code and
data.

To make this switch useful, the host should run in a different address
space mode. Hence, set up and change to home address space mode before
installing the guest ASCE.

The home space ASCE is just copied over from the primary space ASCE, so
no functional change is intended, also for tests that want to use
MSO/MSL. If a test intends to use a different primary space ASCE, it can
now just set the guest.asce in the save_area.

Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 lib/s390x/asm/arch_def.h |  1 +
 lib/s390x/sie.c          | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
index 5beaf15b57e7..745a33878de5 100644
--- a/lib/s390x/asm/arch_def.h
+++ b/lib/s390x/asm/arch_def.h
@@ -92,6 +92,7 @@ enum address_space {
 };
 
 #define PSW_MASK_DAT			0x0400000000000000UL
+#define PSW_MASK_HOME			0x0000C00000000000UL
 #define PSW_MASK_IO			0x0200000000000000UL
 #define PSW_MASK_EXT			0x0100000000000000UL
 #define PSW_MASK_KEY			0x00F0000000000000UL
diff --git a/lib/s390x/sie.c b/lib/s390x/sie.c
index b44febdeaaac..7f4474555ff7 100644
--- a/lib/s390x/sie.c
+++ b/lib/s390x/sie.c
@@ -52,6 +52,8 @@ void sie_handle_validity(struct vm *vm)
 
 void sie(struct vm *vm)
 {
+	uint64_t old_cr13;
+
 	if (vm->sblk->sdf == 2)
 		memcpy(vm->sblk->pv_grregs, vm->save_area.guest.grs,
 		       sizeof(vm->save_area.guest.grs));
@@ -59,6 +61,24 @@ void sie(struct vm *vm)
 	/* Reset icptcode so we don't trip over it below */
 	vm->sblk->icptcode = 0;
 
+	/*
+	 * Set up home address space to match primary space. Instead of running
+	 * in home space all the time, we switch every time in sie() because:
+	 * - tests that depend on running in primary space mode don't need to be
+	 *   touched
+	 * - it avoids regressions in tests
+	 * - switching every time makes it easier to extend this in the future,
+	 *   for example to allow tests to run in whatever space they want
+	 */
+	old_cr13 = stctg(13);
+	lctlg(13, stctg(1));
+
+	/* switch to home space so guest tables can be different from host */
+	psw_mask_set_bits(PSW_MASK_HOME);
+
+	/* also handle all interruptions in home space while in SIE */
+	irq_set_dat_mode(true, AS_HOME);
+
 	while (vm->sblk->icptcode == 0) {
 		sie64a(vm->sblk, &vm->save_area);
 		sie_handle_validity(vm);
@@ -66,6 +86,12 @@ void sie(struct vm *vm)
 	vm->save_area.guest.grs[14] = vm->sblk->gg14;
 	vm->save_area.guest.grs[15] = vm->sblk->gg15;
 
+	irq_set_dat_mode(true, AS_PRIM);
+	psw_mask_clear_bits(PSW_MASK_HOME);
+
+	/* restore the old CR 13 */
+	lctlg(13, old_cr13);
+
 	if (vm->sblk->sdf == 2)
 		memcpy(vm->save_area.guest.grs, vm->sblk->pv_grregs,
 		       sizeof(vm->save_area.guest.grs));
-- 
2.41.0

