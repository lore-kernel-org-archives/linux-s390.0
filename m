Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405FB471423
	for <linux-s390@vger.kernel.org>; Tue, 21 Jul 2026 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784659684; cv=none; b=R5uwIsswzSAkpYOR0FMP4UmWsF/6rtMm+NTCWKZNB/xK22CiEKnJ4Afoa/y3HEQbUe/1e/fCB3Vcv7CZiJTwQr5UlFrB28coTECxPDweqTqI5S0sZ7Y+7ADEheDdj1pn1t/xfCUs9nxjsYm4D8O9LSzNDUP8HgNG0KcV1pdf8eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784659684; c=relaxed/simple;
	bh=3F6uEohCmS1LqpsrLWOOat73J+m9Vw1832Vp2BJSDz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KPM+WBndoBfx9chrRS6sfKg6+A56i7GL3s8v1MbR2HfTEC4JJLSQ0p0HQFQvThlIKcMhbezFEBPljdQS3Zu/5f08g6BwJBiYfeRfyW5QmuBabqL+Zn004yvkbfcefzUzhVI74Y0MWmspvw/q5fIi8LlbVEdtsZMbeQbInQT6IHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rQZ3o+Sa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rQZ3o+Sa"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LHBjJZ1544127
	for <linux-s390@vger.kernel.org>; Tue, 21 Jul 2026 18:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=G3CelN
	7+RHosCmrthu6367/g+U1kt6zAgBkEhD+W/gs=; b=rQZ3o+Sajk2bphz3CIS/37
	eeIHgj2/KxXJncVValALYR4rOMH1WJm8yLgGnp0O7i7MZzQ1VzGQWaw8qeUHCc5I
	Ao+qqW+6tS8Rz/P8AB1NEAR+/NO3u4YT+hHOcpDAP9Qy/CSEee0/UGCFamBm/3bO
	yeeVKHzrk8AfrTo8e7SoL7KGuTERqqfE1yWyU5S9nsnxNVf9k0cZDyF3ucXoIy1B
	wbfYCN59puJW7y5p/3c9eu2oSNJ3POIYTdzhtkzwtCw8nOagCBV0v2Nw2fnEwoV4
	3yTl3RYXQG1o3yD+CdybKgseevM7hPK0x/PXPh6+fDs1hfBNjHdM1As7h6hWyCEQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78g5uxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 21 Jul 2026 18:47:57 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66LIYmoM024617
	for <linux-s390@vger.kernel.org>; Tue, 21 Jul 2026 18:47:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gbhjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 21 Jul 2026 18:47:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66LIlraG45482472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 18:47:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BACA20095;
	Tue, 21 Jul 2026 18:47:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 683F120098;
	Tue, 21 Jul 2026 18:47:53 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jul 2026 18:47:53 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Tue, 21 Jul 2026 20:47:28 +0200
Subject: [PATCH 2/2] s390/ipl: Improve readability
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-ipl_refactor-v1-2-4d5938de9a70@linux.ibm.com>
References: <20260721-ipl_refactor-v1-0-4d5938de9a70@linux.ibm.com>
In-Reply-To: <20260721-ipl_refactor-v1-0-4d5938de9a70@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Mete Durlu <meted@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE5NiBTYWx0ZWRfX4kqw6InceVF9
 egnCN8uIyshfWoM5f8bnIxTO2vvZVjq0BGOqix9vsmJGhvjhsccTFivrpsrC3EMfv9eft1mgtgm
 8YQCbZU5vuOfjGbCx7ef2k6cVvpJe3n6yf+WvVh1EQyPM2rrKqFquU6gSmwPScS8N4TxYHHAwQD
 QanlL+k9UqYlCPkyo3OuFfHruwFcdmMTXgdQPgrMDIfUO4cLJnOkGhIjEt5YqPpZuMLVvaQUyIC
 xKD/uciUcg8PWzfyMvQZo+ecN6CBeVzyVqDdy3kjZZu14pBsCac8i7gaKGUQ4IMtTC2HWee3C3m
 n23PXgTvCRTCDqWusdhXbsYx24flVVbyJYO8MtqVJuP7yRVged/F2CRrJebpW/y3cYjlMEMPy1S
 MU75+CyYRIQWTprBgjWaeIqnyAqiiK9ZjLYx76Mi1EqEHEcsB/5c4JQHOBnxWPKRzTbK+LWnRI5
 ZnjNQXxQIhvTHGyqaXQ==
