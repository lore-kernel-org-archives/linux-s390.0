Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEB1191499
	for <linux-s390@vger.kernel.org>; Thu, 24 Apr 2025 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501825; cv=none; b=DCWPxQzpKBlOdZ9Nblo26BoaGyxByEzNjA+gkFLxMAnV/BZawBLd4aIYfpdHsmZg/ita+wLclRPtvylQKiO2xjd2QtifqgPrc38N8yTdiRJc/T/jFZ41Yd8CH5vP75G5WGFNrzUkfI5Q2RvedcoHr4hjERnh0SyVEWC5ZeYUOrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501825; c=relaxed/simple;
	bh=2+PH3jIAcOGtSPe6Kys0pAk+C2MxvMB/D+UTMegPad4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srkLB3obyUsuQzDX3+84gIUzLvd3auceq5H003VTSxYFPUR0GJYDrxmejsDdLZO6jyYxX6gLOdYR+aZ6cSr7EQNtb+xP2ggfF4k4/wO4bMFtVUAIUB+r8WhoZkFblUwDJlYWiRMNSg4TgD87sSmZ8VfqU9OOs5ytahWXAJN95fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J7OscPZI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J7OscPZI"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OAf5M8021256;
	Thu, 24 Apr 2025 13:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cd5g21oy8inYU3bpI
	CeBytVjlYP5QbW2IgArhe1WcCA=; b=J7OscPZIUIwO0EoEw8EEo9hgrpFc9I5dp
	Lb5xVWUEaNXpxbOkL/tGZ9Hqsnn1vsi2+PujYe2fxZzu0F+QxrrEuL21JnqDDL/b
	/ity0pCSOmveoRmtzfeRUgbW+GZqJSBT06xx7CqM27S/kc+rNyxqit4kKDqat6vb
	pHXFeLHu1725snz0a2+UsmajhAuchs4thjmIfj3F7nOvEwlIPPY+iKZWHz4UAf55
	XKufpPcTzGnGnSuKDnYa28ZkYQR6qFWTerG4ueIVXUihHq+rFFFF8IApZzRlb3IP
	mhPitEhBkRYlUFPA7EL36dsR4QoXJEItl5+vyRko3Qw3mVoHKwB1g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467krsruk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:37:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53OBS5O2005893;
	Thu, 24 Apr 2025 13:36:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfxgd4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 13:36:34 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53ODaUlp53150106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 13:36:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DD7020043;
	Thu, 24 Apr 2025 13:36:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F08972004B;
	Thu, 24 Apr 2025 13:36:29 +0000 (GMT)
