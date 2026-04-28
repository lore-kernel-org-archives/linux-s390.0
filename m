Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363353CA4AB;
	Tue, 28 Apr 2026 08:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364144; cv=none; b=TlJYWe860U1tfwzt2HpTivBVfRI0Ok9TntvWzoO3kISdlNAK6LJJIjGd0pCbbyx+C5eRru81uwNhIpymLjiVIUR69G3ptguExWE8OJ0M5W/8f06XDOwRd6HhCopYMzzFd9LM9LnOrwKwIAmTOdJJPFZ95cM8k6glvieoft8R91U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364144; c=relaxed/simple;
	bh=B00obTVVuGiGeKG/AsWeB9ao39KrBXVgcpHBKo6LtXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MpgZhKOw0pTj0ydfSQ5mPuyCNwxU0pJQRiN6cJbmT6H8vySdA3r042cVmQKSrasT6+lTzlggMgwLPKLmRDDSGiCuI2lMjjU9c27e7ElA/wV0FF/T4oHSIbd4Mm4BZS00j8SkzCm976hg9pBuMDIEefuMNK19j5cRMwvfRiAuueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SmnuTeMY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SmnuTeMY"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RJ0LR4996575;
	Tue, 28 Apr 2026 08:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7ZK+CS
	x72GsXB4jyuo6slFP6YrgpQRLof0TLRfeoMek=; b=SmnuTeMYHEk9u0bD7ifPfP
	+voe6urdbaAHz4xl0Jr90NpArc8ssB/Z7MwgZKx8iKr5DcFwf7khc2JP6c3tgSGh
	kzsyp0H1FwsMAI4x5h14q2Z2MQpEjFn+OoYg/gj4CsAHuuFJeG/ZkRwR2/mhM1J3
	fJD4MqX9l0lNEi4gxA9PiyNfcmWZW7hdSldF6sI7uvPDdFw9u5GyikNd52c3aFOe
	wHvsNCQOjKuwF/xq88M174GKrgVVfSVKZM6BRTTSCF+sVZ1HrLib5qcwmhg722+X
	a3SfnRD4h0yPIKFq8JlAFkKqVU53FEi0XiqhCbLorvnD9FLJvhNFRDlzO4q4xvqQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vba5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 08:15:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63S88sQN026992;
	Tue, 28 Apr 2026 08:15:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5g8nfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 08:15:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63S8FYu246596548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 08:15:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62DB020040;
	Tue, 28 Apr 2026 08:15:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B8E92004B;
	Tue, 28 Apr 2026 08:15:34 +0000 (GMT)
Received: from [9.52.198.32] (unknown [9.52.198.32])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 08:15:34 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 28 Apr 2026 10:15:25 +0200
Subject: [kvm-unit-tests PATCH v5 4/6] s390x: sclp: Use sclp_feat_check
 directly to read DIAG318 feature bit
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-vsie-stfle-fac-v5-4-34c5933a218c@linux.ibm.com>
References: <20260428-vsie-stfle-fac-v5-0-34c5933a218c@linux.ibm.com>
In-Reply-To: <20260428-vsie-stfle-fac-v5-0-34c5933a218c@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2286;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=B00obTVVuGiGeKG/AsWeB9ao39KrBXVgcpHBKo6LtXY=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJkfcpZe/sd+1zZqhr96dYR20rvOr4w93Ws2zFUTdTjG/
 HBRu8f+jlIWBjEuBlkxRZZqceu8qr7WpXMOWl6DmcPKBDKEgYtTACbyqYPhf0W9u1LcxvVeKdsY
 Yn7emBh2qnVTQsXxh2tkV/Of0JreLcPIcFZK+dTBDZOPX5Y5d7fH4eLlf8uWyR6QW/j/kWcz6wz
 WLSwA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f06caa cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=9Xh-GkoT5eCmbU3qKcIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: APEefdeNTp6TbM9Eoadxxk6AwIBPMXkU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA3MSBTYWx0ZWRfX9hTex5FxgrtV
 Ozvlk8NuFguetuFvhUXyefdwxUj8UPxF0nBzuvPjWdaWUDAQ7CGER08XPCgVFYo328wTLBJvRgS
 R97p1PuRUydFD5T0PipEvBQbqUoQdJjoNT/fMpZ2ZDhDSKVus0xbDVxWurD6Cwo/n8kvrkXmswg
 knA4pYQoxrrIkSX/VT/PoSgRWDlce6BoB3r8E0l5UoZlFtW7q/b9Hqiw7LrX+GzT2vInlvlyVXM
 P8OdPxHuYiRItRqp1ILKVzp3NOodfvxAd02dxrly8pX5FD3sVrON8LwLrBfDn2VhEsuF7vuhE59
 DoDnoUSZyXojMvSwjea4kryJgZb0l9ukl7xjIKFpLeCdRPtkEFF7qzJJlCXU6iZlUwsdicQ3EOm
 m7i2tS19AP2/ZWzl2R6TSuKaWU+MuWsDGcTz3Jgs+3p7CX/sEgBgsV4fyuHKOON5r9+Z9tzf4fd
 t1NMw4rZRdfq681hynw==
X-Proofpoint-GUID: APEefdeNTp6TbM9Eoadxxk6AwIBPMXkU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280071

The additional entry in struct ReadInfo is only used to set sclp_facilities
where we are aware where these bits actually are in _read_info. So it is
more readable to directly check the bit here.

While at it order feat checks by byte and bit.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 lib/s390x/sclp.c | 3 +--
 lib/s390x/sclp.h | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
index 1ffcf448e558..9d9fd3cbcb8c 100644
--- a/lib/s390x/sclp.c
+++ b/lib/s390x/sclp.c
@@ -157,8 +157,6 @@ void sclp_facilities_setup(void)
 	assert(read_info);
 
 	cpu = sclp_get_cpu_entries();
-	if (read_info->offset_cpu > 134)
-		sclp_facilities.has_diag318 = read_info->byte_134_diag318;
 	sclp_facilities.has_sop = sclp_feat_check(80, SCLP_FEAT_80_BIT_SOP);
 	sclp_facilities.has_gsls = sclp_feat_check(85, SCLP_FEAT_85_BIT_GSLS);
 	sclp_facilities.has_esop = sclp_feat_check(85, SCLP_FEAT_85_BIT_ESOP);
@@ -168,6 +166,7 @@ void sclp_facilities_setup(void)
 	sclp_facilities.has_esca = sclp_feat_check(116, SCLP_FEAT_116_BIT_ESCA);
 	sclp_facilities.has_ibs = sclp_feat_check(117, SCLP_FEAT_117_BIT_IBS);
 	sclp_facilities.has_pfmfi = sclp_feat_check(117, SCLP_FEAT_117_BIT_PFMFI);
+	sclp_facilities.has_diag318 = sclp_feat_check(134, SCLP_FEAT_134_BIT_DIAG318);
 
 	for (i = 0; i < read_info->entries_cpu; i++, cpu++) {
 		/*
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

