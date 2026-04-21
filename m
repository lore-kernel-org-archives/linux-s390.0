Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736032E22BD;
	Tue, 21 Apr 2026 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776771948; cv=none; b=RBX7xV8fVaAuIPJfbXVwHrWK//0TVqkvAhL399WOuyUqjf5PTuKjvcjtubHyiR02Ytw01fbqoJPbDUiYw3VBWST6WG2cA6JpmjUN8MjPJAJsufxLYZ9b1KydqrYaQXhwzwMQxNkAw5SsqR6XeynK68gUqBb/slkM3p8IQmwKRR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776771948; c=relaxed/simple;
	bh=u0KZ6D005G1aYJpHOmhYeKSDmumV3nOWZhJGCoIisBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lpaFjmeaK+zlDEu5WSD1hHcSnQN18p9iCb0uPsAxEiz7srrx/eyq/eQ0OuDQ+w/z7FLMShhawckboHuhXa0zRcvPJK23zSVvWgMzfbGD3HXtkNie1iLmpjap2GWaLO6x3POQjfS5dt8Rl2Ug+lo7i3upGC9HpF9FsKEc+qJhU1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hyqWsT/R; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hyqWsT/R"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KJgVZj1650596;
	Tue, 21 Apr 2026 11:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4yHUqD
	H3/wcRiZgKnJzzvhBE0xR7rEqnzAO58pmnvZI=; b=hyqWsT/RS34HgQp35IlTJX
	pwYbhru0wPzI6ESCObFTEiPudhUIN9zGoQBE5Q5Xc9SMXw+Ra+4bO6y7cZHfdfLv
	krSFcy23GkEYeaymVfgyg7AI/AaJFPp0KvunNgp6USjjyxBtnvToYKLHL0vIckGv
	6EaWyabUA3ZLXY/eMTpQYmnXa9JUktZxBHF2LTAhfIqWhtXQxjbs2jxCQY2lO6dv
	pIID2aTWTxP0zZq5qQggnzzbvzy4HO4tFzivGemp4itdbsCyX/DZFoKwgOBLtuvx
	C0krbUkwxaUOZZ5cVEOEt5xcW2H6xcxX/EgtzuNcbE2V2xMpr+riXOgVlzN9jQYQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k541uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 11:45:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LBZVPR002821;
	Tue, 21 Apr 2026 11:45:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmnsh0fbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 11:45:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LBjbvE51249638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 11:45:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73CBB2004D;
	Tue, 21 Apr 2026 11:45:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 560AD2004B;
	Tue, 21 Apr 2026 11:45:37 +0000 (GMT)
Received: from [9.52.198.32] (unknown [9.52.198.32])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 11:45:37 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 21 Apr 2026 13:31:10 +0200
Subject: [kvm-unit-tests PATCH v3 4/6] s390x: sclp: Use sclp_feat_check
 directly to read DIAG318 feature bit
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-vsie-stfle-fac-v3-4-3cee84efefa3@linux.ibm.com>
References: <20260421-vsie-stfle-fac-v3-0-3cee84efefa3@linux.ibm.com>
In-Reply-To: <20260421-vsie-stfle-fac-v3-0-3cee84efefa3@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
        kvm@vger.kernel.org, Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1340;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=u0KZ6D005G1aYJpHOmhYeKSDmumV3nOWZhJGCoIisBo=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJnPkxPOXjfgrbmf69SnxiMSP9khM+uBZ4TlFbn8ePF7u
 b9r977sKGVhEONikBVTZKkWt86r6mtdOueg5TWYOaxMIEMYuDgFYCJ33jIyfMl8eXcLR0eiz/ee
 hcs4L1xI+m4/+Vjp1EDJS79CmA/6BDAyvDwtL1lpEPNcNONxmJH6ihvmVUaztuW2np/yxbR0Xgk
 XAwA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pW3mvhPgYxy4FvJ2RE0itj9LQDH_r57n
X-Proofpoint-ORIG-GUID: pW3mvhPgYxy4FvJ2RE0itj9LQDH_r57n
X-Authority-Analysis: v=2.4 cv=VP7tWdPX c=1 sm=1 tr=0 ts=69e76366 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=QsVmYarvNes-L6UfxTcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDExMiBTYWx0ZWRfXx7sUTp2S+c8B
 x0KUsPOjIKbIGstJOgWnhs0tMwy9ghAfOHCc0evZJKZAMiDX8jIDLFdiWcQz6xlkOZtw8zCxA43
 JdTSK83dwbBPuuox9YOqNg64ctLrYyN9IWF3QK1G62j9uiCwv78owSdMnqYyVwlfjj8M0XJ1eii
 18uQejDZNJRpv4o2qFEAwj3RxW+yL1Kb4+ELG1XKMXG+Pp1EWzZ2QHdSLTqIlZKf6hz7J6C+bFf
 O/CB/73ed2ZRKRSB9vbUS+Dv5F7hj5FjrynP2iXWhPrA5aFtvn3T6HaeeyDAQRH+ifyW7LlLwfg
 +B7YJ1Owhy5a29I8vh3KTeqNP4pFH9DFWCd24WKv+loH0T36xCV05Ao8xEwkgxzNJR6ai+Vdn5k
 1s97LvVKOw1eSVaWP+dlt0ZhNkvBJHR4krJ66IZi02oc3/3o1p8mjTU+kqec7R4fbR1eEAet/nO
 rWeeXpl4vOxEs693g+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210112

---
 lib/s390x/sclp.c | 2 +-
 lib/s390x/sclp.h | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
index d624872cba60..ad2ba99ee1e1 100644
--- a/lib/s390x/sclp.c
+++ b/lib/s390x/sclp.c
@@ -186,7 +186,7 @@ void sclp_facilities_setup(void)
 
 	if (read_info->offset_cpu <= 134)
 		return;
-	sclp_facilities.has_diag318 = read_info->byte_134_diag318;
+	sclp_facilities.has_diag318 = sclp_feat_check(134, SCLP_FEAT_134_BIT_DIAG318);
 }
 
 /* Perform service call. Return 0 on success, non-zero otherwise. */
diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
index 42a2f2e9f25a..87af429b5798 100644
--- a/lib/s390x/sclp.h
+++ b/lib/s390x/sclp.h
@@ -144,6 +144,7 @@ struct sclp_facilities {
 #define SCLP_FEAT_116_BIT_ESCA		4
 #define SCLP_FEAT_117_BIT_PFMFI		1
 #define SCLP_FEAT_117_BIT_IBS		2
+#define SCLP_FEAT_134_BIT_DIAG318	0
 
 typedef struct ReadInfo {
 	SCCBHeader h;
@@ -169,8 +170,6 @@ typedef struct ReadInfo {
 	uint8_t  _reserved5[124 - 122];     /* 122-123 */
 	uint32_t hmfai;
 	uint8_t reserved7[134 - 128];       /* 128-133 */
-	uint8_t byte_134_diag318 : 1;
-	uint8_t : 7;
 	/*
 	 * At the end of the ReadInfo, there are also the CPU entries (see
 	 * struct CPUEntry). When the Extended-Length SCCB (ELS) feature is

-- 
2.53.0

