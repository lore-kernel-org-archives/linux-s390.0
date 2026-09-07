Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ABC3C0A07;
	Mon,  7 Sep 2026 14:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792333; cv=none; b=eTYjY7O4BUCKePnHNoai3aP0r/KOveb6i7KnqNHE2m8LqEYJ+Hx4z7ZVX0ip6pamvXWLMKlj1j06HOQB0ljYJe/ovR+1H03T+WP1urEdTVVDOzxc6rmkrGH7bNI1Q19H1wioHE4H/U+auLKAJbDNeOdA+Mqv7eUtdPk6Ld3mTik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792333; c=relaxed/simple;
	bh=N3uquJYwDBDeyZUxQ2yZcIOkWimg4gMtblUSEMXVfJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kV8HXQ5/bH5wnFpiXUJMlC8gI9owPdbB34UV7vIDgcOsB2s0ZIMG/VZLYtjtAxGSLThM49ZGhe7x5rVOYc+rl6v4CtHdfocf0Dy95ruQeOZ5njPh61ekBF85Q5roevVAz/dDrsBsgfOUkWTFxEvx4/Hf0sKfrla/SzzXw7owWPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ivhzn0vC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ivhzn0vC"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687E1X8T281303;
	Mon, 7 Sep 2026 14:45:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pp4OzhFuZOWyStZPn
	vpmVWCTeGiZYpG0xYS87pzRDRk=; b=ivhzn0vCQ/UKxgbeLegNXT9RbwobfhYYE
	ShNdW3FZ2u7tRBXGzQX9aI4ACj0EXHKx/WQZWmNZG/xHDG6c1gunNU4kxAZuBC7R
	0Zl14umRJAANOII6qOqWPw+cglfPKJqRY15B1Pr2zvOaM1hgtbLciByDdnldOqyY
	VfRnDLQJW3IsP7EvG/Lv1sQ35sLgt3ZockTHDoAAMdSELpQ2D2QwqxD/jvqczFI6
	Rvh1Oxoz4Ryf5VX/sfxNj+O/BEbBfd1nxGgXuZiNkuva329W5Cj6zrQEoX+e090Y
	sHgk3n9ubNfnX75OnLy4E6ifYb3MLjPxi3bKZsUSHYSY1Vh7BHo5w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbqjs9hv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 14:45:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 687EfbL1024395;
	Mon, 7 Sep 2026 14:45:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggwdq6mkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 14:45:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 687EjH0d42860872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Sep 2026 14:45:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55E5420049;
	Mon,  7 Sep 2026 14:45:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16F1D20040;
	Mon,  7 Sep 2026 14:45:17 +0000 (GMT)
Received: from t83lp71.lnxne.boe (unknown [9.87.84.240])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Sep 2026 14:45:17 +0000 (GMT)
From: Nagamani PV <nagamani@linux.ibm.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: wintera@linux.ibm.com, aswin@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, kees@kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, Nagamani PV <nagamani@linux.ibm.com>,
        stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net 1/2] s390/ctcm: Fix timer corruption in fsm_addtimer()
