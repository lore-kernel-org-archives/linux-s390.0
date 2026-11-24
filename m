Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795490469;
	b=5olYNohwNwbr0O1IlPbswfliON4CJx0lz4apSLsylQ8qTVIpk1QIJFwoMhy8/R1Oq7cm
	 lxUODZgG20pJY+vwJx5GRkDDP6lmFRF0TdRVJLiKm9iDbYFIrvr42XJLZhT4uDxy16d6J
	 nItMqgMFCjqkM5GFkUF81Z/iEosSzpSjcm5B/tCava24b0Yy9W51pjII8J94mF9P+52kF
	 rzDOvNsYfWEP6oSQ4lSq0Fb0onBjAGIoslvo+Q4RUJyhPKItyBovffeV9bgeaKC/XUwdd
	 wtt5eq/BYnFZ5LOYCuPk3LRn9J7ELkX5LPfOV9gk0A3tNVpWAPfIIUgFHgk9+JPAFeg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=ZWDg+cYEzmZ1vYvzbJGAnTzFCORxgLKMXanTjf9ODFg=;
	b=gKQ8hiy44H6ZcjHhqc9HYn59So5F8+Gr6ADu1LdgEEMXZRxT1C66RjIQUVay7BsG1PDs
	 4zsmpchwHiGNSQvtI1tCjITPnhaxik7FaVzeVt3zPO1dXQAjnBdH+mYayU6QWXC8CGXWQ
	 lZYRmQchI4fzXmYeRRMP3yMGqYtljrqcNoCF5i4wb0+1cVjG0v8dgnjx99Ddf6jfFjBbI
	 Ce+DGy+fi9wgjUa2YdY0CRpdRkBjBGqgpmcSb4T8filAMOTwwga7MZvqPzxidTp9YyWv5
	 Dyxi3uG+rONA2SNN2t5z2ixTRE2c3s7adsgLuDMz3lFBCRLGTF9k9ar49gGkNXN51Lg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZA4ozIKd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E271606A31E
	for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2026 03:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E271606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZA4ozIKd
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-67db35e7953so4168503d50.0
        for <linux-s390@vger.kernel.org>; Mon, 23 Nov 2026 19:21:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795490467; cv=none;
        d=google.com; s=arc-20260327;
        b=nEb7ZkMnIfwV4za0OwkAyRIBNT4PIM2xlNbR+O2Ac+YvbrX9QqdpiyDFYt12QiHwQ1
         AOBtoR+lLMMDHyZf/RgqCrIG/Xvb0VQE02oLiMk2p5n65CxkMdZrPtDxRkdhK5fDXI+k
         OjGsvca9UhWqyXWRxk5K6ZkrwkJDFmY+ijErLePysIn21Z9RiqGclMQgFiY9uu+Lqj00
         1CUO0qrJ8DoqCiJ5jGUgv42a4W5y3sJMRBh09nCtZq23jIM3aVRI6Tenhug/V+r9wXIJ
         ZlewaE5gyRql/ahuxXODhIjF3o62KRj849L5gpS+GS3MR3BrWWOAOSOR+meJ8WTQCGhM
         xP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=ZWDg+cYEzmZ1vYvzbJGAnTzFCORxgLKMXanTjf9ODFg=;
        fh=6aKAPN6nnTCvVgPjKTgeaNSvBGHWiUb7p5Bi0k/l+bk=;
        b=hc5nrUZp7m4gbPWCsaFC7HE+4fliMBZGYnI45qjdOptBlCL2AZDBEVIl05488fPXGZ
         LK/FOf42iWuYSiYg9WG7Bu2HXem2llS0PwKdCNypeUp05Oy38ZLS3xS/aaPV4tCYT2EP
         wcUg6xnXwbFaPlA22skKgTvdgba1VMDoT1ZFFz0bqyeW84VFg8iAMyqyHyeDQx9DwHpo
         fDXm5GM7F9nllRTXypZW89v1mYJfUQh4cZ/uTjWulrwiZEXmPuHMWTNUdrOY1D79dfB5
         p4jgnMT9zcccCuvzWsQxFKUJ0AdpOiJX+DollH4gfoyzEuoGNR/vBsDMLlay52RDIkAv
         R1CA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795490467; x=1796095267; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZWDg+cYEzmZ1vYvzbJGAnTzFCORxgLKMXanTjf9ODFg=;
        b=ZA4ozIKdl81b1ff899siClY9b3FPWUK+FeslD9UvwKLAjcj3ZhON1AYyzagGeCHFnt
         82vZuTYRetYc5UdSeMtg20/XLuI74Kal1khr92UKfyMTnsqKq7hWmSNMKVJrm+g+Biel
         VjlzUV48TlPKI3/q7LWDDslWbXDJiVjPTr00k2tpdeDahIRxQcdf4bbkFI9rAwIu17KV
         jr80iJfN0LW9LqFMkYdxPJRMNylOmXAaaTpgOpnPHF9B4Ua6H1SymjsQw73LcGMdmkrp
         a85vYd+owM3tsi1JzmQaHeszwNwLSXQROcIxONXG87X31pGky31cVpgxrIWEFMfGOZRV
         Q+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795490467; x=1796095267;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZWDg+cYEzmZ1vYvzbJGAnTzFCORxgLKMXanTjf9ODFg=;
        b=AYln4m9npU/1L3YBpZgJNu9vU1fCfNLjqRTr3z0noVTiJw+qvF/kwnt1EsBd5gh1Ko
         e4vkzLpVVAA8ig9l7ADF3Qkk7EEKTrrEyMc0NJ+jIwOkIIFVu/aaO95dsHaDgUXxgtEp
         RmaZbejewe+uRrWWnvkIQkXbVFeSm/2B4AE+Ow511tEaCPLWhZmOWdR10sQJkDPkvoxm
         4BEzxGjmiFyHRR1YhIKrW9JXNEkS7DNblxEL+SJEjPolzpXM1yJ32KVtp+cjcBOGAAJW
         h6raqoMR7oS2wua13W4d5qT/msdalM+VkDVEf+8hPWBmkkyII6ZW77wrbmg2gV1M2yBX
         liyg==
