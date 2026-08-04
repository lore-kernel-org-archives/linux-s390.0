Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5505041DE11
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 07:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785829519; cv=none; b=QEzKlHFxjOQJq/peHq2GzXTlZQF7VaKdMU6sOpm6O8aE+mVC689kSdqRB+QfTA5IrUCaNGphTpkWhl4NFmMryKnMgjzS7CilHSE8M0LIWMPsR1mfEUTk+nkJIGSwMLfPHIfw3qSxRyaOT/NxgZ4kpj6L4MeW6JNJI7SOtPrkYC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785829519; c=relaxed/simple;
	bh=0kVgHDnRAG2KgSYU7BZzujI+RbfYhnTkYjL36VW3u7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbRGq0Lc8ZyTNmkXsoK5QsF5JPZPg1pQkH+y8eKmaq+3Q2fjI9svoAhDVktZEihvOfnSrNomtJTDYEH229jIsF/6fjN20U+9GaCE56XNfxZ4RMGZpWxVkmigl41taOQ3tMpBZCioNZ9WJadXC50hJuJ6bQ45O/bYjjb8Iq+H6hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ExHgJ4Xy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ExHgJ4Xy"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741IC8h3577456
	for <linux-s390@vger.kernel.org>; Tue, 4 Aug 2026 07:45:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lvyS9seyzv6hsm80S
	LlXTjnU+BiY3c68vh0uGM7SLwY=; b=ExHgJ4Xyq9n9mcXnomHAUkmjPXrGQc+UJ
	TdRsxMTlt+6CChaomaJSvhWI9l9cV+5njAt4JUL49RijZKTnIwas1SbX6Qd1mYV3
	WGy7fKn0Nknb/28n4pZsCEiClVRxEgvYkdCB+ioDo1UA0lrgd1t1ImoEqJCiSea0
	vDCa50ZVP9drT7GX63BoblO/yzMQhfCT9oEdcnYOHQttgCBX95Ollm2J/wksl72T
	M/oP3LL+Q+i6ZEt3VhQI2a2Mg1Kw9vhVsNIDri9ibCKGgKtKW7LL67v8XaFTaGy4
	xT91wQX7Q92miSR5JrPWUaLmiA0WazBvOrhrbTCpgwGovBPUwnWgA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g4gm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 07:45:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6747fO15001499
	for <linux-s390@vger.kernel.org>; Tue, 4 Aug 2026 07:45:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw134m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 07:45:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6747jC4v35848660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 07:45:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 693C12004B;
	Tue,  4 Aug 2026 07:45:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A53820040;
	Tue,  4 Aug 2026 07:45:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 07:45:12 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        oberpar@linux.ibm.com
Subject: [PATCH v2 2/2] s390/sclp: Ensure no callback gets called after sclp_unregister() returns
Date: Tue,  4 Aug 2026 09:45:11 +0200
Message-ID: <20260804074511.236153-3-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804074511.236153-1-egorenar@linux.ibm.com>
References: <20260804074511.236153-1-egorenar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1NyBTYWx0ZWRfX2MGQv/pqXy4d
 2J0985NkE+Gsg7UuLlwAwsQFMVFYeBSXMZ4ffWDVc9MEp0KKCtqwCQPtao89URm07YTlAMc6flO
 ob/ryz3KZsJFf2yCbnj96VQWsVPXifkkFXyE31X32FQBMlrtJ439dw5lMSllOeY3iJPV7AyxLVM
 x5TpfSYB0oMcIzHzYi2qFhrX9HU6aT0oRYS71HRgNbyGlaclJvhaAbcUPliQvNw60TQDX2LDLSW
 a+xV6zTe7Y2X38PLSxR3gacGDNxQ66gcC+BI7waOvar78RH124Y9USCndc8LyAFRhNkMv4Kw7qP
 VVjRLbPlgUNk0ntOUFYoDaERG9t9igH/pp5xXGG+8lFkTy6sL8e+OSeubKuZF6DFqoihFFooVdf
 Zu3v9ywCvPXPmgNOvJxeDSEEfrhpZfUeQqUrw+GlRbOxlN1VPPK2UIgMnPjmvDFSwnFUjyf7R6K
 6dRQnagkd61KYV4zycw==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a71988d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=g2Gte7XZiS3mjfz3G6EA:9
