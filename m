Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177598;
	b=qRn7zG17JwLWXyzrJJ6PO+4xpFE7sFwzBBPuK1GnGA8SBHt6tm3oImxb9umrrtCuLqEc
	 RWPnEjycFe8xark31STf+jUxlH0BQ/O8LHi4MWkArezL3GsjIgTziaCvRI9xx53tS7gAR
	 RW2nOyUBBb6Ts2VjQwYZgc0XQ7sWuka0zTGX7sMCRfBJXUIgamElDTmOWN1RaEkneoDx1
	 ITI5IFKex9JAfhwizJApPuV/UFS2F88gm7KdeR+0mNuKECQgCjdwDDtijJPYpCki1I1Bn
	 HLgDFaQm9uDmrB15SW7tj9UF0c6qOZnr4W5OO/0JEWpfaktkzfZp12QNKIFvspZ8q2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=SmJ3SdTe6uZnhzgZJuKjeaRKDfWwuPiS9sl/mhr3vm4=;
	b=uys+CItdLleL+lTx8Ro8rHtCrbsj17H+mz88Q+Ofc8Ve27r2RYfdXgh0LsVCbLeaSH3l
	 VrDHpweEvi7+PuNdPPZqXXqcx56zQOgxNZ3gCxscfrOpSQzK+LrF2qQTjbiKVE0pmhjG7
	 wMFuzxbFeKSm4xa9Q07j2aHLZsrCKUHDPzu00MBvZBTnzZVBqtfBVtvl2YzwYIQgFS1zx
	 B5TWi/hxdQIle36wSFH69Lummjz9wITT6tckiXxGIO7Wip1v05AnhjwCEzfhPW/buHs3v
	 6aVEEp8jKXY1TDE4fjs0MpfSdlDK/yCBc1yppm0rRSiJvhzMqV51C+Oe98QJVcrNqlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cJReooGN;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B856083606
	for <linux-s390@vger.kernel.org>; Sun,  8 Nov 2026 22:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63B856083606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cJReooGN
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36cec75d8caso401713eec.0
        for <linux-s390@vger.kernel.org>; Sun, 08 Nov 2026 14:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794177597; x=1794782397; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SmJ3SdTe6uZnhzgZJuKjeaRKDfWwuPiS9sl/mhr3vm4=;
        b=cJReooGNv954L0thWOLuhBmNKGaT1A/qrjtrQ/PdsxFJMsTz8gagmnHtXRNKMq5Ys+
         Lv/YcL6hNEH1UsJ7JgNuVmSrVnYjfO1D+Z7MehOIZMpbBPsObyMihyihVJojPJv3D4Su
         Kap693PXbGYbrVynDq4XthNpRQmThfBChowelR5Pu+DHXwuFN6gNdlFnDbJCxh5xFBJh
         oKhkiBz78Iux5wG+LA+/9hXRzn8M1T/2NfKDkeLZZIa9iGYIwtr9RAMVVGrojRkL29kD
         g1MQ+Qgbi8IsH9VjYyLK9ghIPrUXFJRKHXmXFDVfZCqyXQj7vq7woc/Ijehd5cjWYdxC
         9D3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177597; x=1794782397;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SmJ3SdTe6uZnhzgZJuKjeaRKDfWwuPiS9sl/mhr3vm4=;
        b=JJRcVLK7tJJewLZ3wuaB4MoZ/wVu+75rBXjnPMYTDw4s9pGmEybPh9JJ3raMgsm5dX
         fjHyXuval3mLI3nYaCGwklfgtgF0psnOvfHI+pRbqReJx1xke2yGN5LHtE1b6etwygRU
         ia7RG6NUVNkBst/k4zjm/uN4YnKyFfXVvFpm7smPz76M/XUv+ZbpMtW70SxqegxduIWb
         kAqM4flKFeHH9SH0n0HKAA3TTWbmrehGU02bCua2Ckn9+Mli6ELaB+mdTOWGu36CwZjA
         PbmpF1jpRxNFzBdWm3g5lt5Ql+tmQfI9tR189WmURVdG0lFcO7bwGyQXacwOzut0rAOp
         WRTg==
