Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15C73B8D76;
	Fri, 18 Sep 2026 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721342; cv=none; b=b9eKnVEjDH795obWBPk0iED7i6OL3jJm35FgIGcq8M/5/LjcGgEfQu47wJ0NXSb4yIjid3AmtEIdcVpzVs11v3gCp2nYso5lOi3WfkaDz/WHCxUTUEkczmBylYtM/jqRwguW+Hj8EAIBW7q/8uH0gZT5KirTmgrEBadPHjrCkSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721342; c=relaxed/simple;
	bh=M5w7KcZOFjWUhKQxEtrZrifriRvEqCkFNPWOUvZGcuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GV+aIs9akaOzZifQZboV4mw5S3CA0kOultmBoHwEJQAheSYBEbonQaMBXFsGmkFJZs7T9+iI3unjb+8R11AcKtRYWb8HW47vVQwamjrDIUa+x/H1UMKG9QB4nvdToeIPRJC8wnXOWU2IMF61r6qC0R0Ly17eHqxL0cLhW3p+nN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dLtrdPzz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dLtrdPzz"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I61aWZ470421;
	Fri, 18 Sep 2026 08:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=OXrvCxG5XQe1pTod/Bq+dTKdA88fiKYkK/6Yxs0fU
	qU=; b=dLtrdPzzYILK5+HwHpRsJySbnmR4RbapC5/T6RnOCmF9Ohq3ezK8g2/PJ
	slBv7tjP/ovnf6b8mZAJ2yG3UFHvzqk3d8+Qe2IbltaQj2zq+JAlKIxJDcn7DYTX
	Xy2DFR1I9i+yMtl9LaTHEFeFG6K/hzPMVkoDYBEV4TCmHBoXi84iOa7rfIaE+tpu
	mewvy7VWVz4L87zpZTYCx4qZkfBTwkjmgndzqZjiaf6xQS6a5L36S/BwDteASp6l
	mv4hV+M7f2SdW6rOzLkO1YjlIcCU4X1jJ2sfI81/hkuPcFtxotxIo2/I/b2iELvc
	ZyM8WRz6Tb3w2j4XUP9EdTwCZgpJA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf5f5h8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:48:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I653vi170846;
	Fri, 18 Sep 2026 08:48:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gra3fdm97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:48:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I8mgwA51249526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 08:48:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A36CC20043;
	Fri, 18 Sep 2026 08:48:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75EF820040;
	Fri, 18 Sep 2026 08:48:42 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 08:48:42 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Mete Durlu <meted@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 00/12] s390: More this_cpu_*() changes
Date: Fri, 18 Sep 2026 10:48:30 +0200
Message-ID: <20260918084842.2333237-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tPp94R0l5J1zesA6-o_FrJSRsci5LMw2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfXzwPrXimprq29
 fKzCR4hHQo+Qn4AfMxEvET7xlUbPd/9c+FR9ZIizyJfgEHVIakmyR4xUjuBr8sarxbICRs6pP+c
 mP8irb5UADu9drdt590glpW4v4WyfCs=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aacfaef cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=65YiLOsmmCOHQeg3vsAA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: tPp94R0l5J1zesA6-o_FrJSRsci5LMw2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfX9Fv4NW1cg4wK
 fh8iy7ZUoYqTY27DdAdMg1Ezd1G7SXUvKzW8k0aElgH/tI7Z7UNIfErNTO+NH9ajV1IUfnsgno+
 R2qwMBGddVjPKriwGbym5QSL6f62OCtvpUd9dZ05INYE52X+/H8XUT5TYl/MwX1HIyugJy6jhNU
 rckZVvGSuOpGDFoGl5tpPcAx7f3OMTW1Okrm7Q8ew28kp5BKPqsbjB9ymJkpAr7OOeA+sJaQPqQ
 Rpf9Dxxcuq2h4b8G6zKmtoc0RnYtTH77sihhztcAeBF5ZagIvHqLRTso23qEXPNMb7whTnomRR7
 K9fmdioUi3cpJuV8KQQk+VvDirNkVblwHmQIWtR0RShCyc9daRbYHL03BolKOVcs7C3ggdkAU54
 GDtUMUkrIl6bnJmMqN6lCFGbkR8LCgXRZeIoEUJg0pn/OFj/SawBEeMFhDfD/o3hTW0Ou+QbSMQ
 h3o0XzjVH/dKPTtuRWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180117

v2:
- Yet another brown paper bug: Re-add CPU migration check to last
  patch. Unconditionally recalculating and updating the percpu variable
  address and percpu offset register can corrupt previous context
  register state in several cases (not only the single case reported by
  Sashiko).

v1:
Most of this is only about cleaning up the percpu code after preemptible
this_cpu_*() operations have been implemented. The first ten patches are
all more or less trivial cleanup patches trying to make the code shorter
and more readable.

The only non-trivial patch is the last one, which converts s390's
this_cpu_*() operations to use a similar scheme like Mark Rutland
provided it for arm64 [1]. This allows to simplify the irq entry and exit
path, however at the cost of slightly worse code for this_cpu_*()
operations.

The simplified irq entry and exit code seems to be worth it. Usable
performance numbers are not available yet, however I don't expect big
difference to before.

[1] https://lore.kernel.org/all/20260904161758.376504-1-mark.rutland@arm.com/

Thanks,
Heiko

Heiko Carstens (12):
  s390/percpu: Fix comment typo
  s390/percpu: Add sanity check to GEN_MVIY macro
  s390/lowcore: Remove _AC() from LOWCORE_ALT_ADDRESS
  s390/percpu: Let MVIY_PERCPU() calculate alternative displacement
  s390/percpu/lowcore: Add and use LC_PERCPU lowcore offset defines
  s390/percpu: Rename inline assembly symbolic names
  s390/percpu: Use __PCPU_BEGIN() and __PCPU_END() for inline assemblies
  s390/percpu: Use percpu code section for this_cpu_cmpxchg128()
  s390/percpu: Use percpu code section for this_cpu_xchg()
  s390/percpu: Use percpu code section for this_cpu_cmpxchg()
  s390: Add CC_HAS_ASM_M_FORMAT_FLAG config option
  s390/percpu: Rework to simplify percpu_entry() and percpu_exit()

 arch/s390/Kconfig                    |   6 +
 arch/s390/include/asm/entry-percpu.h |  71 ++---
 arch/s390/include/asm/lowcore.h      |   5 +-
 arch/s390/include/asm/percpu.h       | 381 +++++++++++++++++----------
 arch/s390/include/asm/ptrace.h       |   2 +-
 arch/s390/kernel/irq.c               |  10 +-
 arch/s390/kernel/nmi.c               |   4 +-
 arch/s390/kernel/traps.c             |   4 +-
 8 files changed, 280 insertions(+), 203 deletions(-)

-- 
2.53.0

