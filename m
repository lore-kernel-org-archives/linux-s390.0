Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194A21E47A9
	for <linux-s390@vger.kernel.org>; Tue,  1 Apr 2025 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515019; cv=none; b=hvJ6qrzpCqTup+8l4soO1yNqD6/tWEVCHsJGp0AR/uqyDQg+7z64TRUN7tviSJ9JAX6jSFuie0ferawAk3WskxLGETsxvY70rYhPYE2TnMlOh8IOtKcdbFdWaPT97CS+qKefm1RhoL6kfFixQ7nRboJOGexH+jNjesp/Bh3onWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515019; c=relaxed/simple;
	bh=WCiItapxGdlJOkjP9fS3TrnziD9r1+19TApo+x+kP0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJZe0ZKbd+EIOtzqnPT7tbSeGTUrbkWs21NvxmHb4sOC8TTZP+Gx3esiARpKbH+yneyZykbfwRwAjjoiFVc6y/XmpmlixolFy4XX3HwPcODecjXMeIWYbHrt2Fgo5jO93ol5ZhmRcw65SjdZO/JspiuLuGvUYE0/wrZY3dC7Wxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LMB45z8b; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LMB45z8b"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531AQHaw031497
	for <linux-s390@vger.kernel.org>; Tue, 1 Apr 2025 13:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1uvvFl9XOtG568Lmj
	1vU2Qea8MfY0HQLcjOYU5Lt3+w=; b=LMB45z8bZee25QbTrBaTNQsUHTQ3m2Ipg
	J45pr9/1kr3M+H63eyFvtt47vlSDK8wv5/RK0ZGjl7Xbv+X3mBtPUfmA+R/QWVF9
	T7px1mHxjOVTebpXif//3SCE/40EWfAI+K2I74qA4sIseDbGjktmHMwCQbwsgNCW
	h1Oyg86Wa/p2KW/3fdL8dAdqdlCyr2ooOj0QiwlXuGQLJTeizzgCl9zX/Y2vw0+2
	47AoyJDw4OnSpdLZ45be01VH6Cjh/JPWE7dC8EMS0JNO75y4MQNRUOVFj+zS4i4p
	qENrhPFkTqbG79QUNhztdNR7OlGST3O8DWgKBMkOTFtKoIda3SvEw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45r27q3xd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 01 Apr 2025 13:43:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 531CAslS004829
	for <linux-s390@vger.kernel.org>; Tue, 1 Apr 2025 13:43:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pujytuwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 01 Apr 2025 13:43:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 531DhWEZ53477764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Apr 2025 13:43:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5D0020040;
	Tue,  1 Apr 2025 13:43:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA8F32004B;
	Tue,  1 Apr 2025 13:43:31 +0000 (GMT)
Received: from funtu2.boeblingen.de.ibm.com (unknown [9.152.224.229])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Apr 2025 13:43:31 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: seiden@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, hca@linux.ibm.com
Cc: linux-s390@vger.kernel.org
Subject: [PATCH v3 1/1] s390/uv: Rename find_secret() to uv_find_secret() and publish
Date: Tue,  1 Apr 2025 15:43:31 +0200
Message-ID: <20250401134331.50421-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401134331.50421-1-freude@linux.ibm.com>
References: <20250401134331.50421-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 49YxSSb7OwDuNflhG5AUis1HJr6cYSNK
X-Proofpoint-GUID: 49YxSSb7OwDuNflhG5AUis1HJr6cYSNK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_05,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=597
 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504010083

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
---
 arch/s390/include/asm/uv.h |  3 +++
 arch/s390/kernel/uv.c      | 15 +++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index b11f5b6d0bd1..8d7e00fa2bf0 100644
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
index 9f05df2da2f7..12da637f23f2 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -681,17 +681,23 @@ static int find_secret_in_page(const u8 secret_id[UV_SECRET_ID_LEN],
 
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
 	int ret;
 
+	if (!list)
+		return -ENOMEM;
+
 	do {
 		uv_list_secrets(list, start_idx, &list_rc, NULL);
 		if (list_rc != UVC_RC_EXECUTED && list_rc != UVC_RC_MORE_DATA) {
@@ -708,6 +714,7 @@ static int find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
 
 	return -ENOENT;
 }
+EXPORT_SYMBOL_GPL(uv_find_secret);
 
 /**
  * uv_get_secret_metadata() - get secret metadata for a given secret id.
@@ -733,7 +740,7 @@ int uv_get_secret_metadata(const u8 secret_id[UV_SECRET_ID_LEN],
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

