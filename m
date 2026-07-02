Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798973D955F;
	Thu,  2 Jul 2026 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005868; cv=none; b=tAtClmpMEU2mSDi7HFp5HKY9pFWr/7EL4Ksmut6hb+dPpVlkCh+VytLqyVHY0ghpg2Z8+kBqDFrGiFpaSu2RcSTSzifzoNZzTdtmHEqAtG4qpBG84lgT8vGcppUUjNCjY/GUV7DDW9ewtVqq3oN/JC97Upq5aIB+9PGFRSeoIUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005868; c=relaxed/simple;
	bh=egely+LF2LssrjeFuNpcv6F/vAeTAmUF67060LlJkqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLuQufdvvhkv1rsY1BLzUs3DVl4FthhRFH0P1daGtoW+z9AxlkcF59lu1Bdkh9dTMx2BpOIBte8eF+mzc8l0bMAQPcKRNGkhQl3v/RJthhx0tfU1x2IGwYfVdJuyXml3C2plzbino7pPcsEvO9deLJjuyxRx1deqzR1b8JYI5Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=trJhEKxC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="trJhEKxC"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662EIkUl076279;
	Thu, 2 Jul 2026 15:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vP1Ktl3vjArw3f9LP
	eeSx3/s8/BNatj5x7wbsqa0f2M=; b=trJhEKxC0k67tfhIOwjCKZ1JaN91lrQQU
	USBVndJvETVEVW6EcM8sHlwE09DCLrgLkihIzSwF6a6AdflxoQSxROxn+Pvx/mvF
	DIjtgnJXF5gLdYt06J/pClnelPOUvnFNYZ4XaXEzJMN0i1vo5SHis+E+5wubpE28
	cLOFc1ypWsYJCiGUheBpBKVgsRqTpyJF83V47NS3HrLgznrAmtzYqXaL3MhZ06KJ
	vznyl0qhNT99HR85cSex33SvZynbJ7aiv5E2XdTOm4JMhZvEFAd6lbqiRlPT7hOF
	/ylADvdp9X96wB1F7XsajjxSV4+GpyETMYlKGL0ERAKTo0xP8A3zQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qgamx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 15:24:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662FJggF011168;
	Thu, 2 Jul 2026 15:24:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7wcnm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 15:24:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 662FOCtu29360446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Jul 2026 15:24:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56A0720043;
	Thu,  2 Jul 2026 15:24:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 422C920040;
	Thu,  2 Jul 2026 15:24:11 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.87.55])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Jul 2026 15:24:11 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 4/8] KVM: s390: Fix return value of kvm_s390_set_cmma_bits()
Date: Thu,  2 Jul 2026 17:24:02 +0200
Message-ID: <20260702152406.204782-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702152406.204782-1-imbrenda@linux.ibm.com>
References: <20260702152406.204782-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a4682a3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=THNiei219oG1Dueoul0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE2MCBTYWx0ZWRfX/ZMPAPwS5ZlP
 p/wgkPGJpIF4hZkpTCQVHqQ7DUWMEoopJuQutomNZYf+v0sQc8jFPJwtiDGrrQd0/OXKJHJ74Pu
 LaWiZKo2uTLFEn7gna5Z+PHzpQmJ3fU=
X-Proofpoint-GUID: gSPguGVDOT6R--OlgIETA3Yi4rHV2PJ6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE2MCBTYWx0ZWRfX8ELDfWQDQ1We
 G0FiKYYBI0zX2HpcVz+Ti0nXXwDwm0q8KhPyc0zA0a9DPVENoDJILvP0OYO4YshmGMs8c5AhHMx
 +nkKJ1m13yjhBWjpCC2RDBrgzKOySvrW6CDF0DWd3mZwIVdxdw4cJC7m9sTY5xxm7pxcVJMLhn+
 qN+OyCX72/3/GuRgb2CK8j0wh1fq1SC36xopeSFU8bpyL7CATUziIu2MQ/6pcsYvZMCpfgIcIic
 oNPvxEoe2c0pdx4KRhQ4UKlkI2iCATTlL/eNKuKTLK4BN6myxstLfS4uVmotdmjwBuUF2EQXWT+
 Si9Huha1XTCKTPXM4baIuUSE4vKBq3k+HuSzqs5OH6x6pUzor/WImV5KFCeUDDNw5w6dD6U8SaM
 iC7Xg8gsdYCZ73aoxhR1lk+9rKvXIbxLCAtVVn4xLmY4YGsjSSF86zfBCcAsbNI+Zquy+wyZo5Y
 /52PGwIUbSIJwbYgqCQ==
X-Proofpoint-ORIG-GUID: gSPguGVDOT6R--OlgIETA3Yi4rHV2PJ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020160

If kvm_s390_set_cmma_bits() is asked to set CMMA values outside of a
memslot, PGM_ADDRESSING (5) is returned, instead of a negative error
value.

Fix by returning -EFAULT whenever the return value would be > 0, which
is consistent with the behaviour before the gmap rewrite.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 784f7d9c79c7..512c81eee068 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2384,7 +2384,7 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
 
 	set_bit(GMAP_FLAG_USES_CMM, &kvm->arch.gmap->flags);
 
-	return r;
+	return r <= 0 ? r : -EFAULT;
 }
 
 /**
-- 
2.55.0

