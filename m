Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F5D560AC8
	for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931217; cv=none; b=poD7P/nx1s2+mlVLqyrkGipVQmktjxiewt8y6sVcHGupSdFwk9Fd+toiwBLAkQJFnSJPEXpjnMJN1a4/rqK1eLlx3u9u1F9ZxPWkvFY1oxild66/cLS7vuQ/CKoNLpqtdTkMICv6yaAlQRrkq/kABUFRVCfU7J3G1sT9OomajvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931217; c=relaxed/simple;
	bh=4WrpaiXx1GRQVpjm8b7gmWUkva2m2HTUpEY5WAi28rA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YEDl5xNtc2gwc04K+fV5EvnyL9n7DJHnkcFVWHl2oAFNYsLUmX0y0lajvmSVlJWJGIUod2JkXWND+RqrtEgTAoP/8rDs6nPBW1Bxq0p8JuvmOLZJ/40GwISH+CESbcfqbsWSpy6y6WoYP1cwhnps80TSpXqjuVWPo9yunVve6uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bn7hz90c; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bn7hz90c"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-151ba226e1bso3776244c88.0
        for <linux-s390@vger.kernel.org>; Tue, 13 Oct 2026 15:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791931213; x=1792536013; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6CWZGGdh7JOQ6UqV1gxmMbPkjK0LPv1nbOU26QpmZ10=;
        b=Bn7hz90c5SJwfQmP2+AW3dGAkw3UtweF3iEJs/fRS4ftpX9ZUfay81B5NwyLYLDRu0
         JjNCwwMOY0bD6FwU7BsgiuLRwurYP8wW9es3IJGv8W7CiB4fefjuPLFLPJCVKKi7I6RI
         oV6uPm/zxlsOkbWwFy17l83iB7KSy6ghSZjl7g4d+WDxw47jSVJgwBFEE2gZJh3cGYCh
         AJc/NlWZK3dIlCPz7w6Mhk08iXNFzMsqxUm42YSyD70MPigXT5E+D88R2wBPNCYmOgB9
         sx+IjU/fnz6dU6nMTKMNh1pR9SUPORMsjJrcOn4zw5C6K9GMMYn0RxKiDx0CTtsij7Gc
         ISow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791931213; x=1792536013;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6CWZGGdh7JOQ6UqV1gxmMbPkjK0LPv1nbOU26QpmZ10=;
        b=XggDU9yuRAS3m5WOg/2cpn8x8IVFld4g665FY3DLJifwu/UB5ogM6uuSFSzmI+NFer
         hfCtYm3DsrYQZz5jmbkxGBRPY0+vVW1kUkMNpV+5ev1IbWOCp3AEao+siNBfIxvOljB4
         aPoclLOefOTXWOlmXEFr7lRQCHRr9s2Z/RJwUr7ZO02hpaU0SZsKkjCdeyGRjpA9EB6L
         yWMlVou5vQcwNKJPzvLWRSUk0H0I+ry/O2iosGyZQcbT0rObY65XhcSz6dXljHpr1lBz
         SbwSpSsaWQcFsHRqtNT9c2iCxueUYTomeZa2aalZuHFWfDSzLFwuoRv8Mo/yFWLsy+ja
         dTHg==
X-Forwarded-Encrypted: i=1; AKwUvBy/0nRKNU7U5kDFpPRjwqj/rPvC3hcRZa+F6TiXQe5mOCwE6IQQV0yfL92TueUdBRAAAewh27eW585A@vger.kernel.org
X-Gm-Message-State: AFq9FYIwRaSiJfvUiKxSYxMeZnc+6FBBnGy0SyoMkJdmfLSZjb4+pDgc
	oR97CD/ZpwOwzCr4z5jpo8PZdkQaEdmS02FlGE43ZVLQE+wokGEpXbeFlw2kAR4KZpXq56vnbXq
	IlggXRAgq4g==
X-Received: from dlak14.prod.google.com ([2002:a05:701b:290e:b0:14e:f9ab:6f83])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2309:b0:153:7a27:b89
 with SMTP id a92af1059eb24-16a5ed4008cmr22709999c88.21.1791931212336; Tue, 13
 Oct 2026 15:40:12 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:39:35 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013223946.1836757-1-irogers@google.com>
Subject: [PATCH 00/11] kobject: Require explicit initialization of struct kobj_type::release
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

