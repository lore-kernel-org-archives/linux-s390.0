Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02224DEC09;
	Thu, 17 Sep 2026 19:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789672974; cv=none; b=YNgx5z9I6NGsYjjg3sB97D6T+YBrgCi55WfQjuKXYhrio+oIV7v3L/kc/8gaE9VLK9h7J6ZVICBxHcvcFXx0YZbEbrIltdrIDHK1ImVyPkXP2hNxBgENvRgykLN+JhRzqegl1fpHSkmDhrWxbjzSLci2Qf9Zw21YBpQmkfN3YvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789672974; c=relaxed/simple;
	bh=oYSS5LH9Wq6JFBwbRBgyMKyfRB3Qt3uYDGQDEMNfrI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TqD5AkwJ1Y4hUIT/0O2RGvYsKaJuVmCEA97yuedadAp3AuKhnI2k933Dx5Fs0F9JHAvZpuIXXEbDmN1cQRh6a3n106kZURZQclF2JKMimDPgbRrUB/rgmIT2kyJOd/nxF7cUr1cH8beSrbtYz5WdT0uSUAsgTfaO18c0T8ItLAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cWng1FXu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cWng1FXu"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HHVY8C1980312;
	Thu, 17 Sep 2026 19:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=a4fsfwnyliNOQfbKdbsDY1Rxm+aR9WlLvKdjhR8IN
	x0=; b=cWng1FXuano9wCMv4+eoJ9WgtqYMTOng4oqE9xFJ2Ez2dVBk4b8boV6Bb
	3ZbLo/fstUTDLDwk+tMJBZ6LOzwYEsH1A2ewdIGwZbF61U7Z/Cku6D74XpKqJD/M
	LxaglKZu0pSA5pLUdHqj4N4ByKmCj+0VyyT2xbTv8Kvy5NHz8SjdAJlE6di16iCq
	/5RCmiDG/RMoOeBRBb5bOwYCH4jMLa0mG2bj+PUOtXuhkvivTJ5WQZGllSsAUJIe
	I17eM0yAXp8dahH7jmnQLtSwV6RCtL7olyyveozFCt10gGY6fxgujEtMg1EZrhx4
	KOh/ewY3yHC5qzj4MgNk9JVtnCIkg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5ebxs1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 19:22:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68HH9Nu43494101;
	Thu, 17 Sep 2026 19:22:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5fjm08a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 19:22:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68HJMb5l46661888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 19:22:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8062120049;
	Thu, 17 Sep 2026 19:22:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58F3320040;
	Thu, 17 Sep 2026 19:22:37 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 19:22:37 +0000 (GMT)
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
Subject: [PATCH 00/12] s390: More this_cpu_*() changes
Date: Thu, 17 Sep 2026 21:22:25 +0200
Message-ID: <20260917192237.638324-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI3MiBTYWx0ZWRfXysyFp1LQoniM
 VBoXtlkhIDMEa2PkB4cufTaJ6Jt00a6HcCYI56o7ee7YmkJUV+jzSs8wbDqBnazBA3zQQvff+6t
 47NfE2JFqEA2gI9NXZCXWl1IrKTZV2+1LM13oJ9tygjZoXMBrjcR06zvd1/XnazGpA762E8O8gZ
 wUUkNIQsHHxBy5xVPJwBUSBbS+N6FvcfnzO+4QLg1A8kHnfsRVeDfiHEGbSqMOZPh4Wa5wwFqyz
 gGBMgmQJtBVBpq1rG9anqOt4UXrUycFdzj7luCRmviFlivoRmKaslgdtzC1Ppg3p9GbRVLTpTP+
 WZ49xO9U25nGL9fOHgQzhw1yhrARi17KdGzP+29Cxocd74XlgjzKdoEXBMRK1HmDfWL+hTn96lZ
 I76FNQ44Y+v7E6pvxaN3reuavkWd3tNHACD0j2M5JvObY8OlYX2DHFkQs3ZVjkaLB/6Z4chn/5X
 6vaHwXJspUG/hQhSrGw==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aac3e02 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=8OyHxx80QQR7nGcn_KoA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: heEYCboTfH4mqVQMwB0epe_t2Zup1a63
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI3MiBTYWx0ZWRfX2lLeZbmRpuDT
 Mgp2O+vEqtRwg3nLW9eO19vSW3IyCze9FM9Pj/eWDBFkP0cYx8jPv47wkQuRi8XxCINX5mI02IU
 Y11ipW5VdozZcuMfCoKjLj2Xwq5hjq0=
X-Proofpoint-GUID: heEYCboTfH4mqVQMwB0epe_t2Zup1a63
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170272

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
 arch/s390/include/asm/entry-percpu.h |  74 ++----
 arch/s390/include/asm/lowcore.h      |   5 +-
 arch/s390/include/asm/percpu.h       | 381 +++++++++++++++++----------
 arch/s390/include/asm/ptrace.h       |   1 -
 arch/s390/kernel/irq.c               |  10 +-
 arch/s390/kernel/nmi.c               |   4 +-
 arch/s390/kernel/traps.c             |   4 +-
 8 files changed, 279 insertions(+), 206 deletions(-)

-- 
2.53.0

