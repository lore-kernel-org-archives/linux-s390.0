Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDC1231A3B;
	Sun, 25 Jan 2026 13:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769346409; cv=none; b=YGN43+Yzqjpdv3AFWW+2ki77pWqyURC4Rkfp+WXbtd/U/zdgRbZKEgcOgUnp5oeOQuZx99lLxiH/DKH+6sJnsYetY/LLFdFWXZUMDsoB6OKKXMaTCHUlNt4JLh+bT8m0Mos+e3oa9Cq5cGGG4Sf/QASpWESuiGl76ZAGcsLoZL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769346409; c=relaxed/simple;
	bh=p0jurGs3G8lIP1wpM/ocjX2dk+nAjOUipOqC/fLe7oo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T6IqYyVCimCNj6I0DvmZ+CfUDE0FCV4eV8Fc8KpPKc444MbkfSoBCvRSxcYpJCiktR+vMlOw/vrzRyfhsD104pOJomVrhddn5v4deUZQMhDW3nSGSbS/Doitqc6allTzFBil9EKI1utROpI9ggqrImcapl8XWtXAa8RCbBd6O9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.223])
	by APP-03 (Coremail) with SMTP id rQCowAAXNt1dFXZpXiGrBg--.34582S2;
	Sun, 25 Jan 2026 21:06:37 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	svens@linux.ibm.com
Cc: linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Subject: [PATCH] s390/raw3270: add unregister in raw3270_init()
Date: Sun, 25 Jan 2026 21:06:36 +0800
Message-Id: <20260125130636.2036258-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAXNt1dFXZpXiGrBg--.34582S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFyUury3Gr4kXr13XrWrZrb_yoW3WFb_Kw
	4F9F92yr4fuwnruryjyryYvry0kF1rWrs29F1Fqryay34xXFn5Xr1qvFnxWr18WF4Iyr9F
	g347WryfC3srKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
	Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUU
	U==
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiDAUSE2l1qZuEcwAAsR

Add ccw_driver_unregister() if class_register() fails.

Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 drivers/s390/char/raw3270.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index 55850b5a7f51..d6915021fde6 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -1325,8 +1325,10 @@ static int raw3270_init(void)
 	if (rc)
 		return rc;
 	rc = class_register(&class3270);
-	if (rc)
+	if (rc) {
+		ccw_driver_unregister(&raw3270_ccw_driver);
 		return rc;
+	}
 	/* Create attributes for early (= console) device. */
 	mutex_lock(&raw3270_mutex);
 	list_for_each_entry(rp, &raw3270_devices, list) {
-- 
2.25.1

