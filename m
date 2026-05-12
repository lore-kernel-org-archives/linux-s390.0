Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045A53EDE76;
	Tue, 12 May 2026 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608383; cv=none; b=Ww0q4n1ZIkY9J4PqeL2FDFpkOK5WtSVtFUM11QnsCUgixoLdfaZEN+RfI71WIaO/eZwncSHHhOqpjeTekN7J5XTXHMtDLqnWHoOyvfnzq+npu5VKt5b4yLsPfxFMhV1n9ZyFSd9h/pnFLfGxIzBJvb/Tg1Nmx6nV/R8c1JPwosI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608383; c=relaxed/simple;
	bh=GcuIl1Ds7xkCTg3IVlyUtz0fxh0j91FhTkJlDxwuFN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQvn8vO+0nx9ncyVaJK1Z0MWvDUZnAytllkrY9UAn2OwqZ9BusGzjV1dJn/wy7zx6GdlsIsBoe9Eh01y8Af2QrIbNprhXRZX7WBKrEe1Z+5aB3z4nmStPs1oHZbFbDS7IE0C8urhiVB/u98zQQpbabmAlfc1rf5S85S57vA9l8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cqT6iWDj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cqT6iWDj"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CCHr2C3179836;
	Tue, 12 May 2026 17:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UEcctdxPNwJaYofH7
	8gCMDZGsEupH92OUqcYlvOnxCE=; b=cqT6iWDjG8djY3r6vuAvM4x/KkCmWA9tb
	u6kXBRAE3sNP5EqPZmkz2maBWRnrvFFG79domnzp+6z4GSVOhrqTkqaUh2KNnmxg
	DbtRVsPtErsfzEQhMULT82TRJr5BIKJ/DeXoKYrvLX/dvGuch1ZAIhrt/o6/VslS
	UzbT0T5IiA0v9wxm007QPhXiVCS3uI1wdcPS/1HGtmno9RPk/M3svYXN98jSfjxG
	xQxe4zvXEijMxP2zl6xnGCpn7bS5wkrmBvdQjzc8tIEq2akI7k6+y7eyfUYitha+
	UYuP3DICYjJNjv91DZiDGiE3CM5nPUv7TgcGkpVoh2QWJVSRlwwpQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6m54f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 17:52:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CHdWKA024353;
	Tue, 12 May 2026 17:52:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgm82r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 17:52:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64CHqqIQ37618100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 17:52:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98D252004B;
	Tue, 12 May 2026 17:52:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F5D120049;
	Tue, 12 May 2026 17:52:52 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 17:52:52 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 2/5] KVM: s390: Fix leaking kvm_s390_mmu_cache in case of errors
Date: Tue, 12 May 2026 19:52:48 +0200
Message-ID: <20260512175251.300882-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512175251.300882-1-imbrenda@linux.ibm.com>
References: <20260512175251.300882-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Us1T8ewB c=1 sm=1 tr=0 ts=6a0368fb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=EVFxPqBYVl373qEVmGMA:9
X-Proofpoint-GUID: AbZf7V9vq8RpCoGMZKnoIhOC9BP1J_yd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE4MyBTYWx0ZWRfX7JYQdPykG6lK
 uaqPvmcr2V8e0o8cixF3xF2mM4sgVujxmHPRHM807bgxg7DgWnWkJcjmoTyh/O0yPZ4TgSZn+pJ
 I/cyZZPeqzU64XZRRO9waJMMvtLtMoHArqWl5X7tYl7N0425+h5PK5V/eSkobQh/0sRZ8dxEcx1
 U4rRkBb4fppC4C6EXu8gkAOfsGYpUqsPhwCim5WaHCGoC/wSDqjrPS6Qh/zbJroO2Rnkqm+kzAO
 CC82N74xaQn8SPv1utm3PuRpTPIfS+VOb/t4AjfUMPPPDjqGUnaxQYiVPpli6pEU4rCTMdH2fuB
 g5n9beA0D3rdrKcq52mm6tZZnMXmG0ELFYVNxGSx+kF2fR/UH2jx+/sbGYbJgjc+1vISzT6z6ew
 +phUOIb2UNtBCueWzar/rU1rkLS4tk+1g7TEnXreyP+poRsF+VygbVWUlDBak4YkZXuJCxyTlT0
 WcvHPICvFu8H/jIR50A==
X-Proofpoint-ORIG-GUID: AbZf7V9vq8RpCoGMZKnoIhOC9BP1J_yd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120183

Fix a memory leak that can happen if gmap_ucas_map_one() or
kvm_s390_mmu_cache_topup() return error values.

Also fix a similar issue in gmap_set_limit().

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Reported-by: Jiaxin Fan <jiaxin.fan@ibm.com>
---
 arch/s390/kvm/gmap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index fd1927761980..10c98c8cc1d8 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -125,7 +125,7 @@ struct gmap *gmap_new_child(struct gmap *parent, gfn_t limit)
 
 int gmap_set_limit(struct gmap *gmap, gfn_t limit)
 {
-	struct kvm_s390_mmu_cache *mc;
+	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
 	int rc, type;
 
 	type = gmap_limit_to_type(limit);
@@ -142,7 +142,6 @@ int gmap_set_limit(struct gmap *gmap, gfn_t limit)
 			rc = dat_set_asce_limit(mc, &gmap->asce, type);
 	} while (rc == -ENOMEM);
 
-	kvm_s390_free_mmu_cache(mc);
 	return 0;
 }
 
@@ -822,8 +821,8 @@ int gmap_ucas_translate(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, gpa_t
 
 int gmap_ucas_map(struct gmap *gmap, gfn_t p_gfn, gfn_t c_gfn, unsigned long count)
 {
-	struct kvm_s390_mmu_cache *mc;
-	int rc;
+	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) = NULL;
+	int rc = 0;
 
 	mc = kvm_s390_new_mmu_cache();
 	if (!mc)
-- 
2.54.0

