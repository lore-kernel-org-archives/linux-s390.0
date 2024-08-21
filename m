Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C001ACDF9;
	Wed, 21 Aug 2024 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238398; cv=none; b=ToOFyEpPgNkzTJ/DvsiAZ4BTzd0t+TYTXVHbrhwnj7i9aV1Dx+Tw8yBRZ/dyyTQNqrt0PUqHTcv40EAeK9q0S0EiYcxXN+dXupr/c4QagNROj/SJ+zsRH5U4NaewCx7lH/AlaAyW7DMI7xytkNkgU/5wsuOKSOqlZAIIxG9GZHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238398; c=relaxed/simple;
	bh=oAkfF2iNaUdnV538jyBss+Om/GijBKXLV2eI/xoGo3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUMmzEGCmDJDEgWbVxgYlYC+I+iQQzq/+kD+/9ncTmlKErcBK3Pn9p+Ra3DzSMgTgl6xSzJguo3NLyJim11IHBqcUNuoS/75PTE3HOoiukxny9OOKuBertkCOyMBfzhXw5MKBaSbC1BlKnaEKdQnooj6XDUUugpc7dFv5SJCG4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcDE5U40; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcDE5U40"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d3dacaccfaso3993386a91.0;
        Wed, 21 Aug 2024 04:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724238393; x=1724843193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJyJsKu1aGroogo9BOVLQBF13dnjMBN9O74vf/4rC9g=;
        b=jcDE5U40G4VpVjD+iVCqLLYneGkjLaCMn6VvNk8U5+dirXQSUlF+Z+iSGvdRJymNS7
         eX+2ZCo9g/bejbSJgTFsJwkncoStqZfL0KGnLhZHL9snJ86n/KoPgGgpugvQPSxZw2Ic
         hJGyLxr96d3FuluETEnmAL5rnS/DKghKlHCKiq1XrGXfZkeEtuc+t0WeU4LwDgK8Mgnd
         x/Sz9iffDFXZo/YSvzUcGrbbmUBUN0muTL0whrTC+Qy3MUPjtmye1BTRnCdc5tzgP7U1
         mD3Ynx1bs2sXn5v/VT3hgCwSOIzxMJ31DrvZqkdJT6yCezzH2JO5qwmuBRKREE1Uh6ht
         mN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724238393; x=1724843193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJyJsKu1aGroogo9BOVLQBF13dnjMBN9O74vf/4rC9g=;
        b=MqJ259Nh2XeWxr0Bof3PinJJrCoPIzmHnm/UpPePvtGiiMWvvAJ8bPMvlBK6EJXfoO
         U9RY/OOjSbQJv4w7KEe968Am7+FSbsceawV9lvsNcxxMAY+8gjfp8QkcrjBHuWnDBCZE
         5cFQtWxZTXJFhuBH6o/UKsgUMGvdor2JBIzlkdzFN7soPLS0Qg9MFSQuRsEcb/Z34L+t
         PIdayKlt5QMfsd9NCXXqvG3vWQpDGLcQXTh0u0zscB+kHKzrGiztXgUiGffnvjLe38I5
         DWjjsIA1Cu+Jo6x11pYnSsFtT4WGbyBqyW+knf8cHevTFyhaoxCXSGDNzeqUn/3hz3qT
         Xfgg==
X-Forwarded-Encrypted: i=1; AJvYcCUk6atWj9rnDqe/C4/x8qQeYOhZFPnW6o13QuMf+igo+Rth0HsLZRAF7d3RcNnUPOOhhNmamiFY@vger.kernel.org, AJvYcCUlSdkUIaiXhNHV8JQvH4PQUU4Zj0ZyP5yjCED+IzARXMqnq6+AsS1EjxjTSIJRcH8fsQi0ueM8oiHbDGk=@vger.kernel.org, AJvYcCUqKY5uhcgomDt7NvN5MydyHfPBL7V9jIdtpbZP15dVxVyGwSP46r7v8bbFM9HrCh35p1f7LanL3K9vsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZysCAhmR6Vto5on+YyuhWGPAQ2nnhovrfTu1dZPNDYCpPU/Do
	2uSaq7CAd32VmP06/nEbWw6gw1Ll54hxEWDxCXIcLgjG1zSf1tut
X-Google-Smtp-Source: AGHT+IEQPX6d1Z9lyxNGcXAUDRxMNQ6K02JjZYuzJdTlw4sGILL+Ukw1fnaGq+FbEAZuTb7s33LWkA==
X-Received: by 2002:a17:90a:c16:b0:2c8:5cb7:54e5 with SMTP id 98e67ed59e1d1-2d5e9dcabb1mr2024063a91.32.1724238392661;
        Wed, 21 Aug 2024 04:06:32 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eba2eb7dsm1487025a91.15.2024.08.21.04.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:06:32 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: jaka@linux.ibm.com
Cc: aha310510@gmail.com,
	alibuda@linux.alibaba.com,
	davem@davemloft.net,
	dust.li@linux.alibaba.com,
	edumazet@google.com,
	guwen@linux.alibaba.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tonylu@linux.alibaba.com,
	ubraun@linux.vnet.ibm.com,
	utz.bacher@de.ibm.com,
	wenjia@linux.ibm.com
Subject: Re: [PATCH net,v5,2/2] net/smc: modify smc_sock structure
Date: Wed, 21 Aug 2024 20:06:25 +0900
Message-Id: <20240821110625.49755-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <42f2d707-cf7e-4cb7-a10b-8bd2e851879e@linux.ibm.com>
References: <42f2d707-cf7e-4cb7-a10b-8bd2e851879e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Jan Karcher wrote:
>
>
>
> On 20/08/2024 12:45, Paolo Abeni wrote:
> >
> >
> > On 8/15/24 06:39, Jeongjun Park wrote:
> >> Since inet_sk(sk)->pinet6 and smc_sk(sk)->clcsock practically
> >> point to the same address, when smc_create_clcsk() stores the newly
> >> created clcsock in smc_sk(sk)->clcsock, inet_sk(sk)->pinet6 is corrupted
> >> into clcsock. This causes NULL pointer dereference and various other
> >> memory corruptions.
> >>
> >> To solve this, we need to modify the smc_sock structure.
> >>
> >> Fixes: ac7138746e14 ("smc: establish new socket family")
> >> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> >> ---
> >>   net/smc/smc.h | 5 ++++-
> >>   1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/net/smc/smc.h b/net/smc/smc.h
> >> index 34b781e463c4..0d67a02a6ab1 100644
> >> --- a/net/smc/smc.h
> >> +++ b/net/smc/smc.h
> >> @@ -283,7 +283,10 @@ struct smc_connection {
> >>   };
> >>   struct smc_sock {                /* smc sock container */
> >> -    struct sock        sk;
> >> +    union {
> >> +        struct sock        sk;
> >> +        struct inet_sock    inet;
> >> +    };
> >>       struct socket        *clcsock;    /* internal tcp socket */
> >>       void            (*clcsk_state_change)(struct sock *sk);
> >>                           /* original stat_change fct. */
> >
> > As per the running discussion here:
> >
> > https://lore.kernel.org/all/5ad4de6f-48d4-4d1b-b062-e1cd2e8b3600@linux.ibm.com/#t
> >
> > you should include at least a add a comment to the union, describing
> > which one is used in which case.
> >
> > My personal preference would be directly replacing 'struct sk' with
> > 'struct inet_sock inet;' and adjust all the smc->sk access accordingly,
> > likely via a new helper.
> >
> > I understand that would be much more invasive, but would align with
> > other AF.
>
> Hi all,
>
> thanks for looking into this patch and providing your view on this topic.
>
> My personal prefernce is clean. I want to have a clean SMC protocol, in
> order to get it on a good path for future improvements.
> The union, IMO, is not clean. It makes the problem less implicit but the
> problem is still there.
>
> Jeongjun, do i understand correct that you've tested the change proposed
> by Alexandra with more changes required?
>
> """
> Although this fix would require more code changes, we tested the bug and
> confirmed that it was not triggered and the functionality was working
> normally.
> """
> https://lore.kernel.org/all/20240814150558.46178-1-aha310510@gmail.com/
>
> If so would you mind adding a helper for this check as Paolo suggested
> and send it?
> This way we see which change is better for the future.

This is the patch I tested. Except for smc.h and smc_inet.c, the rest is 
just a patch that changes smc->sk to smc->inet.sk. When I tested using 
this patch and c repro, the vulnerability was not triggered.

Regards,
Jeongjun Park

>
> The statement that SMC would be more aligned with other AFs is already a
>   big win in my book.
>
> Thanks
> - Jan
>
> >
> > Thanks,
> >
> > Paolo
> >

---
 net/smc/af_smc.c         | 176 +++++++++++++++++++--------------------
 net/smc/smc.h            |   4 +-
 net/smc/smc_cdc.c        |  40 ++++-----
 net/smc/smc_clc.c        |  28 +++----
 net/smc/smc_close.c      |  16 ++--
 net/smc/smc_core.c       |  68 +++++++--------
 net/smc/smc_inet.c       |   8 +-
 net/smc/smc_rx.c         |  16 ++--
 net/smc/smc_stats.h      |  10 +--
 net/smc/smc_tracepoint.h |   4 +-
 net/smc/smc_tx.c         |  28 +++----
 11 files changed, 202 insertions(+), 196 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 8e3093938cd2..d2783e715604 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -132,7 +132,7 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
 				sk->sk_max_ack_backlog)
 		goto drop;
 
