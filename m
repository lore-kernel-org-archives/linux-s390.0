Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116379;
	b=4frnzpskVu+Vynb8rLbPKuKgmvX8aJdPUEpVptqnzkmQhMi9C86hzu6xtuzLjXHGK7yf
	 UvMDwIWst8rzXuQrs/MJULz6C6U6cRVh86mmFw6KGA/H6KwE7XIaz7K4jnGUIPTIJHbug
	 ri7ZpeBTlM2ml+cku3nxAyAEOgd8hR71e5fQMF6gdF3GwimVEmaLk0lnxaCI+RgSPAbbz
	 JtQF9PlYEwPUzA3a/svm9qL/O91dbEDHznwRMEFnGZTHk6gGTis9oOe4osFNcSAhbtbbj
	 61yD76mPTsfX2I3lpgMDvfsvUZfeNDqUhCRC2Sq8ki9R1Z7WbUPSrLGiXRgRO5/TZUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=d2DVsEOIJmONwY68Fz20HCkoh5ZG0X1B/QknI6oOs3U=;
	b=qiBiL60MApxlGrbRPM7PJwmJkBgeYDRjZtMN/BBT/KoDbXbyfbhnAoMyp7oGgZMV00LZ
	 hS24fjYKnUNyDxFIfBwPV1S7azKdY643i0OVYtmAh/5mxrRewQRbQp4H/Mu2cyjk0MRf8
	 q4zWbFK5OY+bU3Fg3WDP1ObrjgHwLacDvvnCe35wrLkyRbWXdwe8y+r8Nr5uYVMgpyM/u
	 OBrJXjsgEPh3PNOgU9wwzd7jL9OzpY5GBCKa6umC6UYwdNW9lRpqpjXA0SZpkG9WeGQDW
	 vEh2wuf9ijkbVzk0CrfvhhTda4pifZ4Evf4amsKt3sXnqIb4b9Kw1eG1yRbnEs6CWwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=levS3667;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE32260A2613
	for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 19:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE32260A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=levS3667
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4cbf700ddccso197668b6e.0
        for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 11:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116378; x=1795721178; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d2DVsEOIJmONwY68Fz20HCkoh5ZG0X1B/QknI6oOs3U=;
        b=levS3667ihkpDSZGBZoTL8DB4CxLcn4v4iMxxr4UaPMr3s2xk5H4TeYZonGwE6R95d
         5IIWRLUyEmU8irpDCOOB0avCAJgCqXnr5tqXMkYM1vC8KjrXU8vYZQj/yFa0N8Eg7PoL
         uSIOAYtghLq5K4g737oVLjq3MqXt29ODZMqKRByOSDM+2IYxO3NTRQEzmpQbUqMC9SOX
         qoDmO6SBrmQK/C4jLpvSEJRqYKd30MjKuAXeqfP5EW59dmOHXnWaGKK4O9y8kN5NZM3f
         w7vtlvGpTVFreZFwgreAvhZVFLRr5+nb0gLmdmYfUMTqpe2thObuHM0Twl7AKogmC+WM
         gMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116378; x=1795721178;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d2DVsEOIJmONwY68Fz20HCkoh5ZG0X1B/QknI6oOs3U=;
        b=xsERqLIh9d5XCejmVJPU8ErtpgiFj+rnF3iCpapbLxYhA8LYhPZzu6hLUHJyh7F72S
         j9oXpcyBILEsTo9ECSu2ly+oGsFgJJgYYkk0dYDTcOk8sRZz0xoPSypxindpJEZzn8VO
         cRKcmKIZwGSw30aQVMLoRuWMlMZ7UPdkyqIAuHoT74dcu+RnkOPlpFV85WClo9/wFMeH
         QwfjlQXdjyym4dSJ7oOV/ncsmRvnC90sshPuTFTnxEIfzZ2Bm9qLNqrJNb93hQGzfJ6+
         yb3RbFEBwbqLxgf492MI1qMIDN+UDR3KxyOwuGr/p62mfIyYrGawQ1PVy6TWiPOTza8d
         +gmA==
X-Forwarded-Encrypted: i=1; AL+hErFOn8+GPCq0TKAK4eabl8j/bNlPFw1yeixTS+CKjM2/tMoOVoYrQm+KEElzZFKCgqkBBuKRw+XOABGB@vger.kernel.org
X-Gm-Message-State: APuU4Z/ASiQ/JLsF49xRvJYgdS1/6dAzYNH4LeCIJs3ASxRJN8FiIQN+
	0tcYxEeLq2dcm16ss9EMpiSClkP2cBUa+6paPsT+Wr0hHeomH+MBJgaicXrgN7rYbSAe8cMSugR
	1WzlnJTFtxQ==
