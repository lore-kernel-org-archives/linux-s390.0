Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E8D332916;
	Wed, 18 Feb 2026 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771424422; cv=none; b=rF9v1Z1AoUJNcAM++aUEa3U6bZpDw7p/U2m/PRys3Grf6nvSj3CJ9BJET+2i7GSDb37ZbkHyFzJacGdb4Sr2U20ixsEsHU4DDfVnItQ7MfQKBWEi/RjmKPrybu9LY/KqWSiQKwTwggrUoN566tTJlBzmvNORFPGpp+AiVQtjgm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771424422; c=relaxed/simple;
	bh=wk2ap9Grs5gRzDrhu8Ml9L9h7l13iyGVUQ1PmeDrbls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNPcp6I2GV3eDtW2Ha0wzb3yzMGCt+o/f0o9d2tIfTYvGq5LWUs2B3L7N350VE7Z5jIZ+zoyIUD5ZlvJd4zYW1jLKnhoucxlBUFTaDvEYEF09YOF7HdPIdBr9qAoSzzs79saC7ERFHMYuS6fF8HFtRSqWXjHkF7xDycLbmahy6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QtYh2JXV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QtYh2JXV"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I6fbBQ1907189;
	Wed, 18 Feb 2026 14:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nXSj0IMrvKeHEYN+c
	vFjboEYcPAfBZS6jWD4fK/MDI0=; b=QtYh2JXVPWz3rLOpuqg/LetPr2UBna+vk
	YDKdSMzVbmcDciI/XiFxR2cR8p4gqR9ki08uaycxoYIbTifjnsfIBMGUeN5Pvn13
	3sbCuBur3CWu2z/Jg6WhRoxk/0mtwCUBGxQDmpB0OikxLAdoRWm4kUh1vi9yTP+p
	f2HbMUTEIdtuRjsceT1Z3xQEshBZHTXk/4LVU/kaq8Rb/6K4N7ThiGRl1LggI0cv
	fhVwr0NFpLS1r4SpbMdBfclTS4JXvOWEd5EMzhTNnJLs62LAJl5wJtOhf5Mrcty9
	qEENSIoBeLotAyr3EnAHUvd1eUa2/XICJ8m32RrIKVW29CgsqEeUA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4kgdt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 14:20:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61IDIvlN011965;
	Wed, 18 Feb 2026 14:20:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb2704s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 14:20:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61IEKDGL38601110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 14:20:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77CA820043;
	Wed, 18 Feb 2026 14:20:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5602D2004B;
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
Subject: [PATCH 1/9] s390/idle: Fix cpu idle exit cpu time accounting
Date: Wed, 18 Feb 2026 15:20:04 +0100
Message-ID: <20260218142012.863464-2-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDEyMCBTYWx0ZWRfX+/x8b4Myc4By
 TbmXYV7pCqhPPIIy/AN4pJZbobNJASEN9sVY5/hvGq2s+g9CcVnexmdvJFYR8SmJlTADh18kueB
 nUIfSQxnTnEmEdz9baaVu9mP4UqvBYV4wyuzuFmuCzCrLgqfNmi426PbvMgq7lUzENSqi+2ZOko
 g//TMzBRjMICE9Se0Ngy2N3H7vbUZ5D4Ue1u/+9HVMuu70Tc661Sozt9YlGq/3WQRFTjJALnBxz
 oUDX691TLAbmmdxCI+njoNtqGQxVpqyD/PTpwcC0GmgzBdIY+b4ISoi3kolCJkjpxZJsdu+rS9y
 ZsmsguMn3aHLjYmW1nkPHs5RJAJUDEfQ/n/2kiTVhEKy9tIZaEwHVh8ZU7TNeMlxSev/nrwTcmk
 bW6RAkxovTuiVX5WVew1P0ENZyvYMsAL9woGVr2yepQHUun8T+S3z/zzDDObeHjLN/LCvMBd3ja
 +ABn01D5amJsMXRZc7w==
X-Proofpoint-ORIG-GUID: iFt_RmT3fC08_UWYQmKWkSuzefsQXLN_
X-Proofpoint-GUID: iFt_RmT3fC08_UWYQmKWkSuzefsQXLN_
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=6995caa2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=80vVb9OYCQLWou6ImFEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_02,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180120

With the conversion to generic entry [1] cpu idle exit cpu time accounting
was converted from assembly to C. This introduced an reversed order of cpu
time accounting.

On cpu idle exit the current accounting happens with the following call
chain:

-> do_io_irq()/do_ext_irq()
 -> irq_enter_rcu()
  -> account_hardirq_enter()
   -> vtime_account_irq()
    -> vtime_account_kernel()