-	if (sk_acceptq_is_full(&smc->sk)) {
+	if (sk_acceptq_is_full(&smc->inet.sk)) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_LISTENOVERFLOWS);
 		goto drop;
 	}
@@ -262,7 +262,7 @@ static void smc_fback_restore_callbacks(struct smc_sock *smc)
 static void smc_restore_fallback_changes(struct smc_sock *smc)
 {
 	if (smc->clcsock->file) { /* non-accepted sockets have no file yet */
-		smc->clcsock->file->private_data = smc->sk.sk_socket;
+		smc->clcsock->file->private_data = smc->inet.sk.sk_socket;
 		smc->clcsock->file = NULL;
 		smc_fback_restore_callbacks(smc);
 	}
@@ -270,7 +270,7 @@ static void smc_restore_fallback_changes(struct smc_sock *smc)
 
 static int __smc_release(struct smc_sock *smc)
 {
-	struct sock *sk = &smc->sk;
+	struct sock *sk = &smc->inet.sk;
 	int rc = 0;
 
 	if (!smc->use_fallback) {
@@ -327,7 +327,7 @@ int smc_release(struct socket *sock)
 		tcp_abort(smc->clcsock->sk, ECONNABORTED);
 
 	if (cancel_work_sync(&smc->connect_work))
-		sock_put(&smc->sk); /* sock_hold in smc_connect for passive closing */
+		sock_put(&smc->inet.sk); /* sock_hold in smc_connect for passive closing */
 
 	if (sk->sk_state == SMC_LISTEN)
 		/* smc_close_non_accepted() is called and acquires
@@ -496,7 +496,7 @@ static void smc_copy_sock_settings(struct sock *nsk, struct sock *osk,
 
 static void smc_copy_sock_settings_to_clc(struct smc_sock *smc)
 {
-	smc_copy_sock_settings(smc->clcsock->sk, &smc->sk, SK_FLAGS_SMC_TO_CLC);
+	smc_copy_sock_settings(smc->clcsock->sk, &smc->inet.sk, SK_FLAGS_SMC_TO_CLC);
 }
 
 #define SK_FLAGS_CLC_TO_SMC ((1UL << SOCK_URGINLINE) | \
@@ -506,7 +506,7 @@ static void smc_copy_sock_settings_to_clc(struct smc_sock *smc)
 /* copy only settings and flags relevant for smc from clc to smc socket */
 static void smc_copy_sock_settings_to_smc(struct smc_sock *smc)
 {
-	smc_copy_sock_settings(&smc->sk, smc->clcsock->sk, SK_FLAGS_CLC_TO_SMC);
+	smc_copy_sock_settings(&smc->inet.sk, smc->clcsock->sk, SK_FLAGS_CLC_TO_SMC);
 }
 
 /* register the new vzalloced sndbuf on all links */
@@ -757,7 +757,7 @@ static void smc_stat_inc_fback_rsn_cnt(struct smc_sock *smc,
 
 static void smc_stat_fallback(struct smc_sock *smc)
 {
-	struct net *net = sock_net(&smc->sk);
+	struct net *net = sock_net(&smc->inet.sk);
 
 	mutex_lock(&net->smc.mutex_fback_rsn);
 	if (smc->listen_smc) {
@@ -776,7 +776,7 @@ static void smc_fback_wakeup_waitqueue(struct smc_sock *smc, void *key)
 	struct socket_wq *wq;
 	__poll_t flags;
 
-	wq = rcu_dereference(smc->sk.sk_wq);
+	wq = rcu_dereference(smc->inet.sk.sk_wq);
 	if (!skwq_has_sleeper(wq))
 		return;
 
@@ -909,12 +909,12 @@ static int smc_switch_to_fallback(struct smc_sock *smc, int reason_code)
 	smc->fallback_rsn = reason_code;
 	smc_stat_fallback(smc);
 	trace_smc_switch_to_fallback(smc, reason_code);
-	if (smc->sk.sk_socket && smc->sk.sk_socket->file) {
-		smc->clcsock->file = smc->sk.sk_socket->file;
+	if (smc->inet.sk.sk_socket && smc->inet.sk.sk_socket->file) {
+		smc->clcsock->file = smc->inet.sk.sk_socket->file;
 		smc->clcsock->file->private_data = smc->clcsock;
 		smc->clcsock->wq.fasync_list =
-			smc->sk.sk_socket->wq.fasync_list;
-		smc->sk.sk_socket->wq.fasync_list = NULL;
+			smc->inet.sk.sk_socket->wq.fasync_list;
+		smc->inet.sk.sk_socket->wq.fasync_list = NULL;
 
 		/* There might be some wait entries remaining
 		 * in smc sk->sk_wq and they should be woken up
@@ -930,20 +930,20 @@ static int smc_switch_to_fallback(struct smc_sock *smc, int reason_code)
 /* fall back during connect */
 static int smc_connect_fallback(struct smc_sock *smc, int reason_code)
 {
-	struct net *net = sock_net(&smc->sk);
+	struct net *net = sock_net(&smc->inet.sk);
 	int rc = 0;
 
 	rc = smc_switch_to_fallback(smc, reason_code);
 	if (rc) { /* fallback fails */
 		this_cpu_inc(net->smc.smc_stats->clnt_hshake_err_cnt);
-		if (smc->sk.sk_state == SMC_INIT)
-			sock_put(&smc->sk); /* passive closing */
+		if (smc->inet.sk.sk_state == SMC_INIT)
+			sock_put(&smc->inet.sk); /* passive closing */
 		return rc;
 	}
 	smc_copy_sock_settings_to_clc(smc);
 	smc->connect_nonblock = 0;
-	if (smc->sk.sk_state == SMC_INIT)
-		smc->sk.sk_state = SMC_ACTIVE;
+	if (smc->inet.sk.sk_state == SMC_INIT)
+		smc->inet.sk.sk_state = SMC_ACTIVE;
 	return 0;
 }
 
@@ -951,21 +951,21 @@ static int smc_connect_fallback(struct smc_sock *smc, int reason_code)
 static int smc_connect_decline_fallback(struct smc_sock *smc, int reason_code,
 					u8 version)
 {
-	struct net *net = sock_net(&smc->sk);
+	struct net *net = sock_net(&smc->inet.sk);
 	int rc;
 
 	if (reason_code < 0) { /* error, fallback is not possible */
 		this_cpu_inc(net->smc.smc_stats->clnt_hshake_err_cnt);
-		if (smc->sk.sk_state == SMC_INIT)
-			sock_put(&smc->sk); /* passive closing */
+		if (smc->inet.sk.sk_state == SMC_INIT)
+			sock_put(&smc->inet.sk); /* passive closing */
 		return reason_code;
 	}
 	if (reason_code != SMC_CLC_DECL_PEERDECL) {
 		rc = smc_clc_send_decline(smc, reason_code, version);
 		if (rc < 0) {
 			this_cpu_inc(net->smc.smc_stats->clnt_hshake_err_cnt);
-			if (smc->sk.sk_state == SMC_INIT)
-				sock_put(&smc->sk); /* passive closing */
+			if (smc->inet.sk.sk_state == SMC_INIT)
+				sock_put(&smc->inet.sk); /* passive closing */
 			return rc;
 		}
 	}
@@ -1050,7 +1050,7 @@ static int smc_find_ism_v2_device_clnt(struct smc_sock *smc,
 			continue;
 		is_emulated = __smc_ism_is_emulated(chid);
 		if (!smc_pnet_is_pnetid_set(smcd->pnetid) ||
-		    smc_pnet_is_ndev_pnetid(sock_net(&smc->sk), smcd->pnetid)) {
+		    smc_pnet_is_ndev_pnetid(sock_net(&smc->inet.sk), smcd->pnetid)) {
 			if (is_emulated && entry == SMCD_CLC_MAX_V2_GID_ENTRIES)
 				/* It's the last GID-CHID entry left in CLC
 				 * Proposal SMC-Dv2 extension, but an Emulated-
@@ -1200,7 +1200,7 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
 {
 	struct smc_clc_first_contact_ext *fce =
 		smc_get_clc_first_contact_ext(aclc, false);
-	struct net *net = sock_net(&smc->sk);
+	struct net *net = sock_net(&smc->inet.sk);
 	int rc;
 
 	if (!ini->first_contact_peer || aclc->hdr.version == SMC_V1)
@@ -1347,8 +1347,8 @@ static int smc_connect_rdma(struct smc_sock *smc,
 
 	smc_copy_sock_settings_to_clc(smc);
 	smc->connect_nonblock = 0;
-	if (smc->sk.sk_state == SMC_INIT)
-		smc->sk.sk_state = SMC_ACTIVE;
+	if (smc->inet.sk.sk_state == SMC_INIT)
+		smc->inet.sk.sk_state = SMC_ACTIVE;
 
 	return 0;
 connect_abort:
@@ -1450,8 +1450,8 @@ static int smc_connect_ism(struct smc_sock *smc,
 
 	smc_copy_sock_settings_to_clc(smc);
 	smc->connect_nonblock = 0;
-	if (smc->sk.sk_state == SMC_INIT)
-		smc->sk.sk_state = SMC_ACTIVE;
+	if (smc->inet.sk.sk_state == SMC_INIT)
+		smc->inet.sk.sk_state = SMC_ACTIVE;
 
 	return 0;
 connect_abort:
@@ -1546,7 +1546,7 @@ static int __smc_connect(struct smc_sock *smc)
 		/* -EAGAIN on timeout, see tcp_recvmsg() */
 		if (rc == -EAGAIN) {
 			rc = -ETIMEDOUT;
-			smc->sk.sk_err = ETIMEDOUT;
+			smc->inet.sk.sk_err = ETIMEDOUT;
 		}
 		goto vlan_cleanup;
 	}
@@ -1586,14 +1586,14 @@ static void smc_connect_work(struct work_struct *work)
 {
 	struct smc_sock *smc = container_of(work, struct smc_sock,
 					    connect_work);
-	long timeo = smc->sk.sk_sndtimeo;
+	long timeo = smc->inet.sk.sk_sndtimeo;
 	int rc = 0;
 
 	if (!timeo)
 		timeo = MAX_SCHEDULE_TIMEOUT;
 	lock_sock(smc->clcsock->sk);
 	if (smc->clcsock->sk->sk_err) {
-		smc->sk.sk_err = smc->clcsock->sk->sk_err;
+		smc->inet.sk.sk_err = smc->clcsock->sk->sk_err;
 	} else if ((1 << smc->clcsock->sk->sk_state) &
 					(TCPF_SYN_SENT | TCPF_SYN_RECV)) {
 		rc = sk_stream_wait_connect(smc->clcsock->sk, &timeo);
@@ -1603,33 +1603,33 @@ static void smc_connect_work(struct work_struct *work)
 			rc = 0;
 	}
 	release_sock(smc->clcsock->sk);
-	lock_sock(&smc->sk);
-	if (rc != 0 || smc->sk.sk_err) {
-		smc->sk.sk_state = SMC_CLOSED;
+	lock_sock(&smc->inet.sk);
+	if (rc != 0 || smc->inet.sk.sk_err) {
+		smc->inet.sk.sk_state = SMC_CLOSED;
 		if (rc == -EPIPE || rc == -EAGAIN)
-			smc->sk.sk_err = EPIPE;
+			smc->inet.sk.sk_err = EPIPE;
 		else if (rc == -ECONNREFUSED)
-			smc->sk.sk_err = ECONNREFUSED;
+			smc->inet.sk.sk_err = ECONNREFUSED;
 		else if (signal_pending(current))
-			smc->sk.sk_err = -sock_intr_errno(timeo);
-		sock_put(&smc->sk); /* passive closing */
+			smc->inet.sk.sk_err = -sock_intr_errno(timeo);
+		sock_put(&smc->inet.sk); /* passive closing */
 		goto out;
 	}
 
 	rc = __smc_connect(smc);
 	if (rc < 0)
-		smc->sk.sk_err = -rc;
+		smc->inet.sk.sk_err = -rc;
 
 out:
-	if (!sock_flag(&smc->sk, SOCK_DEAD)) {
-		if (smc->sk.sk_err) {
-			smc->sk.sk_state_change(&smc->sk);
+	if (!sock_flag(&smc->inet.sk, SOCK_DEAD)) {
+		if (smc->inet.sk.sk_err) {
+			smc->inet.sk.sk_state_change(&smc->inet.sk);
 		} else { /* allow polling before and after fallback decision */
 			smc->clcsock->sk->sk_write_space(smc->clcsock->sk);
-			smc->sk.sk_write_space(&smc->sk);
+			smc->inet.sk.sk_write_space(&smc->inet.sk);
 		}
 	}
-	release_sock(&smc->sk);
+	release_sock(&smc->inet.sk);
 }
 
 int smc_connect(struct socket *sock, struct sockaddr *addr,
@@ -1692,7 +1692,7 @@ int smc_connect(struct socket *sock, struct sockaddr *addr,
 		sock->state = rc ? SS_CONNECTING : SS_CONNECTED;
 		goto out;
 	}
-	sock_hold(&smc->sk); /* sock put in passive closing */
+	sock_hold(&smc->inet.sk); /* sock put in passive closing */
 	if (flags & O_NONBLOCK) {
 		if (queue_work(smc_hs_wq, &smc->connect_work))
 			smc->connect_nonblock = 1;
@@ -1716,7 +1716,7 @@ int smc_connect(struct socket *sock, struct sockaddr *addr,
 static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
 {
 	struct socket *new_clcsock = NULL;
-	struct sock *lsk = &lsmc->sk;
+	struct sock *lsk = &lsmc->inet.sk;
 	struct sock *new_sk;
 	int rc = -EINVAL;
 
@@ -1793,7 +1793,7 @@ static void smc_accept_unlink(struct sock *sk)
 	spin_lock(&par->accept_q_lock);
 	list_del_init(&smc_sk(sk)->accept_q);
 	spin_unlock(&par->accept_q_lock);
-	sk_acceptq_removed(&smc_sk(sk)->listen_smc->sk);
+	sk_acceptq_removed(&smc_sk(sk)->listen_smc->inet.sk);
 	sock_put(sk); /* sock_hold in smc_accept_enqueue */
 }
 
@@ -1904,28 +1904,28 @@ static int smcr_serv_conf_first_link(struct smc_sock *smc)
 static void smc_listen_out(struct smc_sock *new_smc)
 {
 	struct smc_sock *lsmc = new_smc->listen_smc;
-	struct sock *newsmcsk = &new_smc->sk;
+	struct sock *newsmcsk = &new_smc->inet.sk;
 
 	if (tcp_sk(new_smc->clcsock->sk)->syn_smc)
 		atomic_dec(&lsmc->queued_smc_hs);
 
-	if (lsmc->sk.sk_state == SMC_LISTEN) {
-		lock_sock_nested(&lsmc->sk, SINGLE_DEPTH_NESTING);
-		smc_accept_enqueue(&lsmc->sk, newsmcsk);
-		release_sock(&lsmc->sk);
+	if (lsmc->inet.sk.sk_state == SMC_LISTEN) {
+		lock_sock_nested(&lsmc->inet.sk, SINGLE_DEPTH_NESTING);
+		smc_accept_enqueue(&lsmc->inet.sk, newsmcsk);
+		release_sock(&lsmc->inet.sk);
 	} else { /* no longer listening */
 		smc_close_non_accepted(newsmcsk);
 	}
 
 	/* Wake up accept */
-	lsmc->sk.sk_data_ready(&lsmc->sk);
-	sock_put(&lsmc->sk); /* sock_hold in smc_tcp_listen_work */
+	lsmc->inet.sk.sk_data_ready(&lsmc->inet.sk);
+	sock_put(&lsmc->inet.sk); /* sock_hold in smc_tcp_listen_work */
 }
 
 /* listen worker: finish in state connected */
 static void smc_listen_out_connected(struct smc_sock *new_smc)
 {
-	struct sock *newsmcsk = &new_smc->sk;
+	struct sock *newsmcsk = &new_smc->inet.sk;
 
 	if (newsmcsk->sk_state == SMC_INIT)
 		newsmcsk->sk_state = SMC_ACTIVE;
@@ -1936,12 +1936,12 @@ static void smc_listen_out_connected(struct smc_sock *new_smc)
 /* listen worker: finish in error state */
 static void smc_listen_out_err(struct smc_sock *new_smc)
 {
-	struct sock *newsmcsk = &new_smc->sk;
+	struct sock *newsmcsk = &new_smc->inet.sk;
 	struct net *net = sock_net(newsmcsk);
 
 	this_cpu_inc(net->smc.smc_stats->srv_hshake_err_cnt);
 	if (newsmcsk->sk_state == SMC_INIT)
-		sock_put(&new_smc->sk); /* passive closing */
+		sock_put(&new_smc->inet.sk); /* passive closing */
 	newsmcsk->sk_state = SMC_CLOSED;
 
 	smc_listen_out(new_smc);
@@ -2430,7 +2430,7 @@ static void smc_listen_work(struct work_struct *work)
 	u8 accept_version;
 	int rc = 0;
 
-	if (new_smc->listen_smc->sk.sk_state != SMC_LISTEN)
+	if (new_smc->listen_smc->inet.sk.sk_state != SMC_LISTEN)
 		return smc_listen_out_err(new_smc);
 
 	if (new_smc->use_fallback) {
@@ -2565,7 +2565,7 @@ static void smc_tcp_listen_work(struct work_struct *work)
 {
 	struct smc_sock *lsmc = container_of(work, struct smc_sock,
 					     tcp_listen_work);
-	struct sock *lsk = &lsmc->sk;
+	struct sock *lsk = &lsmc->inet.sk;
 	struct smc_sock *new_smc;
 	int rc = 0;
 
@@ -2586,14 +2586,14 @@ static void smc_tcp_listen_work(struct work_struct *work)
 		sock_hold(lsk); /* sock_put in smc_listen_work */
 		INIT_WORK(&new_smc->smc_listen_work, smc_listen_work);
 		smc_copy_sock_settings_to_smc(new_smc);
-		sock_hold(&new_smc->sk); /* sock_put in passive closing */
+		sock_hold(&new_smc->inet.sk); /* sock_put in passive closing */
 		if (!queue_work(smc_hs_wq, &new_smc->smc_listen_work))
-			sock_put(&new_smc->sk);
+			sock_put(&new_smc->inet.sk);
 	}
 
 out:
 	release_sock(lsk);
-	sock_put(&lsmc->sk); /* sock_hold in smc_clcsock_data_ready() */
+	sock_put(&lsmc->inet.sk); /* sock_hold in smc_clcsock_data_ready() */
 }
 
 static void smc_clcsock_data_ready(struct sock *listen_clcsock)
@@ -2605,10 +2605,10 @@ static void smc_clcsock_data_ready(struct sock *listen_clcsock)
 	if (!lsmc)
 		goto out;
 	lsmc->clcsk_data_ready(listen_clcsock);
-	if (lsmc->sk.sk_state == SMC_LISTEN) {
-		sock_hold(&lsmc->sk); /* sock_put in smc_tcp_listen_work() */
+	if (lsmc->inet.sk.sk_state == SMC_LISTEN) {
+		sock_hold(&lsmc->inet.sk); /* sock_put in smc_tcp_listen_work() */
 		if (!queue_work(smc_tcp_ls_wq, &lsmc->tcp_listen_work))
-			sock_put(&lsmc->sk);
+			sock_put(&lsmc->inet.sk);
 	}
 out:
 	read_unlock_bh(&listen_clcsock->sk_callback_lock);
@@ -2692,7 +2692,7 @@ int smc_accept(struct socket *sock, struct socket *new_sock,
 	sock_hold(sk); /* sock_put below */
 	lock_sock(sk);
 
-	if (lsmc->sk.sk_state != SMC_LISTEN) {
+	if (lsmc->inet.sk.sk_state != SMC_LISTEN) {
 		rc = -EINVAL;
 		release_sock(sk);
 		goto out;
@@ -3167,36 +3167,36 @@ int smc_ioctl(struct socket *sock, unsigned int cmd,
 
 	smc = smc_sk(sock->sk);
 	conn = &smc->conn;
-	lock_sock(&smc->sk);
+	lock_sock(&smc->inet.sk);
 	if (smc->use_fallback) {
 		if (!smc->clcsock) {
-			release_sock(&smc->sk);
+			release_sock(&smc->inet.sk);
 			return -EBADF;
 		}
 		answ = smc->clcsock->ops->ioctl(smc->clcsock, cmd, arg);
-		release_sock(&smc->sk);
+		release_sock(&smc->inet.sk);
 		return answ;
 	}
 	switch (cmd) {
 	case SIOCINQ: /* same as FIONREAD */
-		if (smc->sk.sk_state == SMC_LISTEN) {
-			release_sock(&smc->sk);
+		if (smc->inet.sk.sk_state == SMC_LISTEN) {
+			release_sock(&smc->inet.sk);
 			return -EINVAL;
 		}
-		if (smc->sk.sk_state == SMC_INIT ||
-		    smc->sk.sk_state == SMC_CLOSED)
+		if (smc->inet.sk.sk_state == SMC_INIT ||
+		    smc->inet.sk.sk_state == SMC_CLOSED)
 			answ = 0;
 		else
 			answ = atomic_read(&smc->conn.bytes_to_rcv);
 		break;
 	case SIOCOUTQ:
 		/* output queue size (not send + not acked) */
-		if (smc->sk.sk_state == SMC_LISTEN) {
-			release_sock(&smc->sk);
+		if (smc->inet.sk.sk_state == SMC_LISTEN) {
+			release_sock(&smc->inet.sk);
 			return -EINVAL;
 		}
-		if (smc->sk.sk_state == SMC_INIT ||
-		    smc->sk.sk_state == SMC_CLOSED)
+		if (smc->inet.sk.sk_state == SMC_INIT ||
+		    smc->inet.sk.sk_state == SMC_CLOSED)
 			answ = 0;
 		else
 			answ = smc->conn.sndbuf_desc->len -
@@ -3204,23 +3204,23 @@ int smc_ioctl(struct socket *sock, unsigned int cmd,
 		break;
 	case SIOCOUTQNSD:
 		/* output queue size (not send only) */
-		if (smc->sk.sk_state == SMC_LISTEN) {
-			release_sock(&smc->sk);
+		if (smc->inet.sk.sk_state == SMC_LISTEN) {
+			release_sock(&smc->inet.sk);
 			return -EINVAL;
 		}
-		if (smc->sk.sk_state == SMC_INIT ||
-		    smc->sk.sk_state == SMC_CLOSED)
+		if (smc->inet.sk.sk_state == SMC_INIT ||
+		    smc->inet.sk.sk_state == SMC_CLOSED)
 			answ = 0;
 		else
 			answ = smc_tx_prepared_sends(&smc->conn);
 		break;
 	case SIOCATMARK:
-		if (smc->sk.sk_state == SMC_LISTEN) {
-			release_sock(&smc->sk);
+		if (smc->inet.sk.sk_state == SMC_LISTEN) {
+			release_sock(&smc->inet.sk);
 			return -EINVAL;
 		}
-		if (smc->sk.sk_state == SMC_INIT ||
-		    smc->sk.sk_state == SMC_CLOSED) {
+		if (smc->inet.sk.sk_state == SMC_INIT ||
+		    smc->inet.sk.sk_state == SMC_CLOSED) {
 			answ = 0;
 		} else {
 			smc_curs_copy(&cons, &conn->local_tx_ctrl.cons, conn);
@@ -3230,10 +3230,10 @@ int smc_ioctl(struct socket *sock, unsigned int cmd,
 		}
 		break;
 	default:
-		release_sock(&smc->sk);
+		release_sock(&smc->inet.sk);
 		return -ENOIOCTLCMD;
 	}
-	release_sock(&smc->sk);
+	release_sock(&smc->inet.sk);
 
 	return put_user(answ, (int __user *)arg);
 }
@@ -3324,7 +3324,7 @@ int smc_create_clcsk(struct net *net, struct sock *sk, int family)
 
 	/* smc_clcsock_release() does not wait smc->clcsock->sk's
 	 * destruction;  its sk_state might not be TCP_CLOSE after
-	 * smc->sk is close()d, and TCP timers can be fired later,
+	 * smc->inet.sk is close()d, and TCP timers can be fired later,
 	 * which need net ref.
 	 */
 	sk = smc->clcsock->sk;
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 34b781e463c4..7dd76dbea245 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -283,7 +283,7 @@ struct smc_connection {
 };
 
 struct smc_sock {				/* smc sock container */
-	struct sock		sk;
+	struct inet_sock		inet;	/* inet_sock has to be the first member of smc_sock */
 	struct socket		*clcsock;	/* internal tcp socket */
 	void			(*clcsk_state_change)(struct sock *sk);
 						/* original stat_change fct. */
@@ -327,7 +327,7 @@ struct smc_sock {				/* smc sock container */
 						 * */
 };
 
-#define smc_sk(ptr) container_of_const(ptr, struct smc_sock, sk)
+#define smc_sk(ptr) container_of_const(ptr, struct smc_sock, inet.sk)
 
 static inline void smc_init_saved_callbacks(struct smc_sock *smc)
 {
diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 619b3bab3824..45d81c87b398 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -35,7 +35,7 @@ static void smc_cdc_tx_handler(struct smc_wr_tx_pend_priv *pnd_snd,
 
 	sndbuf_desc = conn->sndbuf_desc;
 	smc = container_of(conn, struct smc_sock, conn);
-	bh_lock_sock(&smc->sk);
+	bh_lock_sock(&smc->inet.sk);
 	if (!wc_status && sndbuf_desc) {
 		diff = smc_curs_diff(sndbuf_desc->len,
 				     &cdcpend->conn->tx_curs_fin,
@@ -56,7 +56,7 @@ static void smc_cdc_tx_handler(struct smc_wr_tx_pend_priv *pnd_snd,
 		 * User context will later try to send when it release sock_lock
 		 * in smc_release_cb()
 		 */
-		if (sock_owned_by_user(&smc->sk))
+		if (sock_owned_by_user(&smc->inet.sk))
 			conn->tx_in_release_sock = true;
 		else
 			smc_tx_pending(conn);
@@ -67,7 +67,7 @@ static void smc_cdc_tx_handler(struct smc_wr_tx_pend_priv *pnd_snd,
 	WARN_ON(atomic_read(&conn->cdc_pend_tx_wr) < 0);
 
 	smc_tx_sndbuf_nonfull(smc);
-	bh_unlock_sock(&smc->sk);
+	bh_unlock_sock(&smc->inet.sk);
 }
 
 int smc_cdc_get_free_slot(struct smc_connection *conn,
@@ -294,7 +294,7 @@ static void smc_cdc_handle_urg_data_arrival(struct smc_sock *smc,
 	/* new data included urgent business */
 	smc_curs_copy(&conn->urg_curs, &conn->local_rx_ctrl.prod, conn);
 	conn->urg_state = SMC_URG_VALID;
-	if (!sock_flag(&smc->sk, SOCK_URGINLINE))
+	if (!sock_flag(&smc->inet.sk, SOCK_URGINLINE))
 		/* we'll skip the urgent byte, so don't account for it */
 		(*diff_prod)--;
 	base = (char *)conn->rmb_desc->cpu_addr + conn->rx_off;
@@ -302,7 +302,7 @@ static void smc_cdc_handle_urg_data_arrival(struct smc_sock *smc,
 		conn->urg_rx_byte = *(base + conn->urg_curs.count - 1);
 	else
 		conn->urg_rx_byte = *(base + conn->rmb_desc->len - 1);
-	sk_send_sigurg(&smc->sk);
+	sk_send_sigurg(&smc->inet.sk);
 }
 
 static void smc_cdc_msg_validate(struct smc_sock *smc, struct smc_cdc_msg *cdc,
@@ -321,9 +321,9 @@ static void smc_cdc_msg_validate(struct smc_sock *smc, struct smc_cdc_msg *cdc,
 		conn->local_tx_ctrl.conn_state_flags.peer_conn_abort = 1;
 		conn->lnk = link;
 		spin_unlock_bh(&conn->send_lock);
-		sock_hold(&smc->sk); /* sock_put in abort_work */
+		sock_hold(&smc->inet.sk); /* sock_put in abort_work */
 		if (!queue_work(smc_close_wq, &conn->abort_work))
-			sock_put(&smc->sk);
+			sock_put(&smc->inet.sk);
 	}
 }
 
@@ -383,10 +383,10 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 		atomic_add(diff_prod, &conn->bytes_to_rcv);
 		/* guarantee 0 <= bytes_to_rcv <= rmb_desc->len */
 		smp_mb__after_atomic();
-		smc->sk.sk_data_ready(&smc->sk);
+		smc->inet.sk.sk_data_ready(&smc->inet.sk);
 	} else {
 		if (conn->local_rx_ctrl.prod_flags.write_blocked)
-			smc->sk.sk_data_ready(&smc->sk);
+			smc->inet.sk.sk_data_ready(&smc->inet.sk);
 		if (conn->local_rx_ctrl.prod_flags.urg_data_pending)
 			conn->urg_state = SMC_URG_NOTYET;
 	}
@@ -395,7 +395,7 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 	if ((diff_cons && smc_tx_prepared_sends(conn)) ||
 	    conn->local_rx_ctrl.prod_flags.cons_curs_upd_req ||
 	    conn->local_rx_ctrl.prod_flags.urg_data_pending) {
-		if (!sock_owned_by_user(&smc->sk))
+		if (!sock_owned_by_user(&smc->inet.sk))
 			smc_tx_pending(conn);
 		else
 			conn->tx_in_release_sock = true;
@@ -405,32 +405,32 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 	    atomic_read(&conn->peer_rmbe_space) == conn->peer_rmbe_size) {
 		/* urg data confirmed by peer, indicate we're ready for more */
 		conn->urg_tx_pend = false;
-		smc->sk.sk_write_space(&smc->sk);
+		smc->inet.sk.sk_write_space(&smc->inet.sk);
 	}
 
 	if (conn->local_rx_ctrl.conn_state_flags.peer_conn_abort) {
-		smc->sk.sk_err = ECONNRESET;
+		smc->inet.sk.sk_err = ECONNRESET;
 		conn->local_tx_ctrl.conn_state_flags.peer_conn_abort = 1;
 	}
 	if (smc_cdc_rxed_any_close_or_senddone(conn)) {
-		smc->sk.sk_shutdown |= RCV_SHUTDOWN;
+		smc->inet.sk.sk_shutdown |= RCV_SHUTDOWN;
 		if (smc->clcsock && smc->clcsock->sk)
 			smc->clcsock->sk->sk_shutdown |= RCV_SHUTDOWN;
-		smc_sock_set_flag(&smc->sk, SOCK_DONE);
-		sock_hold(&smc->sk); /* sock_put in close_work */
+		smc_sock_set_flag(&smc->inet.sk, SOCK_DONE);
+		sock_hold(&smc->inet.sk); /* sock_put in close_work */
 		if (!queue_work(smc_close_wq, &conn->close_work))
-			sock_put(&smc->sk);
+			sock_put(&smc->inet.sk);
 	}
 }
 
 /* called under tasklet context */
 static void smc_cdc_msg_recv(struct smc_sock *smc, struct smc_cdc_msg *cdc)
 {
-	sock_hold(&smc->sk);
-	bh_lock_sock(&smc->sk);
+	sock_hold(&smc->inet.sk);
+	bh_lock_sock(&smc->inet.sk);
 	smc_cdc_msg_recv_action(smc, cdc);
-	bh_unlock_sock(&smc->sk);
-	sock_put(&smc->sk); /* no free sk in softirq-context */
+	bh_unlock_sock(&smc->inet.sk);
+	sock_put(&smc->inet.sk); /* no free sk in softirq-context */
 }
 
 /* Schedule a tasklet for this connection. Triggered from the ISM device IRQ
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 33fa787c28eb..c08ebc55f2ad 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -704,7 +704,7 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 	if (signal_pending(current)) {
 		reason_code = -EINTR;
 		clc_sk->sk_err = EINTR;
-		smc->sk.sk_err = EINTR;
+		smc->inet.sk.sk_err = EINTR;
 		goto out;
 	}
 	if (clc_sk->sk_err) {
@@ -713,17 +713,17 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 		    expected_type == SMC_CLC_DECLINE)
 			clc_sk->sk_err = 0; /* reset for fallback usage */
 		else
-			smc->sk.sk_err = clc_sk->sk_err;
+			smc->inet.sk.sk_err = clc_sk->sk_err;
 		goto out;
 	}
 	if (!len) { /* peer has performed orderly shutdown */
-		smc->sk.sk_err = ECONNRESET;
+		smc->inet.sk.sk_err = ECONNRESET;
 		reason_code = -ECONNRESET;
 		goto out;
 	}
 	if (len < 0) {
 		if (len != -EAGAIN || expected_type != SMC_CLC_DECLINE)
-			smc->sk.sk_err = -len;
+			smc->inet.sk.sk_err = -len;
 		reason_code = len;
 		goto out;
 	}
@@ -732,7 +732,7 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 	    (clcm->version < SMC_V1) ||
 	    ((clcm->type != SMC_CLC_DECLINE) &&
 	     (clcm->type != expected_type))) {
-		smc->sk.sk_err = EPROTO;
+		smc->inet.sk.sk_err = EPROTO;
 		reason_code = -EPROTO;
 		goto out;
 	}
@@ -749,7 +749,7 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
 	krflags = MSG_WAITALL;
 	len = sock_recvmsg(smc->clcsock, &msg, krflags);
 	if (len < recvlen || !smc_clc_msg_hdr_valid(clcm, check_trl)) {
-		smc->sk.sk_err = EPROTO;
+		smc->inet.sk.sk_err = EPROTO;
 		reason_code = -EPROTO;
 		goto out;
 	}
@@ -835,7 +835,7 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 	struct smc_clc_smcd_gid_chid *gidchids;
 	struct smc_clc_msg_proposal_area *pclc;
 	struct smc_clc_ipv6_prefix *ipv6_prfx;
-	struct net *net = sock_net(&smc->sk);
+	struct net *net = sock_net(&smc->inet.sk);
 	struct smc_clc_v2_extension *v2_ext;
 	struct smc_clc_msg_smcd *pclc_smcd;
 	struct smc_clc_msg_trail *trl;
@@ -1015,11 +1015,11 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 	/* due to the few bytes needed for clc-handshake this cannot block */
 	len = kernel_sendmsg(smc->clcsock, &msg, vec, i, plen);
 	if (len < 0) {
-		smc->sk.sk_err = smc->clcsock->sk->sk_err;
-		reason_code = -smc->sk.sk_err;
+		smc->inet.sk.sk_err = smc->clcsock->sk->sk_err;
+		reason_code = -smc->inet.sk.sk_err;
 	} else if (len < ntohs(pclc_base->hdr.length)) {
 		reason_code = -ENETUNREACH;
-		smc->sk.sk_err = -reason_code;
+		smc->inet.sk.sk_err = -reason_code;
 	}
 
 	kfree(pclc);
@@ -1208,10 +1208,10 @@ int smc_clc_send_confirm(struct smc_sock *smc, bool clnt_first_contact,
 	if (len < ntohs(cclc.hdr.length)) {
 		if (len >= 0) {
 			reason_code = -ENETUNREACH;
-			smc->sk.sk_err = -reason_code;
+			smc->inet.sk.sk_err = -reason_code;
 		} else {
-			smc->sk.sk_err = smc->clcsock->sk->sk_err;
-			reason_code = -smc->sk.sk_err;
+			smc->inet.sk.sk_err = smc->clcsock->sk->sk_err;
+			reason_code = -smc->inet.sk.sk_err;
 		}
 	}
 	return reason_code;
@@ -1239,7 +1239,7 @@ int smc_clc_srv_v2x_features_validate(struct smc_sock *smc,
 				      struct smc_init_info *ini)
 {
 	struct smc_clc_v2_extension *pclc_v2_ext;
-	struct net *net = sock_net(&smc->sk);
+	struct net *net = sock_net(&smc->inet.sk);
 
 	ini->max_conns = SMC_CONN_PER_LGR_MAX;
 	ini->max_links = SMC_LINKS_ADD_LNK_MAX;
diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index 10219f55aad1..74020e9eba1b 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -49,7 +49,7 @@ static void smc_close_cleanup_listen(struct sock *parent)
 static void smc_close_stream_wait(struct smc_sock *smc, long timeout)
 {
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
-	struct sock *sk = &smc->sk;
+	struct sock *sk = &smc->inet.sk;
 
 	if (!timeout)
 		return;
@@ -82,7 +82,7 @@ void smc_close_wake_tx_prepared(struct smc_sock *smc)
 {
 	if (smc->wait_close_tx_prepared)
 		/* wake up socket closing */
-		smc->sk.sk_state_change(&smc->sk);
+		smc->inet.sk.sk_state_change(&smc->inet.sk);
 }
 
 static int smc_close_wr(struct smc_connection *conn)
@@ -113,7 +113,7 @@ int smc_close_abort(struct smc_connection *conn)
 
 static void smc_close_cancel_work(struct smc_sock *smc)
 {
-	struct sock *sk = &smc->sk;
+	struct sock *sk = &smc->inet.sk;
 
 	release_sock(sk);
 	if (cancel_work_sync(&smc->conn.close_work))
@@ -127,7 +127,7 @@ static void smc_close_cancel_work(struct smc_sock *smc)
  */
 void smc_close_active_abort(struct smc_sock *smc)
 {
-	struct sock *sk = &smc->sk;
+	struct sock *sk = &smc->inet.sk;
 	bool release_clcsock = false;
 
 	if (sk->sk_state != SMC_INIT && smc->clcsock && smc->clcsock->sk) {
@@ -195,7 +195,7 @@ int smc_close_active(struct smc_sock *smc)
 	struct smc_cdc_conn_state_flags *txflags =
 		&smc->conn.local_tx_ctrl.conn_state_flags;
 	struct smc_connection *conn = &smc->conn;
-	struct sock *sk = &smc->sk;
+	struct sock *sk = &smc->inet.sk;
 	int old_state;
 	long timeout;
 	int rc = 0;
@@ -313,7 +313,7 @@ static void smc_close_passive_abort_received(struct smc_sock *smc)
 {
 	struct smc_cdc_conn_state_flags *txflags =
 		&smc->conn.local_tx_ctrl.conn_state_flags;
-	struct sock *sk = &smc->sk;
+	struct sock *sk = &smc->inet.sk;
 
 	switch (sk->sk_state) {
 	case SMC_INIT:
@@ -361,7 +361,7 @@ static void smc_close_passive_work(struct work_struct *work)
 	struct smc_sock *smc = container_of(conn, struct smc_sock, conn);
 	struct smc_cdc_conn_state_flags *rxflags;
 	bool release_clcsock = false;
-	struct sock *sk = &smc->sk;
+	struct sock *sk = &smc->inet.sk;
 	int old_state;
 
 	lock_sock(sk);
@@ -447,7 +447,7 @@ static void smc_close_passive_work(struct work_struct *work)
 int smc_close_shutdown_write(struct smc_sock *smc)
 {
 	struct smc_connection *conn = &smc->conn;
-	struct sock *sk = &smc->sk;
+	struct sock *sk = &smc->inet.sk;
 	int old_state;
 	long timeout;
 	int rc = 0;
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 3b95828d9976..86430ab7c0ef 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -180,7 +180,7 @@ static int smc_lgr_register_conn(struct smc_connection *conn, bool first)
 	/* find a new alert_token_local value not yet used by some connection
 	 * in this link group
 	 */
-	sock_hold(&smc->sk); /* sock_put in smc_lgr_unregister_conn() */
+	sock_hold(&smc->inet.sk); /* sock_put in smc_lgr_unregister_conn() */
 	while (!conn->alert_token_local) {
 		conn->alert_token_local = atomic_inc_return(&nexttoken);
 		if (smc_lgr_find_conn(conn->alert_token_local, conn->lgr))
@@ -203,7 +203,7 @@ static void __smc_lgr_unregister_conn(struct smc_connection *conn)
 		atomic_dec(&conn->lnk->conn_cnt);
 	lgr->conns_num--;
 	conn->alert_token_local = 0;
-	sock_put(&smc->sk); /* sock_hold in smc_lgr_register_conn() */
+	sock_put(&smc->inet.sk); /* sock_hold in smc_lgr_register_conn() */
 }
 
 /* Unregister connection from lgr
@@ -1010,12 +1010,12 @@ static int smc_switch_cursor(struct smc_sock *smc, struct smc_cdc_tx_pend *pend,
 	/* recalculate, value is used by tx_rdma_writes() */
 	atomic_set(&smc->conn.peer_rmbe_space, smc_write_space(conn));
 
-	if (smc->sk.sk_state != SMC_INIT &&
-	    smc->sk.sk_state != SMC_CLOSED) {
+	if (smc->inet.sk.sk_state != SMC_INIT &&
+	    smc->inet.sk.sk_state != SMC_CLOSED) {
 		rc = smcr_cdc_msg_send_validation(conn, pend, wr_buf);
 		if (!rc) {
 			queue_delayed_work(conn->lgr->tx_wq, &conn->tx_work, 0);
-			smc->sk.sk_data_ready(&smc->sk);
+			smc->inet.sk.sk_data_ready(&smc->inet.sk);
 		}
 	} else {
 		smc_wr_tx_put_slot(conn->lnk,
@@ -1072,23 +1072,23 @@ struct smc_link *smc_switch_conns(struct smc_link_group *lgr,
 			continue;
 		smc = container_of(conn, struct smc_sock, conn);
 		/* conn->lnk not yet set in SMC_INIT state */
-		if (smc->sk.sk_state == SMC_INIT)
+		if (smc->inet.sk.sk_state == SMC_INIT)
 			continue;
-		if (smc->sk.sk_state == SMC_CLOSED ||
-		    smc->sk.sk_state == SMC_PEERCLOSEWAIT1 ||
-		    smc->sk.sk_state == SMC_PEERCLOSEWAIT2 ||
-		    smc->sk.sk_state == SMC_APPFINCLOSEWAIT ||
-		    smc->sk.sk_state == SMC_APPCLOSEWAIT1 ||
-		    smc->sk.sk_state == SMC_APPCLOSEWAIT2 ||
-		    smc->sk.sk_state == SMC_PEERFINCLOSEWAIT ||
-		    smc->sk.sk_state == SMC_PEERABORTWAIT ||
-		    smc->sk.sk_state == SMC_PROCESSABORT) {
+		if (smc->inet.sk.sk_state == SMC_CLOSED ||
+		    smc->inet.sk.sk_state == SMC_PEERCLOSEWAIT1 ||
+		    smc->inet.sk.sk_state == SMC_PEERCLOSEWAIT2 ||
+		    smc->inet.sk.sk_state == SMC_APPFINCLOSEWAIT ||
+		    smc->inet.sk.sk_state == SMC_APPCLOSEWAIT1 ||
+		    smc->inet.sk.sk_state == SMC_APPCLOSEWAIT2 ||
+		    smc->inet.sk.sk_state == SMC_PEERFINCLOSEWAIT ||
+		    smc->inet.sk.sk_state == SMC_PEERABORTWAIT ||
+		    smc->inet.sk.sk_state == SMC_PROCESSABORT) {
 			spin_lock_bh(&conn->send_lock);
 			smc_switch_link_and_count(conn, to_lnk);
 			spin_unlock_bh(&conn->send_lock);
 			continue;
 		}
-		sock_hold(&smc->sk);
+		sock_hold(&smc->inet.sk);
 		read_unlock_bh(&lgr->conns_lock);
 		/* pre-fetch buffer outside of send_lock, might sleep */
 		rc = smc_cdc_get_free_slot(conn, to_lnk, &wr_buf, NULL, &pend);
@@ -1099,7 +1099,7 @@ struct smc_link *smc_switch_conns(struct smc_link_group *lgr,
 		smc_switch_link_and_count(conn, to_lnk);
 		rc = smc_switch_cursor(smc, pend, wr_buf);
 		spin_unlock_bh(&conn->send_lock);
-		sock_put(&smc->sk);
+		sock_put(&smc->inet.sk);
 		if (rc)
 			goto err_out;
 		goto again;
@@ -1442,9 +1442,9 @@ void smc_lgr_put(struct smc_link_group *lgr)
 
 static void smc_sk_wake_ups(struct smc_sock *smc)
 {
-	smc->sk.sk_write_space(&smc->sk);
-	smc->sk.sk_data_ready(&smc->sk);
-	smc->sk.sk_state_change(&smc->sk);
+	smc->inet.sk.sk_write_space(&smc->inet.sk);
+	smc->inet.sk.sk_data_ready(&smc->inet.sk);
+	smc->inet.sk.sk_state_change(&smc->inet.sk);
 }
 
 /* kill a connection */
@@ -1457,7 +1457,7 @@ static void smc_conn_kill(struct smc_connection *conn, bool soft)
 	else
 		smc_close_abort(conn);
 	conn->killed = 1;
-	smc->sk.sk_err = ECONNABORTED;
+	smc->inet.sk.sk_err = ECONNABORTED;
 	smc_sk_wake_ups(smc);
 	if (conn->lgr->is_smcd) {
 		smc_ism_unset_conn(conn);
@@ -1511,11 +1511,11 @@ static void __smc_lgr_terminate(struct smc_link_group *lgr, bool soft)
 		read_unlock_bh(&lgr->conns_lock);
 		conn = rb_entry(node, struct smc_connection, alert_node);
 		smc = container_of(conn, struct smc_sock, conn);
-		sock_hold(&smc->sk); /* sock_put below */
-		lock_sock(&smc->sk);
+		sock_hold(&smc->inet.sk); /* sock_put below */
+		lock_sock(&smc->inet.sk);
 		smc_conn_kill(conn, soft);
-		release_sock(&smc->sk);
-		sock_put(&smc->sk); /* sock_hold above */
+		release_sock(&smc->inet.sk);
+		sock_put(&smc->inet.sk); /* sock_hold above */
 		read_lock_bh(&lgr->conns_lock);
 		node = rb_first(&lgr->conns_all);
 	}
@@ -1684,10 +1684,10 @@ static void smc_conn_abort_work(struct work_struct *work)
 						   abort_work);
 	struct smc_sock *smc = container_of(conn, struct smc_sock, conn);
 
-	lock_sock(&smc->sk);
+	lock_sock(&smc->inet.sk);
 	smc_conn_kill(conn, true);
-	release_sock(&smc->sk);
-	sock_put(&smc->sk); /* sock_hold done by schedulers of abort_work */
+	release_sock(&smc->inet.sk);
+	sock_put(&smc->inet.sk); /* sock_hold done by schedulers of abort_work */
 }
 
 void smcr_port_add(struct smc_ib_device *smcibdev, u8 ibport)
@@ -1910,7 +1910,7 @@ static bool smcd_lgr_match(struct smc_link_group *lgr,
 int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 {
 	struct smc_connection *conn = &smc->conn;
-	struct net *net = sock_net(&smc->sk);
+	struct net *net = sock_net(&smc->inet.sk);
 	struct list_head *lgr_list;
 	struct smc_link_group *lgr;
 	enum smc_lgr_role role;
@@ -2370,10 +2370,10 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 
 	if (is_rmb)
 		/* use socket recv buffer size (w/o overhead) as start value */
-		bufsize = smc->sk.sk_rcvbuf / 2;
+		bufsize = smc->inet.sk.sk_rcvbuf / 2;
 	else
 		/* use socket send buffer size (w/o overhead) as start value */
-		bufsize = smc->sk.sk_sndbuf / 2;
+		bufsize = smc->inet.sk.sk_sndbuf / 2;
 
 	for (bufsize_comp = smc_compress_bufsize(bufsize, is_smcd, is_rmb);
 	     bufsize_comp >= 0; bufsize_comp--) {
@@ -2432,7 +2432,7 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 	if (is_rmb) {
 		conn->rmb_desc = buf_desc;
 		conn->rmbe_size_comp = bufsize_comp;
-		smc->sk.sk_rcvbuf = bufsize * 2;
+		smc->inet.sk.sk_rcvbuf = bufsize * 2;
 		atomic_set(&conn->bytes_to_rcv, 0);
 		conn->rmbe_update_limit =
 			smc_rmb_wnd_update_limit(buf_desc->len);
@@ -2440,7 +2440,7 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 			smc_ism_set_conn(conn); /* map RMB/smcd_dev to conn */
 	} else {
 		conn->sndbuf_desc = buf_desc;
-		smc->sk.sk_sndbuf = bufsize * 2;
+		smc->inet.sk.sk_sndbuf = bufsize * 2;
 		atomic_set(&conn->sndbuf_space, bufsize);
 	}
 	return 0;
@@ -2525,7 +2525,7 @@ int smcd_buf_attach(struct smc_sock *smc)
 	if (rc)
 		goto free;
 
-	smc->sk.sk_sndbuf = buf_desc->len;
+	smc->inet.sk.sk_sndbuf = buf_desc->len;
 	buf_desc->cpu_addr =
 		(u8 *)buf_desc->cpu_addr + sizeof(struct smcd_cdc_msg);
 	buf_desc->len -= sizeof(struct smcd_cdc_msg);
diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
index bece346dd8e9..9e5eff8f5226 100644
--- a/net/smc/smc_inet.c
+++ b/net/smc/smc_inet.c
@@ -60,6 +60,11 @@ static struct inet_protosw smc_inet_protosw = {
 };
 
 #if IS_ENABLED(CONFIG_IPV6)
+struct smc6_sock {
+	struct smc_sock smc;
+	struct ipv6_pinfo inet6;
+};
+
 static struct proto smc_inet6_prot = {
 	.name		= "INET6_SMC",
 	.owner		= THIS_MODULE,
@@ -67,9 +72,10 @@ static struct proto smc_inet6_prot = {
 	.hash		= smc_hash_sk,
 	.unhash		= smc_unhash_sk,
 	.release_cb	= smc_release_cb,
-	.obj_size	= sizeof(struct smc_sock),
+	.obj_size	= sizeof(struct smc6_sock),
 	.h.smc_hash	= &smc_v6_hashinfo,
 	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
+	.ipv6_pinfo_offset	= offsetof(struct smc6_sock, inet6),
 };
 
 static const struct proto_ops smc_inet6_stream_ops = {
diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index f0cbe77a80b4..f713d3180d67 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -60,7 +60,7 @@ static int smc_rx_update_consumer(struct smc_sock *smc,
 				  union smc_host_cursor cons, size_t len)
 {
 	struct smc_connection *conn = &smc->conn;
-	struct sock *sk = &smc->sk;
+	struct sock *sk = &smc->inet.sk;
 	bool force = false;
 	int diff, rc = 0;
 
@@ -117,7 +117,7 @@ static void smc_rx_pipe_buf_release(struct pipe_inode_info *pipe,
 	struct smc_spd_priv *priv = (struct smc_spd_priv *)buf->private;
 	struct smc_sock *smc = priv->smc;
 	struct smc_connection *conn;
-	struct sock *sk = &smc->sk;
+	struct sock *sk = &smc->inet.sk;
 
 	if (sk->sk_state == SMC_CLOSED ||
 	    sk->sk_state == SMC_PEERFINCLOSEWAIT ||
@@ -211,7 +211,7 @@ static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
 
 	bytes = splice_to_pipe(pipe, &spd);
 	if (bytes > 0) {
-		sock_hold(&smc->sk);
+		sock_hold(&smc->inet.sk);
 		if (!lgr->is_smcd && smc->conn.rmb_desc->is_vm) {
 			for (i = 0; i < PAGE_ALIGN(bytes + offset) / PAGE_SIZE; i++)
 				get_page(pages[i]);
@@ -259,7 +259,7 @@ int smc_rx_wait(struct smc_sock *smc, long *timeo,
 	struct smc_connection *conn = &smc->conn;
 	struct smc_cdc_conn_state_flags *cflags =
 					&conn->local_tx_ctrl.conn_state_flags;
-	struct sock *sk = &smc->sk;
+	struct sock *sk = &smc->inet.sk;
 	int rc;
 
 	if (fcrit(conn))
@@ -283,7 +283,7 @@ static int smc_rx_recv_urg(struct smc_sock *smc, struct msghdr *msg, int len,
 {
 	struct smc_connection *conn = &smc->conn;
 	union smc_host_cursor cons;
-	struct sock *sk = &smc->sk;
+	struct sock *sk = &smc->inet.sk;
 	int rc = 0;
 
 	if (sock_flag(sk, SOCK_URGINLINE) ||
@@ -360,7 +360,7 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return -EINVAL; /* future work for sk.sk_family == AF_SMC */
 
-	sk = &smc->sk;
+	sk = &smc->inet.sk;
 	if (sk->sk_state == SMC_LISTEN)
 		return -ENOTCONN;
 	if (flags & MSG_OOB)
@@ -449,7 +449,7 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
 		if (splbytes)
 			smc_curs_add(conn->rmb_desc->len, &cons, splbytes);
 		if (conn->urg_state == SMC_URG_VALID &&
-		    sock_flag(&smc->sk, SOCK_URGINLINE) &&
+		    sock_flag(&smc->inet.sk, SOCK_URGINLINE) &&
 		    readable > 1)
 			readable--;	/* always stop at urgent Byte */
 		/* not more than what user space asked for */
@@ -509,7 +509,7 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
 /* Initialize receive properties on connection establishment. NB: not __init! */
 void smc_rx_init(struct smc_sock *smc)
 {
-	smc->sk.sk_data_ready = smc_rx_wake_up;
+	smc->inet.sk.sk_data_ready = smc_rx_wake_up;
 	atomic_set(&smc->conn.splice_pending, 0);
 	smc->conn.urg_state = SMC_URG_READ;
 }
diff --git a/net/smc/smc_stats.h b/net/smc/smc_stats.h
index e19177ce4092..baaac41a8974 100644
--- a/net/smc/smc_stats.h
+++ b/net/smc/smc_stats.h
@@ -108,7 +108,7 @@ while (0)
 #define SMC_STAT_TX_PAYLOAD(_smc, length, rcode) \
 do { \
 	typeof(_smc) __smc = _smc; \
-	struct net *_net = sock_net(&__smc->sk); \
+	struct net *_net = sock_net(&__smc->inet.sk); \
 	struct smc_stats __percpu *_smc_stats = _net->smc.smc_stats; \
 	typeof(length) _len = (length); \
 	typeof(rcode) _rc = (rcode); \
@@ -123,7 +123,7 @@ while (0)
 #define SMC_STAT_RX_PAYLOAD(_smc, length, rcode) \
 do { \
 	typeof(_smc) __smc = _smc; \
-	struct net *_net = sock_net(&__smc->sk); \
+	struct net *_net = sock_net(&__smc->inet.sk); \
 	struct smc_stats __percpu *_smc_stats = _net->smc.smc_stats; \
 	typeof(length) _len = (length); \
 	typeof(rcode) _rc = (rcode); \
@@ -154,7 +154,7 @@ while (0)
 
 #define SMC_STAT_RMB_SIZE(_smc, _is_smcd, _is_rx, _len) \
 do { \
-	struct net *_net = sock_net(&(_smc)->sk); \
+	struct net *_net = sock_net(&(_smc)->inet.sk); \
 	struct smc_stats __percpu *_smc_stats = _net->smc.smc_stats; \
 	typeof(_is_smcd) is_d = (_is_smcd); \
 	typeof(_is_rx) is_r = (_is_rx); \
@@ -172,7 +172,7 @@ while (0)
 
 #define SMC_STAT_RMB(_smc, type, _is_smcd, _is_rx) \
 do { \
-	struct net *net = sock_net(&(_smc)->sk); \
+	struct net *net = sock_net(&(_smc)->inet.sk); \
 	struct smc_stats __percpu *_smc_stats = net->smc.smc_stats; \
 	typeof(_is_smcd) is_d = (_is_smcd); \
 	typeof(_is_rx) is_r = (_is_rx); \
@@ -218,7 +218,7 @@ while (0)
 do { \
 	typeof(_smc) __smc = _smc; \
 	bool is_smcd = !(__smc)->conn.lnk; \
-	struct net *net = sock_net(&(__smc)->sk); \
+	struct net *net = sock_net(&(__smc)->inet.sk); \
 	struct smc_stats __percpu *smc_stats = net->smc.smc_stats; \
 	if ((is_smcd)) \
 		this_cpu_inc(smc_stats->smc[SMC_TYPE_D].type); \
diff --git a/net/smc/smc_tracepoint.h b/net/smc/smc_tracepoint.h
index a9a6e3c1113a..243fb8647cfe 100644
--- a/net/smc/smc_tracepoint.h
+++ b/net/smc/smc_tracepoint.h
@@ -27,7 +27,7 @@ TRACE_EVENT(smc_switch_to_fallback,
 	    ),
 
 	    TP_fast_assign(
-			   const struct sock *sk = &smc->sk;
+			   const struct sock *sk = &smc->inet.sk;
 			   const struct sock *clcsk = smc->clcsock->sk;
 
 			   __entry->sk = sk;
@@ -55,7 +55,7 @@ DECLARE_EVENT_CLASS(smc_msg_event,
 		    ),
 
 		    TP_fast_assign(
-				   const struct sock *sk = &smc->sk;
+				   const struct sock *sk = &smc->inet.sk;
 
 				   __entry->smc = smc;
 				   __entry->net_cookie = sock_net(sk)->net_cookie;
diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 214ac3cbcf9a..29e780aee677 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -66,9 +66,9 @@ static void smc_tx_write_space(struct sock *sk)
  */
 void smc_tx_sndbuf_nonfull(struct smc_sock *smc)
 {
-	if (smc->sk.sk_socket &&
-	    test_bit(SOCK_NOSPACE, &smc->sk.sk_socket->flags))
-		smc->sk.sk_write_space(&smc->sk);
+	if (smc->inet.sk.sk_socket &&
+	    test_bit(SOCK_NOSPACE, &smc->inet.sk.sk_socket->flags))
+		smc->inet.sk.sk_write_space(&smc->inet.sk);
 }
 
 /* blocks sndbuf producer until at least one byte of free space available
@@ -78,7 +78,7 @@ static int smc_tx_wait(struct smc_sock *smc, int flags)
 {
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	struct smc_connection *conn = &smc->conn;
-	struct sock *sk = &smc->sk;
+	struct sock *sk = &smc->inet.sk;
 	long timeo;
 	int rc = 0;
 
@@ -148,7 +148,7 @@ static bool smc_should_autocork(struct smc_sock *smc)
 	int corking_size;
 
 	corking_size = min_t(unsigned int, conn->sndbuf_desc->len >> 1,
-			     sock_net(&smc->sk)->smc.sysctl_autocorking_size);
+			     sock_net(&smc->inet.sk)->smc.sysctl_autocorking_size);
 
 	if (atomic_read(&conn->cdc_pend_tx_wr) == 0 ||
 	    smc_tx_prepared_sends(conn) > corking_size)
@@ -184,7 +184,7 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
 	size_t chunk_len, chunk_off, chunk_len_sum;
 	struct smc_connection *conn = &smc->conn;
 	union smc_host_cursor prep;
-	struct sock *sk = &smc->sk;
+	struct sock *sk = &smc->inet.sk;
 	char *sndbuf_base;
 	int tx_cnt_prep;
 	int writespace;
@@ -211,8 +211,8 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
 		SMC_STAT_INC(smc, urg_data_cnt);
 
 	while (msg_data_left(msg)) {
-		if (smc->sk.sk_shutdown & SEND_SHUTDOWN ||
-		    (smc->sk.sk_err == ECONNABORTED) ||
+		if (smc->inet.sk.sk_shutdown & SEND_SHUTDOWN ||
+		    (smc->inet.sk.sk_err == ECONNABORTED) ||
 		    conn->killed)
 			return -EPIPE;
 		if (smc_cdc_rxed_any_close(conn))
@@ -562,8 +562,8 @@ static int smcr_tx_sndbuf_nonempty(struct smc_connection *conn)
 			struct smc_sock *smc =
 				container_of(conn, struct smc_sock, conn);
 
-			if (smc->sk.sk_err == ECONNABORTED)
-				return sock_error(&smc->sk);
+			if (smc->inet.sk.sk_err == ECONNABORTED)
+				return sock_error(&smc->inet.sk);
 			if (conn->killed)
 				return -EPIPE;
 			rc = 0;
@@ -664,7 +664,7 @@ void smc_tx_pending(struct smc_connection *conn)
 	struct smc_sock *smc = container_of(conn, struct smc_sock, conn);
 	int rc;
 
-	if (smc->sk.sk_err)
+	if (smc->inet.sk.sk_err)
 		return;
 
 	rc = smc_tx_sndbuf_nonempty(conn);
@@ -684,9 +684,9 @@ void smc_tx_work(struct work_struct *work)
 						   tx_work);
 	struct smc_sock *smc = container_of(conn, struct smc_sock, conn);
 
-	lock_sock(&smc->sk);
+	lock_sock(&smc->inet.sk);
 	smc_tx_pending(conn);
-	release_sock(&smc->sk);
+	release_sock(&smc->inet.sk);
 }
 
 void smc_tx_consumer_update(struct smc_connection *conn, bool force)
@@ -730,5 +730,5 @@ void smc_tx_consumer_update(struct smc_connection *conn, bool force)
 /* Initialize send properties on connection establishment. NB: not __init! */
 void smc_tx_init(struct smc_sock *smc)
 {
-	smc->sk.sk_write_space = smc_tx_write_space;
+	smc->inet.sk.sk_write_space = smc_tx_write_space;
 }
--
