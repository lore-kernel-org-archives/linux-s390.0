Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116360;
	b=ESjMbBLwXuTxUWr0Mbv2Fsp1tgWfr3tXHBhAt06ut/nLhZDYGS9kJs8JzvnoGG5FDJ+d
	 Mbjmyrel0EQfII+Z+NNNUAZ8MK5xsysgtPVr1X/yjXK4eiMUn5iNiIa9vLn+KIjBXKujp
	 J7dGpwLsfwZdXIPKzgMdMzxIx+eQ9Njmlhi7SNV3cY1cH6WpIpbdnmfSxG0GKSTE9d+SY
	 eDlBdMZUiQdU2JKysz2ft7Gk0KQa728QSIQFn7Hduh6dCFd8O8f6owjey+7yMwJOvkSVv
	 DN+FkAc1/oU04CFYUEn4b2/ChZJs+lIFGtecXODPBBjkURsPh+W9xF589JwKycm7hUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=MCKguj/vcFyjyUsBFpEVwvA/Ew8DwdobaKTpU+d8I2Y=;
	b=DnqOb3hIFR6DBrrRgNO8dUjLUMw3DhcrKF/yf5TliHfAL4bLVdD+RvzgR0Nq0XsQLx2N
	 R20XsuU/7UlI4ZVFgRIXt1wiOHjtq3PJBhF2zsvGcCf+q5C0pZu5F0qQB1g/2Skm58JmQ
	 wy+IXj+zLf4WxPqcQAPDOxAgW8PGyd8lm9BDAdg9YnwIfBfT77QK26oa/QM2WdsRNuBF+
	 FjgtFks4AYaoPQLeHZcQLwO+QwCZs0axGO4yGzY5dVF6vIn5ReGs6Pu6YT5fh5csmF/du
	 J88Krfi4u/NX+RQBuR4XPbh8AluG6Oqn8mGz1VT7z1+2mNLxoL54kgnD+pS0+DFxknw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=D+q8GpbI;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938A260A2634
	for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 19:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 938A260A2634
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=D+q8GpbI
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-89fb6a45c48so110792b3a.1
        for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 11:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116359; x=1795721159; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MCKguj/vcFyjyUsBFpEVwvA/Ew8DwdobaKTpU+d8I2Y=;
        b=D+q8GpbI4NdO7QuDoNEZVES5pOHQO240I7HDWjn1f2rrdZCPcnuN3whOXGpx0a39oF
         vy29NgI8yDcoBcybaw2tN63zB7751vVbEVZZn/LzCMjY9HBRS20Keo1KE3hlO33zrKMY
         i9rsNYFToAMc7x/wdPBJ/4VyeJTA7enjCxjXgL3JsrE7hQmAx+Yowi3dVHZ+q9R9WTsa
         Q51KrqNHmyCaoJot9RTu5s/hbSfngwHvYv+jm5vhy3LwOlq0rIMZBhXUMFuk5WVGWCJ5
         g7VSQ0AS6OPJKeceOFnEmsage9ERncv5M09VAiTQMd1EpN6QJylgkCyMQrC/nJS7o9QN
         QLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116359; x=1795721159;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MCKguj/vcFyjyUsBFpEVwvA/Ew8DwdobaKTpU+d8I2Y=;
        b=yL8TwABDPOvWzC4MGtHAEfGhK9cqWynXex5xfwMBFPV0a+eBMFxgZ9euefAkSB3Yfy
         EhtG6TzpC64K56htCnLVTSKFWzNv97OdEp3H1ahQ9mDdDx5yeeswN7pUxf+HiddALvbO
         fTFu4//SSUrX8ZvEJhkftBktHa9iyezFOzMrM3RDBScGXUoy2rmGtSLnEU5EYkzVM5ZJ
         w7M8P3MO1WKw+DtISfTgPjEXitLOejlDYX2JJZb8ICzkLe1X741gezM3jsXT5BwrWEUQ
         tJ22OUHR63fTXelUMInOJT431Vyt6+XIUrkP/49Seqe2xS54oKaA3CtprE9Ce4wJWJ1a
         cEeg==
X-Forwarded-Encrypted: i=1; AL+hErFv78v8UGc1ClzFkRDWI2j0my6XFosQHq84H9kOlIM5km71w70xYZ9H5itlSDTB28+N8XeV1l55K32F@vger.kernel.org
X-Gm-Message-State: APuU4Z+PydPUk42C5ydBtCJXRiKSFXAhCLtrlqP7KPFZfw0oH3neDVpM
	HXw6XfKRqV+rMRTCyG6VEjN+fXWOvE3AEK3bhjavCOhpVjC9QvQAMH6T/lm+TGiHHaYH8NroYGc
	Up0h5BZjBwA==
X-Received: from pgjk11-n2.prod.google.com ([2002:a05:6a02:81cb:20b0:cd6:1fc4:6199])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9191:b0:3fb:1bfb:ff29
 with SMTP id adf61e73a8af0-4014e74d624mr589862637.69.1795116358583; Thu, 19
 Nov 2026 11:25:58 -0800 (PST)
Date: Thu, 19 Nov 2026 11:25:17 -0800
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
Message-ID: <20261119192520.1983406-7-irogers@google.com>
Subject: [PATCH v4 6/9] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
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

hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
with kobject_create_and_add() (which allocates a dynamic kobject using
dynamic_kobj_ktype), and hypervisor_subsys_init() in
drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype with
&hyp_sysfs_kobj_type, which had no .release callback.

Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
kobject release behavior.

Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/xen/sys-hypervisor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.c
index 91923242a5ae..0e8a2cd69fd6 100644
--- a/drivers/xen/sys-hypervisor.c
+++ b/drivers/xen/sys-hypervisor.c
@@ -659,7 +659,13 @@ static const struct sysfs_ops hyp_sysfs_ops = {
 	.store = hyp_sysfs_store,
 };
 
+static void hyp_sysfs_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct kobj_type hyp_sysfs_kobj_type = {
+	.release = hyp_sysfs_release,
 	.sysfs_ops = &hyp_sysfs_ops,
 };
 
-- 
2.56.1.708.g77570a6a1d-goog

