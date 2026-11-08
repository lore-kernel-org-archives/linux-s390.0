Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177582;
	b=mqGoVFrRJp74Bu5deOALIgNmHKZ4wI9WfktP6iH9Y7YnT7/rb2Q851/HZWKKfTknnTWQ
	 GFqhI4LXXWwOlDtcTfQW2KG93dhNiGBaH3QueoZZSkU4kscGR5/ix/5qi2LpkxSAAUGym
	 kNzr8Cw9M7WVyDiMRZbMPrqur594xWqJ+ANTXeuvt5mIpFdQO5NecCbw0VdwwvdFzDQjA
	 IA1fafrpiBnDOJ+CALGM/f+7/tFEqneS8+scdnNo2gyqqxWyhdGRl6JfiomFkeAai+1Ok
	 dyneH0gaWt/c4ZWiYKzrNeTzj1+tZIksiKzPBjhulZEv3gUc1otlVAixV+Xz+5fIucw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=dh1tm53EjhTHyh6SV5ixAXTcy4PG9n9Z3Dkm6AKA6MM=;
	b=LFzWyMd11Bh1uDpCUPuk/WEEmYt+ExAd82DSIykPyr1cpn093k9lNl/3/K/RFjdT174z
	 vAvrv9/RQTiL3bPV41MupljHSHLFM72Bizbh6SOX29D7GEhyGUMSWbnH1/HfxHZpePTpS
	 pURk9IPYaVWcLkVYW9+rlrUU85/1wJ5L5unzgBu4qOwR1xHAz6+UXiHQC/kexrlCFUIrN
	 Gdpe0sAbCX2VqYAdquuro97q0TmeMc//tFYcfyfD+2PzlGCjD/v9XJBr+73pqx24v7RM9
	 IKjBXW8lnzsA26OoKhu6I9f0sBnM6pLnV9kx/6IUhz7/pEiXu/B7YLoJPTTpOmGMIiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ldVjID6l;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36850606A321
	for <linux-s390@vger.kernel.org>; Sun,  8 Nov 2026 22:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36850606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ldVjID6l
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36de26cb4b3so346879eec.1
        for <linux-s390@vger.kernel.org>; Sun, 08 Nov 2026 14:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794177580; x=1794782380; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dh1tm53EjhTHyh6SV5ixAXTcy4PG9n9Z3Dkm6AKA6MM=;
        b=ldVjID6loqmnPNFD/OaQ1ryvyuLqFJ8E4Rmks8oFWxH8wb56ZGhOTinJd6AgOSJN6X
         eyQWYvinnqT6zEG01/RQdCnGd6x2V0Jftj7n4U/vmVkJUAhXm9rpFjoL01D6FYnKlWMB
         Se/KJEsvGUwegaaKRjgstvqc+0E4NQMuqMIJdhVIGH4bcKeGAMpeJ2uStDl2Agul0sFQ
         YSe6vinpwXu6tG+d9D+72/I67lvbThO1xg3qGRJUtBZaFA/7UJHqfOcZnShjW51+jr0M
         Zgd8zjOIOlB2rBdIFJRuAFHSOb8t2TN7R5dw1AvU8DbOcav9gt8mQ58ntKfCqbONMFCX
         d4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177580; x=1794782380;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dh1tm53EjhTHyh6SV5ixAXTcy4PG9n9Z3Dkm6AKA6MM=;
        b=sUIoUUuaoisBpfiDRq4JHuEKNqEaV9jR9OCni128bW5wEeQOFKNlm6P1ltLjseGeMF
         +ujlhUYGnmgm0QlbhEo/t6oxkbKvcLr1+ge7do2mRjLzydJb7zwGfyv56ztNxZv/xMQk
         oDC7Jjtb51SF4FO4dvi13ti3dIBAk6BR8caQGg4ygVVu3QjNwsED4cJO5szOALMZqtK5
         7VQTdAnx0+s68pVmO/WQIv5wlAl2n6E4x3t6l9kVqT1B6CRNlSqNbHFTVY7JcN/bdOmt
         I6K/RwbMmTS0RylqlxOwffK1JnWIWW3sToDiSSx0A+e85YBD2543CUV8KZ+D4o+fIL5q
         qQWA==
X-Forwarded-Encrypted: i=1; AL+hErELQF3r2VicGfD+39QeEHCh6rcqmOcFyJyY8aRfwYDSMtBdj2PBBb6hQVkKveV7PkVa0TazFVOOHgGt@vger.kernel.org
X-Gm-Message-State: APuU4Z9p7w1Km1BTzY1VycAlhTapzdaTf+7NuMeqOexOp0dt900QGYRw
	HbZIcftLbxk/ncHNlIhClQL2WfE3huAB+LfOGAc2UsjwFpCkEvEEk08drwDdSUNNZ+pr5wQrI1Y
	iifWDg0HkcA==
