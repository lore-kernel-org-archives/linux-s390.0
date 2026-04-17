Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94872377014;
	Fri, 17 Apr 2026 07:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411353; cv=none; b=qZ3JEi4y0QxcVZQDgYqRK0pmVUHD1vwoBGL+iS0dqwqSZbdovG8vfyJcBYmrIdi/qFbp/YM1rmDPOfg2ghR59r1CFUC2LnYi73M9nCLox98Xkus/BgHxVoETk8eKYyC0mEXHuizAjk2pIUmQMzt+OUBnRnLySZJmjfCdz9ZJ9Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411353; c=relaxed/simple;
	bh=uj/sTiOGAy0WNSVlrUECiYhVK8QzY9DLHh3Qu8x/k/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rx1hKZCtw4jNMLWqb8XhFaLrSh4izWHLHhpAaOibUloTa6m1ijkdOhXSgDVXYcImWRzOSLJIDfDqQDqpMEHE8LNKrOnrAqK4Zjg/6DgMaOm7QjGN5SZvZHhW4vJ12zKKkHto7UMxidpcuKT/6Da4QqfRmwfxN9OyJfzwxfytcxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.116])
	by APP-05 (Coremail) with SMTP id zQCowADXaw_D4uFpm+fXDQ--.31691S2;
	Fri, 17 Apr 2026 15:35:31 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Benjamin Block <bblock@linux.ibm.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>,
	Kees Cook <kees@kernel.org>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] s390/debug: reject zero-length input before trimming a newline
Date: Fri, 17 Apr 2026 15:35:30 +0800
Message-ID: <20260417073530.96002-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADXaw_D4uFpm+fXDQ--.31691S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFWrGF4ftr4xtrW3Jw43Jrb_yoWDWFg_Gr
	97C3WkG3ZxJ342qr12yrW0qF4F9w1rGF1F9rsavrWUXryDXry3X3y8Zan5Jr13GFs8Jrs3
	uwnYva13Aw10yjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbo5l5UUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

debug_get_user_string() duplicates the userspace buffer with
memdup_user_nul() and then unconditionally looks at buffer[user_len - 1]
to strip a trailing newline.

A zero-length write reaches this helper unchanged, so the newline trim
reads before the start of the allocated buffer.

Reject empty writes before accessing the last input byte.

Fixes: 66a464dbc8e0 ("[PATCH] s390: debug feature changes")

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/s390/kernel/debug.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index 31430e9bcfdd..2612f634e826 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -1414,6 +1414,9 @@ static inline char *debug_get_user_string(const char __user *user_buf,
 {
 	char *buffer;
 
+	if (!user_len)
+		return ERR_PTR(-EINVAL);
+
 	buffer = memdup_user_nul(user_buf, user_len);
 	if (IS_ERR(buffer))
 		return buffer;
-- 
2.50.1 (Apple Git-155)

