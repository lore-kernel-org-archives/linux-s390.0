Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624730;
	b=UKRLVxni/MRYCON2bNXudeuqNVhNRFR3E54jO8FwWohOZGKeeqFNLJv+7/VuPKOFQVzO
	 Hy/f8zFvVLxYQUdpO34dGxYVKhjyGOrxJjQXB0eTn95yE8dMGBcnthyqejfLhAdSYR8aG
	 kTaTmom3JT1IcW9j5wgzlwmFDmdcMBncmbTkTpgcBLcSnI4XJLmjLeFmTXFDJzXKlqM5b
	 VfjVIZ/va0abw1Hv3vrv3z5nTsgpwZUpGwwy+lRGYQQF3CUqFq8fTPkf26h6HzvURFzSs
	 H42XLMrxIymSzY+lEzEdhmZiwhBFN/POqBCr0lpQxmis/PSWcMTsiyztjYnyusMYjhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624730;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ox1wF8D18V204q4ml/KOvTVoPeyzjpCfyQd/Jbv+kRw=;
	b=3CWO5d1WDAl7s1qT+VWL1AzF3sEMkAkXLOvPWCxPmSi8reLmULqx3ZpEa9E0FVb+qPOQ
	 ezY5mjxCDt7/zASrJ6+I4wuhLAJBS/l6OYfCo8aRLiXsA+i4mEcuvLp1nUa+T83dF+YFp
	 Zv/5woJ3eID0PhERqEksXbfzATjGMZoGJwwEXrL6oOEY/pSCA/anJQy8DbbVBSmtm2ylK
	 nIWe6BFqVAGHda/1t03W3EWmB4SR6jiRiFk+1eHZSt9Ia4lb+nAZuavkOnRAtvBF0GG5D
	 xqmFX7v3aU/a4vlCr2uhBotfvi8ykcaNQnswcimR52jDj4pqmfmY7Tph3p2ZYiTgBXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MB+LQI7w;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7BE606A684;
	Wed, 25 Nov 2026 16:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A7BE606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MB+LQI7w
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APGYnL61999837;
	Wed, 25 Nov 2026 16:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ox1wF8
	D18V204q4ml/KOvTVoPeyzjpCfyQd/Jbv+kRw=; b=MB+LQI7wxPoAUj1Tpmz11B
	r0OFwVIPM4qqW2/SucAJ+2J6z/lbb/Sl4evSGUeAv3hYRGyuDhf4NqOzjytPPFXU
	B8MpEGrd2xT37AXSkQJ5QQjAs32qwFQxYXI06nCqG3teAkHndUWjeCRJMM//QPvR
	RDLLnf/TFNduqjKUYv9ZuWwxlcKcyklfDEuf8jrkWt6yJJA4XtLwqJI1PIP6GWNT
	MsZlcUFdNH01+NoADjziGWUqYpvFaFcfMQKz1Zk7oFG+xTQWmhchptq1vy7PCDHK
	2mtcstjEVDs2EqqTh60vyVYChRVd/qYy8W14XL2kDtARjH3Tglok1yw2qpC7YKpA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fadfg4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 16:38:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6APGYKuJ955094;
	Wed, 25 Nov 2026 16:38:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5axkvk2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 16:38:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6APGcgbQ51511628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 16:38:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F027A20040;
	Wed, 25 Nov 2026 16:38:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C99A62004D;
	Wed, 25 Nov 2026 16:38:41 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Nov 2026 16:38:41 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Wed, 25 Nov 2026 17:38:36 +0100
Subject: [PATCH 1/2] s390: Export arch_smp_send_reschedule
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-vcpu_kick-v1-1-a203b01ab957@linux.ibm.com>
References: <20261125-vcpu_kick-v1-0-a203b01ab957@linux.ibm.com>
In-Reply-To: <20261125-vcpu_kick-v1-0-a203b01ab957@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.comu>,
        Andreas Grapentin <gra@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        Steffen Eiden <seiden@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA2NiBTYWx0ZWRfX2OVxQcRhHxDT
 hgO8ccjmw+dzqLHJkNJvNemNARbxzo070Ak6xLeQhkxk4We+VsT2BNS+tKbxaxfFUqYAUj5+i0n
 HIUnqX2saIZu60C7WHCSP6ipWR7tK19iFqOEdZPthdDhw4oSAavvYHBHU/eqyGwjkMz0YHLYkAC
 azbBp+gJtqHHkbxB1N9HaY7IzOiyGjiIP9Us/ePYvyExVfr2JDdmM1zG7RE8d1te/Jjv4rl69Vm
 6oLVzAT6TU+QlXKxocm6vgx2y9LBXzhuG44vXAYGLq6kai2VvC/oXhm81MnwtTx96eBKHbSJjky
 ActpueHplbOdN7uDIM/sqZZaVpita+wT5c1ppDW5/aS2HMMxt5hTpnZUz58PsP1hl43baKDtmLA
 qIzxfXcA00r5i6/C1kSEs2gimKhjVYCTpx+6SKSkF9pVN/MJySGTkUU3VMRfdkQTxd4ttexKiwy
 7+bAERCvOtbgppQGHdw==
X-Proofpoint-ORIG-GUID: LW8EJjlFT7-7EUCCmB01eV1shE8BvkPb
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b070f16 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=7XwTW0U2p8o1u0-yezEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: LW8EJjlFT7-7EUCCmB01eV1shE8BvkPb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA2NiBTYWx0ZWRfX6jtwkBVP2dzM
 hsq9ziYw88YtSh0yEMLDA4j88+zfxGMHUeVefyGGdHjs92Lef2A//u0lqA9LTEbYLKQY1rdLT9v
 I99mnv9ONoD0g3hIksF/S9UdhxKr5VA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1011 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250066

Export arch_smp_send_reschedule in order to be able to use the generic
vcpu_kick infrastructure which is required for arm on s390 smp support.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kernel/smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index f7c262a17c03..14d198789e30 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -531,6 +531,7 @@ void arch_smp_send_reschedule(int cpu)
 {
 	pcpu_ec_call(per_cpu_ptr(&pcpu_devices, cpu), ec_schedule);
 }
+EXPORT_SYMBOL_GPL(arch_smp_send_reschedule);
 
 #ifdef CONFIG_IRQ_WORK
 void arch_irq_work_raise(void)

-- 
2.56.1

