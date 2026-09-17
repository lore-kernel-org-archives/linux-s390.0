Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35022389E07;
	Thu, 17 Sep 2026 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789629449; cv=none; b=PySxutJnXZk6gY9P7nmp8scjOy6+qlVLsc0h39V0KIGZEvWI+fYjW37GfK9Eoz3RHLj/iDZenq6SI3ndPze0HZ8+gsk1jySQ01KS4Y2svwMaUHs6WZyTp7hsolsZyUQhqpEiB5WwKe7AHjcj364nlwLp0f53HQmT7xa5/J1A7Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789629449; c=relaxed/simple;
	bh=pjDq12ig3+++ExHp/dVoL8aGQsjnmG0jizFlkIm1nB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdOw7M5FAu51hF5XX64XLJEwZjF6EjaABZEUVecrEOWt82vvPH1qs041Gd6B4gQfHl1uf0xpQ+1sOaA8r6tmC+uZFg5XjES9dRD8S0PaFBaSpg3KCenpHa23kQEOwQ4awYFLr9ruyc1IHeLVgjXNi/u5fMTX1YJw3GCRAwRW1EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PvuN0LcM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PvuN0LcM"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H61l864025741;
	Thu, 17 Sep 2026 07:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qX+NvKXpootNf1pRb
	33+/ZhPW5r2qWyMl+TE0PRk9R4=; b=PvuN0LcMP5s7Z/rRwTdUFMmMI9/tE6wb4
	TA9gVWJwfjKdyULjERuxXuHIOGab7Ht7+WT5/sg3JbF3tm4LeUTO4QjdAmP3O18O
	7nosPhVL3j2VRyVVSnpCrJVF0jX/pvb6RHcXwpibk0WLaZm5ofTYZ3dbfvcwlDfe
	Lrn3lqFyXuvvjf+14UuDf7SEtVnotXcNY/B6k/021cwGXt5jWqlRxUe81Au6Vq+o
	DCPtxCjiDhHrEEtG/cuAXwacJE5Y/JLb9E68thxfDMQ8lNB26diQu0WJVUS7GhS3
	p2kCrwlYgBwmjJFInEoGMg5UOT3SbkjjOjqmw7E0JDcTxNji39g+Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqgxbe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 07:17:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68H653qM2660558;
	Thu, 17 Sep 2026 07:17:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5fjh9fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 07:17:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68H7HBb124969930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 07:17:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 026A120043;
	Thu, 17 Sep 2026 07:17:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B12CF20040;
	Thu, 17 Sep 2026 07:17:10 +0000 (GMT)
Received: from t83lp71.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 07:17:10 +0000 (GMT)
From: Nagamani PV <nagamani@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, andrew+netdev@lunn.ch, wintera@linux.ibm.com,
        twinkler@linux.ibm.com, horms@kernel.org, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, hexlabsecurity@proton.me,
        hidayath@linux.ibm.com, stable@vger.kernel.org,
        Nagamani PV <nagamani@linux.ibm.com>
Subject: [PATCH net v2] net/iucv: fix races in afiucv_netdev_event()
Date: Thu, 17 Sep 2026 09:17:06 +0200
Message-ID: <20260917071706.23831-1-nagamani@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803182053.2355882-1-nagamani@linux.ibm.com>
References: <20260803182053.2355882-1-nagamani@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5MyBTYWx0ZWRfX1Qi+YmnlB944
 B02ef/uylF6ie7Eey1hGeYF+QPyPCE+nBD/ut2E5UNGjGt6lNXwtFBZb7IoYJEfFeFZI/JqMTnJ
 rRoQQhpnFqaCW4yKcUGvCHAbqLjdGUxuM2nrHhX9tOhoMG44fqKJE/zLx47NouINHWJ535GoLGH
 tmt1bJ2E7rOCMPQotS6K3P8/ahJSZzEiS4Ln++ao4zrCrKSkzDf7rKy475PR3tt5ONzvZSDPD4H
 cEffyp9m6T8QwSPmcOHSg1aoMpkkgtRNjgXhP9BtUuWa6HhFp7Y5tLI+u7kJzVGr7D2c93xRkQP
 tZBNqb1FjitFh+pP0FjqHgCjy4/ds/74tN9tAOH9hslLulr8p2tX3/qtLz9v+1Yy0FtGohJU6/w
 MWtUIDVakSrE6XQPSy0oB4K5ldA7ws/yoe9abqVI4cgVbhlqJbcyBjHMq8tkpDTCU+8LenSiIsg
 6d9Ie75xEzPXEO+/Grg==