X-Received: from dyba7.prod.google.com ([2002:a05:693c:63c7:b0:372:278c:c777])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e5cb:b0:370:d6e4:e8aa
 with SMTP id 5a478bee46e88-3725826f58cmr4715450eec.41.1794177579956; Sun, 08
 Nov 2026 14:39:39 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:04 -0800
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261108223913.3624571-1-irogers@google.com>
Subject: [PATCH v3 0/9] Add __must_init and require explicit kobj_type::release
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
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

Clang supports the 'require_explicit_initialization' attribute on struct
fields to enforce that the field is explicitly initialized when an
aggregate object is constructed, emitting -Wuninitialized-explicit-init
(enabled by default) if the field is omitted.

Following discussion at the Linux Plumbers Conference [1], patch 1 adds
the attribute to include/linux/compiler_attributes.h as __must_init. In
v1 it was called __require_explicit_initialization. Kees picked up that
patch with a first seq_file user [2], and in that thread Greg suggested
the shorter __must_init spelling, which Kees and Miguel agreed to. As
the attribute did not land in the v7.4 merge window, Kees asked that
this series carry the renamed attribute.

As Documentation/core-api/kobject.rst notes:
  "One important point cannot be overstated: every kobject must have a
  release() method, and the kobject must persist (in a consistent state)
  until that method is called. If these constraints are not met, the
  code is flawed."

Annotating struct kobj_type::release caught struct kobj_type definitions
across the tree that omitted .release:
- Patches 2-8 fix struct kobj_type definitions where dynamically
  allocated kobjects, ksets, or enclosing structures were either leaked
  on kobject_put(), freed prematurely before kobject release, or missing
  proper static initializers.
- Patch 9 annotates struct kobj_type::release with __must_init and
  explicitly sets .release = NULL (with explanatory comments prefixed
  with "Pre-existing:") on the remaining legacy struct kobj_type
  definitions whose kobjects are static, per-CPU, permanent firmware
  structures, or embedded in devm- or parent-managed allocations.

Danilo Krummrich offered to route the series as a whole through the
driver-core tree [3]. Subsystem maintainer Acked-by tags are still
needed (and would be much appreciated!) for the following three patches:
- Patch 2: powerpc/secvar: Add missing kobject release callback to secvar_ktype
- Patch 3: sh: sq: Add missing kobject release callback to ktype_percpu_entry
- Patch 6: xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type

Note on tool use: An LLM coding assistant was used to help audit the
compiler diagnostics across the tree, draft the fixes and changelog
descriptions, and verify builds and review feedback.

Changes in v3:
- Rebased on v7.4-rc1.
- Note in cover letter that patches 2 (powerpc/secvar), 3 (sh: sq), and
  6 (xen/sys-hypervisor) are still awaiting subsystem Acked-by tags for
  merging through the driver-core tree, and CC those maintainers on the
  cover letter.
- Patch 1: Add Reviewed-by from Kees Cook; clarify that LLVM issue
  #232483 affects Clang versions prior to its upstream fix (pointed out
  by Nathan Chancellor).
- Patch 4 (cpufreq): Drop obsolete reference to cpufreq_governor_dbs in
  the commit message per Zhongqiu Han; add Reviewed-by from Zhongqiu Han
  and Acked-by from Rafael J. Wysocki and Viresh Kumar.
- Patch 5 (dlm): Add Acked-by from Alexander Aring.
- Patch 8 (drm/amdkfd): Add Reviewed-by from Felix Kuehling.
- Patch 9 (kobject): Fix omapfb manager-sysfs.c and overlay-sysfs.c
  comments to describe managers[] and overlays[] as dynamically
  allocated rather than static and note the CONFIG_DEBUG_KOBJECT_RELEASE
  hazard, fix a struct-vs-member wording nit in usnic_ib_sysfs.c, and
  generalize the commit message note on CONFIG_DEBUG_KOBJECT_RELEASE
  (reported by Sashiko).

Changes in v2:
- Rebased on v7.3-16928-g83f32c773255 (v7.4 merge window).
- Patch 1: Rename __require_explicit_initialization to __must_init per
  Greg Kroah-Hartman; document the Clang >= 20 requirement per Miguel
  Ojeda; note the Clang gap for file-scope objects without an
  initializer reported by Kees Cook; add tags from v1 and from Kees's
  posting.