X-Forwarded-Encrypted: i=1; AL+hErGDswqIWLAZdpG6M3MkWB4RGbs2GoeYVXxyf0mYIc6dXfB1yjmo4AHcUDjjz0hOr1SRuXIYiqn8iagH@vger.kernel.org
X-Gm-Message-State: APuU4Z/T/XpWmnTh9JSI36hlk/LVMoQ1DHYR4O+CctTM2jFeggjai5Hd
	tTM5H2XiJjskI/bb6UCWBCcWf6aaTGz4r+/xmbwIm6IE+6Od3tLskRL8nj9Nx56THpe6j8/+A+y
	Z7kawQYf4XXCKey04DvWUACvEE7OW2jg=
X-Gm-Gg: AZFdTZc2q3nl8LgSAk/O4CCSpRP8pdImFUmN07DtbPJf6nepqc+85XIZUtwiyOcidpr
	yo39lR+hC68iB1476uB1UoIMQnapgKiHjZa0N3eqr4GqL8ia6KeNlLulGDgqEAwNRDvKHGAAoVn
	GwxhmDT6hi/lBDaxVsfky59kdCGaVSFmZZzF+YCBEHwR4pzwsTCyDtxi7EfAR1I1TIk/edt9G9x
	NOtvApY/XPHK++DLmBH3RQ1ywoSx3wSP1qQinlEJb6OPsvbiT2SLgNAe4tJ+OSNLiF501x78PYv
	JmgpxzhccnSMCMvwdMs+b/n8HNTnJLgDutSDs7Vqm2N/jdDIuN8YdMZFxrxZo/RJ2jVynpjxi/n
	L8MVXX2EaA99PyXKFZoDL5o7efgPFZxTVhEp5ihux7V6fPJTmE0r+498ejg==
X-Received: by 2002:a05:690e:1905:b0:67b:e67a:da38 with SMTP id
 956f58d0204a3-67df4423620mr4510969d50.21.1795490467284; Mon, 23 Nov 2026
 19:21:07 -0800 (PST)
Received: from 723974502065 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Nov 2026 19:21:06 -0800
From: Qican Ma <goonsomeway@gmail.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 23 Nov 2026 19:21:06 -0800
X-Gm-Features: Aa3M54oi5W3hts7IvD6RqrKWmrg1C4_Je8YHGmDB5ytcVLRAJrf4yW87opup_rg
Message-ID: <CA+OT+OPkNsk2QHczVmb6KVJ+z_1tpH9DXm8JmACc5E6x-YFwPA@mail.gmail.com>
Subject: [PATCH net] net/smc: serialize clcsock release against CDC receive path
To: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, mjambigi@linux.ibm.com
Cc: tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

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
@@ -428,7 +428,8 @@ static void smc_cdc_msg_recv(struct smc_sock *smc,
struct smc_cdc_msg *cdc)
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
