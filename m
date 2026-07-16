Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C252FDC53;
	Thu, 16 Jul 2026 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784211285; cv=none; b=QxCxj23IA1DO9ndEPBZbQzR5j9UlXqIqejtWeZgeu6VO6bS2aTn0gbgOcJ0Jvl0cyNVLJ5MfDP4u+zVMBoPSAZyuoNQhNRJbNoiPKW+dZZ1dtJDIP2FxcNO4hNckMf/JDFhLDmMCzOSNugjy2kXzIXplXdAeX5Nc9SCVG324BNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784211285; c=relaxed/simple;
	bh=dUsbDZ6HTSkg65F8EIiTZAdGjRgLUwj4dSaPNOkaeWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQ8x76pgha8XpTAeDYhnsVTPhucCoJUEXQZSRwimymyN1EhUn0LFmyi8FvSmpXDiREncPQ5L9YFHpUtuUXTrWc3TD4ocQeCyykLjGSOHr7s14JKxorfxYAZ8VjRvqbx0B7idN8LSoE2vtkwz/BUJxlfDAnY4qAnHov64Gy5MSDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z1iN+CoG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z1iN+CoG"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDfcdk1469497;
	Thu, 16 Jul 2026 14:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2gHV5VMvq54+aU8DI
	zL9/w8iQMfGX2oJ+rwuYTn0ctY=; b=Z1iN+CoGmxI24vqrGFYJ7VL0Q5gZkDJM4
	wTkmtwTy1I/4YwZym48eEsbzD1BM4SjGfT73avtFGiLE9STk04OvhFVJb8a8+4GU
	83EX0u7LRl8/LZZJ0e3EdXuH5Iu9pKdMVFV7uq8Nqplm1tlmnIFPFlDlJMmfdCeY
	Ma4NQtvk3pL6DqpCpN5KUyL2Oh15dvTcPF/HMTzOUJJrXItp9SL+0L+uNA/h0Pm0
	+tnzzrJLOaziOlCQXmC2cVZB1fkIs6m4okOFevbsnX7sQGmKVwWpvZMZln/DYl/v
	BNNS9zis3y9/ecwC2Z0A2s7UbqYdyRZYvPW+3IarlAZeCq4ZX77wQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33hss8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 14:14:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GE4dtT005227;
	Thu, 16 Jul 2026 14:14:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhn8mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 14:14:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66GEEbjO49414632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2026 14:14:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 814CF20040;
	Thu, 16 Jul 2026 14:14:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 501D42004F;
	Thu, 16 Jul 2026 14:14:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jul 2026 14:14:37 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] s390/mm: Fix handling of secure storage access exceptions in vmalloc area
Date: Thu, 16 Jul 2026 16:14:34 +0200
Message-ID: <20260716141436.2125703-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716141436.2125703-1-hca@linux.ibm.com>
References: <20260716141436.2125703-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE0NiBTYWx0ZWRfXyV481t8lyfSS
 AJ8Oi3DbO0rHxVw1v4SRVjF7Bo2+CqAmnPYwEWoxY5zQ+/MkfEP/vEcm56Dn8G/gvUL8W/jAmKu
 k2LXouoNSS8r2zDpCku2szsIYZX3MbY=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a58e752 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=aTeQ_7Lur19LOBhsqlcA:9
 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: pNmcBO6XlsQVytgqcsMuecAP4QsBClyw
X-Proofpoint-ORIG-GUID: pNmcBO6XlsQVytgqcsMuecAP4QsBClyw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE0NiBTYWx0ZWRfX2nGAdLYpNUCE
 uY2MBuVEW+x3lWMqJTLiQn7KYLUgvKe3PpFAC7BdfXs6UxXp8WdG+Co9g3sLpTTVwaIZnwO85eC
 JHwAvFW200QVATkA/pis5bkXUov5cXA9tbFtrhMmDrdWx0insN82TtVUaQ4AlAdHh4PVR94R9ku
 6zMa2BGzENyGqQpj6A6qDDlGNYWAzYxEYBxyn0g3ObPlPWK304s16vsXsT8G2+3/ksa8e0MV6gb
 fA7LuPHgV90aIa/S5CaP5OcgBtQxf81ps5QoJ+qJikfqm9A/6fS0A+Hj+nj+m9+u/+linnPFwHD
 2VCMtArHAXkoG7y7zF2bU6MEOoSjuPQQYDZN2pB4zQYHktoZ0nfaTPf2biZxLMiIO9KLC/EzUg3
 oZOEJofVg43owrtNKI7EqQtJ2i0/bUEgbHHl1nlsTv41eJsSsoMYjGzdo6oQzffthYjy/41Xd+j
 7qCIl4vJ6L471EzjbVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160146

Secure storage access exceptions in vmalloc area need to be handled
separately since folio_try_get() or virt_to_phys() do not work on such
addresses. Given that there cannot be a valid access let such exceptions
fail immediately. The kernel will either fixup or crash.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/fault.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 028aeb9c48d6..392e46742039 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -438,6 +438,8 @@ void do_secure_storage_access(struct pt_regs *regs)
 		panic("Unexpected PGM 0x3d with TEID bit 61=0");
 	}
 	if (is_kernel_fault(regs)) {
+		if (is_vmalloc_addr((void *)addr))
+			return handle_fault_error_nolock(regs, 0);
 		folio = virt_to_folio((void *)addr);
 		if (unlikely(!folio_try_get(folio)))
 			return;
-- 
2.53.0