X-Proofpoint-GUID: zijSPlCYq_CwgXgBzk7kEJtZFk2ckbuk
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aab93fc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ckcQMgNaPUpcWHtMZpgA:9
X-Proofpoint-ORIG-GUID: HhuX4Y-EWG_xSM__v9pc-rUOUIe2A5x0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5MyBTYWx0ZWRfX4yDJrCBhuIqN
 06an3Onb0N8HlD4e2FSZ97yRLv5bOYLAAY7hJ1ao+oebnRTEAHGAq4a9Pj4atyZz4uBGn7ZLNEJ
 qJhPcfg0YxkR16AYSOHMGIhF0Bx9jH0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1011 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170093

afiucv_netdev_event() walks iucv_sk_list.head inside a bare
sk_for_each() with no lock held, while concurrent paths can modify
or destroy sockets in that list:

BUG-1  Use-After-Free
  iucv_sock_kill() calls iucv_sock_unlink() under write_lock_bh
  followed by sock_put() which may free the sk.  If the notifier
  is mid-traversal when sock_put() runs, the stale sk pointer
  dereference at iucv = iucv_sk(sk) is a use-after-free.
  KASAN reports: slab-use-after-free in afiucv_netdev_event.
  Confirmed with KASAN on IBM Z.

BUG-2  Locking correctness: iucv_send_ctrl() without lock_sock()
  iucv_send_ctrl() is called without holding lock_sock(sk).  The
  notifier reads iucv->hs_dev without the socket lock, while
  iucv_sock_close() writes iucv->hs_dev = NULL under lock_sock().
  iucv_send_ctrl() also reads and writes sk->sk_shutdown as bare
  accesses, racing with iucv_sock_close() which holds lock_sock()
  for the same fields.  KCSAN reports both races.
  Confirmed with KCSAN on IBM Z:

    write to iucv->hs_dev of 8 bytes by task N on cpu M:
      iucv_sock_close+0x196 [af_iucv]    (under lock_sock)

    read to iucv->hs_dev by task N on cpu M:
      afiucv_netdev_event [af_iucv]      (no lock held)

BUG-3  sk_state data race
  sk->sk_state is written without lock_sock() in the notifier, racing
  with iucv_sock_close() writing the same field under lock_sock().
  KCSAN reports: data-race in afiucv_netdev_event / iucv_sock_close.
  Confirmed with KCSAN on IBM Z:

    write to sk->sk_state by task N on cpu M:
      iucv_sock_close+0x196 [af_iucv]   (under lock_sock)

    read to sk->sk_state by task N on cpu M:
      afiucv_netdev_event+0xa6 [af_iucv] (no lock held)

Fix with a two-pass algorithm:

  Pass 1 (read_lock_bh): walk iucv_sk_list, sock_hold() each
    matching socket, collect into a local list.  The read lock
    prevents concurrent write_lock_bh in iucv_sock_link/unlink
    from modifying the list while we take references.

  Pass 2 (lock_sock per socket): for each collected socket,
    acquire lock_sock to serialise against iucv_sock_close(),
    check sk_state under the lock, call iucv_send_ctrl() and
    update sk_state safely, then release_sock() + sock_put().

This eliminates all three races:
  - BUG-1: read_lock_bh prevents sk from being unlinked and freed
    while we hold a reference to it.
  - BUG-2: iucv_send_ctrl() is now called under lock_sock(), not
    racing with concurrent socket close.
  - BUG-3: sk_state is read and written under lock_sock(),
    serialising against iucv_sock_close().

Pass 1 reads iucv_sk(sk)->hs_dev under read_lock_bh to filter
sockets belonging to the affected device.  iucv_sock_close() writes
hs_dev = NULL under lock_sock(), which is orthogonal to read_lock_bh.
Use READ_ONCE() for the Pass 1 read and WRITE_ONCE() for the
iucv_sock_close() write to document the intentional concurrent access
and suppress KCSAN false positives.  The read is safe: read_lock_bh
prevents the socket from being freed; if hs_dev is concurrently
cleared to NULL it will not match event_dev (a valid pointer) so the
socket is correctly skipped.

Fixes: 9fbd87d41392 ("af_iucv: handle netdev events")
Reported-by: Bryam Vargas <hexlabsecurity@proton.me>
Link: https://lore.kernel.org/netdev/20260724222917.134769-1-hexlabsecurity@proton.me/
Suggested-by: Hidayath Khan <hidayath@linux.ibm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Nagamani PV <nagamani@linux.ibm.com>
---
Changes since v1 (2-line read_lock_bh fix, posted 2026-08-03):
  - Redesign as two-pass algorithm to fix all races in one patch:
    Pass 1: read_lock_bh + sock_hold() to safely collect matching
    sockets; Pass 2: lock_sock() per socket to act on sk_state,
    call iucv_send_ctrl() and update sk_state under the lock.
  - Fixes Sashiko Finding 1 (New/High): sleep-in-atomic - V1 called
    iucv_send_ctrl() inside read_lock_bh(); Pass 2 runs after
    read_unlock_bh() so GFP_KERNEL allocation is safe.
  - Fixes Sashiko Finding 2 (Pre-existing/High): lockless manipulation
    of sk_state, sk_shutdown, sk_socket - all now under lock_sock().
  - Add WRITE_ONCE(iucv->hs_dev, NULL) in iucv_sock_close() and
    READ_ONCE(iucv_sk(sk)->hs_dev) in Pass 1 to document intentional
    concurrent access across orthogonal locks and suppress KCSAN.
  - All three bugs confirmed with KASAN + KCSAN on IBM Z with
    before/after TAP results.
  - Retarget from net-next to net (Fixes: + Cc: stable).
  - Update subject from "fix UAF" to "fix races" to reflect full scope.