Date: Mon,  7 Sep 2026 16:45:10 +0200
Message-ID: <20260907144511.3810194-2-nagamani@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907144511.3810194-1-nagamani@linux.ibm.com>
References: <20260907144511.3810194-1-nagamani@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: DXf0WoIM3DbSNe12kr9F-OdhZmIF5VAH
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE2MSBTYWx0ZWRfX8xkGvnQcA5J+
 /O1gQymJXVQHMNBRReRZtPNaUWmDjalx80AbxbpNUye+YV/xDUxjbGd9aktEKWTE7jJN1Zwt8/J
 JIp5nUlRJTUDswmYhScurCQC75ZiAF0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE2MSBTYWx0ZWRfX8COOC0VB0KOF
 06GsQzx7JMk5/Nyt+ZQSsMwqMf2cubHaaREkxdDP0K+m8RfHd6hBx/tS2ztPX3D0z50KE6fYOMx
 ei1JHpZEsHoxvldhllQQXGq580IBlJReAYOaHnDQoQ82QFC2WQNoH6VAHbq/kWPb39Tkv+CTuGv
 4YqBZWzcYI6lxjnuovQMnFcuJl4QulkTi8f8+cyD63F189BNuUNcwkKTblHEV1I+0fk9tRg5PF2
 njdTJ6/+Ssh01opwH5lX3x89EgzMiYvtB3bBB91yCVx2ofSe36O0EPL2ESrjULig9NN4+RMUrYA
 bjT209uxRZTm5Z3xKpwip1AujCbwzOO6w0JYDO14LKS3QEvqK/r2od58dISmRuHj0hbqIBKJUeN
 DJsxydQU8O3OE6YLP6n99xAe7Tr/jQQZ9PtsRk/8BiTNgAc0z1kL9nk0+IV47wbR6Dep4sroqzz
 MRTtfhHZSkpj0I4MniA==
X-Authority-Analysis: v=2.4 cv=JaKMa0KV c=1 sm=1 tr=0 ts=6a9ece02 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=T_NMYt6YcsbJOU4cA00A:9 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: f7tb0JdMEi_mOt0yf9vk6Yf3-MjWRlaK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_04,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070161

fsm_addtimer() calls timer_setup() unconditionally before add_timer().
If called on an already-pending timer, timer_setup() re-initializes
the timer's list_head fields while the timer is still enqueued in the
wheel, corrupting the timer list.

The timer is already initialized once by fsm_settimer() which calls
timer_setup() correctly. Multiple callsites invoke fsm_addtimer()
without a preceding fsm_deltimer(), including ctcm_main.c
ctcm_send_sweep() and ctcm_mpc.c mpc_action_side_xid(), making the
redundant timer_setup() in fsm_addtimer() a real corruption risk.

Remove the redundant timer_setup() calls from fsm_addtimer() and
fsm_modtimer(), and replace add_timer() with mod_timer() which safely
handles both pending and non-pending timers atomically without
corrupting the timer wheel.

Fixes: e99e88a9d2b0 ("treewide: setup_timer() -> timer_setup()")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260803182736.2356374-1-nagamani@linux.ibm.com?part=1
Reviewed-by: Aswin Karuvally <aswin@linux.ibm.com>
Tested-by: Aswin Karuvally <aswin@linux.ibm.com>
Signed-off-by: Nagamani PV <nagamani@linux.ibm.com>
---
 drivers/s390/net/fsm.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/net/fsm.c b/drivers/s390/net/fsm.c
index 9b8622aef807..8d2e9bbb74a2 100644
--- a/drivers/s390/net/fsm.c
+++ b/drivers/s390/net/fsm.c
@@ -171,12 +171,9 @@ fsm_addtimer(fsm_timer *this, int millisec, int event, void *arg)
 	       this->fi->name, this, millisec);
 #endif
 
-	timer_setup(&this->tl, fsm_expire_timer, 0);
 	this->expire_event = event;
 	this->event_arg = arg;
-	this->tl.expires = jiffies + (millisec * HZ) / 1000;
-	add_timer(&this->tl);
-	return 0;
+	return mod_timer(&this->tl, jiffies + msecs_to_jiffies(millisec));
 }
 
 /* FIXME: this function is never used, why */
@@ -189,12 +186,9 @@ fsm_modtimer(fsm_timer *this, int millisec, int event, void *arg)
 		this->fi->name, this, millisec);
 #endif
 
-	timer_delete(&this->tl);
-	timer_setup(&this->tl, fsm_expire_timer, 0);
 	this->expire_event = event;
 	this->event_arg = arg;
-	this->tl.expires = jiffies + (millisec * HZ) / 1000;
-	add_timer(&this->tl);
+	mod_timer(&this->tl, jiffies + msecs_to_jiffies(millisec));
 }
 
 EXPORT_SYMBOL(init_fsm);
-- 
2.53.0

