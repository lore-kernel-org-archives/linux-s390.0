Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267651AB6D5;
	Thu, 12 Sep 2024 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152202; cv=none; b=mhKuuewfrJ+okDPsnFe9kMZJjgmnMbGVZNIaX1Tdznb8lkaCm7MB/oTz+zYr6TierI0fW6fbVMgFuZXENMcACD/iJsw9K+p0iYaV3PmIPmZrs6bHFeNYrvYQULhPF7BYSgGr3XQc+s2/tVkz8EkbS+9BOiOnIVTu7xdq0N5DmuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152202; c=relaxed/simple;
	bh=5dPDL/akI8510Bvk9s4NT0x8bg8G/mibEYyLZ1vEnXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RCvJhrTnfvGM9nEw/yOyc33QtsFsJuIk7J13YDYcB7ZHCOBXeWmM2mfFzErdSnqCVU2JZFHr1NYsRXC6xXfqc2a4kyKYd8WJy6byCRjSuYpe8LY4Fa56kOCCvpXrdl63wWe8784tNv/JPxyVYSCuZCtTwG4n/LB2iwyeb39AeoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SXMklcag; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SXMklcag"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=7ulpk
	EqvslMLAqlB3/y0tIJkh9m/nwy2+ESqvMYqvhU=; b=SXMklcag1rZ8+Dxq65u8O
	0NdGCEJ02aWj99OB1rlXbXlvNQ/CC2bC6/8ancP9wswC2G143irpqlVE9qYCr8iz
	Pb76hFVPuOyF9PG+7dox3IXw1z8aDWKhh6+FM2H5LM89OHqXZNQn676XOkYj9ggc
	PNWqXvRk2nER/2pHqtr90o=
Received: from 192.168.0.110 (unknown [117.147.35.238])
	by gzga-smtp-mta-g2-2 (Coremail) with SMTP id _____wAXC0Xm_eJmecy5Gw--.57154S2;
	Thu, 12 Sep 2024 22:42:47 +0800 (CST)
From: Zhengchao Shao <shaozhengchao@163.com>
To: netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	shaozhengchao@163.com
Subject: [PATCH net-next] net/smc: remove useless macros in smc_close.h
Date: Thu, 12 Sep 2024 22:42:40 +0800
Message-ID: <20240912144240.8635-1-shaozhengchao@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXC0Xm_eJmecy5Gw--.57154S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF15Kw1xCr1fXF43Aw18Xwb_yoWxurX_A3
	48ur4xW3WrZFn7KrWkKw42vrWvvr4kXrWrZFn0yFy5Ga18tr4UuFsYgFnxA3sI9wsxuFW3
	XF45Xr4qya42kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRMrWrDUUUUU==
X-CM-SenderInfo: pvkd065khqwuxkdrqiywtou0bp/1tbizR1YvGV4JIPqTgABsr

After commit 51f1de79ad8e("net/smc: replace sock_put worker by
socket refcounting") is merged, SMC-COSES_SOCK_PUT_DELAY is no
longer used. So, remove it.

Signed-off-by: Zhengchao Shao <shaozhengchao@163.com>
---
 net/smc/smc_close.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/smc/smc_close.h b/net/smc/smc_close.h
index 634fea2b7c95..9baee2eafc3b 100644
--- a/net/smc/smc_close.h
+++ b/net/smc/smc_close.h
@@ -17,7 +17,6 @@
 #include "smc.h"
 
 #define SMC_MAX_STREAM_WAIT_TIMEOUT		(2 * HZ)
-#define SMC_CLOSE_SOCK_PUT_DELAY		HZ
 
 void smc_close_wake_tx_prepared(struct smc_sock *smc);
 int smc_close_active(struct smc_sock *smc);
-- 
2.34.1

