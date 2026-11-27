Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791875;
	b=gXiXRe6ctOrkklj+djILso6kt/VmCxjzUBUL8JtU1EvWzoCafffmuR/R/k+XQnXMICcG
	 Ig5g2LUOcCwxxCMc/5ZJ1AiupoJG+kf7NVe0R83ZMzlm8U06wyaRZH4L1tfB+AE4KlUz1
	 AVwz4ZW0QPEFu66ekIs1r6COSrE94x90FQUQUza8EAmJS2B07/qlOxXTzryKZiRNoQHBg
	 v2z2OwXsCe282ilx0xGwAFwdMfEjBywkWZiMKnUqTX+5gbo2tTFpTuFfwFH1vWGajZdpJ
	 J5zBdXgVWZ8wBEkY6EFaUc4v4aLxk38GZdCipthZf6MX7mybwz0XelPKhVBPGtAiqfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791875;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NVAyTJf6fpkWM38lvgOf8qWNAjdO6M6hT7r2AcKkunM=;
	b=L1cTnw/5HM+jJn4PobHIKNYw0ZpW2mfwue8JfOv6CiaReJ71hYkEpfIERr+dPQTckD35
	 y09f9cMqOrAVg2BfgUvsEIw/e61JDRp/QL6ymO/hrbZKEbnAjKYL6AfGTxqDhw6DJZ3Lx
	 vSxUQ0MIMEaOJqeflF7ndsz9IIeLZToczPC94q/+mTbDXS2zFSqcDEaADnoXJnboKPimi
	 bWsFLVcHDQktPVcHgOe7dA8DO26XcOSWjCkz6zKW76pO2YsfnyfTG172585GBXBKbpZhJ
	 va9SV9c04pMWi09Rgm8nz0TQ/WFfZPSj7bvimySMoaHAggIYnN/jNttjkutvNOh8R2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eCNEv9g2;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E3B606A329;
	Fri, 27 Nov 2026 15:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8E3B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eCNEv9g2
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE5Ii63267360;
	Fri, 27 Nov 2026 15:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NVAyTJf6fpkWM38lv
	gOf8qWNAjdO6M6hT7r2AcKkunM=; b=eCNEv9g2MBmuQ62mkS0x0cqVd6oph9EYA
	ffR6vf2U9E94KmpxsKl6umAvgeqMb1gOsZlnLJOBmWuswGKBJ4uPakdHW54VQI5P
	1d12onvdYsspYSXATKK5USlaWI65AvQTNK2AYSt+LFPB8oXQwyC0eaDsVQu5vQoZ
	r8Z4IxUtJEOg7zaJEdSykjhcuEU8P+jfPmKKaCxiwf7mJ48iBSqVX5eyBj43vX3C
	6hXTGEnINxi7iN3VpAPN3ONIXWaXCJj39Gj1NpBq1/FOpu4zIWraryQbNjRgC7Ud
	Hda6WJhMZzeUO/gtnt33+O7h3/EbP5e6w1c6r0i6QNXhooV6vIkrA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g1njbg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:04:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4HXN2819251;
	Fri, 27 Nov 2026 15:04:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5kfaanm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 15:04:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARF4Djf15925612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 15:04:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDEEC20040;
	Fri, 27 Nov 2026 15:04:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C749120065;
	Fri, 27 Nov 2026 15:04:12 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.43.64])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 15:04:12 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com, seiden@linux.ibm.com
Subject: [PATCH v1 01/12] KVM: s390: ucontrol: Do not mask -ENOMEM when translating
Date: Fri, 27 Nov 2026 16:04:00 +0100
Message-ID: <20261127150411.221072-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127150411.221072-1-imbrenda@linux.ibm.com>
References: <20261127150411.221072-1-imbrenda@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8mB8bHNeywhe2I1tw5hO9pXuvNAVKUAS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX6+tcU47VUktF
 4idpRshGh1+531mnUDnQVt6VpLKknafmMdW68cIQe66nY/F7Pm0Bw592XCbOGU+D0DalSKu27o1
 kRyhaB5h0v/Tz+oi8Ooz1UYQKPYudGA=
X-Proofpoint-GUID: 8mB8bHNeywhe2I1tw5hO9pXuvNAVKUAS
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6b099bf5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=0Yj4GNeYBWgtlkHHeR8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX3ibstCmrXLcs
 BVVhWwKP93/nDhqYrBK1vE6jw8DI45NdsmCuf41ClhzD3cDmgx0/2IxHFGPTy02QQZ5AMPnFFiI
 KZBNiS9FtzwLdUGEADqTgpNkchj/M5iKwrgAB5w+T2UmunHBWc2bF692HznAtiJuHVCbKXbDKzo
 V/AwPp/mMb1cNwhAiz1Cs3ja8Q+0UqTt7nnCp7EGrTHTEPGmgK2qsP8dV9kzLEuHcktRQWz9/Ox
 aVAoXEscmQ5CiUFtsU/5fGGbqo6fVSv45qYmOM9bnJdIb/j2WFTcX2RAmZWjI26ALTZiKFMIJYl
 IBsliAG5MnsD0LBvwW2IBvjtcDNHPW+IYpuc1IU5TavBluzwxQf4WnI2JAv6RBu5b8ADOU7SKTw
 t2B6kTiOLiOzepY41/3M7Z9+l7ftEqkfh76cTyNp0XMVIfm4IZHvn0QbRYYuz5RE96e2yo0QuIq
 DDe4UCDbLf5pe7phMJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270058

Do not mask -ENOMEM or any other error when vcpu_ucontrol_translate()
is called. In case of failure, return the error without masking it to
-EREMOTE.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Cc: stable@vger.kernel.org
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap/gmap.c |  5 ++++-
 arch/s390/kvm/s390/s390.c | 10 ++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index b9d92bef5459..ef1243ad4e54 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -937,7 +937,10 @@ static int gmap_ucas_translate_simple(struct gmap *gmap, gpa_t *gaddr, union crs
  * This allows ucontrol VMs to use the normal fault resolution path, like
  * normal VMs.
  *
- * Return: %0 in case of success, otherwise %-EREMOTE.
+ * Return:
+ * * %0 in case of success,
+ * * %-ENOMEM if running out of memory,
+ * * otherwise %-EREMOTE.
  */
 int gmap_ucas_translate(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, gpa_t *gaddr)
 {
diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index 18fb200f854a..cec1278f2ceb 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -4316,8 +4316,9 @@ static int kvm_s390_fixup_prefix(struct kvm_vcpu *vcpu)
 	gfn_t gfn;
 	int rc;
 
-	if (vcpu_ucontrol_translate(vcpu, &gaddr))
-		return -EREMOTE;
+	rc = vcpu_ucontrol_translate(vcpu, &gaddr);
+	if (rc)
+		return rc;
 	gfn = gpa_to_gfn(gaddr);
 
 	rc = kvm_s390_faultin_gfn_simple(vcpu, NULL, gfn, true);
@@ -4619,8 +4620,9 @@ static int vcpu_dat_fault_handler(struct kvm_vcpu *vcpu, gpa_t gaddr, bool wr)
 	};
 	int rc;
 
-	if (vcpu_ucontrol_translate(vcpu, &gaddr))
-		return -EREMOTE;
+	rc = vcpu_ucontrol_translate(vcpu, &gaddr);
+	if (rc)
+		return rc;
 	f.gfn = gpa_to_gfn(gaddr);
 
 	rc = kvm_s390_faultin_gfn(vcpu, NULL, &f);
-- 
2.56.1

