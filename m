Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793121;
	b=EEGuj3NrGuEqm7u2UaywJgzSCVjzcmaPrTFcmQrm5TFtdLzJqZ61RP7UhBTxBl9Y3Blk
	 ivb60HEfA80VS65txXVnYtUIQ1zLBIGy/rFUwEr24sXyQEb+ffyTuNa5W6K0dItaBxpkD
	 BjZnkwEpz3zDD+cxSlYBzFb+7lb9GF54sbwW+pllc09msbeCBs0orpPPzJ23rP5lBiiYQ
	 +35S3mDXEqVIAmzneF4/+c1c9fryHkE1ZIrWR4ky352NR4zCmlG4qJG8MHVTXwE2uf3rs
	 DfBMkVLPSHtGqvJqYhq9oQcuqNW8HgMw+Tz58DUsOYvVACRF6xYNq5takn1iLQlDflA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=0YbBEF/i3LHD2RuXWt/9khib8KcPq1szk/F79X3/JjE=;
	b=Idt59Q1uRkuL6nNl3MLGB9Ufv1ACucYn6+2cymMLWi5jsU9iIHXHpGm2Cw+h9mVUXKku
	 AoU08DzCwm30K6mPY8Jzv+il8r0SAs+oUoEaDYsKoajQF2hNand8JLWSbOZc9bPQvDwqg
	 tyyy9BA1xueNqhnQdzV6kZ87DFc0+F3/45dxTSzupsbOG5YKOq2dL65Dn8FDwL1/PDbp1
	 i/PA8GHqEJMgmMG99J4PUoZ8ID9zwLBfrR7bFFPd2maSH678Ds5dC/M8/Pg5SqKi4w/n5
	 pAZEOypu9/bn65i9GxbG4RCUMSvz8uuEceHisctuQjoFgI7wbiV5hNKjvSO11DaEFaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rFjzQvYC;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFA4606A31C
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 01:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CFA4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rFjzQvYC
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-37123334649so282361eec.1
        for <linux-s390@vger.kernel.org>; Sun, 15 Nov 2026 17:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794793119; x=1795397919; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0YbBEF/i3LHD2RuXWt/9khib8KcPq1szk/F79X3/JjE=;
        b=rFjzQvYC6f6TMa6Z5eJPNwAq3cMH/AYWSldZIDjXVd7vut5NqO71wKglDyoITuklQz
         ANGdBCKIlVoit2FlqHdnAF+B5w0tIDlalUM3RbhLs1S2YuWZAlyPmCFODpgtyyNK8vHk
         ZNwleBDOi61gTwihuTf+3tp6Rw93y1n5gPR5yMZIStuwKoiVugc44eOu89SuX3fPbqeF
         83R1e2ykT3OYsXkDPy+41zc0MV2kioi+OHpr2MQpdDiZV00hTrsmvQABkCwM8SATxJ4H
         9vMLBbrYk0H/4a6VWH8Qy3iA/fldsXTvEsoLbda349UPsUKyTdJnPheLr9udYaZ7mZS0
         Un3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794793119; x=1795397919;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0YbBEF/i3LHD2RuXWt/9khib8KcPq1szk/F79X3/JjE=;
        b=0i9RW75kCqEPFBZWtwMYcTduzVLu+goAF6ZMqJ6MMQt2hCO9ExA/i/0UTs63P6bXcX
         SpSkpGbhMq47n67/kL13gH/qJNDegL1WXRat8ukX9RoJdXalpt9kd7F9u+pqEGdWNXAM
         BtjT6Dh0gTKz8RzIiryNm7KLnmt2jrt+GIJxaFTWYqnob+ZE49P8OGUvFLD+jj9b79Qm
         HygYia78S+q0f8PnJtjjuC8gy0oBLs8JVjpJ8eNFIeAISRXbhPVonivbHE86bHulJFgc
         IgWmfl4sh9OG/BQh8morAsz5Xvkrjnm52039zN681XcXu+k42y6HtFUdhBLiI2AUM58A
         hXSA==
X-Forwarded-Encrypted: i=1; AL+hErFpus5l+onQQs49YE+qizclzeOWIAdiAH6qdzEDFiNG3jT7iR5ZsY1P3G2lqrFRgGSXWgVeRMpvlYPN@vger.kernel.org
X-Gm-Message-State: APuU4Z/xxTVPUtPg3lWTNB/iql3tH5e6q45qgPQdxjKYKOPyWbESzcLJ
	+ZokaAIYw40a3qGNBKNRebt0okvUdFwvqqxYrV+yb0Zo2bGVN9133s6d
