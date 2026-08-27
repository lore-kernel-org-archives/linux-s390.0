Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEC848662D;
	Thu, 27 Aug 2026 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787845987; cv=none; b=aTyTW8SmJ1usZJZbq4kuGtkPSgprtu9WOf0NV+sJq1LbuQmM8JWACyWnmwS7ddy+1VMpFT3lzDmplUu377kA9yAl9SVuUx6DK6kXcqXdLlHxjXqO98O17zebvLBx2DhxXMpwunnSr9x9u6/10BBioU+gytRSMEeYniTM1PB7NqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787845987; c=relaxed/simple;
	bh=x9xdSjbyG421knKQsJE0As0Fzfy3RA3/kmy4Qmy3OmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VHkDKpk+/VxgTvk1yaWDAzrgqWw9ev+EA6KIMQPGylyzTkuUpVMUxlnubcC8bhn2I3pOTBYi4kZtLxzHLRSg9CTRnaWdNrwezKSk89gUQxv6ob/qyX5w/SZIQ94a3zn1ymy/LHrtyTvAlUcG4p9zNbO+SVNFm3Yldme9Rj1tAho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p6TzNf+/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p6TzNf+/"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RF5Ns53245515;
	Thu, 27 Aug 2026 15:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Q7CDrL
	/fnNEkoDfZR9EjqdANiAN9ufFElc3qpXLTj2w=; b=p6TzNf+/7d5YO7fPHAXDRG
	GaOuYAoO7FsKDCeyL/38uJgSzJ+FEjFz2jBE9CSjaTGrAQntTKzBMckkz9hDCK7G
	wrjTcrSFK2obJsHd+yt0E+6OMSqU4EWXKQnlEqThozJQsnkDGtQICzfL8vdbzGD7
	pbjcpEt3DU/5EYYrjQoNzdNDAauicstsps+ciGVOGflFCcm03s6pSGUqhZMAjkX7
	E7eBLDIVKmMzJw7/gWtz6K6ucmg1wBO9AakEYnCMXioT38y5ZiTIH9Ggns7c8g9t
	GpqrAIm14fTz7C28XXpQHtYFIDrytSRemPNqwSdReRE4MBlq/IGuf/OvVw7EFm6w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716j6e18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RFfiFV006041;
	Thu, 27 Aug 2026 15:53:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragrqt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RFqusN29885042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 15:52:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C6652004F;
	Thu, 27 Aug 2026 15:52:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6ECF72004E;
	Thu, 27 Aug 2026 15:52:55 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.61.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 15:52:55 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 27 Aug 2026 17:52:43 +0200
Subject: [PATCH v6 03/21] KVM: s390: vsie: Add vsie_interp_extf detection
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-vsie-sigpi-v6-3-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
In-Reply-To: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2460;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=x9xdSjbyG421knKQsJE0As0Fzfy3RA3/kmy4Qmy3OmI=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFkTYoMSFsoEX2p+x/GV9c3Tsvh1NhcNVpl/eHflM2vp6
 nmrNtVqdJSyMIhxMciKKbJUi1vnVfW1Lp1z0PIazBxWJpAhDFycAjCRVwIMf7hmq6YttGeJZ9Er
 yW8Ucr/ns3nzFrNfZ8xP2SQbJU5tKGL4p6x17LBT7vTXwXqJmpmunk0TZTZen79E8HP1B8tt64+
 v5QEA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX3axbEckpG3gf
 TqZFrjOcHeKQALBl1DKbkA350tx+O1nDurLUuT8JIv8ugpGvUOMJx3lshMwtQZQNoORiaiUT04v
 v/EHBlQZDPNRPOGDuexPfZVpvjmXAvw=
X-Proofpoint-GUID: 1Po5fTe_Li9OTufw1x5dcLMtVVijhhy0
X-Proofpoint-ORIG-GUID: sR7DMG80lOx1mlmdMHOIse6ftR9tYtML
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX93DM8qckVsO8
 2z0v6i7JZ3QJcy6HFieROvBTNuN6LT991pxegrqG+jfq8GfMrPiTQH8jHw7g4mYjda5qFzkNTP1
 Aeq/cTq0pX5g2zCC3iynXJDe3GiJMftmNkvn3YMLAyyN22DbbiioJTroxW2Fd4m1mszCzttlhlN
 W2RtFWiLoR65LH/2EaDrio/+PI9tbXqXHgRt87iaT3cC2kFaE93289zKtRzLV4UWlkW8EfA/2I5
 UVMxNZHbfVcdZUoH2W3KPdVRPp4g/gTs33TAs2o/LnA7GEKbGaVJ88vIiuKYnsZeG5SAPWmVjqY
 9IEb34r+4sS7kxi1dYTrZKgNQmy2/q6sTXGxKip6+vI5jmNkMolPS7I2mcgagJ77GyE/jvJzxT5
 RkQFd4ENg89Nl61gePu7I2rubGe6ye8oh5W+azkbuM2SKimf/rItTB9+MFRS/hgwgDyAz6fiPSe
 wjbQaHqOr79UDY3+0Zw==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a905d5e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=aPtVb-VRJjWQdk5PnbsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_06,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270131

Add sensing of the VSIE Interpretation Extension Facility as
vsie_interp_extf from SCLP. This facility is introduced with IBM Z
gen17.
Along with the new facility add a KVM struct member use_ssca that we
enable when the vsie_interp_extf is available.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_s390.h | 1 +
 arch/s390/include/asm/sclp.h          | 1 +
 arch/s390/kvm/s390/s390.c             | 1 +
 drivers/s390/char/sclp_early.c        | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host_s390.h b/arch/s390/include/asm/kvm_host_s390.h
index cd692f8fb764..6fdac144ca3a 100644
--- a/arch/s390/include/asm/kvm_host_s390.h
+++ b/arch/s390/include/asm/kvm_host_s390.h
@@ -623,6 +623,7 @@ struct kvm_arch {
 	int use_pfmfi;
 	int use_skf;
 	int use_zpci_interp;
+	int use_ssca;
 	int user_cpu_state_ctrl;
 	int user_sigp;
 	int user_stsi;
diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index 44066550b9b1..9e960c09ce0b 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -105,6 +105,7 @@ struct sclp_info {
 	unsigned char has_dirq : 1;
 	unsigned char has_iplcc : 1;
 	unsigned char has_zpci_lsi : 1;
+	unsigned char has_vsie_interp_extf : 1;
 	unsigned char has_aisii : 1;
 	unsigned char has_aeni : 1;
 	unsigned char has_aisi : 1;
diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index b0839e887221..ae0177d74b11 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -3359,6 +3359,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	kvm->arch.use_pfmfi = sclp.has_pfmfi;
 	kvm->arch.use_skf = sclp.has_skey;
+	kvm->arch.use_ssca = sclp.has_vsie_interp_extf;
 	spin_lock_init(&kvm->arch.start_stop_lock);
 	kvm_s390_vsie_init(kvm);
 	if (use_gisa)
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index 22dd797e6229..40e6e346ee08 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -56,6 +56,7 @@ static void __init sclp_early_facilities_detect(void)
 		sclp.has_diag318 = !!(sccb->byte_134 & 0x80);
 		sclp.has_diag320 = !!(sccb->byte_134 & 0x04);
 		sclp.has_iplcc = !!(sccb->byte_134 & 0x02);
+		sclp.has_vsie_interp_extf = !!(sccb->byte_134 & 0x01);
 	}
 	if (sccb->cpuoff > 137) {
 		sclp.has_sipl = !!(sccb->cbl & 0x4000);

-- 
2.55.0

