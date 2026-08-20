Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205F943C7B9;
	Thu, 20 Aug 2026 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230043; cv=none; b=AhaY9QMXe/XC+4L+BPSTfbT8Wx+iI3pNhgUOrnj3QT6D02bzB5KYtrYa5WtkfdjeW9oRTnBR+hYrjKMhThe75Un73aXN+q+M8nr2zb3XDPU6NjGabtFFq/EGAJVDQm5/u1FT6+Wz22uNmdVrO3dys20VShd8SR/HbNQj2K9fYdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230043; c=relaxed/simple;
	bh=NXijLyNzW1j6rL2xoxWLuHFGErliw/0/bKGsdxIOr7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LZSqLJGi7/ITPH+6Ed8TqkKYrnXArROpY3YEp9E3lYiHu4mnMzkYMQV9VQ32sv/LGmNu4dF5X3vBYmQ8+mvbs0KL0oJQ2JA+sKzNAFU72imziTTyfhlAvfGcGnp8c/Pyoweut62rSQMd7lhFw4YY+vPDvt+RYeiU2TkVhl4lmWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jAoL6d8g; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Bdc1s8pj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jAoL6d8g";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Bdc1s8pj"
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	by smtp-out2.suse.de (Postfix) with ESMTP id C5F0B3EFD;
	Thu, 20 Aug 2026 12:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1787230036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hBzZv2yl4kbAvlurVLFuOr66YVEI3TpPTChso4lrfJs=;
	b=jAoL6d8gym4kdR82GnDa2JYxsho93mm3OhG3upXICV4UPqaFQrKCs9cLF0jWY5viyQFuVU
	GkmM0oJaFNPRRmWKoDbEWQfGoaD7YN+0hQGxXp9ZdtXjRu91wMeu6wyYC+kVryPgDYiDae
	ohryYZ5cVNSlgh1MPj70TtKWn8SgY14=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Bdc1s8pj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1787230031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hBzZv2yl4kbAvlurVLFuOr66YVEI3TpPTChso4lrfJs=;
	b=Bdc1s8pjzt3d4u/uUdVjPTbYBqzF0kEG7CjoDfIzCAoJBeKlk99ivOQiu5o0CdwKpgPpuz
	zDmNeZuaU3O/Q9z1E6ndZjGt9AqlxUkle5LNqHOnOEelxbBeNywRIPE4td2F55twEOPxJh
	rL3xSv4IqyOvMwmSTZOMeqa/ats6tFc=
From: Anthony Iliopoulos <ailiop@suse.com>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390: remove unused setup_profiling_timer function
Date: Thu, 20 Aug 2026 14:46:46 +0200
Message-ID: <20260820124649.143863-1-ailiop@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [16.69 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_SHORT(3.00)[0.999];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DIRECT_TO_MX(0.00)[git-send-email 2.55.0];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.com:dkim];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b306:2000::2:from];
	DKIM_TRACE(0.00)[suse.com:+];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Score: 16.69
X-Spam-Level: ****************
X-Spamd-Bar: ++++++++++++++++
X-Rspamd-Queue-Id: C5F0B3EFD
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: YES
X-Rspamd-Action: add header
X-Spam: Yes

setup_profiling_timer() is not used by any code at this point. Since a
default weak implementation exists, there is no need to keep this
arch-specific definition around. Remove it along with the now-redundant
profile header includes.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 arch/s390/kernel/entry.h |  1 -
 arch/s390/kernel/irq.c   |  1 -
 arch/s390/kernel/smp.c   | 11 -----------
 arch/s390/kernel/time.c  |  1 -
 4 files changed, 14 deletions(-)

diff --git a/arch/s390/kernel/entry.h b/arch/s390/kernel/entry.h
index dc84ab497251..144a72ad7dc6 100644
--- a/arch/s390/kernel/entry.h
+++ b/arch/s390/kernel/entry.h
@@ -45,7 +45,6 @@ void do_ext_irq(struct pt_regs *regs);
 void do_restart(void *arg);
 void __init startup_init(void);
 void die(struct pt_regs *regs, const char *str);
-int setup_profiling_timer(unsigned int multiplier);
 
 struct s390_mmap_arg_struct;
 struct fadvise64_64_args;
diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index c923496aa7b4..319e4e5bc9fe 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -13,7 +13,6 @@
 #include <linux/interrupt.h>
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
-#include <linux/profile.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/ftrace.h>
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 167c72803ccf..d5e58329a24b 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -980,17 +980,6 @@ void __init smp_setup_processor_id(void)
 	lc->spinlock_index = 0;
 }
 
-/*
- * the frequency of the profiling timer can be changed
- * by writing a multiplier value into /proc/profile.
- *
- * usually you want to run this on all CPUs ;)
- */
-int setup_profiling_timer(unsigned int multiplier)
-{
-	return 0;
-}
-
 static ssize_t cpu_configure_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 2b989bebd220..66191fdef101 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -32,7 +32,6 @@
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/types.h>
-#include <linux/profile.h>
 #include <linux/timex.h>
 #include <linux/notifier.h>
 #include <linux/clockchips.h>
-- 
2.55.0

