Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6166841B8F8;
	Tue, 11 Aug 2026 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437855; cv=none; b=RBjIzeDdjDSmqYOtkHcbTyrOEDTieUGEh+keCSdGA9Fbw0Swi6QxWO/YqlTC7k/VTKskWbmOx4eJA8IQppdW0hqrryijtm5roGEjSZ9X9zW/yuDXe0zWkNzWETtyfjV0uw9YmzQbkf2SHErL8VhddnbDIqmpQKd5FiorkW+EZ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437855; c=relaxed/simple;
	bh=rSkSxd7H6sMnrV3dfh8+hFotskFFf4wzUZl2cq9TNYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fLG3+3+hqmKIAxwb+6jj6G1leuaeYAfbcT/yl2sUifBXUfNCdOjDIdUvyZ3JgssJ5wH/QH3H7y+20n8X0PM3i6iRkvSUfKy6ZS2IaChzrX0kKKjBfEeuj0Z8X91/n7z0kXSaeYrPHFYEay9SDbjDBQPwXCsYouX3c7sfDN2zNL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pasm5HuG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pasm5HuG"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AN1bhB2999523;
	Tue, 11 Aug 2026 08:44:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=1c6WUok7b6+FnOaOJYOHsUnnYqZq
	mzg+63DdIUAWgD8=; b=pasm5HuG6zFh2TUYEM9qY2aZFl2kiOupBG9yEqKia7Lj
	JWJXHeXxNLooTOU/JnBVY8MQRpbImjX/I474CdQ9H8srA5lUxcKxRuwjOaMAT7vI
	5wrIix4zXui7IYTFy0q2BuvC6AfOL5rceJhBjXYqRVXsP466wWXOYbIMoDd9K3Go
	X2Yu0lSvmJiejXJXeAl8o9SzCC8eJYQRlqLJ0o4YxvB5N6UE+RsYy/BxYCUywj6u
	axHN1NGS3E2RDdQ4xDZR3QVbNaqggmoP51nZOnuRKoHRLVo0PJEe0nbSWblMvxGu
	q/Ycwiqa+5RRsb1tyS1cQX0NWlph/vyAF84m68sL2Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw3er6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 08:44:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67B8fHmr019249;
	Tue, 11 Aug 2026 08:44:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w0axg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 08:44:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67B8i18X41156962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 08:44:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FD3D20043;
	Tue, 11 Aug 2026 08:44:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D15A420040;
	Tue, 11 Aug 2026 08:44:00 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 08:44:00 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Tue, 11 Aug 2026 10:43:52 +0200
Subject: [PATCH] s390: uv: Fix loop condition in uv_find_secrets
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260811-uv_secrets_fix-v1-1-940a421a9292@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvyJ7TkiziL4SIWZb7cXCLQnCvycdZ
 2DmBcZIyDCIFyImYjpCAVUJ8LsLG0paCoOudVf3Ssk7WUYf8WK70iPb3nXNbJxBb6BEZ8Si/+E
 45fwBSxBGZWAAAAA=
X-Change-ID: 20260811-uv_secrets_fix-58a63b4a4ec4
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steffen Eiden <seiden@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7ae0d5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=oTDM0dCkufzkdTJShNUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ffpj1HA0S_0oZidvkTBzFP0Bb-JQD8Es
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA3MCBTYWx0ZWRfX//EH8xOrB1Ob
 WOfh/DBeYLpekAc9efSyuNfvhGMlpmXevObljCe7MCpl4sp69AiYNI8DnFNMxw7kZf/QN7F1uPp
 gHQV4HyKqlkfOG15b14mqddXvyP03HQ2213bQL7Wqf9AMV692EKs9lOdz2xeVi8kaLGccpCTmUn
 lgGsfKRcJwW09XxA5TAhEz7CjKDd0Ce79CAg95kf3gvNJsnZOZg1fNIw486LCH0VpALBNTPnlsv
 q21ozunRhgJVL8/6hKch6+AnfKQFvpmJY3MsxOmJERpv4hUG7irpFYAVGyywq1sUSCVhN/842aG
 hgGwoyjQFbyRsbMqnI1YDrdff3lCADB8DfYZvw9EZ35xAuxbw7IzFfaBdP/2xUqRf5/xe2Zu+gE
 JhXEFhDN4qVS6iPIKT9i9YcCiSmFZtbL194p7lG2bewYxaztxuH6YxXcsjGESp/KBMQ01BXB/AR
 WNhTrBIYCMB2WEryDZQ==
X-Proofpoint-ORIG-GUID: Ffpj1HA0S_0oZidvkTBzFP0Bb-JQD8Es
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA3MCBTYWx0ZWRfXwFsUgRFAaosF
 rVywTHUA4vppVps32twOBFydDUeF9q5pE1SrqgLWNJQ4a6I8h5fLzOQp50CDcetMrV0oqiVQH53
 1yn19bBFKxi7qUBOVSoVQn9czToUp2Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110070

Nothing modified `start_idx` between the assignment and the comparison,
so the condition was always false and the do/while ran exactly once
even when the UV returned UVC_RC_MORE_DATA. Systems with more than
85 UV secrets got -ENOENT for any secret past the first page.

Fix this by setting the start index at the beginning of the loop not at
the end. First test if there are more secrets left by comparing
start_idx with list->next_secret_idx, and then set the start index to the
next secret index.

Fixes: 7c9137af2042 ("s390/uv: Retrieve UV secrets support")
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kernel/uv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index a284f98d9716..d970b15ef126 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -781,11 +781,14 @@ int uv_find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
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
@@ -796,7 +799,6 @@ int uv_find_secret(const u8 secret_id[UV_SECRET_ID_LEN],
 		ret = find_secret_in_page(secret_id, list, secret);
 		if (ret == 0)
 			return ret;
-		start_idx = list->next_secret_idx;
 	} while (list_rc == UVC_RC_MORE_DATA && start_idx < list->next_secret_idx);
 
 	return -ENOENT;

---
base-commit: d58772d8520c7ef247c4b95c9bd76d3a25da9ff5
change-id: 20260811-uv_secrets_fix-58a63b4a4ec4

Best regards,
-- 
Steffen Eiden <seiden@linux.ibm.com>

