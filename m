Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235F1483BFC;
	Fri, 14 Aug 2026 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725247; cv=none; b=W/aJmMVfAjHmN9oOGEa+ueX9dcw9sSedGGvugva/jckoMtSDhnAGgpc7oVT2iMHoSdsTtpW3TiHoJ8xrl0Te1tJkuwua0XCJZeI/8/w/PCLZbBwLWr/tIDke5+zuOl4BbC7j9kDwQbd3pJgckOvINn9dRZvj5/by0Bqk7dMdrLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725247; c=relaxed/simple;
	bh=OJabUmjpN2xVQQuzzXfItbIk31nOl2WjqbAEbvIWHes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P4snw1SI5q1Lldo/YWK36VEaSAii8B4MRd+rVHwE2ZNoopI0SGXHArPoROkPRXrHPaoY0wlkPHF4nvsdRxhRYP/cBqiIR7mX9ivnYCyxv4csR/RCSOeeSX/l5e3FDwo9KPyqesi0ny8om/vDxiOuM3922DHJUpAiPhYuv88oad4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L5xlmib5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L5xlmib5"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EE5h171247928;
	Fri, 14 Aug 2026 16:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=xa8DlR3FkoNKgdGJvDv3c3mE5bR5FT6suhTkUfEKa
	XI=; b=L5xlmib5IZcW2ySOmIvs4qbXYClPojHN+spzoXsZYieB5glX7ubSxCkgU
	ZHFEMBUXdrV6lkpfl/0uQf8ZMCynjJdOKN2kDQaKQqA+r6jMtNS/j+tYM/Bk13kQ
	tl+qyk72AulMUmfb3Luc7wll9Yjn275O+aSgB/QUaODhJKVaCUu98k6L49NWwEvx
	7QWYt5kYcpwD4lHCSW10/MP51XR3x+epP9V+VCalx/vzs//tzw9cC5sUvRkBABEX
	5Zc7FMHujToEC62HbU8yDHybn6Qi5TcWCErD0PGMRI3HVaNntjNF69EYcO3kpPjA
	MdF8hsEFDPHHKE3SOEqY7Px6oWqhA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp3chhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 16:34:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EGQHZi015977;
	Fri, 14 Aug 2026 16:34:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsk81b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 16:34:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EGXuCk31981866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 16:33:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0270920043;
	Fri, 14 Aug 2026 16:33:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C526820040;
	Fri, 14 Aug 2026 16:33:55 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 16:33:55 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 0/6] KVM: s390: Even more misc fixes
Date: Fri, 14 Aug 2026 18:33:49 +0200
Message-ID: <20260814163355.227191-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7f437b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=XVQnN-byj0jvHxSx_-UA:9
X-Proofpoint-GUID: CBANHiHhx8HBAv7uLpE4Y5viEcYtpUJt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDEyNiBTYWx0ZWRfX4Eze0UA+MUf6
 g32tcsUPuceZV1O6X/E2A6MWqSAJ9+9MObAbEDj70EJiXDqR531L68KR+/hhbNSQiMXHZeItY6a
 fKfLQq1D1h4NDpa/r2Kzfg0DuRBPUH4+NnSWVFcAcAtKR/30c/WCxVxPtnM+VLEHU2mbvA5ofoj
 3krAA8HfhPFFASGfkUjSx03o+UOFRmYTQ0HVQXZ+iMhDqELrlwKd6Ld5jLQpqpYivuDgD6UnlR3
 E2zRoXcVqq1V9cdqNfT9+MW5KZ6PCts3VrQ9WwqA/grZX7Qs1dy5wDbnBWZlfZFmj0VSz5onlsO
 QLYnTNN1og63uiixNWEyxtLVi6ZyPJDhGh3gs/Te8Wj4P65x/nW1oCweTSVbCToSIUCMJSCkVrd
 cC3zlZfhg3Opn6SZGMDsYmt92V4H5hL5kG68FSqkCTE88co1KOr3Cv5CGgqjG3nQaXFQ59X39Dn
 pahlw/0+77zo+v9huOw==
X-Proofpoint-ORIG-GUID: CBANHiHhx8HBAv7uLpE4Y5viEcYtpUJt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDEyNiBTYWx0ZWRfX9FDqhjE3gIyu
 efV3YV/KImY6f9k6E1MrYE0Atg/BQhIgnV+Daf2yOLIt3cKDbupP0PZxNXdq8nGoILlO2RB6NSU
 uEIFIUA5t08xOlAaGw7YCFr7APy2EEE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140126

A few fixes that had been dropped from previous series due to still
having issues, plus a few new fixes.

v1->v2:
* Fix racy usage of sg->parent in patch 2
* Fix wrong number of arguments for dat_delete_slot() in patch 3
* Restrict srcu usage to the bare minimum necessary to avoid potentially
  triggering page faults in the guest while holding the srcu
* Fix races also in other skey functions


Claudio Imbrenda (6):
  KVM: s390: Fix dirty marking in adapter_indicators_set*()
  KVM: s390: Fix _gaccess_shadow_fault()
  KVM: s390: Refactor dat_set_slot()
  KVM: s390: Move all code into kvm_arch_prepare_memory_region()
  KVM: s390: Add missing srcu in kvm_s390_set_irq_state()
  KVM: s390: Fix potential races in dat skey functions

 arch/s390/kvm/dat.c       |  65 +++++++++++---------
 arch/s390/kvm/dat.h       |  10 ++--
 arch/s390/kvm/gaccess.c   |  13 ++++
 arch/s390/kvm/interrupt.c |  44 +++++++-------
 arch/s390/kvm/kvm-s390.c  | 122 +++++++++++++++++---------------------
 5 files changed, 132 insertions(+), 122 deletions(-)

-- 
2.55.0