vtime_account_kernel() accounts the passed cpu time since last_update_timer
as system time, and updates last_update_timer to the current cpu timer
value.

However the subsequent call of

 -> account_idle_time_irq()

will incorrectly subtract passed cpu time from timer_idle_enter to the
updated last_update_timer value from system_timer. Then last_update_timer
is updated to a sys_enter_timer, which means that last_update_timer goes
back in time.

Subsequently account_hardirq_exit() will account too much cpu time as
hardirq time. The sum of all accounted cpu times is still correct, however
some cpu time which was previously accounted as system time is now
accounted as hardirq time, plus there is the oddity that last_update_timer
goes back in time.

Restore previous behavior by extracting cpu time accounting code from
account_idle_time_irq() into a new update_timer_idle() function and call it
before irq_enter_rcu().

Fixes: 56e62a737028 ("s390: convert to generic entry") [1]
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/idle.h |  1 +
 arch/s390/kernel/idle.c      | 13 +++++++++----
 arch/s390/kernel/irq.c       | 10 ++++++++--
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/idle.h b/arch/s390/include/asm/idle.h
index 09f763b9eb40..133059d9a949 100644
--- a/arch/s390/include/asm/idle.h
+++ b/arch/s390/include/asm/idle.h
@@ -23,5 +23,6 @@ extern struct device_attribute dev_attr_idle_count;
 extern struct device_attribute dev_attr_idle_time_us;
 
 void psw_idle(struct s390_idle_data *data, unsigned long psw_mask);
+void update_timer_idle(void);
 
 #endif /* _S390_IDLE_H */
diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index 39cb8d0ae348..0f9e53f0a068 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -21,11 +21,10 @@
 
 static DEFINE_PER_CPU(struct s390_idle_data, s390_idle);
 
-void account_idle_time_irq(void)
+void update_timer_idle(void)
 {
 	struct s390_idle_data *idle = this_cpu_ptr(&s390_idle);
 	struct lowcore *lc = get_lowcore();
-	unsigned long idle_time;
 	u64 cycles_new[8];
 	int i;
 
@@ -35,13 +34,19 @@ void account_idle_time_irq(void)
 			this_cpu_add(mt_cycles[i], cycles_new[i] - idle->mt_cycles_enter[i]);
 	}
 
-	idle_time = lc->int_clock - idle->clock_idle_enter;
-
 	lc->steal_timer += idle->clock_idle_enter - lc->last_update_clock;
 	lc->last_update_clock = lc->int_clock;
 
 	lc->system_timer += lc->last_update_timer - idle->timer_idle_enter;
 	lc->last_update_timer = lc->sys_enter_timer;
+}
+
+void account_idle_time_irq(void)
+{
+	struct s390_idle_data *idle = this_cpu_ptr(&s390_idle);
+	unsigned long idle_time;
+
+	idle_time = get_lowcore()->int_clock - idle->clock_idle_enter;
 
 	/* Account time spent with enabled wait psw loaded as idle time. */
 	WRITE_ONCE(idle->idle_time, READ_ONCE(idle->idle_time) + idle_time);
diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index bdf9c7cb5685..080e9285b337 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -146,6 +146,10 @@ void noinstr do_io_irq(struct pt_regs *regs)
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	bool from_idle;
 
+	from_idle = test_and_clear_cpu_flag(CIF_ENABLED_WAIT);
+	if (from_idle)
+		update_timer_idle();
+
 	irq_enter_rcu();
 
 	if (user_mode(regs)) {
@@ -154,7 +158,6 @@ void noinstr do_io_irq(struct pt_regs *regs)
 			current->thread.last_break = regs->last_break;
 	}
 
-	from_idle = test_and_clear_cpu_flag(CIF_ENABLED_WAIT);
 	if (from_idle)
 		account_idle_time_irq();
 
@@ -182,6 +185,10 @@ void noinstr do_ext_irq(struct pt_regs *regs)
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	bool from_idle;
 
+	from_idle = test_and_clear_cpu_flag(CIF_ENABLED_WAIT);
+	if (from_idle)
+		update_timer_idle();
+
 	irq_enter_rcu();
 
 	if (user_mode(regs)) {
@@ -194,7 +201,6 @@ void noinstr do_ext_irq(struct pt_regs *regs)
 	regs->int_parm = get_lowcore()->ext_params;
 	regs->int_parm_long = get_lowcore()->ext_params2;
 
-	from_idle = test_and_clear_cpu_flag(CIF_ENABLED_WAIT);
 	if (from_idle)
 		account_idle_time_irq();
 
-- 
2.51.0

