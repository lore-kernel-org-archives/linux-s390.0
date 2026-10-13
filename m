Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425645632BF
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 22:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931250; cv=none; b=sE0rBG4J4J5qAxpquo/uXIezIFYK5GBXK3BMGKmcRVyEyNAdhtXZwywlavJ+6LRpZUSdnjXEvlGkkNo5HPELzjGU1I+1FI8PGHiaOP7Y/cqa6ICVnwNZwG+XwMc9GpH8ou8sGaFoIoCXpxZTCJpAUdaYg1nrFfpanq8dReltNbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931250; c=relaxed/simple;
	bh=kNzY4659saQzwEUZQfm99c5GlQJNbi8H+xQ55wYkvMs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S7XocQUpNsRnf0QnuB+mWczFhs3daEQovKZG/9ujz0UqoN8ln/iHnw22JVBPhOxRfzqA5jrdpa+l3zJ8BWL4vdadd16s/6gJjrNqBKDS3Own+RncQQYKWSQ0Gu/loM62nSSAyMd024igJL/OD9Q+A4RrcGEhz7hTfFV+HRDLPrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hqdCl5v8; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hqdCl5v8"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35c5aef2a74so1455374eec.0
        for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 15:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791931238; x=1792536038; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KZW0TlkuVx1/ay444vuidlpbLOf1N6NgoBIEapd0snM=;
        b=hqdCl5v8N7B7SzkG3lj5QkK8GYfSBb+8iXG13lDcP4hmVuKbyfniC1u+uc/t9BZT+j
         k5ogskh7gxYyEpeL2Rc1KhxepYxWWBnYMPRcX/OysN4QbIBwqdsedNJEUnQHQ0PtJN0o
         BfWIT3II/nZK63U36vnhqhCHQ2cEVjHllHb5asv5aon3Ok5dhrsIKs4o6HdGvUtkoQcW
         +//4oBh77B5bd7SrrL4YKY421zxiXNCq/CWtNJG+PRFb5EFs02MS2vBenVWoZ1+a8w5j
         gvaycrz0j43LKoRqvXT+iQjWEUPPKHKL2/WsIZYVFwPnN+SdEx35obmKvKAIPKBepxLV
         H7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791931238; x=1792536038;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KZW0TlkuVx1/ay444vuidlpbLOf1N6NgoBIEapd0snM=;
        b=u9NrjQRXvGCZaXAVw3j0bhOEPi3XZtb7/vPQUCd6C8XU7tPEMTE0OWzTP8In20mm0r
         Ltk7UwAbpG8o1YdN26R8CyMWL2XCBKXfib5Zl9ycp5VldQC97+vA1pBeF+QxOEp36Vm+
         1s4FpuyqwvjNv7d3UEh6wBT4ySyYJblykOMz07sYNbkGTwat16huagBEFfomPFrLPKlv
         0BBjyrjppd6Hr8Uae577nJ1Nr8gJ0ncMjbB3X1POTvPywRn6zigul3OszMhC2NWyO8TC
         pxzeh6Ssa/EfX17ELNpbeVbTyfdFy3+solQUSp5IKmolEzoHCfjRZqN+7bbx43rEkU2J
         bSDg==
X-Forwarded-Encrypted: i=1; AKwUvBwu77g7zqKqgguAF29ZJAOUh302Eippsd6Kw3WNu/WpBJctqiyqBR2/DlqgUXhiqXVnB6Q4jd318Efc@vger.kernel.org
X-Gm-Message-State: AFq9FYL/NHMundHLj5hC2KbV6fg1I0MKiweLASm9C/wTAAjnM8xe18zP
	3b3/20WV7DZUw+ZsH7Yh0IOoHBiH0hVPJrBVpnuc8n7jwMhiCo7jEExID8ql0hRr/6xCRVc6XGa
	fkB9gscDpIA==
X-Received: from dly17-n1.prod.google.com ([2002:a05:701b:2051:10b0:168:6cd7:1061])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b0d4:b0:141:4a06:ad6f
 with SMTP id a92af1059eb24-16a5dfd5d8cmr22211984c88.8.1791931237569; Tue, 13
 Oct 2026 15:40:37 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:39:46 -0700
