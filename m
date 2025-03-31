Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879DA1B423C
	for <linux-s390@vger.kernel.org>; Mon, 31 Mar 2025 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743417314; cv=none; b=KcBNC/F6T0drg9wQSVdWckaL92zIrKZNW5xHtFJrnWyeULQFVmdgy8aoZCf8dk3FmK/y4Zuc4CiJzBswcOamLxX3Qa4NHvOVfl9Q/xAQQIu42s9c/zX47vMfrYHB1fcDc3gpoNocblCV/j3mU51oaqe8HUu/nPjckJRYk0Q+zaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743417314; c=relaxed/simple;
	bh=UGTMT2j2V9IlDXvr9/tfeFcpZyG1WTGgXle84qw2S7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucroNtu3i2TBIKJ8fV9bKB43brK80ctMMMxOBPltoRtEejyEpv3f42texA8SsIV2N8rkvO9iLWth3aPCKbHU8/xuugKHNIJhQA2nq2Uqo/zwfFdS9+cPNuG5/NkgDDAw9FRdt0lkQJ/LuXL3D7vPw1Y6P5a4+uKV7C1od3/glVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IaHWv6Uw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IaHWv6Uw"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52V5Y2Wc031024
	for <linux-s390@vger.kernel.org>; Mon, 31 Mar 2025 10:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zDEd9G8WImlWRbm6i
	QkVnbOsTWFVMQtaQaC7JbrnxlA=; b=IaHWv6UwYrL1eDQn/C7oklB11oXCBv7Nx
	3zExplnynrMLZ5uzcD1qUsshwWHyDHs2CrdFSElN8RBl09U6S01s4xLM2+HR2Ilc
	Lj+qLheiEUDXY+7Ml12DHtuOup+r8jAFHeSm8MWFDZwzN5iN4qRYAqe8a5lTa/8y
	IZcrSc9OIFu/ocw4RqRlVdlr+LzT9qxM/vnXUl0O0NKX2hmFMSyZJ+vL4OP6j1YX
	n6Nsr+EG9Y4dgvwFbFOgFJmnj+9chtBPhBUjGFYMv/r/aPAKz13xY2X+EzwhEBMr
	+E5HnJ3mMjZNfyZltJOXXMP91U/+Ss75sbQFfEdt0SZQqnZttw4Ng==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45q602kw1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 31 Mar 2025 10:35:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52VA2auk014576
	for <linux-s390@vger.kernel.org>; Mon, 31 Mar 2025 10:35:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pvpkwb1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 31 Mar 2025 10:35:10 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52VAZ6FU42926348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 10:35:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E1F520043;
	Mon, 31 Mar 2025 10:35:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0196F20040;
	Mon, 31 Mar 2025 10:35:06 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.47.161])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Mar 2025 10:35:05 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: seiden@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, hca@linux.ibm.com
Cc: linux-s390@vger.kernel.org
Subject: [PATCH v2 1/1] s390/uv: New param workpage for the uv_get_secret_metadata() function
Date: Mon, 31 Mar 2025 12:35:05 +0200
Message-ID: <20250331103505.15210-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331103505.15210-1-freude@linux.ibm.com>
References: <20250331103505.15210-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uSFdLLvE-ooyhqM5SqFM9QuPQCowhOt0
X-Proofpoint-ORIG-GUID: uSFdLLvE-ooyhqM5SqFM9QuPQCowhOt0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 suspectscore=0 mlxlogscore=868 priorityscore=1501
 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503310074

The pkey uv handler may be called in a do-not-allocate memory
situation. For example when an encrypted swap file is used and the
encryption is done via UV retrievable secrets with protected keys.

The pkey uv handler calls uv_get_secret_metadata() and thus has a need
to have this function work without memory allocations. So this patch
extends the uv_get_secret_metadata() function to be able to work on
a provided working page instead of allocating/freeing memory via
kmalloc/kfree:

int uv_get_secret_metadata(const u8 secret_id[UV_SECRET_ID_LEN],
			   struct uv_secret_list_item_hdr *secret,
			   u8 *workpage);

Parameter workpage is a ephemeral working page used by the function.
If given (!= NULL), it needs to point to memory of at least PAGE_SIZE
bytes. If NULL, the function uses kmalloc/kfree to allocate and free a
working buffer.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 arch/s390/include/asm/uv.h |  3 ++-
 arch/s390/kernel/uv.c      | 12 +++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index b11f5b6d0bd1..496cd9c9f2a5 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -617,7 +617,8 @@ static inline int uv_remove_shared(unsigned long addr)
 }
 
 int uv_get_secret_metadata(const u8 secret_id[UV_SECRET_ID_LEN],
-			   struct uv_secret_list_item_hdr *secret);
+			   struct uv_secret_list_item_hdr *secret,
+			   u8 *workpage);
 int uv_retrieve_secret(u16 secret_idx, u8 *buf, size_t buf_size);
 
 extern int prot_virt_host;
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 9f05df2da2f7..0a8a6bc19c49 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -713,6 +713,9 @@ static int find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
  * uv_get_secret_metadata() - get secret metadata for a given secret id.
  * @secret_id: search pattern.
  * @secret: output data, containing the secret's metadata.
+ * @workpage: ephemeral working page. Caller may give a ptr to one page
+ *            here as ephemeral working buffer. If NULL, kmalloc is used
+ *            to alloc a working buffer.
  *
  * Search for a secret with the given secret_id in the Ultravisor secret store.
  *
@@ -725,16 +728,19 @@ static int find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
  * * %EIO:	- Other unexpected UV error.
  */
 int uv_get_secret_metadata(const u8 secret_id[UV_SECRET_ID_LEN],
-			   struct uv_secret_list_item_hdr *secret)
+			   struct uv_secret_list_item_hdr *secret,
+			   u8 *workpage)
 {
 	struct uv_secret_list *buf;
 	int rc;
 
-	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
+	buf = workpage ? (struct uv_secret_list *)workpage :
+		kzalloc(sizeof(*buf), GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 	rc = find_secret(secret_id, buf, secret);
-	kfree(buf);
+	if (!workpage)
+		kfree(buf);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(uv_get_secret_metadata);
-- 
2.43.0

