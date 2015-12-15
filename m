Return-Path: <davem@davemloft.net>
Date: Tue, 15 Dec 2015 15:39:26 -0500 (EST)
Message-Id: <20151215.153926.440589493634712000.davem@davemloft.net>
Subject: Re: Information leak in sco_sock_bind
From: David Miller <davem@davemloft.net>
In-Reply-To: <CACT4Y+Zi9L5K3JExRLxuLS7FzjnQQth3b9ns-q6QufpyHOXf7Q@mail.gmail.com>
References: <CACT4Y+Zi9L5K3JExRLxuLS7FzjnQQth3b9ns-q6QufpyHOXf7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Archive: <https://lore.kernel.org/linux-bluetooth/>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
To: dvyukov@google.com
Cc: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, kcc@google.com, glider@google.com, sasha.levin@oracle.com, edumazet@google.com, keescook@google.com, hannes@stressinduktion.org, ursula.braun@de.ibm.com, linux-s390@vger.kernel.org, lauro.venancio@openbossa.org, aloisio.almeida@openbossa.org, sameo@linux.intel.com
List-ID: <linux-s390.vger.kernel.org>

From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 15 Dec 2015 21:02:30 +0100

> The following program leads to leak of 6 bytes from kernel stack:

This should fix it:

====================
[PATCH] bluetooth: Validate socket address length in sco_sock_bind().

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 net/bluetooth/sco.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index fe12966..f52bcbf 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -526,6 +526,9 @@ static int sco_sock_bind(struct socket *sock, struct sockaddr *addr,
 	if (!addr || addr->sa_family != AF_BLUETOOTH)
 		return -EINVAL;
 
+	if (addr_len < sizeof(struct sockaddr_sco))
+		return -EINVAL;
+
 	lock_sock(sk);
 
 	if (sk->sk_state != BT_OPEN) {
-- 
2.4.1
