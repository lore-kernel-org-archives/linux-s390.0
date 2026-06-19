Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E6E2853F3
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881437; cv=none; b=gu3UX1t9OypaFQaBavFgaP5xIwlnaQWrGm/M01pVmFkS82nxetij4cRvyF5cI7ktKQW8Ni2NY7cSNs8xoNP1ioeHSDk5A+M60ZGa8aSl3gY4V+pSlW7h64OteJv8qKybQPpWtugKRo349CCyxF+tK3AoJoOMgoiKbibWHn7C8pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881437; c=relaxed/simple;
	bh=n0TaIFU2dlUiY6Vzb+eElnBvXKO/Y+F2CeNOmOSDEpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UrEdBl/jiaR/i8kv/rypc0wSP7951wn5m9+4Yeak3OXfNFCzux8xUAzLRFLRFeij8hO3qSep1xdLaAJBBCz+erg5Owe8eXq/JtU5PVk/P6IGJmXsKmbAmPPGltZoFMlALjQZsXWDNtOrBFe1Ju/4lk0JkcbE612gAowQ/X0DjTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icaPiIDi; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icaPiIDi"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84347ad88edso1857389b3a.1
        for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 08:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781881436; x=1782486236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p5fF29AhKZUYQkqmksxc4GcdOoLjfu8vsoNrkddfAwM=;
        b=icaPiIDia+iWmEFhB2Z748fn+YVVv6PPRnGMgZMay8iUtTkG7gu1SsqMAw7Skq6vFo
         Aij2rIUYIY5Ft41A0gg2hN0XapAOQGCSm18cZOvew193TwvFWFpbVnPph7wBqub0Q2p4
         Scy1nT3lyVvtRb3bVrddCUwlYbM8K+sT1hdyLtpsjHi/70Ro9zaP3T4AVhhtny0DTdnC
         67LXG+zPFF4ZGoP4zz+3V3M0gFWkKlmdRfKif61AeWvLVLkpgXokbEN6zejedbmUlcoU
         wcBQKVfRezT3RJV52pp/0ptJ6lzVx8rxxSpJssrV7K+G2OpIDj6uYs4sjJPd+Mxa1Gt4
         nlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781881436; x=1782486236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5fF29AhKZUYQkqmksxc4GcdOoLjfu8vsoNrkddfAwM=;
        b=sHd9WFDTIXmn98nA59ARPbcnLUKvVInFzf8qB9CNfY1D8U2mPZkYDt7BfsFwU1Go/3
         +MnCPZpTMaLl14t/fHkMGkNYZ1hjR0l33tdnVMBAXvHAe+S2Sancdk6THKqLOOTeLDUg
         iDzaXw8ovUMcAtqC+YbO3UGceKUWk1As++3NhHV4XkP+Ds6bH1f3gF60yySvpIxQaPnZ
         slk1YvPeZ4i/5YMGt7COASjdQnlhfg5KYYYHSzegduW8DB3G8GlV02G17cBvTkIM+b9N
         CLdq9seq/6gB2eZTJs98wPPlTINttjkPFu7Vyh7+XOOu59xw3JXjZWiIY9AiO/EAuraq
         0Sbg==
X-Forwarded-Encrypted: i=1; AFNElJ88SaXMP9qHIYWOh9SerC2FmtnVbq0fYCKxHfzYdUTK15WoaGyt+pbjNOPSc2txfEqp3B7VVYVpbTu6@vger.kernel.org
X-Gm-Message-State: AOJu0Yylsbv+NeK5S5TVfPkmCKqoI4l4qDJ4cv0ofnDo18JV6DAWsavU
	L8F/eT43F2PLQjSSByYyaFnXktf9EvCp2JjjRAs74oIRmZQIkCvnhksT
X-Gm-Gg: AfdE7ckOkZ+GE0iV/L8HYaLXT1AcfMM6MJktn786jjCYezTD06PuvVluL0f/kRt8wUZ
	e18YlMGgTGC7fF+CWvSVwYMuMFlbfdJNZDi4XIzRXtlajAzchwGIjDZs37aj/WCtM13S5MJHpxI
	mzSGv7rPtnprlAm2LBW7xYwU6YQ4tjXUAQe5aSgCZ53G0RuqnBJiJMYRwdN9UTabZi9eDu7YFkE
	vN4cI4O+l2hNG8Dy0MsmbwfyCZJ+EmSBYmdqpbxghSOMr+1sPz9UU79KxT/IrdjB1G0PEkgGcXK
	Em4CC/SI94TMMEgDyu7ROBuV1M3MTWSw/EmyPdxn6Z/1VGjaE1XhxeWJvaNkWeDGEkX26AiBXoN
	IuZ8rxELb5YPBsjwA9oZHP6MsJjx+PxKZCV5dT0R88+PpJ6NTkJG6oOSKiK2Pby5aawowa5B39V
	VWcHSbi16I2hejPkx3njS7T1ljc/TAFF4RCjrz5yyuTeI0eG+oyR0=