X-Proofpoint-GUID: hXXWENXBsMFYikz7QHpOPT5ayQBg5ssz
X-Proofpoint-ORIG-GUID: hXXWENXBsMFYikz7QHpOPT5ayQBg5ssz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1NyBTYWx0ZWRfX7/JbaPCBpYir
 AUHR9I3AywyIML66kmngxyi61zil/LdpLdc6tIUwbddyM31SpwMlnaGWFPl4zjBON+ELRnawVGn
 pbavqZrCv+cfnDyUNk9MH2FBSrwG7Ug=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040057

There is a potential race condition between sclp_unregister()
and sclp_dispatch_evbufs()/sclp_dispatch_state_change(). As a result,
it is not guaranteed that the callbacks registered with sclp_register()
will not get called one more time (and no more than one) after
sclp_unregister() returns.

Example of a race situation
===========================

         CPU A (SCLP)                 CPU B (driver using SCLP API)

--> sclp_dispatch_evbufs()
 --> spin_unlock(&sclp_lock)

                                    --> sclp_unregister()
				     --> spin_lock(&sclp_lock)
				     --> remove struct sclp_register from list
				     --> spin_unlock(&sclp_lock)
                                    <-- sclp_unregister()

                                    --> free struct sclp_register

 --> receiver_fn()
  --> illegal memory access

 --> spin_lock(&sclp_lock)
<-- sclp_dispatch_evbufs()

To guarantee that this race situation never occurs, it must be ensured
that sclp_unregister() waits for the last callback invocation by
sclp_dispatch_evbufs()/sclp_dispatch_state_change() to return.
The basic idea is to use a single completion per struct sclp_register
to block in sclp_unregister() until the last callback completes.
It is sufficient to use only one completion per struct sclp_register
because the callbacks state_change_fn() and receiver_fn() never get called
in parallel.

Initially, the completion is marked as done in sclp_register() and every
time when sclp_dispatch_evbufs()/sclp_dispatch_state_change() calls
one of the callbacks, the completion is marked as incomplete before
its invocation and as done afterwards. The call to wait_for_completion()
in sclp_unregister() shall block until the last invocation of the callback
finishes. And if no callback is pending or being invoked by
sclp_dispatch_evbufs()/sclp_dispatch_state_change() then the completion
is always marked as done and sclp_unregister() shall never block in
wait_for_completion() and return quickly.

To mark the completion as incomplete, reinit_completion() is needed and it
must be guaranteed that no racy wait_for_completion() calls are going on in
parallel. This is achieved by calling reinit_completion() with the SCLP
spinlock held. The following situations must be considered:
1. No callback invocation is pending or in progress when
   wait_for_completion() is called from sclp_unregister(). This is
   a regular situation occurring in most of the cases. wait_for_completion()
   will return quickly because the completion is marked as done. When
   wait_for_completion() gets called, the callbacks no longer exist in
   the list sclp_reg_list, and, therefore,
   sclp_dispatch_evbufs()/sclp_dispatch_state_change() would not be able
   to obtain one of them and invoke reinit_completion() while
   a wait_for_completion() call is going on in parallel.
2. One of the callbacks is pending or in progress when
   sclp_unregister() gets called. This is a rare situation.
   The SCLP spinlock is either being held by
   sclp_dispatch_evbufs()/sclp_dispatch_state_change() or not. In the former
   case, sclp_unregister() would block in the SCLP spinlock trying to
   remove the callbacks from the list and not enter wait_for_completion().
   The SCLP spinlock is released after a reinit_complete() call, therefore,
   it will not race with a wait_for_complete() call in sclp_unregister().
   If the SCLP spinlock is not held by
   sclp_dispatch_evbufs()/sclp_dispatch_state_change(), then
   a reinit_complete() call must have been completed already and
   it will not race with a wait_for_complete() call in sclp_unregister().