X-Proofpoint-GUID: PrKlru68jgJHYrlUb2svgutQ_IioFc-8
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5fbede cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=YD0RDi72nqFdutIJeGgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE5NiBTYWx0ZWRfX659xZOdBvHEk
 /Z8VTMm7OMqKqT5ZYdIvmL53wIVxKVUKL19HoFW6Wui6lF3JGEB5unCNM7bTMWoTDCR2/O2LDhP
 GBlOKlowjFFQgin2a5bZHtyNfKvziJI=
X-Proofpoint-ORIG-GUID: PrKlru68jgJHYrlUb2svgutQ_IioFc-8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210196

Use explicit decleration on all shutdown_action/shutdown_trigger
declerations and reformat shutdown_actions_list decleration to
improve readability. No functional changes.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 arch/s390/kernel/ipl.c | 53 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 2e1e37588d0d..d74ef30155aa 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -2021,8 +2021,11 @@ static int vmcmd_init(void)
 	return sysfs_create_group(&vmcmd_kset->kobj, &vmcmd_attr_group);
 }
 
-static struct shutdown_action vmcmd_action = {SHUTDOWN_ACTION_VMCMD_STR,
-					      vmcmd_run, vmcmd_init};
+static struct shutdown_action vmcmd_action = {
+	.name	= SHUTDOWN_ACTION_VMCMD_STR,
+	.fn	= vmcmd_run,
+	.init	= vmcmd_init
+};
 
 /*
  * stop shutdown action: Stop Linux on shutdown.
@@ -2036,14 +2039,21 @@ static void stop_run(struct shutdown_trigger *trigger)
 	smp_stop_cpu();
 }
 
-static struct shutdown_action stop_action = {SHUTDOWN_ACTION_STOP_STR,
-					     stop_run, NULL};
+static struct shutdown_action stop_action = {
+	.name	= SHUTDOWN_ACTION_STOP_STR,
+	.fn	= stop_run
+};
 
 /* action list */
 
 static struct shutdown_action *shutdown_actions_list[] = {
-	&ipl_action, &reipl_action, &dump_reipl_action, &dump_action,
-	&vmcmd_action, &stop_action};
+	&ipl_action,
+	&reipl_action,
+	&dump_reipl_action,
+	&dump_action,
+	&vmcmd_action,
+	&stop_action
+};
 
 /*
  * Trigger section
@@ -2071,8 +2081,10 @@ static int set_trigger(const char *buf, struct shutdown_trigger *trigger,
 
 /* on reipl */
 
-static struct shutdown_trigger on_reboot_trigger = {ON_REIPL_STR,
-						    &reipl_action};
+static struct shutdown_trigger on_reboot_trigger = {
+	.name	= ON_REIPL_STR,
+	.action	= &reipl_action
+};
 
 static ssize_t on_reboot_show(struct kobject *kobj,
 			      struct kobj_attribute *attr, char *page)
@@ -2097,8 +2109,10 @@ static void do_machine_restart(char *__unused)
 void (*_machine_restart)(char *command) = do_machine_restart;
 
 /* on panic */
-
-static struct shutdown_trigger on_panic_trigger = {ON_PANIC_STR, &stop_action};
+static struct shutdown_trigger on_panic_trigger = {
+	.name	= ON_PANIC_STR,
+	.action	= &stop_action
+};
 
 static ssize_t on_panic_show(struct kobject *kobj,
 			     struct kobj_attribute *attr, char *page)
@@ -2122,9 +2136,10 @@ static void do_panic(void)
 }
 
 /* on restart */
-
-static struct shutdown_trigger on_restart_trigger = {ON_RESTART_STR,
-	&stop_action};
+static struct shutdown_trigger on_restart_trigger = {
+	.name	= ON_RESTART_STR,
+	.action	= &stop_action
+};
 
 static ssize_t on_restart_show(struct kobject *kobj,
 			       struct kobj_attribute *attr, char *page)
@@ -2159,8 +2174,10 @@ void do_restart(void *arg)
 }
 
 /* on halt */
-
-static struct shutdown_trigger on_halt_trigger = {ON_HALT_STR, &stop_action};
+static struct shutdown_trigger on_halt_trigger = {
+	.name	= ON_HALT_STR,
+	.action	= &stop_action
+};
 
 static ssize_t on_halt_show(struct kobject *kobj,
 			    struct kobj_attribute *attr, char *page)
@@ -2185,8 +2202,10 @@ static void do_machine_halt(void)
 void (*_machine_halt)(void) = do_machine_halt;
 
 /* on power off */
-
-static struct shutdown_trigger on_poff_trigger = {ON_POFF_STR, &stop_action};
+static struct shutdown_trigger on_poff_trigger = {
+	.name	= ON_POFF_STR,
+	.action	= &stop_action
+};
 
 static ssize_t on_poff_show(struct kobject *kobj,
 			    struct kobj_attribute *attr, char *page)

-- 
2.53.0