Bryam Vargas: your RFC identified the lockless socket manipulation in
afiucv_netdev_event() as part of your 17-context analysis.  I have
included Reported-by for that attribution.  Please let me know if you
are happy with this, or prefer a different tag.

 net/iucv/af_iucv.c | 57 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 5 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index ea047bab65e7..b197f9a254a7 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -320,6 +320,12 @@ static void iucv_sock_unlink(struct iucv_sock_list *l, struct sock *sk)
 	write_unlock_bh(&l->lock);
 }
 
+/* Used by afiucv_netdev_event() two-pass algorithm */
+struct iucv_netdev_todo {
+	struct list_head list;
+	struct sock *sk;
+};
+
 /* Kill socket (only if zapped and orphaned) */
 static void iucv_sock_kill(struct sock *sk)
 {
@@ -445,7 +451,7 @@ static void iucv_sock_close(struct sock *sk)
 
 	if (iucv->hs_dev) {
 		dev_put(iucv->hs_dev);
-		iucv->hs_dev = NULL;
+		WRITE_ONCE(iucv->hs_dev, NULL);
 		sk->sk_bound_dev_if = 0;
 	}
 
@@ -2207,21 +2213,62 @@ static int afiucv_netdev_event(struct notifier_block *this,
 			       unsigned long event, void *ptr)
 {
 	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
+	struct iucv_netdev_todo *entry, *tmp;
+	LIST_HEAD(todo);
 	struct sock *sk;
-	struct iucv_sock *iucv;
 
 	switch (event) {
 	case NETDEV_REBOOT:
 	case NETDEV_GOING_DOWN:
+		/*
+		 * Pass 1: collect matching sockets under read_lock_bh.
+		 *
+		 * read_lock_bh(&iucv_sk_list.lock) excludes concurrent
+		 * write_lock_bh in iucv_sock_link/unlink, so sk cannot
+		 * be removed from the list or freed while we walk it.
+		 * sock_hold() pins the sk so it survives after we drop
+		 * the lock.
+		 *
+		 * iucv_sock_close() writes hs_dev = NULL under lock_sock,
+		 * which is orthogonal to read_lock_bh.  READ_ONCE() documents
+		 * the intentional concurrent access: if hs_dev is being
+		 * cleared to NULL it will not equal event_dev (a valid
+		 * pointer) so the socket is correctly skipped.
+		 */
+		read_lock_bh(&iucv_sk_list.lock);
 		sk_for_each(sk, &iucv_sk_list.head) {
-			iucv = iucv_sk(sk);
-			if ((iucv->hs_dev == event_dev) &&
-			    (sk->sk_state == IUCV_CONNECTED)) {
+			if (READ_ONCE(iucv_sk(sk)->hs_dev) != event_dev)
+				continue;
+			entry = kmalloc_obj(*entry, GFP_ATOMIC);
+			if (!entry)
+				continue;
+			sock_hold(sk);
+			entry->sk = sk;
+			list_add_tail(&entry->list, &todo);
+		}
+		read_unlock_bh(&iucv_sk_list.lock);
+		/*
+		 * Pass 2: act on each socket under lock_sock.
+		 *
+		 * lock_sock() serialises against iucv_sock_close() and
+		 * sock_orphan(), so sk_state and sk_socket are stable.
+		 * iucv_send_ctrl() may call sock_alloc_send_skb(GFP_KERNEL)
+		 * which requires non-atomic context -- satisfied here because
+		 * we are no longer holding read_lock_bh.
+		 */
+		list_for_each_entry_safe(entry, tmp, &todo, list) {
+			sk = entry->sk;
+			lock_sock(sk);
+			if (sk->sk_state == IUCV_CONNECTED) {
 				if (event == NETDEV_GOING_DOWN)
 					iucv_send_ctrl(sk, AF_IUCV_FLAG_FIN);
 				sk->sk_state = IUCV_DISCONN;
 				sk->sk_state_change(sk);
 			}
+			release_sock(sk);
+			sock_put(sk);
+			list_del(&entry->list);
+			kfree(entry);
 		}
 		break;
 	case NETDEV_DOWN:
-- 
2.47.1