In-Reply-To: <20261013223946.1836757-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013223946.1836757-12-irogers@google.com>
Subject: [PATCH 11/11] kobject: Require explicit initialization of struct kobj_type::release
From: Ian Rogers <irogers@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Documentation/core-api/kobject.rst states:

  "One important point cannot be overstated: every kobject must have a
  release() method, and the kobject must persist (in a consistent state)
  until that method is called. If these constraints are not met, the code is
  flawed. Note that the kernel will warn you if you forget to provide a
  release() method. Do not try to get rid of this warning by providing an
  "empty" release function."

Annotate struct kobj_type::release with __require_explicit_initialization
so the compiler diagnoses any struct kobj_type initializer that omits
.release.

For the remaining legacy struct kobj_type definitions where the kobject
is static, per-CPU, or embedded inside a devm- or parent-managed
structure rather than freed by kobject_put(), explicitly initialize
.release = NULL with a comment documenting why no release callback is
provided.

Link: https://lpc.events/event/20/contributions/2392/
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/arm64/kernel/cpuinfo.c                          | 2 ++
 drivers/acpi/sysfs.c                                 | 2 ++
 drivers/dma/ioat/sysfs.c                             | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c              | 4 ++++
 drivers/infiniband/hw/hfi1/sysfs.c                   | 2 ++
 drivers/infiniband/hw/usnic/usnic_ib_sysfs.c         | 2 ++
 drivers/parisc/pdc_stable.c                          | 2 ++
 drivers/power/supply/ab8500_fg.c                     | 2 ++
 drivers/soc/hisilicon/kunpeng_hccs.c                 | 6 ++++++
 drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c | 2 ++
 drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c | 2 ++
 drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c | 2 ++
 fs/erofs/sysfs.c                                     | 4 ++++
 fs/f2fs/sysfs.c                                      | 6 ++++++
 fs/ocfs2/cluster/masklog.c                           | 2 ++
 include/linux/kobject.h                              | 2 +-
 16 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 45c63f3d75c5..ab78efdb13f5 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -309,6 +309,8 @@ const struct seq_operations cpuinfo_op = {
 
 
 static const struct kobj_type cpuregs_kobj_type = {
+	/* info->kobj is embedded in per-CPU cpu_data; cpuid_cpu_offline() only calls kobject_del(). */
+	.release = NULL,
 	.sysfs_ops = &kobj_sysfs_ops,
 };
 
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index dd4a99f09efe..7534d3f305ba 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -972,6 +972,8 @@ static struct attribute *hotplug_profile_attrs[] = {
 ATTRIBUTE_GROUPS(hotplug_profile);
 
 static const struct kobj_type acpi_hotplug_profile_ktype = {
+	/* hotplug->kobj is embedded in static struct acpi_scan_hotplug objects. */
+	.release = NULL,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = hotplug_profile_groups,
 };
diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
index e796ddb5383f..7fdd0ca36b98 100644
--- a/drivers/dma/ioat/sysfs.c
+++ b/drivers/dma/ioat/sysfs.c
@@ -167,6 +167,8 @@ static const struct attribute *const ioat_attrs[] = {
 ATTRIBUTE_GROUPS(ioat);
 
 const struct kobj_type ioat_ktype = {
+	/* ioatdma_chan is allocated via devm_kzalloc() rather than freed by kobject_put(). */
+	.release = NULL,
 	.sysfs_ops = &ioat_sysfs_ops,
 	.default_groups = ioat_groups,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index b15af318784b..0477468f12ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -789,6 +789,8 @@ static const struct sysfs_ops xcp_cfg_res_sysfs_ops = {
 };
 
 static const struct kobj_type xcp_cfg_res_sysfs_ktype = {
+	/* xcp_res is embedded in struct amdgpu_xcp_cfg rather than freed individually by kobject_put(). */
+	.release = NULL,
 	.sysfs_ops = &xcp_cfg_res_sysfs_ops,
 	.default_groups = xcp_cfg_res_sysfs_groups,
 };
@@ -1053,6 +1055,8 @@ static const struct attribute_group amdgpu_xcp_attrs_group = {
 };
 
 static const struct kobj_type xcp_sysfs_ktype = {
+	/* xcp is embedded in struct amdgpu_xcp_mgr rather than freed individually by kobject_put(). */
+	.release = NULL,
 	.sysfs_ops = &kobj_sysfs_ops,
 };
 
diff --git a/drivers/infiniband/hw/hfi1/sysfs.c b/drivers/infiniband/hw/hfi1/sysfs.c
index 372cfd13dc61..33b26650069d 100644
--- a/drivers/infiniband/hw/hfi1/sysfs.c
+++ b/drivers/infiniband/hw/hfi1/sysfs.c
@@ -608,6 +608,8 @@ static const struct sysfs_ops sde_sysfs_ops = {
 };
 
 static struct kobj_type sde_ktype = {
+	/* sdma_engine is embedded in the dd->per_sdma array rather than freed by kobject_put(). */
+	.release = NULL,
 	.sysfs_ops = &sde_sysfs_ops,
 };
 
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
index fdb63a8fb997..234d8d9532aa 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
@@ -245,6 +245,8 @@ static struct attribute *usnic_ib_qpn_default_attrs[] = {
 ATTRIBUTE_GROUPS(usnic_ib_qpn_default);
 
 static struct kobj_type usnic_ib_qpn_type = {
+	/* usnic_ib_qp_grp is embedded in RDMA core-managed struct usnic_ib_qp_grp. */
+	.release = NULL,
 	.sysfs_ops = &usnic_ib_qpn_sysfs_ops,
 	.default_groups = usnic_ib_qpn_default_groups,
 };
diff --git a/drivers/parisc/pdc_stable.c b/drivers/parisc/pdc_stable.c
index 16f4496bca95..6d972c965c1e 100644
--- a/drivers/parisc/pdc_stable.c
+++ b/drivers/parisc/pdc_stable.c
@@ -484,6 +484,8 @@ ATTRIBUTE_GROUPS(paths_subsys);
 
 /* Specific kobject type for our PDC paths */
 static const struct kobj_type ktype_pdcspath = {
+	/* pdcspath_entry instances are static; lifetime is not controlled by kobject_put(). */
+	.release = NULL,
 	.sysfs_ops = &pdcspath_attr_ops,
 	.default_groups = paths_subsys_groups,
 };
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index e6b5efdf5dc9..206ee2e392fb 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2531,6 +2531,8 @@ static struct attribute *ab8500_fg_attrs[] = {
 ATTRIBUTE_GROUPS(ab8500_fg);
 
 static const struct kobj_type ab8500_fg_ktype = {
+	/* fg_kobject is embedded in devm-allocated struct ab8500_fg; ab8500_fg_sysfs_exit() only calls kobject_del(). */
+	.release = NULL,
 	.sysfs_ops = &ab8500_fg_sysfs_ops,
 	.default_groups = ab8500_fg_groups,
 };
diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index 0cc2953d59a5..5d083d2b72ca 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -1038,6 +1038,8 @@ static struct attribute *hccs_port_default_attrs[] = {
 ATTRIBUTE_GROUPS(hccs_port_default);
 
 static const struct kobj_type hccs_port_type = {
+	/* hccs_port_info is allocated via devm_kcalloc() rather than freed by kobject_put(). */
+	.release = NULL,
 	.sysfs_ops = &hccs_comm_ops,
 	.default_groups = hccs_port_default_groups,
 };
@@ -1110,6 +1112,8 @@ static struct attribute *hccs_die_default_attrs[] = {
 ATTRIBUTE_GROUPS(hccs_die_default);
 
 static const struct kobj_type hccs_die_type = {
+	/* hccs_die_info is allocated via devm_kcalloc() rather than freed by kobject_put(). */
+	.release = NULL,
 	.sysfs_ops = &hccs_comm_ops,
 	.default_groups = hccs_die_default_groups,
 };
@@ -1213,6 +1217,8 @@ static struct attribute *hccs_chip_default_attrs[] = {
 ATTRIBUTE_GROUPS(hccs_chip_default);
 
 static const struct kobj_type hccs_chip_type = {
+	/* hccs_chip_info is allocated via devm_kcalloc() rather than freed by kobject_put(). */
+	.release = NULL,
 	.sysfs_ops = &hccs_comm_ops,
 	.default_groups = hccs_chip_default_groups,
 };
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
index ae937854403b..3d787245f5b5 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
@@ -304,6 +304,8 @@ static const struct sysfs_ops display_sysfs_ops = {
 };
 
 static struct kobj_type display_ktype = {
+	/* dssdev->kobj is embedded in struct omap_dss_device and zeroed in display_uninit_sysfs(). */
+	.release = NULL,
 	.sysfs_ops = &display_sysfs_ops,
 	.default_groups = display_sysfs_groups,
 };
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
index 1b644be5fe2e..cf816e83e903 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
@@ -496,6 +496,8 @@ static const struct sysfs_ops manager_sysfs_ops = {
 };
 
 static struct kobj_type manager_ktype = {
+	/* mgr->kobj is embedded in static managers[] and zeroed in dss_manager_kobj_uninit(). */
+	.release = NULL,
 	.sysfs_ops = &manager_sysfs_ops,
 	.default_groups = manager_sysfs_groups,
 };
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
index 1da4fb1c77b4..9aa16b3dee5e 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
@@ -429,6 +429,8 @@ static const struct sysfs_ops overlay_sysfs_ops = {
 };
 
 static struct kobj_type overlay_ktype = {
+	/* ovl->kobj is embedded in static overlays[]; dss_overlay_kobj_uninit() only calls kobject_del(). */
+	.release = NULL,
 	.sysfs_ops = &overlay_sysfs_ops,
 	.default_groups = overlay_sysfs_groups,
 };
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index dfcec9376cd5..588d541e1713 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -238,6 +238,8 @@ static const struct kobj_type erofs_sb_ktype = {
 static const struct kobj_type erofs_ktype = {
 	.default_groups = erofs_groups,
 	.sysfs_ops	= &erofs_attr_ops,
+	/* erofs_root is a static struct kset; lifetime is not controlled by kobject_put(). */
+	.release	= NULL,
 };
 
 static struct kset erofs_root = {
@@ -247,6 +249,8 @@ static struct kset erofs_root = {
 static const struct kobj_type erofs_feat_ktype = {
 	.default_groups = erofs_feat_groups,
 	.sysfs_ops	= &erofs_attr_ops,
+	/* erofs_feat is a static struct kobject; lifetime is not controlled by kobject_put(). */
+	.release	= NULL,
 };
 
 static struct kobject erofs_feat = {
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 811e350a1430..a66cef927c62 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1653,6 +1653,8 @@ static const struct kobj_type f2fs_sb_ktype = {
 
 static const struct kobj_type f2fs_ktype = {
 	.sysfs_ops	= &f2fs_attr_ops,
+	/* f2fs_kset is a static struct kset; lifetime is not controlled by kobject_put(). */
+	.release	= NULL,
 };
 
 static struct kset f2fs_kset = {
@@ -1667,6 +1669,8 @@ static const struct sysfs_ops f2fs_feat_attr_ops = {
 static const struct kobj_type f2fs_feat_ktype = {
 	.default_groups = f2fs_feat_groups,
 	.sysfs_ops	= &f2fs_feat_attr_ops,
+	/* f2fs_feat is a static struct kobject; lifetime is not controlled by kobject_put(). */
+	.release	= NULL,
 };
 
 static struct kobject f2fs_feat = {
@@ -1681,6 +1685,8 @@ static const struct sysfs_ops f2fs_tune_attr_ops = {
 static const struct kobj_type f2fs_tune_ktype = {
 	.default_groups = f2fs_tune_groups,
 	.sysfs_ops	= &f2fs_tune_attr_ops,
+	/* f2fs_tune is a static struct kobject; lifetime is not controlled by kobject_put(). */
+	.release	= NULL,
 };
 
 static struct kobject f2fs_tune = {
diff --git a/fs/ocfs2/cluster/masklog.c b/fs/ocfs2/cluster/masklog.c
index 563881ddbf00..e476fa7ffea6 100644
--- a/fs/ocfs2/cluster/masklog.c
+++ b/fs/ocfs2/cluster/masklog.c
@@ -147,6 +147,8 @@ static const struct sysfs_ops mlog_attr_ops = {
 static struct kobj_type mlog_ktype = {
 	.default_groups = mlog_default_groups,
 	.sysfs_ops      = &mlog_attr_ops,
+	/* mlog_kset is a static struct kset; lifetime is not controlled by kobject_put(). */
+	.release        = NULL,
 };
 
 static struct kset mlog_kset = {
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 55e37a5d405e..e65331717e03 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -114,7 +114,7 @@ void kobject_get_ownership(const struct kobject *kobj, kuid_t *uid, kgid_t *gid)
 char *kobject_get_path(const struct kobject *kobj, gfp_t flag);
 
 struct kobj_type {
-	void (*release)(struct kobject *kobj);
+	void (*release)(struct kobject *kobj) __require_explicit_initialization;
 	const struct sysfs_ops *sysfs_ops;
 	const struct attribute_group **default_groups;
 	const struct kobj_ns_type_operations *(*child_ns_type)(const struct kobject *kobj);
-- 
2.56.0.385.gd3acb90ef8-goog