X-Gm-Gg: AYBFou3WOzxjIrd/0wjM8lJm/JUQuVGGCNtesifEeFZ+A3YcWIqC+XBLTt2WMuAzx4F
	ba5av0qt5owOewGcfI2T6Bjb1f9zMbU5wQZNX+zGXyBqh1jPYnuvP0+IlzODQxnKg9WzVB/mKe8
	1tQumh4QxcfOeo35Uj0n7bDKMpsNeqbLZH9pylGtHwj0F8FSQZ3LOL08G5xw8+yB1aR7SHn3vmC
	Sl01YKwaQf7Eb2M1n7tJqBra/d0uesfTacKz6RwBefim7yp3w4aSzNItdYQNNKHmwSNBBb8bsXL
	VMAyG+A10KXvuAtWl7JbfxdtT5DfhIbzTWvIN2JfgavltLz9tB8RnX14aoJIMeLnneJ36uGNv/x
	6yOvZNQSR+7fTTknFhDeyIIybOyEXzS8pw+KciWE7H3gU3+SlKQzyOqcWiHn9VKVMz8Djb4Dn2r
	mGtL5b7QLFsTxh79B6Z+qeubdkQLH7JiMJo/QmGOfmshBOebE5+iZrGYNw2UKpr/7oJbI+8kz87
	A9EPWqbdy5K6VehlfJktOeA1g1FjpJY8IridcgOyZmjcktw4S/CG0RbR659vC/hbY5F48mBjE5H
	kksBxXy+5clehREOtFs+6melr8kcoOHUezcE+tsZnzK4c0aKXGSygX3aZC0Z4nXN+0Q=
X-Received: by 2002:a05:7301:a0a:b0:375:f846:5b3f with SMTP id 5a478bee46e88-3796057e734mr12265396eec.0.1794793118399;
        Sun, 15 Nov 2026 17:38:38 -0800 (PST)
