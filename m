Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0383D75A6;
	Wed, 15 Apr 2026 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776243169; cv=none; b=J6214N3v/11KUOp7AfKh7ixT65/gl59iY2q5FihzfR2z1pjbv1Ee9J/Fj2pxwZwLWdcgULXvJAmFGRBttLS5inxOmOTGZVlfiOzu6YXxJiJk2ssZxSLyU9BAGKNWy1xOorEomZf/ZruYmRG1X9h0S1ES5vnR0oUoOr+HkrUtnFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776243169; c=relaxed/simple;
	bh=7XBUReqPnza0+VBPetUsQinSSqYiB9lIFaGi3+XGv7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fcq77huyaKMNFcWkbm+QmWJjr/QQgEHFDmDFlSxowndptoKVs8k3b08FK80Z7uWLiV8WrtoB6S9wrzv5FRm+MEBR3EUYxesBTazo1Q0LW6UQtVmwyrM9BBIQuwXkg8x2BnrBXUIuQ8uSjGJnhAsBTQBk33ShWL6lh/4IADCCSUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WdL0nHn3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WdL0nHn3"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F53PQe1833338;
	Wed, 15 Apr 2026 08:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Y2nebPq7dPlnYTubc
	w+/keVB7s5nuRZG35cTnBaVQIY=; b=WdL0nHn38X3V8b0Kagq0nFjjugD1ABiUi
	7ocn5rPsD/nSjQTheq7nSkwDt6g/gVM8GvkTsbYsfS/aRGugoOf8+FMmSQXQwQZ6
	CQ44XNQ0L5Jz5WY4UfEzobPfgSfcX4t1wccp21JQrL98vh0KF1vZM2obTI1Lpfle
	fRC7Dw5kd6n8ggvuZsZFbxMErAPL73hDZkSAzEAE3VaU9TFMBEg0U8K5kzNw9Tjo
	hyE0pF26duGVGsrqmZmAkqPzXbbDb6zhljwluB9ASHN71HWcwvuQSlSr8y6+TMLU
	WPnGYtj/jbeBsBIUJifqkoSLQ9dF4xJM2eFQpJqRVXn0pV85ZOy1g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89rf5hv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 08:52:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63F8mTsv004162;
	Wed, 15 Apr 2026 08:52:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mndds5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 08:52:36 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63F8qWJS24117740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 08:52:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12E672004E;
	Wed, 15 Apr 2026 08:52:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E778A2004B;
	Wed, 15 Apr 2026 08:52:31 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 08:52:31 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, nrb@linux.ibm.com
Subject: [kvm-unit-tests 4/5] lib: s390x: snippet: Add function to create a guest of specific length
Date: Wed, 15 Apr 2026 08:45:44 +0000
Message-ID: <20260415085145.91197-5-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260415085145.91197-1-frankja@linux.ibm.com>
References: <20260415085145.91197-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA4MCBTYWx0ZWRfXzAR1Xmh0CKmd
 DMkRPUvG7IR9uiDvwck7fBrze9xpH17CmAfIaYwF1q2KmelcD8+8JUzDU0R6jMjhK1Dia69AGq6
 L7JCoU8junur30UWubT0br33ppP7s2AbEMdyLbYtJsAEoGezBcPGd2qEDgWKjMN4XyAy68F1Wam
 3/vstAifENleJD8EMLLcgdsa8V1e21OgSI4nZZEx6VX2CSed9B1VI1GBtg/SeGEBT73xA55fCm8
 FmN92r/L3yevdMfGSDqh86F4EO4pmPL0/vDEvTzUoNU1cq5ozkIRnQpEjB9lQPbK9rP2tBSTLEB
 52AAqL4sHyrrWcBxh7/6QqEtYcUIt3QlcGyRhcdw7RMVYfGixpz/fnrondwkQs3pysezgdXJg+I
 oIZe9KkwEuQqqk8rdguDTAWjP3p8+y65UHs+6bgXUKStjYgq+Boj8bafQO0PWu1zjLhCEP3Km+8
 QLLzb7FYOR5PbgPbVpw==
X-Proofpoint-ORIG-GUID: jwmvLdBIUVdJ2Vjr-K7A9zopP0FsRLu2
X-Proofpoint-GUID: jwmvLdBIUVdJ2Vjr-K7A9zopP0FsRLu2
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69df51d5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=-7hCWoKEcjqXKOKG9GAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150080

While 1MB is certainly enough to store the guest code, it's often not
enough for memory tests. Let's add a separate function to allow
arbitrary guest sizes.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/snippet.h | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/lib/s390x/snippet.h b/lib/s390x/snippet.h
index 910849aa..c58ae135 100644
--- a/lib/s390x/snippet.h
+++ b/lib/s390x/snippet.h
@@ -123,13 +123,17 @@ static inline void snippet_pv_init(struct vm *vm, const char *gbin,
 }
 
 /* Allocates and sets up a snippet based guest */
-static inline void snippet_setup_guest(struct vm *vm, bool is_pv)
+static inline void snippet_setup_guest_len(struct vm *vm, bool is_pv,
+					   unsigned long len)
 {
-	const unsigned long guest_size = SZ_1M;
-	uint8_t *guest_start = sie_guest_alloc(guest_size);
+	uint8_t *guest_start;
+
+	/* Guest sizes are specified in megabyte chunks */
+	assert(!(len & ~HPAGE_MASK));
+	guest_start = sie_guest_alloc(len);
 
 	/* Initialize the vm struct and allocate control blocks */
-	sie_guest_create(vm, (uint64_t)guest_start, guest_size);
+	sie_guest_create(vm, (uint64_t)guest_start, len);
 
 	if (is_pv) {
 		/* FMT4 needs a ESCA */
@@ -144,4 +148,10 @@ static inline void snippet_setup_guest(struct vm *vm, bool is_pv)
 	}
 }
 
+/* Allocates and sets up a snippet based guest */
+static inline void snippet_setup_guest(struct vm *vm, bool is_pv)
+{
+	snippet_setup_guest_len(vm, is_pv, SZ_1M);
+}
+
 #endif
-- 
2.51.0

