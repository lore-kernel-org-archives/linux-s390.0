Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178B93D8128
	for <linux-s390@vger.kernel.org>; Tue, 10 Mar 2026 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165282; cv=none; b=HaNoBUk/OB+IuC9Wtqh6IZM6ezXsiaOwmDTgQzbKL9vqJhq7OcCMs0unwEPFL2PARomNNArjfem8jRz0kSx8YjEH2lKoH8SDPpmk6hTzWbSXT6HulxBkkE6vmWmZajsxojTGyTuFCu79Vol7c0jN8vV+YdAasjls5UfpIONd9AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165282; c=relaxed/simple;
	bh=tpIcoWuPSsflrFdJ37N7ykid+E9spThfaWn0fNKRhgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jfkEPOMU/6C4o1V9Chn6/1aVWijLA85VUX3mI+hN7/Qv6Qg0auUGiXkzKEw/MEH84RZGjSzFoQpb0AhmQj5MboakMBYfrN7gS2jBaMWGLPz5z4AG4HDnvbkGqudVvcw7tmlL3vmh4NaFKPq700QD3uwWXLdBmKsBzlYhXEIZoAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iI+Ftvvo; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iI+Ftvvo"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79800183233so2403847b3.1
        for <linux-s390@vger.kernel.org>; Tue, 10 Mar 2026 10:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773165280; x=1773770080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5DX7YX3olkxxd54BvAn1gDzrrUOGFvO/gswDwkhEoMI=;
        b=iI+Ftvvo1Vq6vn0KL8HprpuN7cBPPNq25MlSL3nsmTaoYutg/YmHGkeQK17yZm1iZZ
         OKwTEeSuOg8fQxnDgIFLvci8O67ASlmQ/+dYJdHgoVZElUSIxy1o7AzSgoU/ns1atoeY
         N/OGLdbG/YbE7Lxz5uABfC+1Somo4m4lGpgwjuFVRBCPsiqcc11O8oj7N5B3SHvvDYem
         4z8laTLMITpbYgS9GQ6W7L7JJgCswGHYWioWbk1hrwN7yDmAiclYCHpAXL8eVyvayPuI
         ZEiyHhVIYEFfhOP2UpZ3WJkbIv2JzoO0RHvlRLaCANNXYvghdDt/F9BXtn/ZQLDSmMyT
         E0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773165280; x=1773770080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DX7YX3olkxxd54BvAn1gDzrrUOGFvO/gswDwkhEoMI=;
        b=hVZnkEit5uprtz5wMxpF+7nzX3xZfp8GS5Rm87ffZ3qoR6BOQxA7y+UYnB/CSg5/Np
         kHGFYFddNm+jtt9idP+tRi8j1C9hI9nJW4A+4+pkGPhLdxunjOcIwse5BKsYNcRT3pZ8
         p2cD6jNrF8wgePTmNxtT9KumFJcVt1IamVRA1r2P59KObsraxJpm2lQNfiVtopJvemMC
         hA6yGucwrL6LuNVLiZCqRyD+E+/pzve3PwG2oS6FQFUEHXMc50PZdnQJRknFUuR801G+
         lvxlj/vhXqW/1FTTaQnmrSjFyBrC0o0Dmf3jRllsQaHfx61wAMCdNH8DbvvZvcJeZQZf
         pgNg==
X-Forwarded-Encrypted: i=1; AJvYcCXlpjDQRjLFgpTHA7iU7GmaSH3mQGG3MxMEulyOz+5Ky0sX9h3hmBnJGPwshiC89CcLx0WBZvbdp4lA@vger.kernel.org
X-Gm-Message-State: AOJu0YysQ+kOglQ5M5O+ge6Ts2fs1RZWPFI4ojRhLbuvzOef1k0wWy89
	f03M4BFcWB6J/IUgj1+E6iTQi0pgyMhePoWNQMF62xSYK1sKV0xxrlHp
