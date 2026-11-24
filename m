Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795505359;
	b=npNrg6iDoj7O1tolTniws6/m6vxnKInN4+gQE/bMwYhlmEHiATQ8uOXUZlv4+1QP1aXq
	 Ypcsp3xoHFoD4MTwNk56xD1ILNtI5m5vHOWTt3yciyEp596PZD4jfllEcqBvcgEt6XeN4
	 yA7KdhPB51E06TUhvOWx9y/IvY2SLoPKU+OdbwS3MBh5rVXr+0ipNM/8V5IOMrKYevU5H
	 QZeAgLY/QYqBI/bL2XCZW06oKiXkTK4AnIz4guWmrMJLTcHRfaZ+VY9zgivBOt6H3focV
	 Kq68JmfLXQdVBsFPPix1/Xbpd4D3mYf84can9tFVr4I++MyY39m97IUR0AO9NjUeFBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ff/cIHvuBVZnx7utLGrJmn640e8Haj+dm0NKl1pXUuU=;
	b=Xd35Hn5HOJjM7HAqZ/gYN2+wjEX7sfrJxSDP8zgXTjthW5rRmjELbGPj+ncDEF162vA4
	 /tkJz2JdPkC6Z1MIwsZVIV30avUG+fF7jtzGxy80tMkf5Vc9jcSQTRJUvJIWoOwzX8Oxv
	 1d6CqWfAqpgm2BaP+m0kSGKvCql0bBvMjYDMtlwwGo2IXOXkhgdGytvgGFviJ5j5efhXj
	 cH7WWMjc82ZXVdd3CMpEpBdjHoN6+3K6k4JIOFPwD8NuQRwJSEN/kXGIm+JWiKk99fJOq
	 O7VSp8Q5sSo5TRAY+0cZj9WljbSjjmAQcZodZEW2UCjrvX6ynNcpGJCUap31032e2BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ucmqpqnc;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFBB606A322
	for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2026 07:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACFBB606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ucmqpqnc
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cde1479f76fso2483438a12.0
        for <linux-s390@vger.kernel.org>; Mon, 23 Nov 2026 23:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795505358; x=1796110158; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ff/cIHvuBVZnx7utLGrJmn640e8Haj+dm0NKl1pXUuU=;
        b=Ucmqpqnccjbj9PdQI0KJdYkmVPKb+A5q5QJjFGTEwbdad1o7vHAeliODepnaNiZQYw
         NJWztHrCr7wSYoNJTuSbQaFeF+vXmScRy5evJUEYUlZitg1QD75jY/bEN8NzqewwEfyp
         4/EkxePwiIse+km5wckl8e4xHoOaTyKL2PakL+UIyU1hTDRJkwmup9w/SwyCA+k0JKuT
         S7b/EtLoVLdTn5IgnxBxP/ARnxYNQlSsr+YhvMDc95IIphEtfxbE/CMKA6Xu9+/r7iLd
         jAQRASOlUP24itkMrQMxQ2sIzsMKi+FCMHfXqTnNrA2AJalwpf7DKQQgNF/Eso7sL6M1
         X+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795505358; x=1796110158;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ff/cIHvuBVZnx7utLGrJmn640e8Haj+dm0NKl1pXUuU=;
        b=LHjtdi0UubTDBP4pElnLaceLQM+ZpDqRU7BUwK+mipC4c+0MgDEIpeYNOURqLzt0v4
         4wvPz/bNNn1Okw31qBqnpljRgynskAn/PDYPEr6DtZ2cIuexUTDQ0MQXpb0R9cLEdSIe
         IQZ81gsc2Kank0bfXpJUr9zU8zM7ZpZN3UzbeFmkiwadqG0XNTfy0s8tqM3ZJ2Tmlw2b
         CQOXl4emQYnXCSf3oZ3V6EnlTNZ8OMgGUvmiY4LRQro1sIOEBsWdB1uAUdzoK5UnHmSN
         mx3wKgvcAyuie2q0uXz+yN70/RfnbAMcylBiNW7q53A1KFgEdj8NKdClLkrObTBO75ud
         Q+tw==
X-Forwarded-Encrypted: i=1; AL+hErHGULN6+LuVqKuzwvciWVsqJWFYgyJNSCR65m5yzhIlH6f0rM3FkVzRbWfGj35hJQU1mnVRrAANcRWv@vger.kernel.org
X-Gm-Message-State: APuU4Z/ktb1OX/4vfUZ4adMTLfY3djFjjBU2ld3p9mMi3Zxykz1vqEcv
	p3Fjz30UcyJO8ncl7Q53p56bFfpRf9mH/n4k4YIAedEh/RYShqAy+03r