Received: from o6.lan ([2602:fce1:44f:115e::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379560f5e06sm38324766eec.19.2026.11.15.17.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 17:38:37 -0800 (PST)
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
Date: Mon, 16 Nov 2026 09:38:21 +0800
Subject: [PATCH v4] mm/zsmalloc: remove CONFIG_ZSMALLOC_STAT
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261116-zsmalloc_stat-v4-1-fa9197a2e580@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIxe+moC/3WOQWrDMBBFrxK07rQeRbaTrHqPUspIGscqtmUk1
 yQNvnulhIAxdPk/8978m4gcHEdx2t1E4NlF54cU1MtOmJaGM4OzKQtZyAqxqOA39tR13nzFiSb
 g1FplDcq6EokZAzfucvd9fD5y/NHfbKYsyReaIoMONJg2V1pBbt6eWrDBj5Dd+bh1cfLhel83Y
 5b+N2RGQNBlrRpVoyLbvJ97ct2r8b3IQ2a5po9bWkIBhpgVVgdFmrb0fkUjbul9+i3toWRbYlk
 XvKaXZfkDtBYCEGUBAAA=
X-Change-ID: 20261106-zsmalloc_stat-e261d4dc1276
To: Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Helen Koike <helen.fornazier@gmail.com>, 
 Vignesh Raman <vignesh.raman@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Nhat Pham <nphamcs@gmail.com>, 
 Xueyuan Chen <xueyuan.chen21@gmail.com>
X-Mailer: b4 0.16.0

CONFIG_ZSMALLOC_STAT only controls the debugfs interface. The class
counters are updated regardless of this option.

Remove the CONFIG_ZSMALLOC_STAT guards and rely on the debugfs API
stubs when CONFIG_DEBUG_FS=n. Skip statistics setup silently when
debugfs is unavailable.

Remove the Kconfig entry and drop CONFIG_ZSMALLOC_STAT from both s390
defconfigs. Replace it with CONFIG_DEBUG_FS=y in the DRM CI configs.
Update the English and Chinese documentation to match and use
<pool-name> in the debugfs path.

Suggested-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Dongliang Mu <dzm91@hust.edu.cn> # Documentation
Signed-off-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
---
Changes in v4:
- Drop CONFIG_DEBUG_FS=y from the s390 defconfigs (Alexander).
- Add Reviewed-by and Acked-by tags.
- Link to v3: https://patch.msgid.link/20261111-zsmalloc_stat-v3-1-2d85ed51570e@gmail.com

Changes in v3:
- Squash the three patches into one (Nhat, Sergey).
- Add Nhat's Reviewed-by.
- Update the documentation wording.
- Link to v2: https://patch.msgid.link/20261109-zsmalloc_stat-v2-0-caee41684aba@gmail.com

Changes in v2:
- Drop CONFIG_ZSMALLOC_STAT instead of making the counters conditional.
- Update configuration files and documentation.
- Link to v1: https://patch.msgid.link/20261106-zsmalloc_stat-v1-1-b574f4714adf@gmail.com
---
 Documentation/mm/zsmalloc.rst                    |  4 +--
 Documentation/translations/zh_CN/mm/zsmalloc.rst |  2 +-
 arch/s390/configs/debug_defconfig                |  1 -
 arch/s390/configs/defconfig                      |  1 -
 drivers/gpu/drm/ci/arm.config                    |  2 +-
 drivers/gpu/drm/ci/arm64.config                  |  2 +-
 drivers/gpu/drm/ci/x86_64.config                 |  2 +-
 mm/Kconfig                                       |  9 -------
 mm/zsmalloc.c                                    | 33 ++----------------------
 9 files changed, 8 insertions(+), 48 deletions(-)

diff --git a/Documentation/mm/zsmalloc.rst b/Documentation/mm/zsmalloc.rst
index d2bbecd78e14..4c0786378dc3 100644
--- a/Documentation/mm/zsmalloc.rst
+++ b/Documentation/mm/zsmalloc.rst
@@ -33,8 +33,8 @@ proper handle-based APIs.
 stat
 ====
 
-With CONFIG_ZSMALLOC_STAT, we could see zsmalloc internal information via
-``/sys/kernel/debug/zsmalloc/<user name>``. Here is a sample of stat output::
+With CONFIG_DEBUG_FS, we could see zsmalloc internal information via
+``/sys/kernel/debug/zsmalloc/<pool-name>``. Here is a sample of stat output::
 
  # cat /sys/kernel/debug/zsmalloc/zram0/classes
 
diff --git a/Documentation/translations/zh_CN/mm/zsmalloc.rst b/Documentation/translations/zh_CN/mm/zsmalloc.rst
index 4c8c9b1006a9..b555a07ac871 100644
--- a/Documentation/translations/zh_CN/mm/zsmalloc.rst
+++ b/Documentation/translations/zh_CN/mm/zsmalloc.rst
@@ -32,7 +32,7 @@ zs_unmap_object()解除映射。
 stat
 ====
 
-通过CONFIG_ZSMALLOC_STAT，我们可以通过 ``/sys/kernel/debug/zsmalloc/<user name>``
+启用CONFIG_DEBUG_FS，我们可以通过 ``/sys/kernel/debug/zsmalloc/<pool-name>``
 看到zsmalloc内部信息。下面是一个统计输出的例子。::
 
  # cat /sys/kernel/debug/zsmalloc/zram0/classes
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index d44674b63715..2ae3bc11ef61 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -100,7 +100,6 @@ CONFIG_UNIXWARE_DISKLABEL=y
 CONFIG_IOSCHED_BFQ=y
 CONFIG_BINFMT_MISC=m
 CONFIG_ZSWAP=y
-CONFIG_ZSMALLOC_STAT=y
 CONFIG_SLAB_BUCKETS=y
 CONFIG_SLUB_STATS=y
 # CONFIG_COMPAT_BRK is not set
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index e00e252d4694..3458ec09f172 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -94,7 +94,6 @@ CONFIG_UNIXWARE_DISKLABEL=y
 CONFIG_IOSCHED_BFQ=y
 CONFIG_BINFMT_MISC=m
 CONFIG_ZSWAP=y
-CONFIG_ZSMALLOC_STAT=y
 CONFIG_SLAB_BUCKETS=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_MEMORY_HOTPLUG=y
diff --git a/drivers/gpu/drm/ci/arm.config b/drivers/gpu/drm/ci/arm.config
index d7c51670da2f..fc0a8a4bfb18 100644
--- a/drivers/gpu/drm/ci/arm.config
+++ b/drivers/gpu/drm/ci/arm.config
@@ -5,7 +5,7 @@ CONFIG_CRYPTO_ZSTD=y
 CONFIG_ZRAM_MEMORY_TRACKING=y
 CONFIG_ZRAM_WRITEBACK=y
 CONFIG_ZRAM=y
-CONFIG_ZSMALLOC_STAT=y
+CONFIG_DEBUG_FS=y
 
 # abootimg with a 'dummy' rootfs fails with root=/dev/nfs
 CONFIG_BLK_DEV_INITRD=n
diff --git a/drivers/gpu/drm/ci/arm64.config b/drivers/gpu/drm/ci/arm64.config
index c46125c1f80f..10b01b55a66d 100644
--- a/drivers/gpu/drm/ci/arm64.config
+++ b/drivers/gpu/drm/ci/arm64.config
@@ -5,7 +5,7 @@ CONFIG_CRYPTO_ZSTD=y
 CONFIG_ZRAM_MEMORY_TRACKING=y
 CONFIG_ZRAM_WRITEBACK=y
 CONFIG_ZRAM=y
-CONFIG_ZSMALLOC_STAT=y
+CONFIG_DEBUG_FS=y
 
 # abootimg with a 'dummy' rootfs fails with root=/dev/nfs
 CONFIG_BLK_DEV_INITRD=n
diff --git a/drivers/gpu/drm/ci/x86_64.config b/drivers/gpu/drm/ci/x86_64.config
index 7ac98a78691e..8225b806dad8 100644
--- a/drivers/gpu/drm/ci/x86_64.config
+++ b/drivers/gpu/drm/ci/x86_64.config
@@ -5,7 +5,7 @@ CONFIG_CRYPTO_ZSTD=y
 CONFIG_ZRAM_MEMORY_TRACKING=y
 CONFIG_ZRAM_WRITEBACK=y
 CONFIG_ZRAM=y
-CONFIG_ZSMALLOC_STAT=y
+CONFIG_DEBUG_FS=y
 
 CONFIG_PWM=y
 CONFIG_PM_DEVFREQ=y
diff --git a/mm/Kconfig b/mm/Kconfig
index afff1b25b543..4a77cda7f1d7 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -130,15 +130,6 @@ menu "Zsmalloc allocator options"
 
 comment "Zsmalloc is a common backend allocator for zswap & zram"
 
-config ZSMALLOC_STAT
-	bool "Export zsmalloc statistics"
-	select DEBUG_FS
-	help
-	  This option enables code in the zsmalloc to collect various
-	  statistics about what's happening in zsmalloc and exports that
-	  information to userspace via debugfs.
-	  If unsure, say N.
-
 config ZSMALLOC_CHAIN_SIZE
 	int "Maximum number of physical pages per-zspage"
 	default 8
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7ef80e0da626..104ccf3aa170 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -222,9 +222,7 @@ struct zs_size_stat {
 	unsigned long objs[NR_CLASS_STAT_TYPES];
 };
 
-#ifdef CONFIG_ZSMALLOC_STAT
 static struct dentry *zs_stat_root;
-#endif
 
 static size_t huge_class_size;
 
@@ -279,9 +277,7 @@ struct zs_pool {
 	/* Compact classes */
 	struct shrinker *shrinker;
 
-#ifdef CONFIG_ZSMALLOC_STAT
 	struct dentry *stat_dentry;
-#endif
 #ifdef CONFIG_COMPACTION
 	struct work_struct free_work;
 #endif
@@ -565,14 +561,10 @@ static inline unsigned long class_stat_read(struct size_class *class, int type)
 	return class->stats.objs[type];
 }
 
-#ifdef CONFIG_ZSMALLOC_STAT
-
 static void __init zs_stat_init(void)
 {
-	if (!debugfs_initialized()) {
-		pr_warn("debugfs not available, stat dir not created\n");
+	if (!debugfs_initialized())
 		return;
-	}
 
 	zs_stat_root = debugfs_create_dir("zsmalloc", NULL);
 }
@@ -650,10 +642,8 @@ DEFINE_SHOW_ATTRIBUTE(zs_stats_size);
 
 static void zs_pool_stat_create(struct zs_pool *pool, const char *name)
 {
-	if (!zs_stat_root) {
-		pr_warn("no root stat dir, not creating <%s> stat dir\n", name);
+	if (IS_ERR_OR_NULL(zs_stat_root))
 		return;
-	}
 
 	pool->stat_dentry = debugfs_create_dir(name, zs_stat_root);
 
@@ -666,25 +656,6 @@ static void zs_pool_stat_destroy(struct zs_pool *pool)
 	debugfs_remove_recursive(pool->stat_dentry);
 }
 
-#else /* CONFIG_ZSMALLOC_STAT */
-static void __init zs_stat_init(void)
-{
-}
-
-static void __exit zs_stat_exit(void)
-{
-}
-
-static inline void zs_pool_stat_create(struct zs_pool *pool, const char *name)
-{
-}
-
-static inline void zs_pool_stat_destroy(struct zs_pool *pool)
-{
-}
-#endif
-
-
 /*
  * For each size class, zspages are divided into different groups
  * depending on their usage ratio. This function returns fullness

---
base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd

--  
Best regards,
Xueyuan

