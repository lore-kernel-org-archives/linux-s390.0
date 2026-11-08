Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177587;
	b=4HjBx3Skjv5MeKN/J+8OkeBkUnNDfF1uVOQ02aNqZmMvCwJE2rwZvOLNK23aOU1g/CWx
	 bFOxIJG+IdpwamHgK8nSvdKy5iHBVeZHbHmR30L+620j3YNbtT7S06z41SKniKNYa1vT+
	 DSkB6lPucDycGi8U43ksDoYVnd6pWpnIIsOKhsId1XE+q6DGPGRZC49DhnzS30cCfIL+n
	 E1uGLGeFpXTCyB1ytQwbzUuJzH1DR93AgkY7URk1PjM8HN7Zjlpi19xgGINE1szkvJkfd
	 d5XDXzcb+oTNzpaCykCZk6Tr6+10Zn3s8p63Lb3XQeVTaY6a8eEINBIfmkU6pl6AFlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=xwXDua19Tz/IicJklctcGTeEqQvEHLiE8QZruqc+WN4=;
	b=nJhcj7JbWBgBPhhn8vw86H++iP2wPMDQucIXKXY541wrysKHoYEU9de6mhhTW8eRCiSN
	 Kblfsk6+ULU6vhzkwRI/K60LUIVM5WDfJ2T8Yi3oTFAZ1dDey2prr4/wNAb6n2DYbGJz9
	 Qf+soq6tmDPC/ORAalfqJ5Nna93nIt5uRH4cEBEG+r7ze2Nxpic0T+eH+5ch9owlLqxml
	 L5+yrdslG1b3nkojWDIR97/EpAwUTgwFUFwe6rokVQc1776pL3zb9KRsypy4n1UWqze9v
	 XpTZ33Fkhgo00bX6j9VqggzW8iuapYY9y2hIe2i6FsG3e13CEE4p+HKopqtFMIFBTSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="WiS/rO83";
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F266D606EE85
	for <linux-s390@vger.kernel.org>; Sun,  8 Nov 2026 22:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F266D606EE85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WiS/rO83
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36cec75d8caso401599eec.0
        for <linux-s390@vger.kernel.org>; Sun, 08 Nov 2026 14:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794177586; x=1794782386; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xwXDua19Tz/IicJklctcGTeEqQvEHLiE8QZruqc+WN4=;
        b=WiS/rO83jd9bI/DieSANeabjGnOf7ofkVqtVbL6lwR0Kl1aPmAlLVRbDPbhxCKXHqz
         CNS7naH1rBIwFk3gS0nzJsWAUVUev1LyzwShyBLnB5296dpufWK5/WU8Bse+xdMATfWB
         jaACnxNWH1yWm6H4lhdXSxvzyIU+QYSLfFSG4Qy0WpJ78qLBfr3TMXGLvWjWFAEki3UY
         WYcZF1lL4olsSD+VMeyHsPJH7imK+79Av1uXyTa2G7gIv0jiUzGFoMsFRMQC5MfUlflo
         2HlWIU669YLFvTS6JA3s2ktN5HpFaAE6ptToKgVz0mTlheIc/dgUGTGlGWkDe22ir7Be
         41fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177586; x=1794782386;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xwXDua19Tz/IicJklctcGTeEqQvEHLiE8QZruqc+WN4=;
        b=dpBdPcVF4fHgS1m1j3qHBRGFnCahdUbmZd6mRFE56BNHCQNEfFG1Jk6lp55gkbleTY
         cZV8L2QWhZfvoCyslgbzXyb7DYKB1EiAI+Rb6K9/OfqJ2GBAoHyzEjCJ7IGGZv+fcGeW
         OqkK0dVTWvweRGULGG1vmSg1v4e6daepKbtBtOtwuDFptF5wbW5m0k2BcdHD5MFJTFSI
         l2diFe8eObz1NP4QYi+IG044aV2XsVVL3h2lCK4B6zcB0du03bUyoYue7qPNXG9Xzy6N
         xi18BXCS3YuYvfi1jbceY7YkmsYyDiRiG+IthkxoVMqjS3Y9qETSqU1fKihxZU5g3AzI
         lwEg==
X-Forwarded-Encrypted: i=1; AL+hErHgC3FYn3mPZ3x2qRSWo4bwwIsgZybjM+DswU9XrPgjtVfBGcbyMxjtiT88ZHoopnGIbbiDBWy0qAA3@vger.kernel.org
X-Gm-Message-State: APuU4Z8VClhtgSdJ6AwHPFxT6ztdOZRG2dmxcypRuKdsglxGKrV4bWRL
	efx5sVnsQuvZY4klwOjqlkgGWh/ANOe1DRocUGjxGC5goB2JMeHPjmFdv7bl+LnVohUiwD0qfUD
	eD740nJ8HAg==
X-Received: from dyx10.prod.google.com ([2002:a05:693c:820a:b0:36a:eec:f68c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:c00c:10b0:36d:dcdb:70c5
 with SMTP id 5a478bee46e88-370f7b8f918mr9710009eec.20.1794177585797; Sun, 08
 Nov 2026 14:39:45 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:07 -0800
In-Reply-To: <20261108223913.3624571-1-irogers@google.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261108223913.3624571-4-irogers@google.com>
Subject: [PATCH v3 3/9] sh: sq: Add missing kobject release callback to ktype_percpu_entry
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

In sq_dev_add(), sq_kobject[cpu] is dynamically allocated with
kzalloc_obj() and initialized with ktype_percpu_entry. When
sq_dev_remove() calls kobject_put(kobj), the kobject is never freed
because ktype_percpu_entry lacks a .release callback.

Provide a sq_kobj_release() callback that calls kfree(kobj).

Fixes: d7c30c682a27 ("sh: Store Queue API rework.")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/sh/kernel/cpu/sh4/sq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
index 908a8e09113b..f33864958487 100644
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -331,7 +331,13 @@ static const struct sysfs_ops sq_sysfs_ops = {
 	.store	= sq_sysfs_store,
 };
 
+static void sq_kobj_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static struct kobj_type ktype_percpu_entry = {
+	.release	= sq_kobj_release,
 	.sysfs_ops	= &sq_sysfs_ops,
 	.default_groups	= sq_sysfs_groups,
 };
-- 
2.56.0.455.g6c5a503b38-goog

