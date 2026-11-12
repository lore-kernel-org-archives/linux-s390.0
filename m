Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482493;
	b=aZ5fTsWvSzg1wok98TUnrCR4EcwNZpj1LZ2Tc44N99PMx7jkXVGPkH7saSE3UZ58bIKi
	 LzZj2WvXbrDjE1rro3urHiWXdpqqGSKRClza1S0V/eqJjxS6wSEfCkP6oXwHr+IBg7xd/
	 IgMOTUCIoSDT0dsG/xJ1hn7a7JMEc6m5BR6WFrIRFqctCBfP2T4+0rmQZcdnG/eOV3GkO
	 nLYwGH8may3S8vjjZZRTnTyLbAhFVC/2lrTba5IiDsbl/YIXg4C3p6wRVj0pe0g5z7fcL
	 b7KtzeWpn2ka5l+3VlkTZrgsAsJXWZ3LDcvWL/bBF+8JrgxF7nA7aAT0vJRcNAXiwrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482493;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=X40y0eyJQY4DcXYAOxeXcnofj9sV2V7nOcXr/2NfD4M=;
	b=JECSJpZsIhOCcEcg0e6EQJRct3FBIHQLexwnhSxLh9ydgL/HNKrZFhJwOSrRvmkPPmNo
	 cB6w6rJgSW4PMa7U1eTEJfGNEP7ZGSZjbfOlrYEVA+8+ThX15XOltSCMN7yzE/f+JfyI1
	 Tycq+Dppbttf8B5MhiEW2o+7FIhPU5JsaY5DaLgmqaxKujORaYtJn1NdcM8UGQzyRIPDX
	 8eucrAoD7LgrK7e89ob1EOcvUfRVli+wUlNGL12RfRaWji4ZetJcBoloqRuvbuCdm8CU6
	 tSlErXmYQWMF1ZjrNHS9o7ukKp0s/60a8L/mcpfzCF0eijlIn6bebKDmtTkl6LedDuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iQ6Ex9eR;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05FD606F407;
	Thu, 12 Nov 2026 11:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B05FD606F407
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=iQ6Ex9eR
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2j4Z81638733;
	Thu, 12 Nov 2026 11:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=X40y0eyJQY4DcXYAO
	xeXcnofj9sV2V7nOcXr/2NfD4M=; b=iQ6Ex9eRkHDDrVdaz2JjhfDb98dcSMtyy
	Y5/2e3Y2NHISnZi2CFDYt7aCnGmjV5tkxoRKCePXpZJDKRwPE1Sbs4trs7GHVB/p
	oAG5+er95OFPJIfQdlwIx3DopPHTSyo9zDQuz2q6NmshY6U6xRUWLkcQsb5Mwbfy
	OR9HqA69rqp0UYdT8JmaKAT1abnt7Si0rNlmsw58tbmoNdyhETLPhWj1zJ4OFztZ
	8qRX/pSsApsML2mG0pu8eoN02+ccYAoz8rjzKTonu+TgeJEgztHhkDIjdt7JPnE1
	5RMZsdGUyIR65rNR0GsacoXZIfqgfvFpK/bqyNRhV3C+BxdHPqjcg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdge45q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 11:21:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC88PUp3145935;
	Thu, 12 Nov 2026 11:21:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hvd51x6xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 11:21:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ACBL6hS29294982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 11:21:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4CE320043;
	Thu, 12 Nov 2026 11:21:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A97FA2004E;
	Thu, 12 Nov 2026 11:21:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 11:21:06 +0000 (GMT)
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Dave Young <ruirui.yang@linux.dev>, Jiri Bohac <jbohac@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>, Usama Arif <usama.arif@linux.dev>,
        linux-s390@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 7/8] s390/kdump: Skip the crashkernel CMA DMA wait
Date: Thu, 12 Nov 2026 12:21:04 +0100
Message-ID: <20261112112105.1169118-8-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
References: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af5a127 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=yY0RN1bv6ftNvu01ybYA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfX/gb7cQhID4Mk
 6lJKiKhY0TN5KY7AR+djUkt9i3UlbzlFPpqY9vo1+ryRMdGbA5McSge7FV1u6msM3ROCkWFKfxA
 WOlXu38l/A5TykX0VXFkMbFWpuRubxR+WqenDrqdXLQChVmV5yGlmFC5rHFuWI3HFaA38aTHzxU
 D8pPC8M0Pb/En7OEjqydlxd939JsPFJkMuzob/6+bPciG89bXv+0AyuYPBybA57GoayBS+zIfJO
 o0OBT7pnkdssQ/KiBX7sSW/McTcnmPA5r0dqFaSVn3EXAYE+pM9pokTkX/EuRgRwXFVNXxftVCW
 updiRKNZTPo41yzjTlmAHecSus0OR9B7AKAuKmXehOgw2cMw0niN7VetCWfDZhDrjpznYUROCCD
 83MuHlm0jXlhkJw7y6mGxeZjKl863ziCbzQj5IH723iIHm48IkoK5Ph2Fb0ndfAFJ2x3yXfJKJg
 IRfM9M7A3DVukeiSbmg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0NCBTYWx0ZWRfXyU1WyHEv5tkz
 AI/PzWjIVuZLy2DPYHTNp3+8bpkKnqr38FRCHyx4TqS5weIjcw4VkRORBBkfusTmRs6YE0oJOAi
 dCvwqg699Hukf84MXtEywc44inSin/g=
X-Proofpoint-GUID: ntYF4n68BWPKKhFjfjrHUAvU9lDdJKK6
X-Proofpoint-ORIG-GUID: ntYF4n68BWPKKhFjfjrHUAvU9lDdJKK6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120044

With a crashkernel CMA reservation, __crash_kexec() waits 10 seconds
before starting the kdump kernel, so that pending DMA into the CMA
memory can finish.

s390 does not need this: before it jumps to the kdump kernel,
s390_reset_system() issues diag 308 subcode 1, which terminates all
in-flight I/O.

Let architectures override the timeout and set it to 0 on s390.

Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
---
 arch/s390/include/asm/kexec.h | 3 +++
 kernel/crash_core.c           | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/arch/s390/include/asm/kexec.h b/arch/s390/include/asm/kexec.h
index 9084b750350d..2e15c4fa70a0 100644
--- a/arch/s390/include/asm/kexec.h
+++ b/arch/s390/include/asm/kexec.h
@@ -97,6 +97,9 @@ void arch_kexec_unprotect_crashkres(void);
 
 bool is_kdump_kernel(void);
 #define is_kdump_kernel is_kdump_kernel
+
+/* s390_reset_system() stops all I/O before the kdump kernel starts */
+#define CMA_DMA_TIMEOUT_SEC 0
 #endif
 
 #ifdef CONFIG_KEXEC_FILE
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index d0bd2d0cf899..5f60d252f4f1 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -36,7 +36,9 @@ note_buf_t __percpu *crash_notes;
 /* time to wait for possible DMA to finish before starting the kdump kernel
  * when a CMA reservation is used
  */
+#ifndef CMA_DMA_TIMEOUT_SEC
 #define CMA_DMA_TIMEOUT_SEC 10
+#endif
 
 #ifdef CONFIG_CRASH_DUMP
 
-- 
2.55.0

