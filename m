Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725881AbgLGMyD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Dec 2020 07:54:03 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next] net/af_iucv: use DECLARE_SOCKADDR to cast from sockaddr
Date: Mon,  7 Dec 2020 13:53:07 +0100
Message-Id: <20201207125307.68725-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

This gets us compile-time size checking.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 net/iucv/af_iucv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index db7d888914fa..882f028992c3 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -587,7 +587,7 @@ static void __iucv_auto_name(struct iucv_sock *iucv)
 static int iucv_sock_bind(struct socket *sock, struct sockaddr *addr,
 			  int addr_len)
 {
-	struct sockaddr_iucv *sa = (struct sockaddr_iucv *) addr;
+	DECLARE_SOCKADDR(struct sockaddr_iucv *, sa, addr);
 	char uid[sizeof(sa->siucv_user_id)];
 	struct sock *sk = sock->sk;
 	struct iucv_sock *iucv;
@@ -691,7 +691,7 @@ static int iucv_sock_autobind(struct sock *sk)
 
 static int afiucv_path_connect(struct socket *sock, struct sockaddr *addr)
 {
-	struct sockaddr_iucv *sa = (struct sockaddr_iucv *) addr;
+	DECLARE_SOCKADDR(struct sockaddr_iucv *, sa, addr);
 	struct sock *sk = sock->sk;
 	struct iucv_sock *iucv = iucv_sk(sk);
 	unsigned char user_data[16];
@@ -738,7 +738,7 @@ static int afiucv_path_connect(struct socket *sock, struct sockaddr *addr)
 static int iucv_sock_connect(struct socket *sock, struct sockaddr *addr,
 			     int alen, int flags)
 {
-	struct sockaddr_iucv *sa = (struct sockaddr_iucv *) addr;
+	DECLARE_SOCKADDR(struct sockaddr_iucv *, sa, addr);
 	struct sock *sk = sock->sk;
 	struct iucv_sock *iucv = iucv_sk(sk);
 	int err;
@@ -874,7 +874,7 @@ static int iucv_sock_accept(struct socket *sock, struct socket *newsock,
 static int iucv_sock_getname(struct socket *sock, struct sockaddr *addr,
 			     int peer)
 {
-	struct sockaddr_iucv *siucv = (struct sockaddr_iucv *) addr;
+	DECLARE_SOCKADDR(struct sockaddr_iucv *, siucv, addr);
 	struct sock *sk = sock->sk;
 	struct iucv_sock *iucv = iucv_sk(sk);
 
-- 
2.17.1
