Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794400927;
	b=w4pqtFKf3Ng83G8jY+LwkWA5llEkii4Uuyv/VzYGjkVY/u83FnmG4fAyJoAIJrYQz0S+
	 7hGH6dwzFuzLuk4AhZIcBXD/K5Y8BeOklnUHTrxeimIcQ1zolEKcFUL0qf9VoIS+yQZI7
	 jZWWobi9y3jflI8ZRxep5coSAK6AxaT50wvnyhEcfk3XcThYFwAw4/kqKZrOh+s/Yrrs+
	 q8cbiZrdU8sQaMftI6GZ3ieQ2bvg8/MqllHRQgW3okWzhdwpuopDRZBRX04I28TNBdNzR
	 YEyiuqtl99XzdrSYnT/zzwZeAf+zvVLvrTGJbMZ7W/8yRtcRfLix7h77Dm/eTdkrARw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=OQ16sdEJf1gdJkohVqyloM5KBnz2C1+nxajXYYSElQA=;
	b=Jk5rWw49YJuzWnQh34pTXTLY2uf64EFBj4JCLqIiL4VQuOTmQZ8yoWmKECOVLQHW5yWM
	 natWJPgPwcYfxnzPTuzQcrRapEmfy44Nwhby0XpjVB/TOhyOD1hKusNMeW2uXbQ7/Vr1+
	 YUE3X+aGF7NejF8B9c7fXqDlHKM29EA70L+xpbrbI8UTf4Me96eUGJEumz8Hew1ba+xtJ
	 NiOuU0D+ZyaVyQfzN/Yi57Lur5ZGUMqn6Rajbt1TLALNkhG2rWCfq6zx+ekBW7YGYa/RI
	 yhsB3OH7Brf9tc5RKl3NiyjPveTABudhQrkKH7fixhKRXphMW18+L//pnhONUKm3t0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0Pou1PQP;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE111606A333
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 12:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE111606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0Pou1PQP
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-37605faade6so58836eec.3
        for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 04:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794400926; x=1795005726; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OQ16sdEJf1gdJkohVqyloM5KBnz2C1+nxajXYYSElQA=;
        b=0Pou1PQPAuvbVRhRj9+hhQ5LLYq2V5/nMuKx/UUTnGe6vVRdZBQ2wGseEP21of/KFn
         sJMYUNBub5q7J0KLDM5gpc1xQr7ppK5Y2bfQ4x8RF2WXVzAXErxUQk15lKkh5RIS5/zo
         I1EWB5zWqPe4LF2NV0i0t+uOnP46AcBgB0GZFloQViZ5RVIIYIgPKymoYOVgAgA5++JF
         teVuAbHRYpk5ZBwsyKP+FqUapvJbBC7nurVSgwxcM8jaIJwpU1W18t2iINsQOEh9i9o2
         ZHdroZI9LkfOtvZn562cwN/2UHOLRODFi1ZxOOZ1/xU/SaoVwl5PSyA52RsShLlFjEaH
         twXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794400926; x=1795005726;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OQ16sdEJf1gdJkohVqyloM5KBnz2C1+nxajXYYSElQA=;
        b=vgqTBMe7AYywJ8OMlML71BVDt2xm20oT/XNU8jcz0ED52fEslZbGR0llFe7bHOOIft
         9IksWuU8jeaYKytwbPhY8bo0fyRSNEp2bPjXMB+ss2kFGbgaeg0UZgwI+Sb0ksCEzdWQ
         ry9bXfvqpb+ETThvWP9LqUGZR7U48W3Qs0YrUavMHjNcsIqaNi+gxsH+edRi1nbEPUM1
         EdJIORr6OZtf1I4KKME12c3FkGagaiSe5nh/7FqZ0xkZ1poVEhcsdUfE4RheW5d5vnaj
         CwxCfkUSM4vLdThMMFmVt0QhKqEuE81hTeM00FVCK5p75ngICQjCoxHqMHlyjKssi5TF
         uYYQ==
X-Forwarded-Encrypted: i=1; AL+hErG+43JbmpgjXQUL3Nwzj6h7yyO2WfurvXZXknvzCLblTIO5AWMd+huySKcXWueqjFHSMJVG5K1rdhBE@vger.kernel.org
X-Gm-Message-State: APuU4Z9lCHLvGwCIdaU1qRXHe9ZhE8WL6jbvlqZkttEcfi72z/zEtsZK
	CmlIZoUZ5+gFL5IJPLtOe61PoNJa66AhusWM/eVMvFzjZI+DL/9Bz5GX
