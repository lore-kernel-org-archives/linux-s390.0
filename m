Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 04/16] af_iucv: remove unnecessary break after goto
Date: Mon, 14 Jul 2014 18:30:54 +0200
Message-Id: <1405355467-7350-5-git-send-email-fabf@skynet.be>
In-Reply-To: <1405355467-7350-1-git-send-email-fabf@skynet.be>
References: <1405355467-7350-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: davem@davemloft.net, joe@perches.com, Fabian Frederick <fabf@skynet.be>, Ursula Braun <ursula.braun@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 net/iucv/af_iucv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 7a95fa4..d79f5fb 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1103,7 +1103,6 @@ static int iucv_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 		default:
 			err = -EINVAL;
 			goto out;
-			break;
 		}
 	}
 
-- 
1.8.4.5
