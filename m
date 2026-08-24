Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813EF25B083;
	Mon, 24 Aug 2026 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582308; cv=none; b=gikTWn+9IFveG60ZvlTVL5RI5t5f9yNBJYCjztU56ETBt7KB4Qhtvu+9SjyvGtZKyEMGiL4wsZGU8NnpB4JnfnvcbT+YuiNQTh1l03DXEwXbPGcFrhgiV79d+NogW4gORMdBfaILewpt7gk4FwNV4FogejWfUtKoDO5PbioDgLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582308; c=relaxed/simple;
	bh=WO4HFdMFUn+K8RseUFT06gSlj/ebL2TqCVLAYdCIIIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ow5Lz8kV94Kb2s7ghgxUHEWFflVvY8bhHdZR41dfxoOT43vonKO/54/bRUX0grpq3NJCBR9JpNn1UxrYpl+wdnBp8Ra94lp9gFQnK/TdxVHY0i3s7ek6aZGUr6+VsYz3PUIzTph/lBXL5uF/Q8Hskk5cNfBxD+hmwki+91FOoKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k8zuMq5v; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k8zuMq5v"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1U5T084925;
	Mon, 24 Aug 2026 14:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PDhRi9Se+JYLvciHn
	Q14WLYewX4pqGx2gKb+TkyAMdE=; b=k8zuMq5vubt+K/VoKxCwxQ3yMptbvrlLZ
	4vprg9Bu5LIOur02nqFa19tIOi3/JuLBmmmlmYdLmA57qopCP9U0X5lomOkjhsg6
	ZhyyTMKTsQQPIEzhkjT8wX8ViV+N6RGv5Y43oIPTE+SJoRWHmMQBJuXApG4LFFWh
	N1mM9YduQ6KrgSwUNYYvRgL5UgSowBMdzhKep++jMD6l9cL7feBEFOINHqttQ9he
	rK39CY2mBxjtFRhuyTaBU6UQyBuko148eENrJ20dLVcxycF987Qgi53CmWAy3pl8
	WNxioywyqCvNYAYQGasMUB1Y/QmoJRKwbTRTj9HyDnlJsSCMpxuYg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqhytp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:38:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEQGHW029699;
	Mon, 24 Aug 2026 14:38:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3jpj4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:38:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OEcGRx46661926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 14:38:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B62E2004E;
	Mon, 24 Aug 2026 14:38:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A2F320040;
	Mon, 24 Aug 2026 14:38:16 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 14:38:15 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, thuth@redhat.com,
        Nico Boehr <nrb@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
Subject: [kvm-unit-tests GIT PULL 04/13] lib: s390x: snippet: Add function to create a guest of specific length
Date: Mon, 24 Aug 2026 14:35:36 +0000
Message-ID: <20260824143740.291583-5-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824143740.291583-1-frankja@linux.ibm.com>
References: <20260824143740.291583-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WxjaRcKFUVvvI2RoUatpfQtxgv1c5iTg
X-Proofpoint-ORIG-GUID: WxjaRcKFUVvvI2RoUatpfQtxgv1c5iTg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfXzZWjm7Z3KOF/
 zGRD8UIxcFiI3R1lfUHQTe2LGNFJTyJazdeVLVBX6AmBKs63XzBL0NIClK6X+6sqLjPMMFWabdl
 msRZydVjJCgI7w+fofAj099iX2m1b+Sdr9IkJDIiDrzCwd+WNYvoz1h/q1ifdZki5jsAxhmV/qw
 YYW0fciWrKpR1TT2zkL/UmGTs2YsxKydnBsQn5AOhMktYMjqm5Vvb0+eR0mHnXidjjTlVdCXdMW
 sA7I8Cl1i+mFts5qFTuXly9sRF9dYz+GgP2/dMa39n4aidBHQQyFfVGJGpnLaLrSEow3Cb27Ru4
 jCJmT7jNprKgSKDqS1TEtDUQD+ND7w21ZTLC/87T6xJHNSLmQnFwS5XA4uHN3LPf7REG8tzv7Ng
 EXVBP1c2fYohLGw9/1fFeWBx5uGJWWkjI0DmBXhOi3yEb8LyprER7Ty/9iunRLwy9OSViBaTtTG
 Lrn2x1/bl0cpeBqGkZw==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8c575d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=6ZxjpF0HYxlCLNsfbHYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX+Ka1KePf6dmg
 rK7IsIk3SRZvlpQOZkhDZjl3Z4YtBve5lAZc3WKRHqokqrA5V52ptqORX1niFT4Q2HK2Jgt6t9q
 9sQhjXX6YfZB/e+5asoBNm1a2lwuUDc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240122

While 1MB is certainly enough to store the guest code, it's often not
enough for memory tests. Let's add a separate function to allow
arbitrary guest sizes.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
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
2.53.0