With this change sclp_unregister() may no longer be invoked
from atomic context or registered callbacks. But this should not be a
problem because this is no regular use case and no driver using
sclp_register()/sclp_unregister() requires this at the moment and
likely should not require it in the future.

Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---
 drivers/s390/char/sclp.c | 19 +++++++++++++++----
 drivers/s390/char/sclp.h |  2 ++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index 98e334724a62..8954f4260401 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -565,9 +565,11 @@ sclp_dispatch_evbufs(struct sccb_header *sccb)
 				 evbuf, !reg);
 
 		if (reg && reg->receiver_fn) {
+			reinit_completion(&reg->done);
 			spin_unlock_irqrestore(&sclp_lock, flags);
 			reg->receiver_fn(evbuf);
 			spin_lock_irqsave(&sclp_lock, flags);
+			complete(&reg->done);
 		} else if (reg == NULL)
 			rc = -EOPNOTSUPP;
 	}
@@ -773,8 +775,8 @@ sclp_dispatch_state_change(void)
 	sccb_mask_t receive_mask;
 	sccb_mask_t send_mask;
 
+	spin_lock_irqsave(&sclp_lock, flags);
 	do {
-		spin_lock_irqsave(&sclp_lock, flags);
 		reg = NULL;
 		list_for_each(l, &sclp_reg_list) {
 			reg = list_entry(l, struct sclp_register, list);
@@ -788,15 +790,18 @@ sclp_dispatch_state_change(void)
 			} else
 				reg = NULL;
 		}
-		spin_unlock_irqrestore(&sclp_lock, flags);
 		if (reg && reg->state_change_fn) {
+			reinit_completion(&reg->done);
+			spin_unlock_irqrestore(&sclp_lock, flags);
 			/* STCG: State-change callback (b=callback) */
 			sclp_trace(2, "STCG", 0, (u64)reg->state_change_fn,
 				   false);
-
 			reg->state_change_fn(reg);
+			spin_lock_irqsave(&sclp_lock, flags);
+			complete(&reg->done);
 		}
 	} while (reg);
+	spin_unlock_irqrestore(&sclp_lock, flags);
 }
 
 struct sclp_statechangebuf {
@@ -885,6 +890,8 @@ sclp_register(struct sclp_register *reg)
 	/* Trigger initial state change callback */
 	reg->sclp_receive_mask = 0;
 	reg->sclp_send_mask = 0;
+	init_completion(&reg->done);
+	complete(&reg->done);
 	list_add(&reg->list, &sclp_reg_list);
 	spin_unlock_irqrestore(&sclp_lock, flags);
 	rc = sclp_init_mask(1);
@@ -898,7 +905,10 @@ sclp_register(struct sclp_register *reg)
 
 EXPORT_SYMBOL(sclp_register);
 
-/* Unregister event listener. */
+/* Unregister event listener.
+ * It can sleep and, therefore, may not get called from atomic context.
+ * And neither it can get called from a receive_fn() callback because
+ * struct sclp_register must remain valid after the call. */
 void
 sclp_unregister(struct sclp_register *reg)
 {
@@ -911,6 +921,7 @@ sclp_unregister(struct sclp_register *reg)
 	list_del(&reg->list);
 	spin_unlock_irqrestore(&sclp_lock, flags);
 	sclp_init_mask(1);
+	wait_for_completion(&reg->done);
 }
 
 EXPORT_SYMBOL(sclp_unregister);
diff --git a/drivers/s390/char/sclp.h b/drivers/s390/char/sclp.h
index b31a680e0871..b04f6287ccfc 100644
--- a/drivers/s390/char/sclp.h
+++ b/drivers/s390/char/sclp.h
@@ -11,6 +11,7 @@
 
 #include <linux/types.h>
 #include <linux/list.h>
+#include <linux/completion.h>
 #include <asm/asm-extable.h>
 #include <asm/machine.h>
 #include <asm/sclp.h>
@@ -275,6 +276,7 @@ struct sclp_register {
 	void (*state_change_fn)(struct sclp_register *);
 	/* called for events in cp_receive_mask/sclp_receive_mask */
 	void (*receiver_fn)(struct evbuf_header *);
+	struct completion done;
 };
 
 /* externals from sclp.c */
-- 
2.53.0