X-Gm-Gg: AZFdTZckEp0u0Y65x9VabsnmVp3rdnBRH1InQ+Npvdjv1NH2aU6h+JTsMzF6G/eSGw2
	WCm1SyUYFzyX9Qag9l1E5W4RfKYxVP479euxsoJifxj5y7Z7oSUSC47t/jjm/+ydXMnpR4ozzAe
	/h696CF+bu6Gi8ZO/XqhJ80iRXzEkaY2UVSpgyrm4RjnMsvUAmrfBsViHeFQXONYtrPEG/ysm5o
	OFJJXZ7BJELFHkulOS2vDXAtEh68j8P5ZfH8CTdyJi116CZmWMvgb7Ww3IDRfipBf4PCDfSyQcj
	xmJHEeYiDeykhJaRJ7MzBwldmZCWcGuOP557+lteaShvIvbhVSQuaGEfFDygIg8BUId4zrngd43
	L1iWWP9CnshijyTVSvYx7OiOXlw7MMe7VDasQ8H+kMVEjg1uqB0/hwH6utXycYIzcmNbUdLJZBh
	ICwva/qiuiCM9vua9ItMxgQUxK6iDa6SqZa11mV92A07skGuNxktl6dWpkSIU70+SbZTf8yLX6A
	H7i7C77GBwEFlE7dR4VN9IMAknVCJoNK3IRmqURaqIOICvkoFZaQ1ioVeWk+1kIY4+dAAXKvh6u
	NYoylT0Lycl9yHERywrQNrsd5UAD2VxNT3yAoNZ6wFREZw6+TdN41NZwR4ibEOBLUU0vtcIIXkC
	2Epwet+CDViwlfxErKxKQ8+OLKT0ZpXcCVxoG
X-Received: by 2002:a17:90b:2c87:b0:3b0:9e42:b67c with SMTP id 98e67ed59e1d1-3b41c96ed40mr12458674a91.61.1795505357803;
        Mon, 23 Nov 2026 23:29:17 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([43.224.245.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4b0f482bdsm5930398a91.14.2026.11.23.23.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 23:29:17 -0800 (PST)
From: Qican Ma <goonsomeway@gmail.com>
To: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, sidraya@linux.ibm.com, mjambigi@linux.ibm.com
Cc: tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net v2] net/smc: serialize clcsock release against CDC receive path
Date: Tue, 24 Nov 2026 15:29:11 +0800
Message-ID: <179550535135.21127.16258389542236461283@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

In smc_cdc_msg_recv_action(), receiving a close or senddone flag writes
RCV_SHUTDOWN to smc->clcsock->sk->sk_shutdown while holding only
bh_lock_sock(&smc->sk). Meanwhile __smc_release() drops the socket lock
and calls smc_clcsock_release() (which clears smc->clcsock and calls
sock_release() under clcsock_release_lock) before calling
smc_conn_free(&smc->conn). Even on paths that call smc_conn_free() first,
an in-flight SMC-R softirq that already looked up the connection in
smc_cdc_rx_handler() can still enter smc_cdc_msg_recv() concurrently with
smc_clcsock_release() and dereference or write through a freed clcsock.

Free the SMC connection before releasing clcsock in __smc_release(),
matching smc_close_active_abort() and smc_close_passive_work(). Because
smc_conn_free() sets conn->freed = 1 while lock_sock(sk) is held and
release_sock(sk) synchronizes on sk->sk_lock.slock before
smc_clcsock_release() runs, checking !smc->conn.freed under
bh_lock_sock(&smc->sk) in smc_cdc_msg_recv() guarantees that no CDC
handler accesses smc->clcsock once smc_clcsock_release() can start.

Found with an LLM-assisted code review tool and verified by inspection on
v7.4-rc4 (b6a9fa34ce4). Build-tested only; not runtime-tested due to lack
of an SMC-R/SMC-D setup.

Fixes: b38d732477e4 ("smc: socket closing and linkgroup cleanup")
Cc: stable@vger.kernel.org
Signed-off-by: Qican Ma <goonsomeway@gmail.com>
---
v2: resend via direct SMTP to fix line-wrapping corruption in v1;
    verified clean git am on net/main both standalone and on top of
    Bryam Vargas's v9 CDC cursor bounds series.

 net/smc/af_smc.c  | 4 ++--
 net/smc/smc_cdc.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index bfc0c7e71a1..1d8a602729c 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -313,13 +313,13 @@ static int __smc_release(struct smc_sock *smc)
 	sk->sk_prot->unhash(sk);
 
 	if (sk->sk_state == SMC_CLOSED) {
+		if (!smc->use_fallback)
+			smc_conn_free(&smc->conn);
 		if (smc->clcsock) {
 			release_sock(sk);
 			smc_clcsock_release(smc);
 			lock_sock(sk);
 		}
-		if (!smc->use_fallback)
-			smc_conn_free(&smc->conn);
 	}
 
 	return rc;
diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 32d6d03df32..499a2473b79 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -428,7 +428,8 @@ static void smc_cdc_msg_recv(struct smc_sock *smc, struct smc_cdc_msg *cdc)
 {
 	sock_hold(&smc->sk);
 	bh_lock_sock(&smc->sk);
-	smc_cdc_msg_recv_action(smc, cdc);
+	if (!smc->conn.freed)
+		smc_cdc_msg_recv_action(smc, cdc);
 	bh_unlock_sock(&smc->sk);
 	sock_put(&smc->sk); /* no free sk in softirq-context */
 }
-- 
2.50.1 (Apple Git-155)

