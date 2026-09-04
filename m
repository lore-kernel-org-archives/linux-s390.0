Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403AA41CB31;
	Fri,  4 Sep 2026 06:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502025; cv=none; b=HJIsN/MjnSM4/w7L/6mwdeAN6BIt4xt7NuF/EUsaGwTsA/27jHqlErVDZhhvtu4MErf6JM5xusiQMlEGSJOzPmHleG8DVqjTyx238C6PkFwzA00Yg3EL3sA5ar5bEawCJi/46FIkMBX/oiURHLcdDEZ4hrR5VajV08OCdkNoLhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502025; c=relaxed/simple;
	bh=Rx+D++fOJbvAYXNm5yiBOwh5WsThNrKjpyNCMLKC41A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NScgNbvOPqQgana8q/LsDb0GzTRK9Ck3NxzXYAkrt3GbRZW3QNSedTGagQQ+Zw9CiDpB2PMo670UiOvLXb/54Emac21A7IoMjxkae1zlCv7nH/TLeiNeEVYWyXp7bNKv1ED5ooT1hBzREcPT6OUuHGutjNgHY1it/8BBfSsXs6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SNtR60YV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SNtR60YV"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464jLk3994202;
	Fri, 4 Sep 2026 06:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Uxl3GulOC/zNdN1Ba
	nRrvX9gYYIHHh8kZ7pqCrjaknI=; b=SNtR60YV8QrOhbFDlddkbjepBqF/tw6LH
	QCFFfQXiQzcMDpBR4E4YOmSQVyDa5/OJFPIDKxZYpREBIIjhmOXYiAULSGGJkbL+
	UjUpDd4fxKGvWHsGoZgOumFJ7IYfvl7UI7MUEPBctwG7jxX8s/Vuv+hLqXlAtQO0
	kgqO17Hk9MNrCnQGQc1PCwjf1rEVmsrXhQdImjqh5WowyxVyqoUBFDbBDLa4XNRj
	ZFqzFfI+eV6xCvI77qt6slaIyvjZ4cEGMFCbm7CAi9HtlrsVubYwEcjbfrEXR4TC
	pjFPf9806S8uW2zE5Te6l73oxH74eelm4L3Okz3Uqe9aEKYiewFnA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnue8hmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:07:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6845uG7D015858;
	Fri, 4 Sep 2026 06:07:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjauv4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:06:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68466rM845351342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 06:06:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB5ED2004D;
	Fri,  4 Sep 2026 06:06:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C56720040;
	Fri,  4 Sep 2026 06:06:53 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.53.213])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 06:06:53 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 10/11] s390/uv: Fix loop condition in uv_find_secrets
Date: Fri,  4 Sep 2026 08:06:46 +0200
Message-ID: <20260904060647.562443-11-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904060647.562443-1-imbrenda@linux.ibm.com>
References: <20260904060647.562443-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QChFfa0PDXwCx-bkMFx_j47stJk7frU6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfXyUpQPjskYDwm
 ZAXmzT+MRtFwP8kyX8QUxEDxOa6b2OF13VM9J1dX0gq69Cv8bxge4/xxJAVFG+JNfooBlcvKnay
 Tl0o3qBzGrzPQNfSgmss0OYp9vejmAGT2TBh4/zbgXa0z22J54G9haGvdwk06wfCIbRoZJRDRN0
 C3IkkGf4JJIAYekhHfkQGSnE8L/zl/7ykKfjdKA5a0wafB5i8RFjvvK1KpZi83X5M1SJgqyuCn+
 HB/Fl5L7rqGt7TTZbMhrRjFnhAY43Q9jMvv3w9zqz/tPy9e3afau56TwV1ftHiWMNkXhdmaW8Rc
 QSiDOnn2WFkQfz8MFgSE4QOfEf9/6uijiBJDG9Y5B3MOnF6iKIygDOSsKUMYzF9qdyk5tMRBlSx
 HqOpXvXw/WuevAzgjUxPJVjXRN8SI/Uzp5yly+vIe+va4Id4zb8kMz9h0kkpBh8LatyEq4e5ChW
 fuTCMtttUf9sKLlEKZA==
X-Proofpoint-ORIG-GUID: QChFfa0PDXwCx-bkMFx_j47stJk7frU6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfX0On0Njvs/D8b
 25VDmJ0mtzf8qAWEQVCp/PMSg4O82vuI07aFW4LjoGX7qT9MiGHDh5wrdAF/bphVcBT+G1nAIv9
 YMt8tOdoDV+s9df0kDTXF3gkbtgT4o4=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a9a6004 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=4JZJ5w1qc1-yHB45ZIcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040054

From: Steffen Eiden <seiden@linux.ibm.com>

Systems with more than 85 UV secrets got -ENOENT for any secret past the
first page.

Fix this by setting the start index at the beginning of the loop in
uv_find_secret() and not at the end. First test if there are more
secrets left by comparing start_idx with list->next_secret_idx, and then
set the start index to the next secret index.

Fixes: 7c9137af2042 ("s390/uv: Retrieve UV secrets support")
Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260812-uv_secrets_fix-v3-1-a85bd29e0666@linux.ibm.com>
---
 arch/s390/kernel/uv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index dc14ebc0105b..52003c463fad 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -846,11 +846,14 @@ int uv_find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
 		   struct uv_secret_list *list,
 		   struct uv_secret_list_item_hdr *secret)
 {
-	u16 start_idx = 0;
+	u16 start_idx;
 	u16 list_rc;
 	int ret;
 
+	list->next_secret_idx = 0;
+
 	do {
+		start_idx = list->next_secret_idx;
 		uv_list_secrets(list, start_idx, &list_rc, NULL);
 		if (list_rc != UVC_RC_EXECUTED && list_rc != UVC_RC_MORE_DATA) {
 			if (list_rc == UVC_RC_INV_CMD)
@@ -861,7 +864,6 @@ int uv_find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
 		ret = find_secret_in_page(secret_id, list, secret);
 		if (ret == 0)
 			return ret;
-		start_idx = list->next_secret_idx;
 	} while (list_rc == UVC_RC_MORE_DATA && start_idx < list->next_secret_idx);
 
 	return -ENOENT;
-- 
2.55.0