X-Received: from jaqb6.prod.google.com ([2002:a05:6638:1a6:b0:61f:e4cd:8716])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:c3eb:b0:4b9:e5fa:8a17
 with SMTP id 5614622812f47-57a0a913526mr994137b6e.28.1795116377408; Thu, 19
 Nov 2026 11:26:17 -0800 (PST)
Date: Thu, 19 Nov 2026 11:25:20 -0800
In-Reply-To: <20261119192520.1983406-1-irogers@google.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119192520.1983406-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261119192520.1983406-10-irogers@google.com>
Subject: [PATCH v4 9/9] kobject: Require explicit initialization of struct kobj_type::release
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Srish Srinivasan <ssrish@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Alexander Aring <aahringo@redhat.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Documentation/core-api/kobject.rst states:

  "One important point cannot be overstated: every kobject must have a
  release() method, and the kobject must persist (in a consistent state)
  until that method is called. If these constraints are not met, the code
  is flawed. Note that the kernel will warn you if you forget to provide
  a release() method. Do not try to get rid of this warning by providing
  an \"empty\" release function."

Annotate struct kobj_type::release with __must_init so the compiler
diagnoses any struct kobj_type initializer that omits .release.

For the remaining legacy struct kobj_type definitions that still omit a
release callback, explicitly initialize .release = NULL and document
each site's lifetime status:
- In built-in code where the backing storage is static, per-CPU, or
  allocated once at boot and never freed (arm64 cpuinfo, ACPI hotplug
  profiles, and s390 sclp_mem), note that omitting release() violates
  the kobject API contract while explaining what guarantees the storage
  outlives kobject cleanup.
- In drivers and tristate modules with broken kobject lifetime
  management (where enclosing dynamic or devm allocations are freed or
  zeroed independently of kobject_put(), or where module unload unmaps
  static kobjects/ksets while final or CONFIG_DEBUG_KOBJECT_RELEASE
  delayed cleanup may still be pending), document the lifetime hazard
  with a FIXME comment for follow-up fixes.

This change does not alter runtime behavior at these sites.

