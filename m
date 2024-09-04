Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DF51474A7;
	Wed,  4 Sep 2024 06:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433177; cv=none; b=I79WECMxT634rDRuFblTW/ODwN5+0HyPb2II3V/LVLVj1n+v5FxOPBPoC/A0346g77/IdMI3EdvALod3cOV8sdlf6A5jO5Iqyxi7lO3kk0Pq7nP8yV83CsLaKFvyTJOVn2DFNUlXfckOPntpLAf43X4yCFsDtZgez+LyCwnDsTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433177; c=relaxed/simple;
	bh=ctHiHkwE6tuAM+pU9h4uYZ8WWO1ajWuOutSejTQKAfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9pToQlDOSkGxt7RKdTLJzfMuujsjIsZWhUTz12yAbet7UTZ6bGKCum9e/XHPpa/1fLoZbnB/tqqevhF7V5Wi3B+ltHbXfZLBdNEf+wcqusuvw26HI25AUAotvu0G1eRrgZZu21y8xK+lgmOU5qQ1GbX/6QD5zIneg2GZPzgdF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GF3otf1N; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GF3otf1N"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4843qjJ5023414;
	Wed, 4 Sep 2024 06:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=0S2sSyTqalzFM
	k1QFvsJIk3XU0AKQNPbYyEFYeBwcas=; b=GF3otf1N2dE7lFoVSqzt7Qzhqmfaj
	0ttbc5r5mdGqg5b2IstGXvSoP2n1eM8WrTh2M0RCi1HdgHPcjYnUDa+WstAoSybp
	gdgYwMkl8eFxujlUomHtvuzM8xLhfqsffvtPXOdeyj+YExc8fQT99w9gnpVD4sBi
	y2hYkoA9/XJkl11naeAg/p4fhN8FkrFS274GP/v9SfoqHJYXA5tQMQgA2/JIgaAQ
	iWkT7hQdXWlQJQ4D3bQ4qrjulGadO10QVjbjdyOxFkNbDIsibjZ5mT2cYSOmJjL5
	PCOY2qmxzCvbrLuwVnbebBPXqfKP/R4VrhQHJ2Y72Ml9s2cbU4faxadWw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btp9hn8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 06:59:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4845US8E000926;
	Wed, 4 Sep 2024 06:59:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cf0mxcm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 06:59:22 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4846xITl11469248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Sep 2024 06:59:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBD3020043;
	Wed,  4 Sep 2024 06:59:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8DFF20040;
	Wed,  4 Sep 2024 06:59:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  4 Sep 2024 06:59:18 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 88E4DE0297; Wed,  4 Sep 2024 08:59:18 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 3/7] s390/tracing: pass ftrace_regs to function_graph_enter()
Date: Wed,  4 Sep 2024 08:58:57 +0200
Message-ID: <20240904065908.1009086-4-svens@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904065908.1009086-1-svens@linux.ibm.com>
References: <20240904065908.1009086-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7aIX8uAl-RY4UpNawcSPGqSm3YmATvQS
X-Proofpoint-ORIG-GUID: 7aIX8uAl-RY4UpNawcSPGqSm3YmATvQS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_04,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxlogscore=662 adultscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040049

Will be used later to print function arguments in the function
graph tracer.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 arch/s390/kernel/entry.h  | 4 +++-
 arch/s390/kernel/ftrace.c | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/entry.h b/arch/s390/kernel/entry.h
index 21969520f947..d0a5fbaad987 100644
--- a/arch/s390/kernel/entry.h
+++ b/arch/s390/kernel/entry.h
@@ -5,6 +5,7 @@
 #include <linux/percpu.h>
 #include <linux/types.h>
 #include <linux/signal.h>
+#include <linux/ftrace.h>
 #include <asm/extable.h>
 #include <asm/ptrace.h>
 #include <asm/idle.h>
@@ -41,7 +42,8 @@ void do_restart(void *arg);
 void __init startup_init(void);
 void die(struct pt_regs *regs, const char *str);
 int setup_profiling_timer(unsigned int multiplier);
-unsigned long prepare_ftrace_return(unsigned long parent, unsigned long sp, unsigned long ip);
+unsigned long prepare_ftrace_return(unsigned long parent, unsigned long sp, unsigned long ip,
+				    struct ftrace_regs *regs);
 
 struct s390_mmap_arg_struct;
 struct fadvise64_64_args;
diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index cf9ee90ae216..dd77b656d9b9 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -266,14 +266,14 @@ void ftrace_arch_code_modify_post_process(void)
  * in current thread info.
  */
 unsigned long prepare_ftrace_return(unsigned long ra, unsigned long sp,
-				    unsigned long ip)
+				    unsigned long ip, struct ftrace_regs *regs)
 {
 	if (unlikely(ftrace_graph_is_dead()))
 		goto out;
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		goto out;
 	ip -= MCOUNT_INSN_SIZE;
-	if (!function_graph_enter(ra, ip, 0, (void *) sp, NULL))
+	if (!function_graph_enter(ra, ip, 0, (void *) sp, regs))
 		ra = (unsigned long) return_to_handler;
 out:
 	return ra;
-- 
2.43.0