X-Received: by 2002:aa7:8882:0:b0:842:7e7f:2914 with SMTP id d2e1a72fcca58-8455078a5a4mr4177673b3a.4.1781881435832;
        Fri, 19 Jun 2026 08:03:55 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8455366ec53sm2844747b3a.13.2026.06.19.08.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 08:03:55 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: "D . Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Simon Horman <horms@kernel.org>,
	Ursula Braun <ubraun@linux.ibm.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Guvenc Gulce <guvenc@linux.ibm.com>,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net v2] net/smc: fix out-of-bounds read when sk_user_data holds a sk_psock
Date: Fri, 19 Jun 2026 15:03:41 +0000
Message-ID: <20260619150342.3626224-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SMC stores its smc_sock in the clcsock's sk_user_data tagged
SK_USER_DATA_NOCOPY and reads it back with smc_clcsock_user_data(), which
only strips that flag. sockmap stores a sk_psock in the same field tagged
SK_USER_DATA_NOCOPY | SK_USER_DATA_PSOCK. Nothing keeps both off one
socket, and SMC then casts the sk_psock to an smc_sock.

A passive-open child hits this. It inherits the listener's
smc_clcsock_data_ready(), but sk_clone_lock() clears its NOCOPY
sk_user_data, and a BPF sock_ops program then adds the child to a sockmap,
installing a sk_psock in that field. The inherited callback reads it as an
smc_sock and dereferences a clcsk_* pointer past the end of the sk_psock:

  BUG: KASAN: slab-out-of-bounds in smc_clcsock_data_ready+0x84/0x200 net/smc/af_smc.c:2637
  Read of size 8 at addr ffff8880013b8674 by task syz.6.12484/67930
   <IRQ>
   smc_clcsock_data_ready+0x84/0x200 net/smc/af_smc.c:2637
   tcp_urg+0x24d/0x360 net/ipv4/tcp_input.c:6264
   tcp_rcv_state_process+0x280d/0x4940 net/ipv4/tcp_input.c:7336
   tcp_child_process+0x371/0xa50 net/ipv4/tcp_minisocks.c:1002
   tcp_v4_rcv+0x1eaa/0x2a00 net/ipv4/tcp_ipv4.c:2186
   [...]
   </IRQ>

  Allocated by task 67930:
   sk_psock_init+0x142/0x740 net/core/skmsg.c:766
   sock_hash_update_common+0xd3/0x990 net/core/sock_map.c:1010
   bpf_sock_hash_update+0x114/0x170 net/core/sock_map.c:1229
   __cgroup_bpf_run_filter_sock_ops+0x74/0xa0 kernel/bpf/cgroup.c:1727
   tcp_init_transfer+0x1085/0x1100 net/ipv4/tcp_input.c:6693
   [...]

sk_psock() already guards the other side, returning NULL unless
SK_USER_DATA_PSOCK is set. Make smc_clcsock_user_data() and its RCU
variant return the smc_sock only when sk_user_data carries SMC's tag
alone. A sk_psock then reads back as NULL, which the data_ready and
fallback callbacks already handle.

Fixes: a60a2b1e0af1 ("net/smc: reduce active tcp_listen workers")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/smc/smc.h | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 52145df83f6e..88dfb459b7cc 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -342,13 +342,25 @@ static inline void smc_init_saved_callbacks(struct smc_sock *smc)
 
 static inline struct smc_sock *smc_clcsock_user_data(const struct sock *clcsk)
 {
-	return (struct smc_sock *)
-	       ((uintptr_t)clcsk->sk_user_data & ~SK_USER_DATA_NOCOPY);
+	uintptr_t data = (uintptr_t)clcsk->sk_user_data;
+
+	/*
+	 * Return the smc_sock only if the slot carries SMC's tag alone.
+	 * sockmap stores a sk_psock here tagged SK_USER_DATA_PSOCK; it is
+	 * not an smc_sock and must not be dereferenced as one.
+	 */
+	if ((data & ~SK_USER_DATA_PTRMASK) != SK_USER_DATA_NOCOPY)
+		return NULL;
+	return (struct smc_sock *)(data & SK_USER_DATA_PTRMASK);
 }
 
 static inline struct smc_sock *smc_clcsock_user_data_rcu(const struct sock *clcsk)
 {
-	return (struct smc_sock *)rcu_dereference_sk_user_data(clcsk);
+	uintptr_t data = (uintptr_t)rcu_dereference(__sk_user_data(clcsk));
+
+	if ((data & ~SK_USER_DATA_PTRMASK) != SK_USER_DATA_NOCOPY)
+		return NULL;
+	return (struct smc_sock *)(data & SK_USER_DATA_PTRMASK);
 }
 
 /* save target_cb in saved_cb, and replace target_cb with new_cb */
-- 
2.43.0