Link: https://lpc.events/event/20/contributions/2392/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/arm64/kernel/cpuinfo.c                   |  7 +++++++
 drivers/acpi/sysfs.c                          |  7 +++++++
 drivers/dma/ioat/sysfs.c                      |  8 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    |  8 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c       | 17 +++++++++++++++
 drivers/infiniband/hw/hfi1/sysfs.c            |  7 +++++++
 drivers/infiniband/hw/usnic/usnic_ib_sysfs.c  |  7 +++++++
 drivers/parisc/pdc_stable.c                   |  8 +++++++
 drivers/power/supply/ab8500_fg.c              |  8 +++++++
 drivers/s390/char/sclp_mem.c                  |  6 ++++++
 drivers/soc/hisilicon/kunpeng_hccs.c          | 18 ++++++++++++++++
 .../fbdev/omap2/omapfb/dss/display-sysfs.c    |  7 +++++++
 .../fbdev/omap2/omapfb/dss/manager-sysfs.c    |  8 +++++++
 .../fbdev/omap2/omapfb/dss/overlay-sysfs.c    |  7 +++++++
 fs/erofs/sysfs.c                              | 14 +++++++++++++
 fs/f2fs/sysfs.c                               | 21 +++++++++++++++++++
 fs/ocfs2/cluster/masklog.c                    |  7 +++++++
 include/linux/kobject.h                       |  2 +-
 18 files changed, 166 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 94e6cd211d70..7c374b8c25af 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -295,6 +295,13 @@ const struct seq_operations cpuinfo_op = {
 
 
 static const struct kobj_type cpuregs_kobj_type = {
+	/*
+	 * Omitting release() violates the kobject API contract, but lifetime
+	 * is safe: info->kobj is embedded in built-in static per-CPU cpu_data
+	 * that is never freed or passed to kobject_put() (CPU hotplug only
+	 * toggles sysfs visibility via kobject_add() and kobject_del()).
+	 */
+	.release = NULL,
 	.sysfs_ops = &kobj_sysfs_ops,
 };
 
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index a4534b3e3cfb..d435b565ad19 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -975,6 +975,13 @@ static struct attribute *hotplug_profile_attrs[] = {
 ATTRIBUTE_GROUPS(hotplug_profile);
 
 static const struct kobj_type acpi_hotplug_profile_ktype = {
+	/*
+	 * Omitting release() violates the kobject API contract, but lifetime
+	 * is safe: hotplug->kobj is only embedded in static built-in
+	 * struct acpi_scan_handler instances that are never unregistered or
+	 * freed.
+	 */
+	.release = NULL,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = hotplug_profile_groups,
 };
diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
index 976134df8108..ec5a90c7aded 100644
--- a/drivers/dma/ioat/sysfs.c
+++ b/drivers/dma/ioat/sysfs.c
@@ -167,6 +167,14 @@ static const struct attribute *const ioat_attrs[] = {
 ATTRIBUTE_GROUPS(ioat);
 
 const struct kobj_type ioat_ktype = {
+	/*
+	 * FIXME: Broken kobject lifetime (needs follow-up fix):
+	 * ioat_kobject_del() calls kobject_put(&ioat_chan->kobj) and
+	 * release_ioatdma() frees ioat_chan via kfree() without waiting for
+	 * final kobject cleanup (use-after-free if a sysfs reference is held
+	 * or under CONFIG_DEBUG_KOBJECT_RELEASE).
+	 */
+	.release = NULL,
 	.sysfs_ops = &ioat_sysfs_ops,
 	.default_groups = ioat_groups,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index d025b4183b29..5aa90f1271e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -892,6 +892,14 @@ static const struct attribute_group ualink_xcp_info_group = {
 };
 
 static const struct kobj_type ualink_xcp_info_ktype = {
+	/*
+	 * FIXME: Broken kobject lifetime (needs follow-up fix):
+	 * xcp->ualink.kobj is embedded in adev->xcp_mgr;
+	 * amdgpu_ualink_xcp_sysfs_remove() calls kobject_put() and
+	 * amdgpu_device_fini_sw() later calls kfree(adev->xcp_mgr) without
+	 * waiting for final kobject cleanup.
+	 */
+	.release = NULL,
 	.sysfs_ops = &kobj_sysfs_ops
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index ab14079d1c42..8e21bf57596c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -797,6 +797,16 @@ static const struct sysfs_ops xcp_cfg_res_sysfs_ops = {
 };
 
 static const struct kobj_type xcp_cfg_res_sysfs_ktype = {
+	/*
+	 * FIXME: Broken kobject lifetime (needs follow-up fix): xcp_res->kobj
+	 * is embedded in struct amdgpu_xcp_cfg, freed by parent xcp_cfg->kobj's
+	 * xcp_cfg_sysfs_release(). While an added child pins xcp_cfg->kobj
+	 * until kobject_cleanup() finishes, if kobject_init_and_add() fails in
+	 * amdgpu_xcp_cfg_sysfs_init() no parent reference is held and
+	 * kfree(xcp_cfg) can race with delayed cleanup under
+	 * CONFIG_DEBUG_KOBJECT_RELEASE.
+	 */
+	.release = NULL,
 	.sysfs_ops = &xcp_cfg_res_sysfs_ops,
 	.default_groups = xcp_cfg_res_sysfs_groups,
 };
@@ -1061,6 +1071,13 @@ static const struct attribute_group amdgpu_xcp_attrs_group = {
 };
 
 static const struct kobj_type xcp_sysfs_ktype = {
+	/*
+	 * FIXME: Broken kobject lifetime (needs follow-up fix): xcp->kobj is
+	 * embedded in adev->xcp_mgr; amdgpu_xcp_sysfs_entries_fini() calls
+	 * kobject_put() and amdgpu_device_fini_sw() later calls
+	 * kfree(adev->xcp_mgr) without waiting for final kobject cleanup.
+	 */
+	.release = NULL,
 	.sysfs_ops = &kobj_sysfs_ops,
 };
 
diff --git a/drivers/infiniband/hw/hfi1/sysfs.c b/drivers/infiniband/hw/hfi1/sysfs.c
index 372cfd13dc61..dc6693822589 100644
--- a/drivers/infiniband/hw/hfi1/sysfs.c
+++ b/drivers/infiniband/hw/hfi1/sysfs.c
@@ -608,6 +608,13 @@ static const struct sysfs_ops sde_sysfs_ops = {
 };
 
 static struct kobj_type sde_ktype = {
+	/*
+	 * FIXME: Broken kobject lifetime (needs follow-up fix):
+	 * hfi1_verbs_unregister_sysfs() calls kobject_put(&dd->per_sdma[i].kobj)
+	 * and sdma_clean() frees dd->per_sdma via kfree() without waiting for
+	 * final kobject cleanup.
+	 */
+	.release = NULL,
 	.sysfs_ops = &sde_sysfs_ops,
 };
 
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
index fdb63a8fb997..f6946524a562 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
@@ -245,6 +245,13 @@ static struct attribute *usnic_ib_qpn_default_attrs[] = {
 ATTRIBUTE_GROUPS(usnic_ib_qpn_default);
 
 static struct kobj_type usnic_ib_qpn_type = {
+	/*
+	 * FIXME: Broken kobject lifetime (needs follow-up fix):
+	 * usnic_ib_destroy_qp() calls kobject_put(&qp_grp->kobj) via
+	 * usnic_ib_sysfs_qpn_remove() and RDMA core immediately frees qp_grp
+	 * without waiting for final kobject cleanup.
+	 */
+	.release = NULL,
 	.sysfs_ops = &usnic_ib_qpn_sysfs_ops,
 	.default_groups = usnic_ib_qpn_default_groups,
 };
diff --git a/drivers/parisc/pdc_stable.c b/drivers/parisc/pdc_stable.c
index 6b567a74fc2c..1dc7d8ffdc73 100644
--- a/drivers/parisc/pdc_stable.c
+++ b/drivers/parisc/pdc_stable.c
@@ -484,6 +484,14 @@ ATTRIBUTE_GROUPS(paths_subsys);
 
 /* Specific kobject type for our PDC paths */
 static const struct kobj_type ktype_pdcspath = {
+	/*
+	 * FIXME: Broken kobject lifetime (needs follow-up fix): pdcspath_entry
+	 * instances are static in tristate module pdc_stable, and
+	 * pdc_stable_exit() calls kobject_put(&entry->kobj); unloading the
+	 * module unmaps the static storage without waiting for final kobject
+	 * cleanup.
+	 */
+	.release = NULL,
 	.sysfs_ops = &pdcspath_attr_ops,
 	.default_groups = paths_subsys_groups,
 };
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index eddd3e853106..f5a0bb821ee8 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2539,6 +2539,14 @@ static struct attribute *ab8500_fg_attrs[] = {
 ATTRIBUTE_GROUPS(ab8500_fg);
 
 static const struct kobj_type ab8500_fg_ktype = {
+	/*
+	 * FIXME: Broken kobject lifetime (needs follow-up fix): fg_kobject is
+	 * embedded in devm-allocated struct ab8500_fg; ab8500_fg_sysfs_exit()
+	 * only calls kobject_del() (never kobject_put()) before devm frees the
+	 * struct on unbind, and on ab8500_fg_sysfs_init() failure kobject_put()
+	 * races with devm freeing the struct on probe failure.
+	 */
+	.release = NULL,
 	.sysfs_ops = &ab8500_fg_sysfs_ops,
 	.default_groups = ab8500_fg_groups,
 };
diff --git a/drivers/s390/char/sclp_mem.c b/drivers/s390/char/sclp_mem.c
index 6df1926d4c62..a46d27817281 100644
--- a/drivers/s390/char/sclp_mem.c
+++ b/drivers/s390/char/sclp_mem.c
@@ -305,6 +305,12 @@ static ssize_t sclp_memmap_on_memory_store(struct kobject *kobj, struct kobj_att
 }
 
 static const struct kobj_type ktype = {
+	/*
+	 * Omitting release() violates the kobject API contract, but lifetime
+	 * is safe: built-in sclp_init_mem() allocates sclp_mems once at boot
+	 * and never calls kobject_put() or kfree() on it.
+	 */
+	.release = NULL,
 	.sysfs_ops = &kobj_sysfs_ops,
 };
 
diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index 3b9fa3a74abd..bccd0ba95073 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -1038,6 +1038,12 @@ static struct attribute *hccs_port_default_attrs[] = {
 ATTRIBUTE_GROUPS(hccs_port_default);
 
 static const struct kobj_type hccs_port_type = {
+	/*
+	 * FIXME: Broken kobject lifetime (needs follow-up fix): hccs_port_info
+	 * is allocated via devm_kzalloc(), and devm frees it on unbind or probe
+	 * failure without waiting for kobject_put(&port->kobj) final cleanup.
+	 */
+	.release = NULL,
 	.sysfs_ops = &hccs_comm_ops,
 	.default_groups = hccs_port_default_groups,
 };
@@ -1110,6 +1116,12 @@ static struct attribute *hccs_die_default_attrs[] = {
 ATTRIBUTE_GROUPS(hccs_die_default);
 
 static const struct kobj_type hccs_die_type = {
+	/*
+	 * FIXME: Broken kobject lifetime (needs follow-up fix): hccs_die_info
+	 * is allocated via devm_kzalloc(), and devm frees it on unbind or probe
+	 * failure without waiting for kobject_put(&die->kobj) final cleanup.
+	 */
+	.release = NULL,
 	.sysfs_ops = &hccs_comm_ops,
 	.default_groups = hccs_die_default_groups,
 };
@@ -1213,6 +1225,12 @@ static struct attribute *hccs_chip_default_attrs[] = {
 ATTRIBUTE_GROUPS(hccs_chip_default);
 
 static const struct kobj_type hccs_chip_type = {
+	/*
+	 * FIXME: Broken kobject lifetime (needs follow-up fix): hccs_chip_info
+	 * is allocated via devm_kzalloc(), and devm frees it on unbind or probe
+	 * failure without waiting for kobject_put(&chip->kobj) final cleanup.
+	 */
+	.release = NULL,
 	.sysfs_ops = &hccs_comm_ops,
 	.default_groups = hccs_chip_default_groups,
 };
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
index ae937854403b..436ec9c8591b 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
@@ -304,6 +304,13 @@ static const struct sysfs_ops display_sysfs_ops = {
 };
 
 static struct kobj_type display_ktype = {
+	/*
+	 * FIXME: Broken kobject lifetime (needs follow-up fix):
+	 * display_uninit_sysfs() calls kobject_put(&dssdev->kobj) and
+	 * immediately zeroes dssdev->kobj with memset(), corrupting any
+	 * in-flight or delayed (CONFIG_DEBUG_KOBJECT_RELEASE) kobject cleanup.
+	 */
+	.release = NULL,
 	.sysfs_ops = &display_sysfs_ops,
 	.default_groups = display_sysfs_groups,
 };
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
index 1b644be5fe2e..e4d61cf7e939 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
@@ -496,6 +496,14 @@ static const struct sysfs_ops manager_sysfs_ops = {
 };
 
 static struct kobj_type manager_ktype = {
+	/*
+	 * FIXME: Broken kobject lifetime (needs follow-up fix): mgr->kobj is
+	 * embedded in dynamically allocated managers[], zeroed in
+	 * dss_manager_kobj_uninit() right after kobject_put(), and freed in
+	 * dss_uninit_overlay_managers() without waiting for final kobject
+	 * cleanup.
+	 */
+	.release = NULL,
 	.sysfs_ops = &manager_sysfs_ops,
 	.default_groups = manager_sysfs_groups,
 };
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
index 1da4fb1c77b4..3960261cada0 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
@@ -429,6 +429,13 @@ static const struct sysfs_ops overlay_sysfs_ops = {
 };
 
 static struct kobj_type overlay_ktype = {
+	/*
+	 * FIXME: Broken kobject lifetime (needs follow-up fix): ovl->kobj is
+	 * embedded in dynamically allocated overlays[] and freed in
+	 * dss_uninit_overlays() right after dss_overlay_kobj_uninit() calls
+	 * kobject_put(), without waiting for final kobject cleanup.
+	 */
+	.release = NULL,
 	.sysfs_ops = &overlay_sysfs_ops,
 	.default_groups = overlay_sysfs_groups,
 };
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index dfcec9376cd5..3654a945b299 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -238,6 +238,13 @@ static const struct kobj_type erofs_sb_ktype = {
 static const struct kobj_type erofs_ktype = {
 	.default_groups = erofs_groups,
 	.sysfs_ops	= &erofs_attr_ops,
+	/*
+	 * FIXME: Broken kobject lifetime (needs follow-up fix): erofs_root is
+	 * a static struct kset in tristate module erofs, and erofs_exit_sysfs()
+	 * calls kset_unregister(); unloading the module unmaps the static
+	 * storage without waiting for final kobject cleanup.
+	 */
+	.release	= NULL,
 };
 
 static struct kset erofs_root = {
@@ -247,6 +254,13 @@ static struct kset erofs_root = {
 static const struct kobj_type erofs_feat_ktype = {
 	.default_groups = erofs_feat_groups,
 	.sysfs_ops	= &erofs_attr_ops,
+	/*
+	 * FIXME: Broken kobject lifetime (needs follow-up fix): erofs_feat is
+	 * a static struct kobject in tristate module erofs, and
+	 * erofs_exit_sysfs() calls kobject_put(); unloading the module unmaps
+	 * the static storage without waiting for final kobject cleanup.
+	 */
+	.release	= NULL,
 };
 
 static struct kobject erofs_feat = {
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 430356e500af..770ceb12e178 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1683,6 +1683,13 @@ static const struct kobj_type f2fs_sb_ktype = {
 
 static const struct kobj_type f2fs_ktype = {
 	.sysfs_ops	= &f2fs_attr_ops,
+	/*
+	 * FIXME: Broken kobject lifetime (needs follow-up fix): f2fs_kset is
+	 * a static struct kset in tristate module f2fs, and f2fs_exit_sysfs()
+	 * calls kset_unregister(); unloading the module unmaps the static
+	 * storage without waiting for final kobject cleanup.
+	 */
+	.release	= NULL,
 };
 
 static struct kset f2fs_kset = {
@@ -1697,6 +1704,13 @@ static const struct sysfs_ops f2fs_feat_attr_ops = {
 static const struct kobj_type f2fs_feat_ktype = {
 	.default_groups = f2fs_feat_groups,
 	.sysfs_ops	= &f2fs_feat_attr_ops,
+	/*
+	 * FIXME: Broken kobject lifetime (needs follow-up fix): f2fs_feat is
+	 * a static struct kobject in tristate module f2fs, and
+	 * f2fs_exit_sysfs() calls kobject_put(); unloading the module unmaps
+	 * the static storage without waiting for final kobject cleanup.
+	 */
+	.release	= NULL,
 };
 
 static struct kobject f2fs_feat = {
@@ -1711,6 +1725,13 @@ static const struct sysfs_ops f2fs_tune_attr_ops = {
 static const struct kobj_type f2fs_tune_ktype = {
 	.default_groups = f2fs_tune_groups,
 	.sysfs_ops	= &f2fs_tune_attr_ops,
+	/*
+	 * FIXME: Broken kobject lifetime (needs follow-up fix): f2fs_tune is
+	 * a static struct kobject in tristate module f2fs, and
+	 * f2fs_exit_sysfs() calls kobject_put(); unloading the module unmaps
+	 * the static storage without waiting for final kobject cleanup.
+	 */
+	.release	= NULL,
 };
 
 static struct kobject f2fs_tune = {
diff --git a/fs/ocfs2/cluster/masklog.c b/fs/ocfs2/cluster/masklog.c
index 563881ddbf00..5a30f73d8d67 100644
--- a/fs/ocfs2/cluster/masklog.c
+++ b/fs/ocfs2/cluster/masklog.c
@@ -147,6 +147,13 @@ static const struct sysfs_ops mlog_attr_ops = {
 static struct kobj_type mlog_ktype = {
 	.default_groups = mlog_default_groups,
 	.sysfs_ops      = &mlog_attr_ops,
+	/*
+	 * FIXME: Broken kobject lifetime (needs follow-up fix): mlog_kset is
+	 * a static struct kset in tristate module ocfs2_nodemanager, and
+	 * mlog_sys_shutdown() calls kset_unregister(); unloading the module
+	 * unmaps the static storage without waiting for final kobject cleanup.
+	 */
+	.release        = NULL,
 };
 
 static struct kset mlog_kset = {
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 55e37a5d405e..8a1332030884 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -114,7 +114,7 @@ void kobject_get_ownership(const struct kobject *kobj, kuid_t *uid, kgid_t *gid)
 char *kobject_get_path(const struct kobject *kobj, gfp_t flag);
 
 struct kobj_type {
-	void (*release)(struct kobject *kobj);
+	void (*release)(struct kobject *kobj) __must_init;
 	const struct sysfs_ops *sysfs_ops;
 	const struct attribute_group **default_groups;
 	const struct kobj_ns_type_operations *(*child_ns_type)(const struct kobject *kobj);
-- 
2.56.1.708.g77570a6a1d-goog

