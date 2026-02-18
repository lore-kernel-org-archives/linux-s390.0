Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E0D32FA00;
	Wed, 18 Feb 2026 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771424422; cv=none; b=QP5+zxExXDWbwhZDgRWvEeDr72/bAn/bq6CFxKxiy0PIIpMx10Wnkq16r/huZ5EQAh6jaH3E5K2rxo7vZ8F0rPLho98Phn7tgblLWrMVvVqaY8agszlz/Vrr69W0Rpr8Qm4QLyMZrqG8ta6AHYuvITOZgnoEBGdZqzWfcLVcO7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771424422; c=relaxed/simple;
	bh=wQd1/GlJbhrQGcsmPRyXCDBuRblJ6DrdnJfOyv9ytrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKR6TtSG43EcU4ncT33ntDmv31AvS+lQ46JjEI0CvNFHnFHsH6d20rWiRFUVw+zAcVsGX5zj1YYC/jr1xiRozHTZ1AtTJCpQvwmQ1tdFn0ehn3ChIR9RwsvT3CFVSetczzWpP5Tp0NoJSQue5ey8bqHqquuANMQ5vSDjlpd/uE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qQQ/Fx15; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qQQ/Fx15"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I3gtLJ2301761;
	Wed, 18 Feb 2026 14:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rfaKktZX0rgmOILbT
	OClBEUylYCktdaj1x7BupczWcU=; b=qQQ/Fx15FTaIONn+pob35V7JREOMk5jGl
	tpXp0XxIEtAd9tlHOm140kNKLr+ycyOAd8crenUrdJmhyle9briSMLJ5ONet2wWp
	yJRDsgZUwPG1mgEdb1ANaG0MVmTlcZk8g3nZsmUQbVK8CGTluh99+vR7X3wm554i
	e6tc0m0m6hYxJLlZxCs2wAN8LfOhsvaQPxgpjY99R9pTQlftOnu1ENh1GHwM9C+v
	2A91ISvrZ8EgLa+ZIeJhRcprogFAezW4wtm8m2zSBmMQHl3xjVNIgM63LnWotNNZ
	vrdZT77eBGct9K7oJiLu9c6yCUS+0SrPb4SdflYqCG4hhlJl4BTkQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj648ey3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 14:20:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61IDb4PK001432;
	Wed, 18 Feb 2026 14:20:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb2bg31n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 14:20:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61IEKDck33947970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 14:20:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C241D20043;
	Wed, 18 Feb 2026 14:20:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2B3E2004D;
	Wed, 18 Feb 2026 14:20:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Feb 2026 14:20:13 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 3/9] s390/idle: Add comment for non obvious code
Date: Wed, 18 Feb 2026 15:20:06 +0100
Message-ID: <20260218142012.863464-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260218142012.863464-1-hca@linux.ibm.com>
References: <20260218142012.863464-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: I8tMsWU0hwDELJTIVg53Rhvv6W2HRaeH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDEyMCBTYWx0ZWRfX6b+dDX4oZU9Q
 2OMopSEulipltFfDLjJ8m/ONR6WiSSKcN0ItQvO0xcy9K4+BCr2XYhnMGiCUNtA59Idit7+LVky
 9Y7JYOTRab6saj9Asb+RMty/AzM0XYsdLX6JIVYvcr1LYFJVikzx494sdR5hpEgTyd7ZOnprwwv
 W83HLejDjZywvkWOt7kkACRnESz4LiGR/AO4iEx8IdWumWOpLjMfOIqSTpfH5/iM1yn82VXsMlb
 4OJHSTTxAUPqAqFyhf54tZf/Wt6yAN3uwLphqDBLrMgvLhWCpLqf0qDhWSSJ+YHMiftqwNNgDSh
 MfrZJgf+1ov9CcHJOnc9AyOjqLhtV9mU6IYVZCloljFPNtU83sdGt4IxNMJbOVhAq2DPv7gvLAt
 Ymc0acVyWCgyW2ET8VbKTTp9qDNUvrevQ9xpBrgwszjuzycKJIlBHWs8w0IuH6LduNxZMC+iP8v
 LpqFdt2bxmuuxdjYLtA==
X-Proofpoint-GUID: I8tMsWU0hwDELJTIVg53Rhvv6W2HRaeH
X-Authority-Analysis: v=2.4 cv=U+mfzOru c=1 sm=1 tr=0 ts=6995caa2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=OTAgdNo29iS1D3tcfewA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_02,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602180120

Add a comment to update_timer_idle() which describes why wall time (not
steal time) is added to steal_timer. This is not obvious and was reported
by Frederic Weisbecker.

Reported-by: Frederic Weisbecker <frederic@kernel.org>
Closes: https://lore.kernel.org/all/aXEVM-04lj0lntMr@localhost.localdomain/
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/idle.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index 0f9e53f0a068..4e09f126d4fc 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -34,6 +34,15 @@ void update_timer_idle(void)
 			this_cpu_add(mt_cycles[i], cycles_new[i] - idle->mt_cycles_enter[i]);
 	}
 
+	/*
+	 * This is a bit subtle: Forward last_update_clock so it excludes idle
+	 * time. For correct steal time calculation in do_account_vtime() add
+	 * passed wall time before idle_enter to steal_timer:
+	 * During the passed wall time before idle_enter CPU time may have
+	 * been accounted to system, hardirq, softirq, etc. lowcore fields.
+	 * The accounted CPU times will be subtracted again from steal_timer
+	 * when accumulated steal time is calculated in do_account_vtime().
+	 */
 	lc->steal_timer += idle->clock_idle_enter - lc->last_update_clock;
 	lc->last_update_clock = lc->int_clock;
 
-- 
2.51.0

