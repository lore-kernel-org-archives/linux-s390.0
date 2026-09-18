Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1373D4123
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744438; cv=none; b=mmcbcHC927mrjCSMfKg4LsruP9p0/7HvYmyRZwBGnH8anLclsazpuvd5GzpA9xbB2kd6uJPV7nMihbGFclbQg1jT6r4SU6UNJ4nTk6guUkojfNYum5zRnaXH70RUB+OdL0x/m7Ol5lwewQY+xqqOLoVikHhHMRhfXJ8xfPEZ/2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744438; c=relaxed/simple;
	bh=2pN8hQyu8sPQ2DU61MpN4SqmhlwD5SXKp6v3wgS1RJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B/JX32q41XEUGBsH2wXRb/PHd6ZmHOAoDtbQ4UKVvSbAcn+gBrQsgTUIi5+1k7rRG+n5HisxdL2uPrA23v3un/cUjmiw79NVAwkBFp5M849PWWEItkY5nOlDgs+eHd+h8ocuCm6/S+nGfbhuJE+GRHjItZLbmfI5CeA8K6qTOPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HZdrXXlJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HZdrXXlJ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVPAZ1378486
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 15:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=usnA1lIGRvWFPRATUHrPCJ76K58Q7WvBeA507Wd/9
	G4=; b=HZdrXXlJY915DMjxR0oH996JOQATpHxYpHhT6SqeoOT17WHfEFvu9w/Ya
	3y0vclTB7AvkTNoqEHvwGedJSp633FnvPM3fFzEWhE8C+3HN3DDtgcKLhQdn8U/7
	aonWmG7yl6bjkewcRuUycYtNpBQ5nj2O5Xx1L0p/Z2s3Tt7FqMNgmzL9wBqUxN2l
	umTMg+HdHFDP2vL2Q4lGY2VIHaCMweo+v6sbjdVOP7WtXbrB9biACXAcTxHkDJGZ
	WQF0N2VNy7rn1H/DuWeGsxfl8VOMtQd+U4247woXc8WdaFI7D1/RAPnDOXlWipqC
	2mL7aG4W+lJecIM8ydiUB4wkHqBMw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx848tnj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 15:13:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNu5t771797
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 15:13:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr5fffwdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 18 Sep 2026 15:13:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IFDpQq43385166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 15:13:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AA8F2004B;
	Fri, 18 Sep 2026 15:13:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7026E20049;
	Fri, 18 Sep 2026 15:13:51 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 15:13:51 +0000 (GMT)
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: [PATCH v2] s390/debug: Do not register views for failed static debug areas
Date: Fri, 18 Sep 2026 17:13:51 +0200
Message-ID: <20260918151351.3977090-1-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX+tcHiAS54G1B
 TYQDQx5AphHZkV1iJfE4K+g1RwHHTh8q9Yqa24trBxGRrdjeHHUP5DcV3ikMZDFH47/B5jLv8Uk
 Jkb06n6DLUrlZkdCkKhbNb+nX3YWNTybs/9BmgMKSDH0GoOXWL0PIFLpHkhDpHkvgIpRVJsHCK7
 RoYB2wFrsYfY3kxtCYhmlQz64m83GvlBJZM8UqxL4uSrt1C4l7C0RRbIKmBeG4uOc1m56nNA8rl
 luUxckbEf8FrAHqKvQ8j2IIfkjInX1Bbbok2ATgvi5R5ltlN3VwmdFYZhPdOmmbUsvMe3PzoVH+
 4hJaxtrKTie+2CR65J/f3jAowrIc+Nv7gHYo/cqaWD8nK5+rK5vFylsGnUILgilDznFCzAmx5PN
 Avd0aCU05fDUvL5O1liQXkwCBFwyaQ8KvCmGtxJf81oXHDl1aKHlwWLHpeiLW6x53mvDonnuPjU
 PACVAR3sIr18/Zw51JQ==
X-Proofpoint-ORIG-GUID: NutqesZmlfaD4leYhMJndy2m3wHWNiUY
X-Proofpoint-GUID: NutqesZmlfaD4leYhMJndy2m3wHWNiUY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX2fIExuankqRA
 FUxbR4cYRSzRn0J78g+4sT64iF3aRf36t10vi6LxCh9ihcB1eEX7zFCyfLhVEQjZnfPffZdG3iB
 aa+GKWjhva1dQ7WBEufk/+wqNEftQYU=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aad5534 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=sV0Tb8Q8NCWyHoIVPFoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180214

