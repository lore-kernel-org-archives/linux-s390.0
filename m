Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87222F7445;
	Mon,  3 Aug 2026 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781273; cv=none; b=gEBxNZ9OeHfxx7pa8af+x9c5+fHj0oaqT6t1zvYcfb92tvQm1mozXuo9u6YT9LYcQvJk7h7U4DkVIkR8mq8uvvPD861s6EeIJtMX4QmXJyNafn3lyUBO3j7yq2C/5Vk2RqJlmALJXfeli0bmTe2p4GydpnuhRne9az1K018UAKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781273; c=relaxed/simple;
	bh=3U/p2VkcUuKyIQGR3TS8GF7H2r39AnpZNkXH4YQH7nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h0vKaGbwSaKGEntn/xzCkS35YR1rO6GoobIdB+2LQK5+dncc4XC7NSnVUMbRweWikEumjeRIFJNjFarOakjyvF58eDkOEDZgJDP6dW/U+3unZke7XBUAoR7geZkqed240sIqEK4L/amK1CfbCKZFHqnVWmoO9NyK1ck++sZUri0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UczDOWXc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UczDOWXc"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673HIHGj2605140;
	Mon, 3 Aug 2026 18:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=wG6SzNxVLqtuB2Ud/Nun4MwcZSIA0axkF7pd3pzkj
	Qg=; b=UczDOWXc3bpBXsNK3p4pCL/mJTrYdX8iQmX6od729bsXd4lUr+0rFe0bE
	k+wfes4YSrUIAV0N57qV37bElEwCuidq9qxE8577WIcF3jB1jwRxPG4g39s2fVKn
	0XnxWz5a2ZVZsHCgFwPvMcdKdP0mZw9DlLkOeiAJsHz4oHDxpK9uef+QTUfhvgZe
	Z3cc0Eibu3oVkjRJXTxg+CLAgvvz6GCOfn9lm+lB/ZPaJW6ML11m5KEBm0c526/V
	mWddFR+kak6PPqVnWno9UaKkfrUoOnO3N9Wd0SLIlEBjRQ/Yj8b5jlv9vi4IDU0m
	edvVHVw1HMi2sI9M9VLaJDq+PmshQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hj6b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 18:20:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673IBUSg027313;
	Mon, 3 Aug 2026 18:20:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg6f1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 18:20:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673IKs9Z36045198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 18:20:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77E5020043;
	Mon,  3 Aug 2026 18:20:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B4EB20040;
	Mon,  3 Aug 2026 18:20:54 +0000 (GMT)
Received: from t83lp71.lnxne.boe (unknown [9.87.84.240])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 18:20:54 +0000 (GMT)
From: Nagamani PV <nagamani@linux.ibm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: horms@kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        wintera@linux.ibm.com, twinkler@linux.ibm.com,
        heiko.carstens@de.ibm.com, hidayath@linux.ibm.com,
        borntraeger@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH net-next] net/iucv: fix UAF in afiucv_netdev_event()
Date: Mon,  3 Aug 2026 20:20:53 +0200
Message-ID: <20260803182053.2355882-1-nagamani@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE2MiBTYWx0ZWRfX7Vw8xPl3LY/1
 Z2r+U7gdivjl438T5lb9jzMZIZcHNiYFTFNwv2yN0rnPl6RClnAAKVfFQFIvSDln9FVF94noUKz
 SWp4gMisorgpAsFQZ1t3M59xJulGwN0=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a70dc0c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=9erWuH-dJbx6lHhtDFoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE2MiBTYWx0ZWRfX0Trovc4+qUDe
 QQdcFFqKCsvCrkjBO4FWbbA+4ohC+Z+vARGTvaSmK1mLis5VqaIALexKIyXYBaeCn/Tt5W/H52q
 2eZNwwTe6+qbH0CK6eVMv310d30G6P/7i1841q90Ru7+RY8XVytUBENHYt9SSfe7RlfNJoF5rln
 Pz5doQbD63p2295D7jakFAiadU0daDGtl4962+fMpODoglD7CJOQZU5+PqjzCRORPYnEWly4UtZ
 DP06ymjt63K76UZmi8zHD6EAKvv0Pnkkr0zKjhVDUih2yeauB9L+7xhJYRu9e69xPGIXKnyok4X
 8brZ/lng7gzHL6a3hnoliiWp+c1pBo5Mql5jJAi3ASD7jTxAuBTyOrWyROlSITHz/nt585cJsEj
 15gK7dFOC4va7si0FJXz0gWjtdDeo+J2zepfu1wQ1BIVc8Vw61hDprPENP661Ak9E7pI9XpDwyT
 WcWXpF70xpi+m8niN9A==