X-Forwarded-Encrypted: i=1; AL+hErETeBZiOrVfwGRUhDCj61u+v4JQu92HvFZTeJmwaBn21Pes2qvAObx0FulCwRrJLrsMMoqgIAxpWY1a@vger.kernel.org
X-Gm-Message-State: APuU4Z808Bj9Fq7jMl0ssZ3I7VmI6BLFk7gbvLQLLPN1vshu2fDIEXvr
	S3g7bYmAjwKGKRTOboyO3oq6lW5mJOkwqzPMRCjyQPSnDhgb/x0zYSSqtAV65TTpMGENXaleTK/
	/t0lUEW4UAg==
X-Received: from dyz23.prod.google.com ([2002:a05:693c:4097:b0:369:7ef0:57b0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:9a90:b0:36d:38e0:79f3
 with SMTP id 5a478bee46e88-370f8170ddamr8689075eec.25.1794177596308; Sun, 08
 Nov 2026 14:39:56 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:12 -0800
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
Message-ID: <20261108223913.3624571-9-irogers@google.com>
Subject: [PATCH v3 8/9] drm/amdkfd: Free queue in procfs_queue_type kobject
 release callback
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

struct queue embeds a struct kobject (q->kobj) for procfs entries, but
procfs_queue_type had no .release callback and uninit_queue() freed q
immediately after kfd_procfs_del_queue() called kobject_put(&q->kobj).
With CONFIG_DEBUG_KOBJECT_RELEASE=y, this causes a use-after-free.

Add kfd_procfs_queue_release() to free struct queue from the kobject
release callback, change kfd_procfs_del_queue() to only remove the
kobject from sysfs via kobject_del(), and drop the final reference in
uninit_queue() via kobject_put(). Check q->kobj.state_in_sysfs before
calling kobject_del() in kfd_procfs_del_queue() to avoid warnings if
sysfs creation previously failed.

Fixes: 6d220a7e7971 ("drm/amdkfd: Add queue information to sysfs")
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 12 +++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c   |  5 ++++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 6663718fb83c..b349e0d8d47b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -512,7 +512,15 @@ static const struct sysfs_ops procfs_queue_ops = {
 	.show = kfd_procfs_queue_show,
 };
 
+static void kfd_procfs_queue_release(struct kobject *kobj)
+{
+	struct queue *q = container_of(kobj, struct queue, kobj);
+
+	kfree(q);
+}
+
 static const struct kobj_type procfs_queue_type = {
+	.release = kfd_procfs_queue_release,
 	.sysfs_ops = &procfs_queue_ops,
 	.default_groups = procfs_queue_groups,
 };
@@ -552,7 +560,6 @@ int kfd_procfs_add_queue(struct queue *q)
 	if (ret < 0) {
 		pr_warn("Creating proc/<pid>/queues/%u failed",
 			q->properties.queue_id);
-		kobject_put(&q->kobj);
 		return ret;
 	}
 
@@ -697,11 +704,10 @@ static void kfd_procfs_add_sysfs_files(struct kfd_process *p)
 
 void kfd_procfs_del_queue(struct queue *q)
 {
-	if (!q || !q->process->kobj)
+	if (!q || !q->process || !q->process->kobj || !q->kobj.state_in_sysfs)
 		return;
 
 	kobject_del(&q->kobj);
-	kobject_put(&q->kobj);
 }
 
 int kfd_process_create_wq(void)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 6010a5d7a7eb..f7413d651620 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -83,7 +83,10 @@ int init_queue(struct queue **q, const struct queue_properties *properties)
 
 void uninit_queue(struct queue *q)
 {
-	kfree(q);
+	if (q && q->kobj.state_initialized)
+		kobject_put(&q->kobj);
+	else
+		kfree(q);
 }
 
 #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
-- 
2.56.0.455.g6c5a503b38-goog

