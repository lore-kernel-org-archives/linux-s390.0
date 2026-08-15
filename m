Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76F6201278;
	Sat, 15 Aug 2026 13:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786802111; cv=none; b=tEnxQ2qCOveDbYSK9iQlMIQXb7tnNHiSZtDnIdk5dTvTaKuHtYIccfeiC5iLyqG+QbltC/qiiIMJKOa+c3csxCkdvBmCf95is9JdigCEjhC84QaEWkjIhSTFzZSnWP3pNeIxXGV+vLooYGndb4yq/g9k7wM3bDYqQJl7l+cm+pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786802111; c=relaxed/simple;
	bh=6JMaBq1J9AvJ2IuExEfaD0kbpNuJQFPRdKNE0Dk9lHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XMmf5SYgg8CV9abBRLx0GVauxI7VS7aRqaJYTMv17LcAUPLm3nOMI8fR3kPHLY0XhLrVDh+7o4CH1jFg1Jw4T8yAUJMvPgmCotBsmnus2ZxEW4UUFWohLas0XVz2jVvpkGeQ61Ay9zXpV8Fp4qthBNt2yCLRz98bnT1ollHwM5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-05 (Coremail) with SMTP id zQCowAB3qEKwb4Bq23fRBQ--.19153S2;
	Sat, 15 Aug 2026 21:54:58 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: wintera@linux.ibm.com,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Simon Horman <horms@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net/iucv: descend into net/iucv independently of IUCV
Date: Sat, 15 Aug 2026 21:54:56 +0800
Message-ID: <20260815135456.53684-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3qEKwb4Bq23fRBQ--.19153S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr43ZFW5JFWUXr1xXr17Awb_yoW8Gw4xpr
	s5Gr4UJrWkJFyI9FWkCF1vgF90q393trW7CF1DXr45Zw1vqr4UJrnagFW0qF1kuw4xJFWf
	ZFn7KasxCF1Yv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r
	4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjfU5dgADUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

AFIUCV can be enabled as either built-in or a module through QETH_L3 even
when IUCV is disabled. The top-level net Makefile currently descends into
net/iucv/ only under CONFIG_IUCV, so the valid configurations
CONFIG_AFIUCV=y/m with CONFIG_IUCV=n never consider af_iucv.o.

Always descend into net/iucv/. Its Makefile already gates iucv.o and
af_iucv.o on their own Kconfig symbols, so this does not build either
object unless selected.

Fixes: c69748d1c9b5 ("iucv: kernel option for z/VM IUCV and HiperSockets")
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>

Assisted-by: Codex:gpt-5
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since RFC:
https://lore.kernel.org/all/20260625061303.36326-1-pengpeng@iscas.ac.cn/
- submit this as a regular fix rather than an RFC
- describe both AFIUCV=y and AFIUCV=m with IUCV=n
- add Alexandra's Reviewed-by

 net/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/Makefile b/net/Makefile
index 5b2dd7f07a85..c0da946b281e 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -45,7 +45,7 @@ obj-$(CONFIG_WIRELESS)		+= wireless/
 obj-$(CONFIG_MAC80211)		+= mac80211/
 obj-$(CONFIG_TIPC)		+= tipc/
 obj-$(CONFIG_NETLABEL)		+= netlabel/
-obj-$(CONFIG_IUCV)		+= iucv/
+obj-y				+= iucv/
 obj-$(CONFIG_SMC)		+= smc/
 obj-$(CONFIG_RFKILL)		+= rfkill/
 obj-$(CONFIG_NET_9P)		+= 9p/
-- 
2.50.1 (Apple Git-155)

