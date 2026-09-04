Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C8E446058;
	Fri,  4 Sep 2026 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515105; cv=none; b=iYZh9vKWH8MGIjRItLPVhpMzZY3QZXeAwyTiczzvV7OvjwjHWUjQdgl5YZrd/bx+axFJS8sRPJSPIOMK5kypJ9l8Ig8AhUYrVDSRPnVIKoe5v3In4M2kjNvCqsS1An/3dTHH8fQcbJmzFFdB9dMEik9PZjPVrlG/SonTMQM2BMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515105; c=relaxed/simple;
	bh=dOlZgo6ftjlbfiT07KB/jipdctXPJlYiw672b5Hinrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bvy6IRDjewvlTB1DnbbxJWhyLJ018DI4AINxpGmDbpEukbQKPAYojZUJ3n9K8uVK+TNu2oRF0BQBgkZ3UrYpiB47UvW3jAFx2v/uohgLxiDVrIYerzOIBCjf3l31rmsN5kpA+M0KZtsxglINEjk0y6lxBxhKs7Mgv4E3VRzUP+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=delAv2oa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="delAv2oa"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464OBI3254246;
	Fri, 4 Sep 2026 09:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Ot8lMqVKrK2MCXCFN1U+MH81eZoDspSkXBAXCul8v
	Hw=; b=delAv2oayo7o7uv4xZSWJZhx7oOIc5VxxqRHVcqAYSQgXgCo9LJqvudTr
	ntaKKOIWmieT5wDeebr9NP6dIsbLMhu0xg8p1Ec5JAEdyOn7TULikwyBwxP/qLZX
	g19NDuWNA/R1ZIladA8dt7MqPqZXXfp4jcJV1R+r0M3FIStM9fCnMFJQBCL+dgC8
	ExTPsbZHZACAEPd5ifse5oOsozdAe68ndqdudUEWptthFjgr0+TRNHb+K4f/EpOy
	qMzGzWysJ6KbSNkL08Iom54RfegO5bL0qxnDDDO8kSp1B6wBXgdY1zuLrEA1CqDl
	zCCUFHqfFsUzs2AQm54lt0sukPK6Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rsxq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 09:44:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6849fHUn023256;
	Fri, 4 Sep 2026 09:44:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqvfve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 09:44:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6849ikIa17629518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 09:44:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E8F32004B;
	Fri,  4 Sep 2026 09:44:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48CC120043;
	Fri,  4 Sep 2026 09:44:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri,  4 Sep 2026 09:44:46 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 2BD5D160E20; Fri, 04 Sep 2026 11:44:46 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next] dibs: Avoid inconsistent lockstate warning in dibs_lo_move_data()
Date: Fri,  4 Sep 2026 11:44:46 +0200
Message-ID: <20260904094446.1342654-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a9a9314 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=_GMgnms4JJcc9UvDeZwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4NiBTYWx0ZWRfX2al4fzN2YsZg
 wgfTOjjIhoWKGJfIcb1L3OQPftFRa+2jWk0vmSw6Ufw8E+5+2m59dYSlfndj6k2Rf0tEva4KMk0
 TzwEd4qfwsr6How5QVo9FPw95FurpMVs2rc2eKcnUf93EvVqtw/XpZOFUpdMLVErGmQBZRR2rz9
 Cxo0U1yRr8aLg35MqicsRbbbgrSLAsGDEEDQRjBwfqSEZTNZJ2OPhhXSvJb9FFtWfoalP134xKP
 XI7qqZkkbiA6brT/HsU96KDp6VWFFiW7VN9Ztg7dbxmQCP720/MA159xxzMZnHaiG6pyekX35IF
 w7NNk9CBAVqL21xCIUTEQeaBUmavE0+qEiABpTHlppOw3FN3ArTGiVfJdvWB+eeUu+ALjDPF6IR
 eoqiHiaxS+cW6qn8UjC90jV6hAEPeinntQgUTXc4p3g2JINzYUKUQLF441CykDOEmlW349HR+nD
 vRzjjO6ICcaLvPei+tQ==
X-Proofpoint-GUID: EIWQ9tpHHz2IsiTjxBevSKHGrt_uaVHN
X-Proofpoint-ORIG-GUID: mynprZMyK13b6b1VOzhnBykBPs6ykw7n
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4NiBTYWx0ZWRfXwcezzeGo45kY
 Ao/Hl79IVh6yRKP0C+cwtaPFJDYldQvdURUKZWBI3/bLVGr7F7M+DY2qfL91UN9WTen2P27N4h2
 rdATKzGB1J6qB4C82rPDfZ192G3jfN4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040086