X-Gm-Gg: ATEYQzxsltlr8ThnvqsIaaYl7Q4SzLv69Mxj1U2q1PmpYaawAdIAS0wawBOGsu1CoXj
	7UWpwgBGqXCJbIg4ZQD01tZOwT48MTu5X+VPHBIalyNGJQ9fLHJjLZKoCIBn63B9i0GZctVryB+
	lfhr/qqYdD60tru/TzAO866CHpi2I/0OIgfEh21MPjLGuCpYFqUz7FhMgHZhsG7S1G4CgG8g0Jp
	70q0NxNWbxbitgB56Y0JoN7wdyYN3EX/ykuAR/RxPVy0DBoN8ZpOlCAsSBXCCOphpQYpprMchQX
	86A+q8qX6OJvmF3GjG/7bGTjkOOMHicOBkNjlCfo3TYVuwV5SNKjv+FF80H/6ADfRcEXObxQJm1
	K1new2hOz7XbROKr4FvueiMaYbekoBEg+j/sHRvkSzSIHfrMYBKsgZP8K2CaMuxhjZzDipDhVpI
	/ss7PIvB+BTIYsFYbQwt7SWVdTCvWT6zsEktlmnnEwA0vkvWN17AoxdNdS
X-Received: by 2002:a05:690c:6913:b0:798:5bb7:4982 with SMTP id 00721157ae682-7990a86998emr40492057b3.16.1773165280041;
        Tue, 10 Mar 2026 10:54:40 -0700 (PDT)
Received: from desktop-linux.python-stargazer.ts.net ([50.168.180.218])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7990a676fedsm19799977b3.42.2026.03.10.10.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 10:54:39 -0700 (PDT)
From: Mehul Rao <mehulrao@gmail.com>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com
Cc: mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Mehul Rao <mehulrao@gmail.com>
Subject: [PATCH net] net/smc: fix NULL pointer dereference in smc_tcp_syn_recv_sock
Date: Tue, 10 Mar 2026 13:54:26 -0400
Message-ID: <20260310175426.110496-1-mehulrao@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smc_clcsock_user_data() can return NULL when the listening SMC socket is
being torn down concurrently. During close, smc_close_active() sets
sk_user_data to NULL on the underlying CLC socket before shutting it
down. If a TCP SYN completion arrives in this window,
smc_tcp_syn_recv_sock() is called from softirq and dereferences the NULL
pointer when accessing smc->queued_smc_hs.

The sibling function smc_hs_congested() already handles this case by
checking for NULL and returning early. Add the same NULL check to
smc_tcp_syn_recv_sock().

 BUG: KASAN: null-ptr-deref in smc_tcp_syn_recv_sock (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 net/smc/af_smc.c:136)
 Read of size 4 at addr 00000000000006b0 by task poc-F362/154

 CPU: 2 UID: 0 PID: 154 Comm: poc-F362 Not tainted 7.0.0-rc3 #1 PREEMPT(lazy)
 Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
 Call Trace:
  <IRQ>
  dump_stack_lvl (lib/dump_stack.c:122)
  kasan_report (mm/kasan/report.c:597)
  ? smc_tcp_syn_recv_sock (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 net/smc/af_smc.c:136)
  ? smc_tcp_syn_recv_sock (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 net/smc/af_smc.c:136)
  kasan_check_range (mm/kasan/generic.c:186 (discriminator 1) mm/kasan/generic.c:200 (discriminator 1))
  smc_tcp_syn_recv_sock (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 net/smc/af_smc.c:136)
  tcp_check_req (net/ipv4/tcp_minisocks.c:927)
  tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2245)
  ip_protocol_deliver_rcu (net/ipv4/ip_input.c:209)
  ip_local_deliver_finish (include/linux/rcupdate.h:883 net/ipv4/ip_input.c:242)
  ip_local_deliver (net/ipv4/ip_input.c:259)
  ip_rcv (net/ipv4/ip_input.c:573)
  __netif_receive_skb_one_core (net/core/dev.c:6164)

Fixes: 8270d9c21041 ("net/smc: Limit backlog connections")
Cc: stable@vger.kernel.org
Signed-off-by: Mehul Rao <mehulrao@gmail.com>
---
 net/smc/af_smc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index d0119afcc6a1..bb8966eeb332 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -132,6 +132,8 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
 	struct sock *child;
 
 	smc = smc_clcsock_user_data(sk);
+	if (!smc)
+		goto drop;
 
 	if (READ_ONCE(sk->sk_ack_backlog) + atomic_read(&smc->queued_smc_hs) >
 				sk->sk_max_ack_backlog)
-- 
2.53.0

