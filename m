Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48803BF673;
	Thu, 25 Jun 2026 06:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782367996; cv=none; b=QvxOdQT6XRrFweOPG0QtlAVCtnEAT3uHLr5Dt+sTw+1+KE4hywiXf3li2lOw3c3SFj+ODKIOynA8ov/504ZXMRwOluNfJHjOku9yIROTsrHC1vFrkOx2dtlt0XblxB7JTgVOfvfXUcMUkG8Rg6IzKwYTkmgwG6v1y1uFrJp19oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782367996; c=relaxed/simple;
	bh=/6uYjYuSdMURY4H0scc6TmqCQ+g/KxjEmmXCgx/FdtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ruJZpVlWFlswGLwgckORdvAnhhKTHFgWdtTc+zAwcnoyT1egL6qIwN5BICNeRsY4Wy5Ay1LbVGB+AXK78iyJb5swjfBFtCgVc7TpTck9samQhRaBSnhKRb0UpfdlLiyFsqXTS19YWFGwyIbWpj2TfmXnTIcOWKxSgBsO4h/nDiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAD3YOTxxjxqHrQoFQ--.8832S2;
	Thu, 25 Jun 2026 14:13:05 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Alexandra Winter <wintera@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [RFC PATCH] net/iucv: Descend into net/iucv when AFIUCV is enabled
Date: Thu, 25 Jun 2026 14:13:03 +0800
Message-ID: <20260625061303.36326-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3YOTxxjxqHrQoFQ--.8832S2
X-Coremail-Antispam: 1UD129KBjvJXoWrur1kGFW5Gr4kGry3tr47urg_yoW8Jryxpw
	s5KF45J3ykJrWFkFWkZFn5Kry5t3ySy3y3Ga4UZr4jkryvgw4UXrnakrW0vF1xuws3JF43
	u3Z29asxAF1YkwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUgXocUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

AFIUCV can be enabled by the QETH_L3/HiperSockets path even when IUCV
itself is not enabled.  However, the top-level net Makefile only descends
into net/iucv/ under CONFIG_IUCV.

That creates a Kconfig/Kbuild carrier mismatch: CONFIG_AFIUCV=m can be
selected, but af_iucv.o is never considered because the containing
directory is skipped.

This RFC uses an always-descend model for net/iucv/.  The subdirectory
Makefile already gates iucv.o and af_iucv.o on their own Kconfig symbols,
so entering the directory does not force either provider object on.

This is intentionally RFC because s390 maintainers should confirm whether
the QETH_L3-only AF_IUCV configuration is intended to build af_iucv.o
without the base IUCV object.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 net/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/Makefile b/net/Makefile
--- a/net/Makefile
+++ b/net/Makefile
@@ -45,7 +45,7 @@
 obj-$(CONFIG_MAC80211)		+= mac80211/
 obj-$(CONFIG_TIPC)		+= tipc/
 obj-$(CONFIG_NETLABEL)		+= netlabel/
-obj-$(CONFIG_IUCV)		+= iucv/
+obj-y				+= iucv/
 obj-$(CONFIG_SMC)		+= smc/
 obj-$(CONFIG_RFKILL)		+= rfkill/
 obj-$(CONFIG_NET_9P)		+= 9p/
-- 
2.39.5

