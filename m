Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A751340283
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 07:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786604905; cv=none; b=ZU3Nk4AmwThwDgw9o3lhl87kdPftT2n+0FTSjwvKPIFOtwFoS30NZ8Y/fBOq4fjwu/vBcXBg7m0XU7txlR2qhRtflBK+WmnK6y763R5h6nOuDI5LeTaWyq2o3g75Wx5UC2yWbu2aIbimeP5HVnU8j/wum4An3VziiC+IunxpQFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786604905; c=relaxed/simple;
	bh=MsQl/EDWzSbaa32n/Oa3nIdFU282jZEzjmGafcnrqvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iSIJokgdR97Ryj/1Cvhwg0JJZtrf2OQc0ACkUzhQ/jVl0e3VIsd5XRTDpa0Y0ihD93qdeiH1tE53Mcu74RMyc7F3pcugcKQKZYKCxuw8ZrIPjZz/bNpaHp+EDpIDA5G/VRflIPTQy10wLdoSzUBTRZQ9Tzxsgt8274yA1/ABb94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tipQDmY5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tipQDmY5"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D61uhT1430825
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 07:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=41cYJv8CVQ0qlz5SKWrQpOGaY5/D6YloS0vsMUMG8
	uQ=; b=tipQDmY5jDX6LwPjRww2ZGuVkz0V0H64BMbIzJvuZVcFtT+8lXJzSM7Nf
	dHcdUio4Px1D2Vx39Di9s6hiulnHBE2Ipa7aph8lsW7ajUf09yAocuEly8SWm130
	Sr6d9TfqpVKqWOda8mkI5tevpfVc4yUM53mXg5GdnLbc5WjXqRDwfEisFX+NV0dJ
	lm70Qd5TnRwigSLmF4RNYG6z4PnaeilhcLrWvaYhS6aFI+lNMuO2y9hJL/Y2djeU
	mMAkIUSaFxYNzf7LrTRCj0++LlUkYF4kkC5h7pEBL2uixpewIXzGIECm4sRt1Ier
	E8QwNDmqwe/JTeuLFJU/ZvW3P2eng==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp35rft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 07:08:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67D6uTCN018780
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 07:08:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesqa4gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 07:08:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67D78HbK47055342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 07:08:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80E2F20043;
	Thu, 13 Aug 2026 07:08:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BC7820040;
	Thu, 13 Aug 2026 07:08:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 07:08:17 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] s390/pai: Handle multiple PMU stop callback invocations
Date: Thu, 13 Aug 2026 09:08:15 +0200
Message-ID: <20260813070815.2692398-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7d6d66 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=b6_6n78pCtPly934600A:9
X-Proofpoint-GUID: pM1peSR0c6Vxw3zqTvtvi6r_auxJiIqQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA0NyBTYWx0ZWRfX8VODgqpNxLIN
 IV0CHOP41hwFqdNEb07t1aqOypsGM+1yGQAOFZgfUn4kFsdczclPsEpb0KEfpOxojCyPijTkO9i
 wsRYf62F3OpPtYuzinNNlxjy/GGNJdRr8KtoVjkLKGFvkQWrmemYP973n015VqT91wJTFr9x+Mg
 5DXrShniutmQUwmrSeoUVw/3rQOPRFhhI7iqTG0oLGBZyPpoNrMo0Q5OpsuK+pDH6YFKEyCWOU7
 8Ng9E1p2JDLp18Y38AH1OM69VZXK7Jpqb+XpLKDNI2NHdEu7I7R/CuKhA6Y5PyVl8kwCzxJxqG7
 9kiidoh7ZncqqQet+lIwzsTf8b1GdluIlSI5L70UQu2usObbOqpVGt5yz5IVcEs/QX8jf2PcNoR
 IJkoQNRcLCXFFL01JyV+3CqFy3hWoIw9xkG+Qg4+Xq/GFchT0LctomAxehQOXNjJi8QVsWjt5w4
 uAkhE098n1T7T1hU8WA==
X-Proofpoint-ORIG-GUID: pM1peSR0c6Vxw3zqTvtvi6r_auxJiIqQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA0NyBTYWx0ZWRfX87egVBbTqj1a
 rFz8KEMMkBy23VZlcjS0EwBCdiU5JB37R7wJVnxkP1m1zw5cntRwQbjbzU7Zi1qWSrlNfja5/d+
 zVg4wTOiIpYxSCvkNERyDv/lNRosOAY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130047

Handle the following scenario:
The kernel protects itself against a very high sampling load and
throttles the sampling using:

  perf_event_throttle() --> PMU->stop()

Shortly later the scheduler may terminate the task and removes it from the
CPU. It again calls

  PMU->stop()

which results in two invocations of PMU->stop() called back to back.
Protect against this and check the PERF_HES_STOPPED bit on function
entry.  If it is already set return.
Clear bit PERF_HES_STOPPED in PMU->start().

 # Cc: stable@vger.kernel.org # v6.19+
Fixes: ac03223f0723 ("s390/pai_crypto: Add common pai_stop() function")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 arch/s390/kernel/perf_pai.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
index 1e5a1f1cc68a..f6790f658f21 100644
--- a/arch/s390/kernel/perf_pai.c
+++ b/arch/s390/kernel/perf_pai.c
@@ -484,6 +484,7 @@ static void pai_start(struct perf_event *event, int flags,
 			cpump->event = event;
 		}
 	}
+	event->hw.state &= ~PERF_HES_STOPPED;
 }
 
 static void paicrypt_start(struct perf_event *event, int flags)
@@ -530,6 +531,13 @@ static void pai_stop(struct perf_event *event, int flags)
 	struct pai_mapptr *mp = this_cpu_ptr(pai_root[idx].mapptr);
 	struct pai_map *cpump = mp->mapptr;
 
+	/* Cope with multiple invocations:
+	 *   1. perf_event_throttle() --> PMU->stop()
+	 *   2. task schedules out --> PMU->stop()
+	 * Check for event already stopped.
+	 */
+	if (event->hw.state & PERF_HES_STOPPED)
+		return;
 	if (!event->attr.sample_period) {	/* Counting */
 		pai_pmu[idx].pmu->read(event);
 	} else {				/* Sampling */
-- 
2.55.0