X-Proofpoint-ORIG-GUID: RKENEiIK7HTDh2HKB9m3NaR-nxu4k1jT
X-Proofpoint-GUID: MzUuTnwLBFT2u-rvelEiNoq-Dc2PfjLZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_04,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030162

afiucv_netdev_event() traverses iucv_sk_list without holding
iucv_sk_list.lock.

A concurrent socket teardown can unlink and free an af_iucv socket via
iucv_sock_kill() while the netdevice notifier path is still traversing
the list, resulting in a use-after-free when dereferencing the socket.

syzbot reported a KASAN slab-use-after-free triggered from the netdevice
notifier path:

  BUG: KASAN: slab-use-after-free in afiucv_netdev_event+0x166/0x570
  Read of size 8 at addr 001a54009dcda368 by task syz.3.24/516

  Call Trace:
    afiucv_netdev_event+0x166/0x570 net/iucv/af_iucv.c:2193
    notifier_call_chain+0x18e/0x510 kernel/notifier.c:85
    call_netdevice_notifiers net/core/dev.c:2301 [inline]
    __dev_close_many+0x1c6/0x680 net/core/dev.c:1747
    unregister_netdevice_many_notify+0x9b6/0x2650 net/core/dev.c:12388
    unregister_netdevice_queue+0x392/0x3d0 net/core/dev.c:12291
    __tun_detach+0xa50/0x1990 drivers/net/tun.c:621

  Allocated by task 521:
    sk_prot_alloc+0xd2/0x230 net/core/sock.c:2247
    sk_alloc+0x48/0x680 net/core/sock.c:2303
    iucv_sock_alloc+0x4e/0x710 net/iucv/af_iucv.c:456
    iucv_sock_create+0x114/0x180 net/iucv/af_iucv.c:2254

  Freed by task 519:
    kfree+0x164/0x500 mm/slub.c:6561
    iucv_sock_release+0x12e/0x150 net/iucv/af_iucv.c:1482
    sock_close+0xa4/0x230 net/socket.c:1514

Protect the list traversal with the existing read-side lock.
Use read_lock_bh()/read_unlock_bh() to synchronize with
write_lock_bh()-protected updates to iucv_sk_list.

Fixes: 9fbd87d41392 ("af_iucv: handle netdev events")
Cc: stable@vger.kernel.org
Suggested-by: Hidayath Khan <hidayath@linux.ibm.com>
Signed-off-by: Nagamani PV <nagamani@linux.ibm.com>

---
 net/iucv/af_iucv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index ea047bab65e7..034039c50941 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -2213,6 +2213,7 @@ static int afiucv_netdev_event(struct notifier_block *this,
 	switch (event) {
 	case NETDEV_REBOOT:
 	case NETDEV_GOING_DOWN:
+		read_lock_bh(&iucv_sk_list.lock);
 		sk_for_each(sk, &iucv_sk_list.head) {
 			iucv = iucv_sk(sk);
 			if ((iucv->hs_dev == event_dev) &&
@@ -2223,6 +2224,7 @@ static int afiucv_netdev_event(struct notifier_block *this,
 				sk->sk_state_change(sk);
 			}
 		}
+		read_unlock_bh(&iucv_sk_list.lock);
 		break;
 	case NETDEV_DOWN:
 	case NETDEV_UNREGISTER:
-- 
2.53.0