- Move LLM assistance attribution from Assisted-by tags to this cover
  letter per commit 1e035297ffda ("docs: remove Assisted-by
  references").
- Patch 4 (cpufreq): Use "cpufreq: governor:" prefix, drop Fixes tag,
  fix typo, and remove the redundant runtime assignment in
  cpufreq_dbs_governor_init() per Zhongqiu Han.
- Dropped v1 patch 5 (ACPI: CPPC), already fixed upstream by
  commit 27954e29d7de ("ACPI: CPPC: Release CPC descriptors through
  kobject").
- Patch 5 (dlm): Call kobject_del() before dlm_recoverd_stop() in
  release_lockspace() and the new_lockspace() error path, and wait on a
  new ls_kobj_done completion before freeing the lockspace or dropping
  the module reference, avoiding races with delayed kobject release.
- Dropped v1 patch 8 (s390/sclp_mem) per Sumanth Korikkar: the
  /sys/firmware/memory/memoryX kobjects are permanent, so sclp_mem.c is
  folded into patch 9 with .release = NULL.
- Patch 7 (ubifs): Add Tested-by and Reviewed-by from Zhihao Cheng.
- Patch 8 (drm/amdkfd): Check q->kobj.state_in_sysfs before
  kobject_del() in kfd_procfs_del_queue().
- Patch 9 (kobject): Cover sclp_mem.c and the new amdgpu_ualink.c
  ualink_xcp_info_ktype, fix the overlay-sysfs.c comment, and prefix
  legacy .release = NULL comments with "Pre-existing:".
- Patch 9 (kobject): The ioat, kunpeng_hccs and omapfb display comments
  now say that the existing teardown can use-after-free under
  CONFIG_DEBUG_KOBJECT_RELEASE (reported by Sashiko). Fixing those
  drivers is left to follow-up patches.

v2: https://lore.kernel.org/all/20261027223847.652884-1-irogers@google.com/
v1: https://lore.kernel.org/all/20261013223946.1836757-1-irogers@google.com/
[1] https://lpc.events/event/20/contributions/2392/
[2] https://lore.kernel.org/lkml/20261014225811.i.852-kees@kernel.org/
[3] https://lore.kernel.org/all/DMLWX8NY1N1N.2OMQMQCIVRR18@kernel.org/

Ian Rogers (9):
  Compiler Attributes: Add __must_init macro
  powerpc/secvar: Add missing kobject release callback to secvar_ktype
  sh: sq: Add missing kobject release callback to ktype_percpu_entry
  cpufreq: governor: Initialize kobj_type release callback statically
  dlm: Free dlm_ls in kobject release callback
  xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
  ubifs: sysfs: Use kset_create_and_add() for ubifs_kset
  drm/amdkfd: Free queue in procfs_queue_type kobject release callback
  kobject: Require explicit initialization of struct kobj_type::release

 Documentation/conf.py                         |  1 +
 arch/arm64/kernel/cpuinfo.c                   |  5 ++++
 arch/powerpc/kernel/secvar-sysfs.c            |  6 +++++
 arch/sh/kernel/cpu/sh4/sq.c                   |  6 +++++
 drivers/acpi/sysfs.c                          |  2 ++
 drivers/cpufreq/cpufreq_conservative.c        |  5 +++-
 drivers/cpufreq/cpufreq_governor.c            |  4 +--
 drivers/cpufreq/cpufreq_governor.h            |  1 +
 drivers/cpufreq/cpufreq_ondemand.c            |  5 +++-
 drivers/dma/ioat/sysfs.c                      |  7 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    |  5 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c       | 10 +++++++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 12 ++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |  5 +++-
 drivers/infiniband/hw/hfi1/sysfs.c            |  5 ++++
 drivers/infiniband/hw/usnic/usnic_ib_sysfs.c  |  5 ++++
 drivers/parisc/pdc_stable.c                   |  5 ++++
 drivers/power/supply/ab8500_fg.c              |  5 ++++
 drivers/s390/char/sclp_mem.c                  |  2 ++
 drivers/soc/hisilicon/kunpeng_hccs.c          | 21 +++++++++++++++
 .../fbdev/omap2/omapfb/dss/display-sysfs.c    |  7 +++++
 .../fbdev/omap2/omapfb/dss/manager-sysfs.c    |  8 ++++++
 .../fbdev/omap2/omapfb/dss/overlay-sysfs.c    |  8 ++++++
 drivers/xen/sys-hypervisor.c                  |  6 +++++
 fs/dlm/dlm_internal.h                         |  1 +
 fs/dlm/lockspace.c                            | 26 ++++++++++++++-----
 fs/erofs/sysfs.c                              | 10 +++++++
 fs/f2fs/sysfs.c                               | 15 +++++++++++
 fs/ocfs2/cluster/masklog.c                    |  5 ++++
 fs/ubifs/sysfs.c                              | 24 +++++------------
 include/linux/compiler_attributes.h           | 12 +++++++++
 include/linux/kobject.h                       |  2 +-
 scripts/checkpatch.pl                         |  1 +
 tools/lib/python/kdoc/xforms_lists.py         |  1 +
 34 files changed, 211 insertions(+), 32 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0.455.g6c5a503b38-goog

