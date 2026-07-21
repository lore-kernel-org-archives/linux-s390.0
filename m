Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6962947142A
	for <linux-s390@vger.kernel.org>; Tue, 21 Jul 2026 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784659683; cv=none; b=QufA+662nBs0p/tUH7V/1wSVp2obmaH3bwujltpQyNbFm89rdzBNs4oUCDI/I0BcSdyFeLgX8sLm5kOvqHqONmuYiyZKPc1VDTZchEIKUws7CSNBSf9nLG8rj7Ytp71WDAiVCcUYyLh9sxICEIN/3mnHAOrc/LjAvzCH4ppgvvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784659683; c=relaxed/simple;
	bh=WMz66ev0+isuGh0VKuCjHHsqrnhrlnQej6Ll/YilRyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uYeRr6GZLDfMTjWosbHpSE694BLyMyWMOP1bcf/zUz7OZyj4laxyasLXNKpq5qD8++JXxvwvVYPBv8W8X6obSIW3mAqZfXnbP6bndZlQQ5EkjxukoXP4pu49iV+BKnls7u+dqPjOQ1hylrM5ADHVpz8KP0jepO4MPncgjOkjGyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WUTxv6+9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WUTxv6+9"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LHBt9W1567197
	for <linux-s390@vger.kernel.org>; Tue, 21 Jul 2026 18:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Yj/W5x
	rh9Had9tDC09Dbfg+hx0r168BFuUUMXHMr2fE=; b=WUTxv6+9aAimyseqhgigDI
	pLSl+K4K43O5KggNPNf7j9v5TvR1DyH79s6FT3JFuESlJCDCialUWxd1NWNRAl/B
	0G89dyqeG8CXgZGUiHq9bqsALJt04qrxWieibL4Hr9O6euIJ2nXcucMw9xdr6dxS
	f6EFKxroU8qu0yBMzRQd1M5TVqG09UmqVqJtiZtDPw0HXONMVpOjzYMRH50bIX/A
	gJS4VMgyxDKw2GM3E210W4QmeVfdTMmjbZvzHFvit85xxgihtdBEICdwBKDVFHB1
	PNIDkQtL+05OmaHfE1vZ2pAhbAcji9B2X+xr8RYjJiZkVFikYUHMF7h5H4qRpiRQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77k5wda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 21 Jul 2026 18:47:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66LIYcl9011327
	for <linux-s390@vger.kernel.org>; Tue, 21 Jul 2026 18:47:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktq3wmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 21 Jul 2026 18:47:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66LIlrUc45482470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 18:47:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62BC420093;
	Tue, 21 Jul 2026 18:47:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F0CE20095;
	Tue, 21 Jul 2026 18:47:53 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jul 2026 18:47:53 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Tue, 21 Jul 2026 20:47:27 +0200
Subject: [PATCH 1/2] s390/ipl: Use ARRAY_SIZE macro
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-ipl_refactor-v1-1-4d5938de9a70@linux.ibm.com>
References: <20260721-ipl_refactor-v1-0-4d5938de9a70@linux.ibm.com>
In-Reply-To: <20260721-ipl_refactor-v1-0-4d5938de9a70@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Mete Durlu <meted@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a5fbedd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=_O1jqqBY3LxW06MTpxUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE5NiBTYWx0ZWRfX+u206Q3vID4Q
 VN7ZYrNmyUJdnhdOTXH0lA09RmuhdSDUIgwtbFkQiLAufxyterYVm3zlZLX3X2NeVrS9BsrssHv
 CFTC9aDZZ0fGPAtk1HTs4lvZUptMzIQO+xEqEqzD5dMRdTbwBgtO4Osnr0zczRp18iA3kh8xwcc
 bb2ndx9HRiCjWxYH9vp07ZJZU3TXx6YkIZXNY2PN4K+I54KU/zlk2BXo9NvhJT80r5L6sByvOlS
 X/aU2QI8dqobF2uKwfhWaL4l0bQk7j+N9plUolCQiYcDVwsNANQ7uYTYmP5Qktqx7ASRZSzYbRb
 c9dAKhsPVwdl7gT7WEFn2xfrzddhEh7eL/ZmKtkAhPetxA/1PZCUlURm3xkZtwnJh5lf6w/7Dzc
 rmL2wLrXjIFAUbv9s0J24koF6ovCNuQzui/krFHFJOX/CWQTpDdTEUq+LnaRenPzErk5fgf3+mN
 QtR8QP7vOPnlnBbnv/Q==
X-Proofpoint-ORIG-GUID: mcVC3VOm65a2v-v38KAkAocHR_lX6mjg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE5NiBTYWx0ZWRfXyrHYK91R/Z50
 Ejoo/TdpNt3AHSoRDdWvguvD1tA+H+bdlWdLtwKhXwn3UvcugiwssL/oJiAc3HiizsfGnWWteJI
 94qZE0Quf7zFETpYtL89Ri3NvCUB89w=
X-Proofpoint-GUID: mcVC3VOm65a2v-v38KAkAocHR_lX6mjg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210196

Use ARRAY_SIZE macro instead of reimplementing it.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 arch/s390/kernel/ipl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 3c346b02ceb9..2e1e37588d0d 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -2044,7 +2044,6 @@ static struct shutdown_action stop_action = {SHUTDOWN_ACTION_STOP_STR,
 static struct shutdown_action *shutdown_actions_list[] = {
 	&ipl_action, &reipl_action, &dump_reipl_action, &dump_action,
 	&vmcmd_action, &stop_action};
-#define SHUTDOWN_ACTIONS_COUNT (sizeof(shutdown_actions_list) / sizeof(void *))
 
 /*
  * Trigger section
@@ -2057,7 +2056,7 @@ static int set_trigger(const char *buf, struct shutdown_trigger *trigger,
 {
 	int i;
 
-	for (i = 0; i < SHUTDOWN_ACTIONS_COUNT; i++) {
+	for (i = 0; i < ARRAY_SIZE(shutdown_actions_list); i++) {
 		if (sysfs_streq(buf, shutdown_actions_list[i]->name)) {
 			if (shutdown_actions_list[i]->init_rc) {
 				return shutdown_actions_list[i]->init_rc;
@@ -2242,7 +2241,7 @@ static void __init shutdown_actions_init(void)
 {
 	int i;
 
-	for (i = 0; i < SHUTDOWN_ACTIONS_COUNT; i++) {
+	for (i = 0; i < ARRAY_SIZE(shutdown_actions_list); i++) {
 		if (!shutdown_actions_list[i]->init)
 			continue;
 		shutdown_actions_list[i]->init_rc =

-- 
2.53.0

