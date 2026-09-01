Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B883955C3;
	Tue,  1 Sep 2026 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253553; cv=none; b=X0JhHVKulEJMrnuZRAZEdQFDco4yjsMW74VZ0Yw065f70RdkcsHb/ky9kuAQxI1DBwreM5Z+Fi19Z7oy2qSnkvzFGkz1oSUmw+7SWBULWQpM6sew9/0EvnpJLGcitopi973/NMKjOGjHmmpa/h4GzBIqyr/g9ZIBAVsJSPl/JOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253553; c=relaxed/simple;
	bh=tx+BXv8FdJTOqroRusEgS7WxHl7Hlq864y2qJKfbL2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eEusSfbgZBNItLEUbbpRfunUxxQLFkfhUsgXKzuxXh+gX1WvRnl2Zxa4ou/mlyd/yAV7tH0EMH+nCvXGsZ0oBW92X08nxWBMiQFr70kjRrmTSMxWe9nEnKkqL+WB2sTWj+cUKo2NNdha2RKrHQoQMhAPEn9UlJteoYlK66S6/uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=JL9zg82M; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="JL9zg82M"
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1788253545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bEnHDKcXLyTKDgscSQ2cRAL+7EnQmBfBqSJoXXxrq7k=;
	b=JL9zg82MHRd7pK9alIJ8BKW0UoCzNQGeWxrWNBThDPzERk0V38yvjJNLiHtLTTbydPacVa
	CHHVwxaOl0lzJUSSfXovZUoFvGd2y4skGGCsS0UhgbOOJ/YNjNYykH9MfHqwMFokH4nb7C
	08V/FHs8sXir2kdJ7SmGgPqksuKqV8E=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Karsten Graul <kgraul@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Ursula Braun <ubraun@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>
Subject: [PATCH 5.10] net/smc: fix potential panic dues to unprotected smc_llc_srv_add_link()
Date: Tue,  1 Sep 2026 12:05:43 +0300
Message-ID: <20260901090545.10419-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "D. Wythe" <alibuda@linux.alibaba.com>

commit e40b801b3603a8f90b46acbacdea3505c27f01c0 upstream.

There is a certain chance to trigger the following panic:

PID: 5900   TASK: ffff88c1c8af4100  CPU: 1   COMMAND: "kworker/1:48"
 #0 [ffff9456c1cc79a0] machine_kexec at ffffffff870665b7
 #1 [ffff9456c1cc79f0] __crash_kexec at ffffffff871b4c7a
 #2 [ffff9456c1cc7ab0] crash_kexec at ffffffff871b5b60
 #3 [ffff9456c1cc7ac0] oops_end at ffffffff87026ce7
 #4 [ffff9456c1cc7ae0] page_fault_oops at ffffffff87075715
 #5 [ffff9456c1cc7b58] exc_page_fault at ffffffff87ad0654
 #6 [ffff9456c1cc7b80] asm_exc_page_fault at ffffffff87c00b62
    [exception RIP: ib_alloc_mr+19]
    RIP: ffffffffc0c9cce3  RSP: ffff9456c1cc7c38  RFLAGS: 00010202
    RAX: 0000000000000000  RBX: 0000000000000002  RCX: 0000000000000004
    RDX: 0000000000000010  RSI: 0000000000000000  RDI: 0000000000000000
    RBP: ffff88c1ea281d00   R8: 000000020a34ffff   R9: ffff88c1350bbb20
    R10: 0000000000000000  R11: 0000000000000001  R12: 0000000000000000
    R13: 0000000000000010  R14: ffff88c1ab040a50  R15: ffff88c1ea281d00
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #7 [ffff9456c1cc7c60] smc_ib_get_memory_region at ffffffffc0aff6df [smc]
 #8 [ffff9456c1cc7c88] smcr_buf_map_link at ffffffffc0b0278c [smc]
 #9 [ffff9456c1cc7ce0] __smc_buf_create at ffffffffc0b03586 [smc]

The reason here is that when the server tries to create a second link,
smc_llc_srv_add_link() has no protection and may add a new link to
link group. This breaks the security environment protected by
llc_conf_mutex.

Fixes: 2d2209f20189 ("net/smc: first part of add link processing as SMC server")
Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[Denis Arefev: adapted for 5.10: smc_llc_srv_add_link() has no 
req_qentry argument here, as SMC-Rv2 REQ_ADD_LINK support is
not present in 5.10]
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
Backport fix for CVE-2023-54237
Link: https://nvd.nist.gov/vuln/detail/CVE-2023-54237
---
 net/smc/af_smc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index e9dabe758a31..e76e71417a2c 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1303,8 +1303,10 @@ static int smcr_serv_conf_first_link(struct smc_sock *smc)
 	smc_llc_link_active(link);
 	smcr_lgr_set_type(link->lgr, SMC_LGR_SINGLE);
 
+	mutex_lock(&link->lgr->llc_conf_mutex);
 	/* initial contact - try to establish second link */
 	smc_llc_srv_add_link(link);
+	mutex_unlock(&link->lgr->llc_conf_mutex);
 	return 0;
 }
 
-- 
2.43.0

