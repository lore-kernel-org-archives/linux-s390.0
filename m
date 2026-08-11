Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB6638F251;
	Tue, 11 Aug 2026 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462668; cv=none; b=tO8m3SSGWRsqITKnsVPkeh84SLgWjbjiT9TMHiIBI9u1Bc60ERf1l8OtJERFWuH0cJV3P78ywnYHomih86jrGaCKbtn654IMNsVgYt0KA0leXKwBaBQMLelJV+WJ+exKC1QRrdCj2RIgFbwSOrDcWhFq+7k0F+4hLWUN5eaWyG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462668; c=relaxed/simple;
	bh=AiLzB34JMa5rDv4B5CuWW6RB1t4U8yIgwd87vxzCzpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DeIrViHGBw5tD2kmfkzXztl+NLlpvSM7lhzp3gj45Gqwi1IOUhDoXWkPi6tPydFAscV/PAGZMjTrCLUwlYFx0gAcMrFeK+rdXZtym6tyzjCzf1AYxL/pYlpnCtzgbeziip2K+CSEf+367WcfyUYaNL2N6wcSm3tDeSMxqKTP2A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xz7NrC2T; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xz7NrC2T"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDX1FV3633702;
	Tue, 11 Aug 2026 15:37:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=YNw5bq7kKagjMT5TDIRXMIW5j6WC+uHtOHZZx9Prz
	IA=; b=Xz7NrC2TjBl4ArNiA2zM9n+acW20kV4zCyL53J8OzHEhpi9hHRFCSrN16
	fzd+ARrmWAiKPipoRgzNj51VXOFJJ4uoPZpBtZEqtFzje9RYPBX2pcQLKqrOmbWE
	/cWwvtvrqHz0SU3HTdefeIxj/RXs6M4eV+iS4p90D0akQxQP90u6U3amwGsItg5Z
	AalyMjhOSgrCh3ZmWobGCCb10/+bVxqPlqjvCB9Wy4nBWblP/e0HQO0qDv0pDIwl
	Ef/mfGAAiVOKaT0Ns3tsLo6H8ybjG2IE2l5QGBLsz8mAiCUKDS3X/1OsH0Y1Of6i
	wPCEazpQeD99XfRw88TGhY8dob37g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23pdqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:37:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BFQPTw025289;
	Tue, 11 Aug 2026 15:37:43 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq1pmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:37:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BFbfAu27591332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 15:37:41 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A455D58066;
	Tue, 11 Aug 2026 15:37:41 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A74B45806A;
	Tue, 11 Aug 2026 15:37:39 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 15:37:39 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH 0/4] KVM: s390: Even more fixes. And then... even more fixes
Date: Tue, 11 Aug 2026 17:37:34 +0200
Message-ID: <20260811153738.206885-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7b41c8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Qam5fnF6cfqp4561:21 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=rIWqLY8Igl7YtNxxoMcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfXzBDy0fuQdfis
 pwEBp5i2P27iGFKRORnxyQCurk5Xo7KjXvRotl1qxeJBoTYdD94qnHhGTIIYS1tQ3cvUELOMVzE
 66DpPQXCnuizzDpZN81ofMFDd1vkD0/oz88vZ7jYJqtsodFMzLYoWSxfKXsn81+VqyZ2+hN2xJX
 5ETIuX029rKwmttJrgJ36y0IC7rv0weAE+qqSx2M8wfhpv72s5wvGqQbjEdnOGTHWBBjA7SgAER
 dQ7gXZ98nGCoA8nLFOid3SUrarBKuFvYQ94ggk9fM+2l8t/6aE0yXkYEl9Y+SM4evtZd3Qc8eDv
 6dTowZsQJs0tfE0a/XiDaHq/dBb/5gEIYXFKnwlMb7muDOGwMp/pLwfS+r7cfWLK5vAF+CFurbB
 txW49g2KbYK+Hao6JD3t22kiXufvLNB4GEg1j6lIykUH3VWfxbdJXnKbxk11YIeXZGRI6L1gho+
 WvyTH6X0jQyY+69hlYg==
X-Proofpoint-ORIG-GUID: VwRY-miuyYN-IGaNB_OmeMQ1cIoeH3w2
X-Proofpoint-GUID: VwRY-miuyYN-IGaNB_OmeMQ1cIoeH3w2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfXwmoAoJaV1Dl4
 wMATVaZQ7iA3WvXm0LIsOZLJzIGmqq6KN1+iM0/zobxhzCEQYb6iL1GUHOfpJ0tmwHRrjBWXj4A
 qwi0ghneIASapVl63OH0FwOriR2P2p8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110130

More AI reported fixes all over the place. 

Christian Borntraeger (4):
  KVM: s390: keyop: use mmu_lock to read gmap->asce
  KVM: s390: vsie: zero stale crypto bits
  KVM: s390: pv: Fix rc/rrc offset for PVM_DUMP
  KVM: s390: Restore sigset on error path

 arch/s390/kvm/kvm-s390.c | 11 +++++++----
 arch/s390/kvm/vsie.c     |  1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.53.0