Received: from funtu2.boeblingen.de.ibm.com (unknown [9.152.224.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Apr 2025 13:36:29 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v8 21/25] s390/uv: Rename find_secret() to uv_find_secret() and publish
Date: Thu, 24 Apr 2025 15:36:15 +0200
Message-ID: <20250424133619.16495-22-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424133619.16495-1-freude@linux.ibm.com>
References: <20250424133619.16495-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA5MiBTYWx0ZWRfXyWsS8Q8G/M0u U7kQBmPTwZZBS3zZzjpyq8gXWv4meYJDQ4X7DIEWqu8VPIqGfFimoqY18Bqe1KsK8RbbTrBFniE zl850t3ceJb5me4E+UCEQuwhohGzwmg5R2rpDEWdCYjxJZVptP/C8Sg7dy2Az+PIEq7p4+riA4b
 aoBYwvi9VT1Ind128hcoNDLvySQ+FjGsyfKkZwxpXH9sMh9IonIeVX1pv/Scdn4DThnYPAuwb5N a+L8+WiFLqUqHuo58wQzpqlZWcmbYKI/f164h8dB9/J9LoxIGJVKLCs8x4kaygHH8CR3YswBGSP SLCiDO9q4AIy7LQyae3SICKqt47DXISVSaJZwAYf1zJoKgbcBW7WFuZQT+P/Wf6qQf+Ir6q92f5
 7pvRrtUvzHlrf3+Eo3ccMDYMKUmVK8SKzD12m/cN5/1yihmgOtFUu8JniaUho++DfDkqknz6
X-Proofpoint-GUID: aMRuGxAkXbHyo2UZU29UWGGo99HRl9FM
X-Authority-Analysis: v=2.4 cv=IciHWXqa c=1 sm=1 tr=0 ts=680a3e7c cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=EUQXMSza6c67mSslqPIA:9
X-Proofpoint-ORIG-GUID: aMRuGxAkXbHyo2UZU29UWGGo99HRl9FM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_06,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxlogscore=841 mlxscore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240092

Rename the internal UV function find_secret() to uv_find_secret()
and publish it as new UV API in-kernel function.

The pkey uv handler may be called in a do-not-allocate memory
situation where sleeping is allowed but allocating memory which
may cause IO operations is not. For example when an encrypted
swap file is used and the encryption is done via UV retrievable
secrets with protected keys.

The UV API function uv_get_secret_metadata() allocates memory
and then calls the find_secret() function. By exposing the
find_secret() function as a new UV API function uv_find_secret()
it is possible to retrieve UV secret meta data without any
memory allocations from the UV when the caller offers space
for one struct uv_secret_list.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Acked-by: Holger Dengler <dengler@linux.ibm.com>
---
 arch/s390/include/asm/uv.h |  3 +++
 arch/s390/kernel/uv.c      | 19 ++++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index 46fb0ef6f984..7f53fe755f3f 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -616,6 +616,9 @@ static inline int uv_remove_shared(unsigned long addr)
 	return share(addr, UVC_CMD_REMOVE_SHARED_ACCESS);
 }
 
+int uv_find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
+		   struct uv_secret_list *list,
+		   struct uv_secret_list_item_hdr *secret);
 int uv_get_secret_metadata(const u8 secret_id[UV_SECRET_ID_LEN],
 			   struct uv_secret_list_item_hdr *secret);
 int uv_retrieve_secret(u16 secret_idx, u8 *buf, size_t buf_size);
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 9a5d5be8acf4..faac43359e23 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -782,7 +782,12 @@ static int __init uv_sysfs_init(void)
 device_initcall(uv_sysfs_init);
 
 /*
- * Find the secret with the secret_id in the provided list.
+ * Locate a secret in the list by its id.
+ * @secret_id: search pattern.
+ * @list: ephemeral buffer space
+ * @secret: output data, containing the secret's metadata.
+ *
+ * Search for a secret with the given secret_id in the Ultravisor secret store.
  *
  * Context: might sleep.
  */
@@ -803,12 +808,15 @@ static int find_secret_in_page(const u8 secret_id[UV_SECRET_ID_LEN],
 
 /*
  * Do the actual search for `uv_get_secret_metadata`.
+ * @secret_id: search pattern.
+ * @list: ephemeral buffer space
+ * @secret: output data, containing the secret's metadata.
  *
  * Context: might sleep.
  */
-static int find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
-		       struct uv_secret_list *list,
-		       struct uv_secret_list_item_hdr *secret)
+int uv_find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
+		   struct uv_secret_list *list,
+		   struct uv_secret_list_item_hdr *secret)
 {
 	u16 start_idx = 0;
 	u16 list_rc;
@@ -830,6 +838,7 @@ static int find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
 
 	return -ENOENT;
 }
+EXPORT_SYMBOL_GPL(uv_find_secret);
 
 /**
  * uv_get_secret_metadata() - get secret metadata for a given secret id.
@@ -855,7 +864,7 @@ int uv_get_secret_metadata(const u8 secret_id[UV_SECRET_ID_LEN],
 	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
-	rc = find_secret(secret_id, buf, secret);
+	rc = uv_find_secret(secret_id, buf, secret);
 	kfree(buf);
 	return rc;
 }
-- 
2.43.0