Clang supports the 'require_explicit_initialization' attribute on struct
fields to enforce that the field is explicitly initialized when an
aggregate object is constructed, emitting -Wuninitialized-explicit-init
(enabled by default) if the field is omitted.

Following discussion at the Linux Plumbers Conference [1], this series
introduces __require_explicit_initialization in
include/linux/compiler_attributes.h and applies it to
struct kobj_type::release.

As Documentation/core-api/kobject.rst notes:
  "One important point cannot be overstated: every kobject must have a
  release() method, and the kobject must persist (in a consistent state)
  until that method is called. If these constraints are not met, the code
  is flawed."

Annotating struct kobj_type::release caught 30 struct kobj_type
definitions across the tree that omitted .release:
- Patches 2-10 fix 10 struct kobj_type definitions where dynamically
  allocated kobjects, ksets, or enclosing structures were either leaked on
  kobject_put() or freed prematurely before kobject release (risking a
  use-after-free when CONFIG_DEBUG_KOBJECT_RELEASE=y).
- Patch 11 annotates struct kobj_type::release with
  __require_explicit_initialization and explicitly sets .release = NULL
  (with explanatory comments) on the remaining legacy struct kobj_type
  definitions whose kobjects are static, per-CPU, or embedded in devm- or
  parent-managed structures.

[1] https://lpc.events/event/20/contributions/2392/

Ian Rogers (11):
  Compiler Attributes: Add __require_explicit_initialization macro
  powerpc/secvar: Add missing kobject release callback to secvar_ktype
  sh: sq: Add missing kobject release callback to ktype_percpu_entry
  cpufreq: Initialize kobj_type release callback in ondemand and
    conservative governors
  ACPI: CPPC: Free cpc_desc in kobject release callback
  dlm: Free dlm_ls in kobject release callback
  xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
  s390/sclp_mem: Allocate struct sclp_mem dynamically and add kobject
    release
  ubifs: sysfs: Use kset_create_and_add() for ubifs_kset
  drm/amdkfd: Free queue in procfs_queue_type kobject release callback
  kobject: Require explicit initialization of struct kobj_type::release

 Documentation/conf.py                         |  1 +
 arch/arm64/kernel/cpuinfo.c                   |  2 +
 arch/powerpc/kernel/secvar-sysfs.c            |  6 ++
 arch/sh/kernel/cpu/sh4/sq.c                   |  6 ++
 drivers/acpi/cppc_acpi.c                      | 39 +++++-----
 drivers/acpi/sysfs.c                          |  2 +
 drivers/cpufreq/cpufreq_conservative.c        |  5 +-
 drivers/cpufreq/cpufreq_governor.c            |  3 +-
 drivers/cpufreq/cpufreq_governor.h            |  1 +
 drivers/cpufreq/cpufreq_ondemand.c            |  5 +-
 drivers/dma/ioat/sysfs.c                      |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c       |  4 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 10 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |  5 +-
 drivers/infiniband/hw/hfi1/sysfs.c            |  2 +
 drivers/infiniband/hw/usnic/usnic_ib_sysfs.c  |  2 +
 drivers/parisc/pdc_stable.c                   |  2 +
 drivers/power/supply/ab8500_fg.c              |  2 +
 drivers/s390/char/sclp_mem.c                  | 73 +++++++++----------
 drivers/soc/hisilicon/kunpeng_hccs.c          |  6 ++
 .../fbdev/omap2/omapfb/dss/display-sysfs.c    |  2 +
 .../fbdev/omap2/omapfb/dss/manager-sysfs.c    |  2 +
 .../fbdev/omap2/omapfb/dss/overlay-sysfs.c    |  2 +
 drivers/xen/sys-hypervisor.c                  |  6 ++
 fs/dlm/lockspace.c                            | 19 +++--
 fs/erofs/sysfs.c                              |  4 +
 fs/f2fs/sysfs.c                               |  6 ++
 fs/ocfs2/cluster/masklog.c                    |  2 +
 fs/ubifs/sysfs.c                              | 24 ++----
 include/linux/compiler_attributes.h           | 11 +++
 include/linux/kobject.h                       |  2 +-
 scripts/checkpatch.pl                         |  1 +
 tools/lib/python/kdoc/xforms_lists.py         |  1 +
 33 files changed, 170 insertions(+), 90 deletions(-)

-- 
2.56.0.385.gd3acb90ef8-goog

