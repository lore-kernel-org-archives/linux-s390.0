Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B5146AA95;
	Tue,  6 Oct 2026 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791295281; cv=none; b=hjeGaOIIct1afKE/h0eKWb5QCuixpMb0B705bkgdpXsWD800urrHchbeZ9amMZ4BlajQGzWZoHxIq6xUR/1AdhKjIxEfsCK4/qXPlmRIoVgczqgs80bvxXLVb+wclpBdSHxN7N17Z26VFU8adMjToFL7HeRsiBuuhLdeKfWx7mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791295281; c=relaxed/simple;
	bh=v/l+FV+bjTOwQTaMx0EGsuzGKhHopvxWz169Co/nrh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NRc3mLB3+gc2GMY0eFrvYBRtnG6r/I3ml4XE7b4T1jEgOy3qQO2H+2xKHdeFtE6s1nI5/6lGh4zDJIGaf01ncAr9LQXUAGY6pR8HRAZAGZeXSxNR2U6D2YZUWcdzShQEsWtTq+neoss5Z3VUyGCAwmp9B6Rk5EYzwHf5E/uS9Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qjzjPGQw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qjzjPGQw"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696DZLrM3846949;
	Tue, 6 Oct 2026 14:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=dxHJZFbWIVHA3VdqZfbeUn6J3BGK8L8su0rKprxpu
	aA=; b=qjzjPGQwG0lNKGUMPGS2zw5pmjaA6Q/cJBMjXGzTyFU8apyFeTnEAkAsS
	/zybr2yn5igP9eD5coXQ6ULNcRv+Y7vKaqxERdpLpV837GsRgl9cXauKmz07fAu2
	e84eoQ7MqURN1oboXu/eIh+2hUDSglqJPicPnEgd83xsP8xVZ4hIrskNSY74ua/T
	ccADzPPRGw4TKgsT/kxzjdr1lup1rzZItAZmq8psrAZcMtCASItZ5lYjmVIG+ihv
	i52bJfmrEC3D9m0Z6MYUbtL55q8/HwIWf/YGbJ/LD/5PLb5Y1skn2291BQJyU1VH
	VSzaBJlIWTpw3Rw7fDv+ugGnTKq4Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5gau5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 14:01:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696DWYMg337276;
	Tue, 6 Oct 2026 14:01:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1jt63g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 14:01:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696E1DgF53281268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 14:01:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB8022004E;
	Tue,  6 Oct 2026 14:01:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A17172004B;
	Tue,  6 Oct 2026 14:01:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 14:01:13 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 0/2] s390: Remove vtimer infrastructure
Date: Tue,  6 Oct 2026 16:01:11 +0200
Message-ID: <20261006140113.3128582-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1NCBTYWx0ZWRfX56XzCBZKHT35
 F9HViLgJnR70+8N50udrVQ+5K9lCPLllURrV037wj0YQgo5ggmtoQ3L4YCfrPyQssvaZfOQthdE
 rMz60dbtU26I3rxJdrxBT4Vm1uq5/+E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1NCBTYWx0ZWRfX+VLmcwPquQTS
 6mlANIlaPbGFBtkFMUKNGp1sMj0kyFFXMPiLSLCAlpLbRJGEEHdfZZyZgXwfFGd6hEwtAESy/hE
 SddSic4WbDXlo7glkLo9+Nn8HdRXRIwcxxANBZ7d19BKjhcFQ4G0gL75eAK6EhIZYdiqvQlJZkF
 ROkmdEybGSltdV1W3WSiHv8L1gHOVcjPczGGdZ4GTfFlzU/2gH1Q2XyM012MQFXFufegSOK/rb6
 f/eE6yxCSyHhokhbRigFF3eSmKo0+TdeLlNmPzKqU8o6S0I5x5rqhkDiqaAIY9Hy3zlBYu2t+x9
 TIu+D421UKuTZv/w608SsRO1F1ujb36vy3pqToCXUDvF6gC/D8C2sp22i0sAXoMrj79TiOAAPy5
 hxDhxyPmWVO9614KFeHi3YIUKfc/gvGcO2DELdERXd6t1oUoyjkxtsC4twt+I6odV4eGzvcKI3J
 I9t1VWyY13A+0AxaqyQ==
X-Proofpoint-GUID: i1MbHg_G9rDaxlVtuoHboLmHzfxzUOit
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac4ff2f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=IDWH8gVEt6i1YDZ61c0A:9
X-Proofpoint-ORIG-GUID: i1MbHg_G9rDaxlVtuoHboLmHzfxzUOit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060054

v2:
- Use for_each_possible_cpu() instead of for_each_online_cpu() in
  appldata_total_cpu_time_ns() to make sure the reported cpu time is
  monotonic increasing [Sashiko]

- Rework locking in __appldata_timer_setup() to make sure
  appldata_timer_active always reflects if a work is still active or
  not [Sashiko]

- Use mod_delayed_work() [Sashiko]

- Add cpu hotplug handler to recalculate interval if a new CPU is
  added, avoiding potential long delays between an expired timer and
  when the callback is run

- Avoid using scoped_guard(), etc. - keep coding style consistent
  within the file

v1:
s390's virtual timer infrastructure has only a single user and the
semantics of the interface are not straightforward: a virtual timer
fires if the sum of elapsed CPU time over all CPUs exceeds a specified
value.

This is suboptimal since the number of active CPUs defines how
frequently the timer fires. With many CPUs and short intervals this can
be very frequent. Furthermore the required accounting in the vtime code
uses a single 64-bit value to accumulate elapsed CPU time. In busy
systems this can lead to cache line bouncing when the value is updated
concurrently on several CPUs; which is the reason why other accounting
mechanisms use per-CPU data structures for this purpose.

In practice this is not a problem with the appldata default interval
of 10 seconds, however the interval is configurable via sysctl with a
minimum value of 1ms.

Given that there is only a single user, emulate the virtual timer in
appldata using delayed work: the work is scheduled for the minimum
possible wall-clock time until the configured CPU-time interval elapses
(remaining CPU time / number of online CPUs), with a minimum delay of
100ms. The work then reads per-CPU statistics of all online CPUs to
check whether enough CPU time has elapsed, and if so runs the
registered callbacks.

The calculation is more expensive, but avoids potential cache line
bouncing problem. In addition it allows to remove the entire vtimer
infrastructure code with a subsequent patch.

Thanks,
Heiko

Heiko Carstens (2):
  s390/appldata: Emulate virtual timer with delayed work
  s390/vtime: Remove vtimer infrastructure

 arch/s390/appldata/appldata_base.c | 171 ++++++++++++++---------
 arch/s390/include/asm/vtime.h      |   2 +
 arch/s390/include/asm/vtimer.h     |  30 ----
 arch/s390/kernel/process.c         |   1 -
 arch/s390/kernel/smp.c             |   2 +-
 arch/s390/kernel/time.c            |   2 +-
 arch/s390/kernel/vtime.c           | 212 ++---------------------------
 7 files changed, 119 insertions(+), 301 deletions(-)
 delete mode 100644 arch/s390/include/asm/vtimer.h

-- 
2.53.0

