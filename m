Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A44A37207D;
	Wed, 12 Aug 2026 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550139; cv=none; b=flD8i25gdwDu5r+SzOVanc77cg4bcKZrgn55uBetDhSnY3eNUXyNn89HNvLw7lSCxKR4vzpb85fKoz5LQTaaDd26JK/O2ReqpG1I7lhTgRX9knsyzCYGlipmM8ddjWMSLXoB5w0JfSkaZNy0y8AxcaR6G0P/JyaYXPLCyqeJA7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550139; c=relaxed/simple;
	bh=k2udXCvK8y0AOZrm029riw1s57eQvVy5JdPzf5A+bDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NngnF3TM33CxyNeu1HSFTczmZmKuZBuh1++0WVZzLZAujd1Rmv+OaDQuUqd0fXSqxKSJFlJwi3YYff1rTlXG5PqSz1tO9feX4/tahy3t88KlhcTtab3UwezvPBX0+GQYCM6aAG6QvtqrSClYFmvKZbjp7IoHI6pTmAtgWejWbEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HbP/0YV+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HbP/0YV+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1vFT2586065;
	Wed, 12 Aug 2026 15:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Vqs4cK
	YZH/FSUOkiz3sXXq6lgU1Aomj2b7lTprZbbRE=; b=HbP/0YV+ad3HCX4LlofjDB
	58rhZ/Xf+OS/0OToBXTDu4tUsKTPsT9mNalHL7IdAkZXCboBelDM48TzzOIYl6aw
	2RHi1XifkY5fhdDZdlXu8NHRSmi7Wsb9Vo+U0Uv+OyKpI5U+a6kDQof4focadEcr
	fdgby6kpcBolLpZh933JLOWbkuzSUhc27aaBrCrfM6idAUbw593Djozx8uTkG1Ex
	jx5nER8UbXemmiFzqhtBufm6YxTARz/Bi0auPWI4pPD/ox3pUU/eo7xMeNFJaY7S
	2RiJVE+psimzsQqbcfWnndBJTnv53OSiK3M7ZMuPIvR3A0hFcdVb6fVIe6j/3l5w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23uvej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:55:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFfNXf011544;
	Wed, 12 Aug 2026 15:55:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjxsdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:55:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CFtUTi49545704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 15:55:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC64820040;
	Wed, 12 Aug 2026 15:55:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AE5C2004B;
	Wed, 12 Aug 2026 15:55:30 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 15:55:30 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Wed, 12 Aug 2026 17:55:19 +0200
Subject: [PATCH v3 1/2] s390/uv: Fix loop condition in uv_find_secrets
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-uv_secrets_fix-v3-1-a85bd29e0666@linux.ibm.com>
References: <20260812-uv_secrets_fix-v3-0-a85bd29e0666@linux.ibm.com>
In-Reply-To: <20260812-uv_secrets_fix-v3-0-a85bd29e0666@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7c9777 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=oTDM0dCkufzkdTJShNUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX/pmYfJCXnliq
 s3nn2O8sWlWrhw3l4JL2f7oX62/8jGBOnng3qw/KtJNLoIUywnaG+qHL947TLw2O/c3fKEE/MXv
 nCdHviIQ/UVSiOySgBs7EUWtx72wZjaSBHRVeeKLOI8/qiERwnNMzuJdGq1GHmiWWAnOlexI4JL
 Hc+nPYr49GCdVmeJSCESjx2pp3sZ+NcFjcxw63ujkEesWFcMuWjF+7LF41qXyFzEr/QSLgBdizc
 OcslOvnesNqG5x4X6sea9J9Sy1rNAfmDaGfOip9phgzDzU2sV/nzy0zmZRheh8CWiX3yC+6jwfw
 TQODnYCU1aI48ZQAGUUuqpb8jdc61k/67Qmpmid51KuKGH7+1deo7tfMuCmvYZNFZzPQhp6SaSx
 XEg1iYimWooAbVN3xkUlIEJVP2BDUQHHTkUwOv8AC0A8pUUvOc9C52muLUWFy5s+zYap0NVE1Up
 7tU2GKszZr0PUm78/+w==
X-Proofpoint-ORIG-GUID: hkT91K23QGPzGq3rhLJIUNHC94qPraFJ
X-Proofpoint-GUID: hkT91K23QGPzGq3rhLJIUNHC94qPraFJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX0t4PvnUn0jqh
 FWdOuN6K4i42eUsIwRxO+vH/yluO27NOPOdboMxB+QBCC910oStZeJB/+K9QjGWXLOfNMCe0B2i
 cICj8bEeyIKjLE0Vyi5yC3xaHxMnCrY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120126

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

-- 
2.53.0