dibs->lock is acquired in process context and interrupt context
(ism_handle_irq()). So always use spin_lock_irqsave() in process context.

Note that this is not a real deadlock, as dibs_lo devices don't have
any interrupt context.

Example warning:
[  153.760872] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  153.760878] WARNING: inconsistent lock state
[  153.760885] 7.2.0-15871-g544d85de4dc2 #16 Not tainted
[  153.760891] --------------------------------
[  153.760896] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
[  153.760901] python3/5134 [HC0[0]:SC0[2]:HE1:SE0] takes:
[  153.760909] 0001222c0fe72428 (&dibs->lock){?...}-{2:2}, at: dibs_lo_mo=
ve_data+0x1ce/0x380
[  153.760932] {IN-HARDIRQ-W} state was registered at:
[  153.760937]   __lock_acquire+0x59c/0x15d0
[  153.760947]   lock_acquire.part.0+0x11c/0x290
[  153.760953]   lock_acquire+0xb4/0x1e0
[  153.760959]   _raw_spin_lock+0x58/0xb0
[  153.760966]   ism_handle_irq+0x80/0x3f0 [ism]
[  153.760974]   __handle_irq_event_percpu+0x282/0x920
[  153.760983]   handle_irq_event_percpu+0x26/0xe0
[  153.760989]   handle_percpu_irq+0x10e/0x1a0
[  153.760997]   handle_irq_desc+0xa6/0x100
[  153.761003]   zpci_floating_irq_handler+0x3ca/0x610
[  153.761011]   do_airq_interrupt+0x206/0x500
[  153.761018]   __handle_irq_event_percpu+0x282/0x920
[  153.761025]   handle_irq_event_percpu+0x26/0xe0
[  153.761031]   handle_percpu_irq+0x10e/0x1a0
[  153.761039]   handle_irq_desc+0xa6/0x100
[  153.761045]   do_irq_async+0xec/0x150
[  153.761052]   do_io_irq+0x150/0x2e0
[  153.761060]   io_int_handler+0xec/0x118
[  153.761066]   arch_cpu_idle+0x120/0x130
[  153.761118]   arch_cpu_idle+0xbe/0x130
[  153.761124]   s390_enter_idle+0x20/0x30
[  153.761131]   cpuidle_enter_state+0xb6/0x440
[  153.761138]   cpuidle_enter+0x64/0xb0
[  153.761144]   cpuidle_idle_call+0x174/0x380
[  153.761151]   do_idle+0x16e/0x250
[  153.761157]   cpu_startup_entry+0x70/0x80
[  153.761163]   smp_start_secondary+0x36e/0x440
[  153.761171]   restart_int_handler+0x72/0x88
[  153.761178] irq event stamp: 46536
[  153.761182] hardirqs last  enabled at (46536): [<000127b697450a90>] __=
local_bh_enable_ip+0x140/0x270
[  153.761193] hardirqs last disabled at (46535): [<000127b697450b20>] __=
local_bh_enable_ip+0x1d0/0x270
[  153.761202] softirqs last  enabled at (46532): [<000127b6185f82c8>] sm=
c_close_active+0x438/0xba0 [smc]
[  153.761232] softirqs last disabled at (46534): [<000127b6185ee998>] sm=
c_cdc_get_slot_and_msg_send+0x218/0x370 [smc]
[  153.761257]
               other info that might help us debug this:
[  153.761262]  Possible unsafe locking scenario:

[  153.761267]        CPU0
[  153.761271]        ----
[  153.761274]   lock(&dibs->lock);
[  153.761282]   <Interrupt>
[  153.761286]     lock(&dibs->lock);
[  153.761294]
                *** DEADLOCK ***

[  153.761299] locks held by python3/5134: 3, last CPU#1:
[  153.761305]  #0: 0001222bab975f50 (&sb->s_type->i_mutex_key#11){+.+.}-=
{3:3}, at: __sock_release+0x7e/0x230
[  153.761329]  #1: 0001222ba5450378 (sk_lock-AF_SMC){+.+.}-{0:0}, at: sm=
c_close_active+0x438/0xba0 [smc]
[  153.761360]  #2: 0001222ba54508a0 (&smc->conn.send_lock){+...}-{2:2}, =
at: smc_cdc_get_slot_and_msg_send+0x218/0x370 [smc]
[  153.761394]
               stack backtrace:
