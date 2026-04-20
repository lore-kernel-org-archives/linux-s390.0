Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D029338A739;
	Mon, 20 Apr 2026 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776674988; cv=none; b=hmNgsz0TsauQPlcsmpqsaRpJl45Fl+GKvuULLtLrhl/F1maqBfOwLxIcKNyPoVFd1/7fXDJbzGvg6liGxgtpAI0hX3o5vXFN596wRLuGl8wjRIDn1xe1g1FfJxt90mYc2u3IeaHMlszkNAJmbj64f0Oun+rGx24BVvEE+1xZAIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776674988; c=relaxed/simple;
	bh=UmE6Ogty/GCGhZRhirVAUh6/GDuTqGuo8eeBJiX6kwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=saY3/FD/7SnJs43bP/CTxa5u39bklmoLlVgrSvjqwXwlXHar8peA6cBdygIvORsJt0LkV3o/7UcqtexJki4R1+oUp8LMkkxA7K89tDhEqVkc00y36Gja7NIUhkIvevlE1wqVWdbRv3jwXzJ9sjKEYZzQcR7QHZE/udy3DKtxClc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fi2eGyfQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fi2eGyfQ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JBNdYr2386398;
	Mon, 20 Apr 2026 08:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dh4bEdvmvOxVRt0xO
	hgPvzHvD+rM22zmnu4oQNc9l7I=; b=fi2eGyfQ+0v9giGuPbH8ThLDXWNlKjuE8
	9clzmNBVaIo0SCMkJwjLRG+e83Pz9Smm4Z7EAEFPba6WbGEy4yQZiiNPQ5oqZCYw
	3mdg8m77bkjU5pdV/q7XQOuyPN4xroNUDiEz+bsIEYYbERaTzEJYdzr3oAkkidYF
	mUoiXz1jpqXFE0PI/0AXDvSsLrL6OBhbi/4YxCHcmu95XXWAEDSJyMAza9lNvFwd
	AOb+FABJ2GL83aSQLSBEPrdtnP6Qign635fb3XjHr9vSheiJRnmu9cGMHvs6reRT
	UpzAtp5pj1hOET1OOL/TPhGXWPbe4M2KFXe4ol85BqxiYoPmwcg1w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2h9eaa3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 08:49:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63K8ZUUK007018;
	Mon, 20 Apr 2026 08:49:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmnsguy9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 08:49:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63K8nfAV30998864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 08:49:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56D4D20043;
	Mon, 20 Apr 2026 08:49:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BF062004E;
	Mon, 20 Apr 2026 08:49:41 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Apr 2026 08:49:41 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, nrb@linux.ibm.com
Subject: [kvm-unit-tests PATCH v2 4/4] lib: s390x: snippet: Add function to create a guest of specific length
Date: Mon, 20 Apr 2026 08:44:25 +0000
Message-ID: <20260420084933.251244-5-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260420084933.251244-1-frankja@linux.ibm.com>
References: <20260420084933.251244-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MVtza7tYBRyDmk9w1MUenwBzDVPkCPJH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA4NCBTYWx0ZWRfX4rh9aNqWwpeX
 XTQuKZ/vY6ky+Sm0CAU0nMROQIOheKhke38lR+5tC/Vs94D7tNEKxKEuCbTqnkq5zwqZxC5HkDb
 a9v0kLBqx/XvxDn2+IABhROsMygj0YWkg2pz1OAXYAjrzZlbCv/7mZhCPa1Mf9yj69DsAWRV73x
 kY+X2OHHLonwOtBF70nim8w+Q/nGd4Nlex3XWh1rc/J+HazD0YYjOHjB2PPiHdgtiGGU8LQ3Jug
 OFmcyjLItDGI36PFGpkkB/30ttiFYV+VKgsg0FOm7BGexSg4kmJaGQguW9U65ba0qP/CWpjOlHZ
 sfHyIAtqzY8VbB/AioM1hZybNjk9B41fjaRZvfz7suiloKyI57qBKVIG7sxZT2qtooN2sEyXK5v
 s3dUNHS9/6NDPtWEWfzM18FAZKXX+PRZ1GYOiiWx8iSOLp0rHUZHw4hvvuSgCabjTaQulnVF0qj
 yDDu1KrdrP9sNpnzrqA==
X-Authority-Analysis: v=2.4 cv=XLYAjwhE c=1 sm=1 tr=0 ts=69e5e8a9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=6ZxjpF0HYxlCLNsfbHYA:9
X-Proofpoint-GUID: MVtza7tYBRyDmk9w1MUenwBzDVPkCPJH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200084

While 1MB is certainly enough to store the guest code, it's often not
enough for memory tests. Let's add a separate function to allow
arbitrary guest sizes.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
---
 lib/s390x/snippet.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/lib/s390x/snippet.h b/lib/s390x/snippet.h
index 94688f49..05c9a2d4 100644
--- a/lib/s390x/snippet.h
+++ b/lib/s390x/snippet.h
@@ -123,10 +123,14 @@ static inline void snippet_pv_init(struct vm *vm, const char *gbin,
 }
 
 /* Allocates and sets up a snippet based guest */
-static inline void snippet_setup_guest(struct vm *vm, bool is_pv)
+static inline void snippet_setup_guest_len(struct vm *vm, bool is_pv,
+					   unsigned long len)
 {
+	/* Guest sizes are specified in megabyte chunks */
+	assert(!(len & ~HPAGE_MASK));
+
 	/* Initialize the vm struct and allocate control blocks */
-	sie_guest_create(vm, SZ_1M);
+	sie_guest_create(vm, len);
 
 	if (is_pv) {
 		/* FMT4 needs a ESCA */
@@ -141,6 +145,12 @@ static inline void snippet_setup_guest(struct vm *vm, bool is_pv)
 	}
 }
 
+/* Allocates and sets up a snippet based guest */
+static inline void snippet_setup_guest(struct vm *vm, bool is_pv)
+{
+	snippet_setup_guest_len(vm, is_pv, SZ_1M);
+}
+
 static inline void snippet_destroy_guest(struct vm *vm)
 {
 	sie_guest_destroy(vm);
-- 
2.51.0

