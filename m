Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0834F4457DE;
	Tue, 11 Aug 2026 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455432; cv=none; b=ApR5rpdy84HHqqtt08kE3iqt93aDvVwt8Q0U0iWss+JYRJqRtQ8UHafBdb6OheSfCxs4hJAynKDUclCmu4UxiwERNUW08bi60qs9KEAwwCYFBExIZLe9FzgNrTKpQ8/Kk2o2oLD5ztGKkb6Artf+/lOgOD1w+oY0d2d2eIBgpdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455432; c=relaxed/simple;
	bh=lQ6D/f8fJ9K6hbtpwzz38OUGYG81cMYaqh/5VZxdmYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f74rlNham+qfDVrPE883Oux9bSDe8tSPGE/KVyRH0NgW1DpPi9j+GdIJT/+UoH6JsLd9uQDwmGixMomsqLxG1hpEzBDZpbCL7tTGurybDE1DQYEp4lz/DQjQMrhBE67qe2n5OLjETZTOy/u/EsdPlxplTmc5RfYBKT1EalNicAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ht4DdjF9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ht4DdjF9"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWPEi2864434;
	Tue, 11 Aug 2026 13:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MGWr3b
	8DowqblvbxZjK8gtP+yhtyYujeGNK/hWFBtyg=; b=Ht4DdjF9THLuWRdwwzzcy9
	QK/23y1Hrs6nccbW8kZoAFWHYuCqYY7zC7B/gQMZRdermUXbnQzj0k2sgTKeLPRQ
	QK3nRVtpqnxVfKG7nP23+5/uB2moHWWnDLRJyUk36krn+cNfhHDbd1FXsyY85Q4M
	M6tM2FisQshenn/+rxKo5esYsxXsr+Ai6Mf+miG/7VXYfL9qi4zyDogX5+s6u7CA
	JldQ9b1NBcc2nSN0jckmprJ44v58eO+uqlf0z22A9FVDO/Cvybfse74K/+t+VO6+
	e/l7ogwuTPu04L0HqpQAV1FaP81BIWEVxHBpTNN23om+F4bpgpXT2/OkVU3VmjNQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjyw497-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BDQEKK008255;
	Tue, 11 Aug 2026 13:36:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq1865-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BDagG737749220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 13:36:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4ED2A20040;
	Tue, 11 Aug 2026 13:36:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A954020043;
	Tue, 11 Aug 2026 13:36:41 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.69.228])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 13:36:41 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 11 Aug 2026 15:36:35 +0200
Subject: [PATCH v3 20/20] KVM: s390: vsie: Enable use of VSIE SSCA
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-vsie-sigpi-v3-20-45aa1ab07c7c@linux.ibm.com>
References: <20260811-vsie-sigpi-v3-0-45aa1ab07c7c@linux.ibm.com>
In-Reply-To: <20260811-vsie-sigpi-v3-0-45aa1ab07c7c@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2500;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=lQ6D/f8fJ9K6hbtpwzz38OUGYG81cMYaqh/5VZxdmYg=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFnVqtE6RcHWEQvWvfqxk+Pf1NIzTjd2H+Dfs6QiSO9US
 b2cRsLLjlIWBjEuBlkxRZZqceu8qr7WpXMOWl6DmcPKBDKEgYtTACZytonhn9aL6Djl1UaNCWWb
 M7dorOqx1bX8qTJrf2b/vsNWLU5RYYwMT/z1mZ89iemdr3HrS8zOCQv9jkVUCQi8sj+X8bnQ7L0
 YIwA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfX30AwdKb3UBp8
 I156O8glkVKtbOC4epf8T9zR69/GGWBLpPejDaNrgW4KPIB6Z4jaBU/COymfZtjfzN1Ukbnns//
 HVCODKbtbFednQkcwLfAh8Kj2M9hsbEfsGvaR/08bBZuw1gCiNu62m2rhZjyFeUCamQ6R0eeH7h
 6Rp/kZD8hqnNPekPqXr9NPVLnNfyhhoC0ObdIiihjsP31fO4PiQMURwyuZRrv91WtOs70dQBfzi
 /1QT9d0+RgpfdPImGPcIodxF9g8NY7SZL8bA8FGV3pT8C7CgH3r0iDe2lzjjgrFzV4gmhLs+/2V
 rM4NnxVPDNWE3Ap4M0hBCPC0FYXgvIx53f0Ar0d4nsaBc0sJwzw5MfUe3cUlWz3P0tqoQxYgl5I
 TIPmNGvMUiM8CmOPLkK5OFJ8XdP1R3WD8ylJJSBHQtxf2qMac4FHnqF1NKGPukJl4E9igTqtMX1
 796depKgLsrEhEgwDvQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfX/hlpQNbd4VOO
 Ie1Rh5TMWwQRMPja8lkTSVq7sg3BV6qztTmxmSq1chdukpkjXvhdT54DtrR6IMHOJgET4rcgUyg
 GXiX0AruYjOBzZjzZD8XwD1iZNs24Ro=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7b256e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=TE0TNm_Z0-VKmVJMeCwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FbX-4gHgwmli7IU8kGLLMqC84hhYETbK
