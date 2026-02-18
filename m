Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E303333343A;
	Wed, 18 Feb 2026 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771424423; cv=none; b=T1Tjk/MCX0RqNp1Md+qn0Q0y4EyQ7yNYqaUDEkRI+Kio5z59Ho1Al09NlspGN+1dWGs5s1N3ICDn/M/SIaACTeVx9BqnNS+MtsycSZ+F9AWtB6k3VFthAbg2JjWDGAKqgrsXUoNj4D00xZP9ytF+Ntz8GIF/NqG0GDRRosxZpwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771424423; c=relaxed/simple;
	bh=3EyI4qwTX5gkLNjfJL1ssVGr1xtBB/PQuIexvj9nocc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpU+0Wd+i2kRVO9rGVcZi3R478Etc2sw69ouGOADG3A9g0ajKR9H3L/ea2ikEwkcXxzDVhDH+g6zGlLpUUdDW02Fpzqh3OrE0WU7i4cNTbHUVb6MjAxxadyoRFR7B4k4S3ibgPL9wMtBdYQROnEoLaLOEmLAyEPwHW4BWRYQiok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YyfOOxAE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YyfOOxAE"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61IDjaFJ1915831;
	Wed, 18 Feb 2026 14:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pOJ/wADkwVehOiYSV
	j5J1q4Q/2STW8GSGxc2ha3bLOU=; b=YyfOOxAEA9BW2IqUZ352jRuR+adroPcP9
	BVsvdLgdO6axAghjZ6o0H98frwOwpFNMIImJrw6/JuaqLBrK927H0wW3mliF5xt8
	HhysUN/xW3VxzGTUKvi1dAD731JYamDplaLEGGCU+iAwQ7JPdpQnSUWIYOrq/2mF
	hTXSqQTsZK98Ph9L0H5Ol/XoivMXV8QgQSzZ7aGu8fAanEkgT8agwEd6sJcq0ArE
	7F4snbkKADWNxNPAAS5hTc0rnra+fX5+n1hqJu7gbV4e8bsQJcAeq/DeAWh5XdFY
	GCMFOFJQ2ikpTSjopMMJ2MiF1hegShZVv+MDss+SjjMGm/zXwgifw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6ushd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 14:20:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61IDUDjn001381;
	Wed, 18 Feb 2026 14:20:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb2bg31q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 14:20:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61IEKECG15204760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 14:20:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 643DE20043;
	Wed, 18 Feb 2026 14:20:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43C9D20040;
	Wed, 18 Feb 2026 14:20:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Feb 2026 14:20:14 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 7/9] s390/vtime: Use __this_cpu_read() / get rid of READ_ONCE()
Date: Wed, 18 Feb 2026 15:20:10 +0100
Message-ID: <20260218142012.863464-8-hca@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=E+/AZKdl c=1 sm=1 tr=0 ts=6995caa2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=U-gbc-jHn7uRwbEksAQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDEyMCBTYWx0ZWRfXwVmiwHADooC5
 UUS9zNXESL2NXS/evT7xDmqeARf6DN/OpcvRpfz4VlmrQHJml71FvsBE7o6+eZ9TQeevPYhvZ9d
 p24wsA2rKMFtJbAg1MM1HIZ1gsDOROb89ft1CNwBZTM3/qU5LNYyBe7XFOKhEgWVxCigqAwVA99
 C0m0irldVFC3s8Wein8bAc0R+RAhDLk7tFnYKypFpgRZ0+pjTv40WzS/gPNiOJZJYiNtc11zEhl
 J4aGVLu1QwZsQJbxBAS5+XW6fTBOKcFIafuSCEynDnY04JlYxz+TLyfhGa7G+xbWRyQP7FSdHiT
 QimbF4dKtCVEOy4Qd8+5wW/kNlqewr3Sz30kSYbOXfWpERhTnwtFVTQmGEl2jBV0BrpxsgOm0wG
 wTUxI0Vd2+yVCdFjNn/gp0rP+DreFWd02VLhyvHFeptxfrcht0b2fsFLucMr8up4u3Zic+4ui0Z
 AthhQyhritcJ9svCncA==
X-Proofpoint-ORIG-GUID: ef6QU2xgt0J1G4jBBOP85CrnfxCZuCvC
X-Proofpoint-GUID: ef6QU2xgt0J1G4jBBOP85CrnfxCZuCvC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_02,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180120

do_account_vtime() runs always with interrupts disabled, therefore use
__this_cpu_read() instead of this_cpu_read() to get rid of a pointless
preempt_disable() / preempt_enable() pair.

Also there are no concurrent writers to the cpu time accounting fields
in lowcore. Therefore get rid of READ_ONCE() usages.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/vtime.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index 122d30b10440..4111ff4d727c 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -137,23 +137,16 @@ static int do_account_vtime(struct task_struct *tsk)
 		lc->system_timer += timer;
 
 	/* Update MT utilization calculation */
-	if (smp_cpu_mtid &&
-	    time_after64(jiffies_64, this_cpu_read(mt_scaling_jiffies)))
+	if (smp_cpu_mtid && time_after64(jiffies_64, __this_cpu_read(mt_scaling_jiffies)))
 		update_mt_scaling();
 
 	/* Calculate cputime delta */
-	user = update_tsk_timer(&tsk->thread.user_timer,
-				READ_ONCE(lc->user_timer));
-	guest = update_tsk_timer(&tsk->thread.guest_timer,
-				 READ_ONCE(lc->guest_timer));
-	system = update_tsk_timer(&tsk->thread.system_timer,
-				  READ_ONCE(lc->system_timer));
-	hardirq = update_tsk_timer(&tsk->thread.hardirq_timer,
-				   READ_ONCE(lc->hardirq_timer));
-	softirq = update_tsk_timer(&tsk->thread.softirq_timer,
-				   READ_ONCE(lc->softirq_timer));
-	lc->steal_timer +=
-		clock - user - guest - system - hardirq - softirq;
+	user = update_tsk_timer(&tsk->thread.user_timer, lc->user_timer);
+	guest = update_tsk_timer(&tsk->thread.guest_timer, lc->guest_timer);
+	system = update_tsk_timer(&tsk->thread.system_timer, lc->system_timer);
+	hardirq = update_tsk_timer(&tsk->thread.hardirq_timer, lc->hardirq_timer);
+	softirq = update_tsk_timer(&tsk->thread.softirq_timer, lc->softirq_timer);
+	lc->steal_timer += clock - user - guest - system - hardirq - softirq;
 
 	/* Push account value */
 	if (user) {
-- 
2.51.0

