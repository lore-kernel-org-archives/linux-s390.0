Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C38B1AC43E;
	Mon, 18 Nov 2024 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942193; cv=none; b=KDkX3PvHDcx2XjfRUz6wr5nAy8MwvMAGwsvO0OE1zFW7vOZiV9NWl9d0arefQYsTB2/YSVb1sTrWGmj1cfyE76FyIm5I6FR6KE6QwxHz56yWlysAhhl99ytZFGMM3gKESQ4zQVou2pOJWNsjZpoQUHD+uKLUWI+u5tY/i7gOIMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942193; c=relaxed/simple;
	bh=Y6IKnnnehrgtsOGYcC4soeo5EMiO1x9gQENuPzItkvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k1HLydlOcVx9CmBZcNuduBqH+j3bGOKlVYr4hoBTammaMEw7hEC3s7ZT4eT97iye4cdyYDkjR+mrqkffLoIkj37WM8+BVI51xSRWYGZcF7xiHiI2xCmAgkDDZn2rCsihW5vEH4SZCiADWkPACePHdonEgVClpH7XFpF5v8+XzZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=qKVE/Hso; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="qKVE/Hso"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731942187;
	bh=Y6IKnnnehrgtsOGYcC4soeo5EMiO1x9gQENuPzItkvw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qKVE/HsoamW7WBskfH/JsFzqNNnUf/9fRciYOl7BrVHQXChEVo/w4I3wRgSQ5AUAW
	 Vb4vvj5ITSI/+WNv+Q2iQ2YgzjhvabKGVsAscoMYItGIak7OwlNAzTS6UQVDerSbli
	 NC2t654mYZuILJ2S2lxjBfPZgTIirWgI1p6S96sk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 18 Nov 2024 16:02:49 +0100
Subject: [PATCH 3/3] cpu: Remove spurious NULL in attribute_group
 definition
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241118-sysfs-const-attribute_group-fixes-v1-3-48e0b0ad8cba@weissschuh.net>
References: <20241118-sysfs-const-attribute_group-fixes-v1-0-48e0b0ad8cba@weissschuh.net>
In-Reply-To: <20241118-sysfs-const-attribute_group-fixes-v1-0-48e0b0ad8cba@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-s390@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731942187; l=1161;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Y6IKnnnehrgtsOGYcC4soeo5EMiO1x9gQENuPzItkvw=;
 b=SSps8DBII7qesqAsv+xf0NzLA2Q2RkAGnWvq5dXhTqti/ZR3bY+tTVFcPUvGfpHjOTATQg1/u
 H3o+/TmtbdRCrrDyEimbS9Q1Keupowt8TUyAnhPOvDjwEHLC8qQl6tc
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This NULL value is most-likely a copy-paste error from an array
definition. The NULL doesn't have any effect.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/cpu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index d293d52a3e00e1e8d7c82bdf2f1365bb459f8bb6..f3ee615d2274f161857ef0180454f30b54477cc1 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2866,7 +2866,6 @@ static struct attribute *cpuhp_cpu_attrs[] = {
 static const struct attribute_group cpuhp_cpu_attr_group = {
 	.attrs = cpuhp_cpu_attrs,
 	.name = "hotplug",
-	NULL
 };
 
 static ssize_t states_show(struct device *dev,
@@ -2898,7 +2897,6 @@ static struct attribute *cpuhp_cpu_root_attrs[] = {
 static const struct attribute_group cpuhp_cpu_root_attr_group = {
 	.attrs = cpuhp_cpu_root_attrs,
 	.name = "hotplug",
-	NULL
 };
 
 #ifdef CONFIG_HOTPLUG_SMT
@@ -3020,7 +3018,6 @@ static struct attribute *cpuhp_smt_attrs[] = {
 static const struct attribute_group cpuhp_smt_attr_group = {
 	.attrs = cpuhp_smt_attrs,
 	.name = "smt",
-	NULL
 };
 
 static int __init cpu_smt_sysfs_init(void)

-- 
2.47.0