X-Proofpoint-ORIG-GUID: FbX-4gHgwmli7IU8kGLLMqC84hhYETbK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110113

Finally enable code paths actually configuring and using VSIE SIGPI and
SRSI. SIGP can be globally disabled in the KVM module configuration but
will be enabled by default if the machine (IBM z17 onwards) supports it.

This feature improves guest-3 performance by allowing the hardware to
handle SIGP EXTERNAL_CALL and SENSE_RUNNING_STATUS instructions without
exiting VSIE.

Module parameter: ssca (default: true on supported hardware)

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 08c14bbd4aeb..533d1f286f9d 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -247,6 +247,11 @@ static int async_destroy = 1;
 module_param(async_destroy, int, 0444);
 MODULE_PARM_DESC(async_destroy, "Asynchronous destroy for protected guests");
 
+/* allow vsie sigp and srs interpretation if available */
+static bool ssca = true;
+module_param(ssca, bool, 0444);
+MODULE_PARM_DESC(ssca, "VSIE SIGPI and SRSI using the SSCA");
+
 #define HMFAI_DWORDS 16
 /*
  * Base feature mask that defines default mask for facilities. Consists of the
@@ -476,6 +481,8 @@ static void __init kvm_s390_cpu_feat_init(void)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_KSS);
 	if (sclp.has_astfleie2)
 		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ASTFLEIE2);
+	if (sclp.has_vsie_interp_extf && ssca)
+		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_SIGPIF);
 	/*
 	 * KVM_S390_VM_CPU_FEAT_SKEY: Wrong shadow of PTE.I bits will make
 	 * all skey handling functions read/set the skey from the PGSTE
@@ -490,9 +497,6 @@ static void __init kvm_s390_cpu_feat_init(void)
 	 * For KVM_S390_VM_CPU_FEAT_SKEY, KVM_S390_VM_CPU_FEAT_CMMA and
 	 * KVM_S390_VM_CPU_FEAT_PFMFI, all PTE.I and PGSTE bits have to be
 	 * correctly shadowed. We can do that for the PGSTE but not for PTE.I.
-	 *
-	 * KVM_S390_VM_CPU_FEAT_SIGPIF: Wrong SCB addresses in the SCA. We
-	 * cannot easily shadow the SCA because of the ipte lock.
 	 */
 }
 
@@ -3382,7 +3386,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	kvm->arch.use_pfmfi = sclp.has_pfmfi;
 	kvm->arch.use_skf = sclp.has_skey;
-	kvm->arch.use_ssca = sclp.has_vsie_interp_extf;
+	kvm->arch.use_ssca = sclp.has_vsie_interp_extf && ssca;
 	spin_lock_init(&kvm->arch.start_stop_lock);
 	kvm_s390_vsie_init(kvm);
 	if (use_gisa)

-- 
2.55.0