[  153.761400] CPU: 1 UID: 0 PID: 5134 Comm: python3 Not tainted 7.2.0-15=
871-g544d85de4dc2 #16 PREEMPT
[  153.761406] Hardware name: IBM 3931 A01 703 (LPAR)
[  153.761408] Call Trace:
[  153.761409]  [<000127b697366190>] dump_stack_lvl+0xe8/0x140
[  153.761415]  [<000127b6975ccc8c>] print_usage_bug.part.0+0x2ec/0x3a0
[  153.761419]  [<000127b6975cd454>] mark_lock_irq+0x714/0xa20
[  153.761422]  [<000127b6975cda52>] mark_lock+0x2f2/0x790
[  153.761426]  [<000127b6975ce2e6>] mark_usage+0x136/0x1c0
[  153.761430]  [<000127b6975ce90c>] __lock_acquire+0x59c/0x15d0
[  153.761433]  [<000127b6975cfa5c>] lock_acquire.part.0+0x11c/0x290
[  153.761437]  [<000127b6975cfc84>] lock_acquire+0xb4/0x1e0
[  153.761441]  [<000127b699d02a98>] _raw_spin_lock+0x58/0xb0
[  153.761444]  [<000127b6992ca4fe>] dibs_lo_move_data+0x1ce/0x380
[  153.761449]  [<000127b6185f0912>] smcd_tx_ism_write+0x182/0x250 [smc]
[  153.761469]  [<000127b6185ee4c6>] smcd_cdc_msg_send+0x156/0x410 [smc]
[  153.761487]  [<000127b6185ee9a2>] smc_cdc_get_slot_and_msg_send+0x222/=
0x370 [smc]
[  153.761507]  [<000127b6185f8370>] smc_close_active+0x4e0/0xba0 [smc]
[  153.761526]  [<000127b6185a293c>] __smc_release+0x4ac/0x6a0 [smc]
[  153.761546]  [<000127b6185a2c6e>] smc_release+0x13e/0x480 [smc]
[  153.761565]  [<000127b6994544d4>] __sock_release+0xa4/0x230
[  153.761569]  [<000127b69945468c>] sock_close+0x2c/0x40
[  153.761573]  [<000127b697e57180>] __fput+0x2f0/0x880
[  153.761579]  [<000127b697e58440>] fput_close_sync+0xd0/0x1c0
[  153.761583]  [<000127b697e4b3f0>] __s390x_sys_close+0x90/0xf0
[  153.761586]  [<000127b699cdc19e>] __do_syscall+0x1be/0x5a0
[  153.761590]  [<000127b699d04c7a>] system_call+0x72/0x90
[  153.761594] INFO: lockdep is turned off.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/dibs/dibs_loopback.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dibs/dibs_loopback.c b/drivers/dibs/dibs_loopback.c
index 649e4e375be3..44a2e74c2efc 100644
--- a/drivers/dibs/dibs_loopback.c
+++ b/drivers/dibs/dibs_loopback.c
@@ -238,6 +238,7 @@ static int dibs_lo_move_data(struct dibs_dev *dibs, u=
64 dmb_tok,
 {
 	struct dibs_lo_dmb_node *rmb_node =3D NULL, *tmp_node;
 	struct dibs_lo_dev *ldev;
+	unsigned long flags;
 	u16 s_mask;
 	u8 client_id;
 	u32 sba_idx;
@@ -267,12 +268,12 @@ static int dibs_lo_move_data(struct dibs_dev *dibs,=
 u64 dmb_tok,
 	if (!sf)
 		return 0;
=20
-	spin_lock(&dibs->lock);
+	spin_lock_irqsave(&dibs->lock, flags);
 	client_id =3D dibs->dmb_clientid_arr[sba_idx];
 	s_mask =3D ror16(0x1000, idx);
 	if (likely(client_id !=3D NO_DIBS_CLIENT && dibs->subs[client_id]))
 		dibs->subs[client_id]->ops->handle_irq(dibs, sba_idx, s_mask);
-	spin_unlock(&dibs->lock);
+	spin_unlock_irqrestore(&dibs->lock, flags);
=20
 	return 0;
 }
--=20
2.53.0