__REGISTER_STATIC_DEBUG_INFO() calls debug_register_view()
unconditionally, even when debug_register_static() has failed. In that
case _debug_register() was never reached and id->debugfs_root_entry is
still NULL, so debugfs_create_file() places the view file in the debugfs
root directory. For sclp_err this leaves a /sys/kernel/debug/hex_ascii
file with nothing to indicate which debug log it belongs to.

debug_register_static() is not exported and the macro is its only
caller, so let it return an error code and skip the view registration
when it fails. No debugfs files are created for such an area then.

Reproduce by booting with s390dbf=sclp_err::100000000. The sclp_err
registration fails, no s390dbf/sclp_err/ directory is created, and a
hex_ascii file appears in the debugfs root instead.

Fixes: d72541f94512 ("s390/debug: add early tracing support")
Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
---
v2:
- Resend as regular patch, no functional changes since RFC

 arch/s390/include/asm/debug.h |  8 ++++++--
 arch/s390/kernel/debug.c      | 12 +++++++++---
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/debug.h b/arch/s390/include/asm/debug.h
index 39d484c59774..ad438d6352c8 100644
--- a/arch/s390/include/asm/debug.h
+++ b/arch/s390/include/asm/debug.h
@@ -460,7 +460,11 @@ static int VNAME(var, active_entries)[EARLY_AREAS] __initdata
 #define __REGISTER_STATIC_DEBUG_INFO(var, name, pages, areas, view)	\
 static int __init VNAME(var, reg)(void)					\
 {									\
-	debug_register_static(&var, (pages), (areas));			\
+	int rc;								\
+									\
+	rc = debug_register_static(&var, (pages), (areas));		\
+	if (rc)								\
+		return rc;						\
 	debug_register_view(&var, (view));				\
 	return 0;							\
 }									\
@@ -493,7 +497,7 @@ static debug_info_t __refdata var =					\
 static debug_info_t __used __section(".s390dbf_info") *VNAME(var, info) = &var; \
 __REGISTER_STATIC_DEBUG_INFO(var, name, pages, nr_areas, view)
 
-void debug_register_static(debug_info_t *id, int pages_per_area, int nr_areas);
+int debug_register_static(debug_info_t *id, int pages_per_area, int nr_areas);
 
 #endif /* MODULE */
 
diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index b5bf8284dbfc..c6f3a55fcfa9 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -950,8 +950,12 @@ EXPORT_SYMBOL(debug_register);
  *
  * Note: This function is called automatically via an initcall generated by
  *	 DEFINE_STATIC_DEBUG_INFO.
+ *
+ * Return:
+ * - 0 on success
+ * - negative error code on failure
  */
-void debug_register_static(debug_info_t *id, int pages_per_area, int nr_areas)
+int debug_register_static(debug_info_t *id, int pages_per_area, int nr_areas)
 {
 	unsigned long flags;
 	debug_info_t *copy;
@@ -959,7 +963,7 @@ void debug_register_static(debug_info_t *id, int pages_per_area, int nr_areas)
 	if (!initialized) {
 		pr_err("Tried to register debug feature %s too early\n",
 		       id->name);
-		return;
+		return -EINVAL;
 	}
 
 	debug_get_param(id->name, &id->level, &pages_per_area, false);
@@ -975,7 +979,7 @@ void debug_register_static(debug_info_t *id, int pages_per_area, int nr_areas)
 		id->active_entries = NULL;
 		raw_spin_unlock_irqrestore(&id->lock, flags);
 
-		return;
+		return -ENOMEM;
 	}
 
 	/* Replace static trace area with dynamic copy. */
@@ -993,6 +997,8 @@ void debug_register_static(debug_info_t *id, int pages_per_area, int nr_areas)
 	mutex_lock(&debug_mutex);
 	_debug_register(id);
 	mutex_unlock(&debug_mutex);
+
+	return 0;
 }
 
 /* Remove debugfs entries. */
-- 
2.55.0