X-Gm-Gg: AYBFou3oqGtft0R0Vl4+u1rOAfkWgusRatqxxU5b5D5+M2GHVl5AvmQPqVpdvBClE7B
	dXq2w6si/SqMeppgSKKfX4jVdBFIlxHiiPR286kTlksYQCZxDR9W7IT2K1n17eAZZDq9vdOj+Wt
	8/HJRcNjBuk90mniZG5rGrOCjiU6Ua4dE0xKNzDrdt1fH0k3iMvxxxthtXojOMlCxubUGGhd3K7
	WpKVo/pUksjbOXj8OEiG6Q06dVAioMkKB6rhJe4bqA1FyrFTAt33utBHpD3mSqSmBvoCDCwHyy6
	3Xm9edsMhqVc/7NZzXS8ZfD8zw0/1Ds9DQy2Bj1U37XiU+CBMWxHtmEsB3wjfp76DFBKWZPXuoX
	aAtN6OxgfCD21NvZS/fuNyxr580uECbkUfYP2SemEYcQxKdiMCNpqORrIKdEe8mDMU8CG5d/o9M
	Ah8niBWxONnHpfK1PuzkpC4QmXlJgxiU+5O+rNw0wcD4b+Gfe3vwzNH+/A5P5a16+f6zqRSIqyp
	13ttvNeQbRnegoXkbjtSPOOCG5hiJN4JNBMXvDeV1d5VfLyurYXt71IDH55WIU3Ov4e12a+nOYl
	M1GtzEdlxCPlyKmJ1DhbPMUIC6Sh5MnwlWOZ2iQz4jLTdsDzLqM9sD/MqsT3EId3J78=
X-Received: by 2002:a05:7022:3a86:b0:143:5c2a:e45f with SMTP id a92af1059eb24-1b3c01600d4mr3616454c88.0.1794400925446;
        Wed, 11 Nov 2026 04:42:05 -0800 (PST)
Received: from o6.lan ([2602:fce1:44f:115e::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b4efc2sm13462032c88.15.2026.11.11.04.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:42:04 -0800 (PST)
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
Date: Wed, 11 Nov 2026 20:41:26 +0800
Subject: [PATCH v3] mm/zsmalloc: remove CONFIG_ZSMALLOC_STAT
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
Message-Id: <20261111-zsmalloc_stat-v3-1-2d85ed51570e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHVi9GoC/3WO2wrCMBBEf6Xk2dUmxlZ98j9EZJNs20jbSFKLF
 /rvNhWhCD7OMOcwLxbIWwpsn7yYp94G69oxrBcJ0xW2JYE1Y2YiFRnnaQbP0GBdO30OHXZAY2u
 k0VzkGRuZq6fC3iff8fTJ4aYupLsoiQuFgUB5bHUVKyUhNquvFox3V4juOK5s6Jx/TO96HqX/j
 vQcOKhNLguZc4mmOJQN2nqpXcPikV7M6d0vLSAFjUSSZ1uJCuf0MAxvI0pZ6ycBAAA=
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

Remove the Kconfig entry and replace the existing CONFIG_ZSMALLOC_STAT
settings with CONFIG_DEBUG_FS=y. Update the English and Chinese
documentation to match, and clarify the pool name in the debugfs path.

Suggested-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
---
Drop CONFIG_ZSMALLOC_STAT instead of making the counters conditional. The
option only controls the debugfs interface, while the class counters are
updated unconditionally. Removing it simplifies the code.

Following Nhat's suggestion, remove CONFIG_ZSMALLOC_STAT and rely on
the existing debugfs API stubs when CONFIG_DEBUG_FS=n.
---
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
 arch/s390/configs/debug_defconfig                |  2 +-
 arch/s390/configs/defconfig                      |  2 +-
 drivers/gpu/drm/ci/arm.config                    |  2 +-
 drivers/gpu/drm/ci/arm64.config                  |  2 +-
 drivers/gpu/drm/ci/x86_64.config                 |  2 +-
 mm/Kconfig                                       |  9 -------
 mm/zsmalloc.c                                    | 33 ++----------------------
 9 files changed, 10 insertions(+), 48 deletions(-)

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
index d44674b63715..83193ef8efb9 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -100,7 +100,7 @@ CONFIG_UNIXWARE_DISKLABEL=y
 CONFIG_IOSCHED_BFQ=y
 CONFIG_BINFMT_MISC=m
 CONFIG_ZSWAP=y
-CONFIG_ZSMALLOC_STAT=y
+CONFIG_DEBUG_FS=y
 CONFIG_SLAB_BUCKETS=y
 CONFIG_SLUB_STATS=y
 # CONFIG_COMPAT_BRK is not set
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index e00e252d4694..694a309377d5 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -94,7 +94,7 @@ CONFIG_UNIXWARE_DISKLABEL=y
 CONFIG_IOSCHED_BFQ=y
 CONFIG_BINFMT_MISC=m
 CONFIG_ZSWAP=y
-CONFIG_ZSMALLOC_STAT=y
+CONFIG_DEBUG_FS=y
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

