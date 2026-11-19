Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116372;
	b=cVNB3JFTAs/lcaBjzKmCeLkfkAAYNUxRIgw9jsrj5h0iVgsEqhA821WNvCk2QKWVmJWz
	 SVs8ftT9Clp8yDQ8GDi96jS5WyOwvbqQOwZqwxKkhQ1U58IyoQeNY0SEW6Ca4c/JXGYvd
	 wT7uVpULd+mNVKIiIEDdZZoCAgtT/KOcmGAFbRXMzl4ySyzfkuZnNrdrG1YRAi02Ab5hC
	 rmCFgbB7Adj+cY3NDpLYb7ldTffH3S4+UCYNMoM92IVXI61Y2aY9CMQcPvFHT0k0gGZTy
	 PAY0YH8H6/pALuBX7Qm6yW2VpRMwoisFkwVMz1GAv2EeK5Glya9xKludC6PASMYYFTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116372;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ed6ZuPWwDHIYUoQ+FZI+Wi1n/4SIGbM4V5gI4MqacGo=;
	b=gqSj7zfIfMZruLmJM8fB7Bij90XpgiF4syX08dYjtJZQaIn7JUd8NAnAguG2Cm4gejog
	 LpcmrQc/vNf/sj2/M49QGF2tf/JqMltgva6q3zFMFqKEnm1zaj+p1i17vxP8ENp7G/39O
	 smLhaQyX0JTiZykzp5RT1SrMwCmIqbcKIAwKaSNTNYFFX7v/u4al/bc3+R5+n7S+mVr3g
	 PPfrewf8gXoIwTSRvVGTtFpJ+5czmDPG/O2zYK69Is1rEMomyT46ARd7gAQrEF0ZfStUm
	 BAvG6/CWveFgy7Ixi78Nz5LmdvRBzq3A26tQaHxuiKHVKj6/t868qgU3yJxbbUjhdmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kLKVMsB9;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C3960A2619
	for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 19:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36C3960A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kLKVMsB9
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-383f2d05c73so196795eec.0
        for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 11:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116371; x=1795721171; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ed6ZuPWwDHIYUoQ+FZI+Wi1n/4SIGbM4V5gI4MqacGo=;
        b=kLKVMsB9YDaG4K9j6iMehsycwJx0ij9U+zmFqOnRmYHu53t6nEiX3t8yU3HxVvB+b/
         6KyiT8DM3Qe/mOTjAtQojTdUiR3Z33rCCdl8HCeQIoVhmg5xeCyf1uUTKPgTB08m9y0W
         wh7Bmx0trBkjDpJikZ7sItLvMM5zb51kE7X5w2jxhGQpoWhxk7dPMrKtTAtkRESJSasl
         VT8nSjUna2MpBdK/el90bXgng+kJf0I/4O9/UiUly1YL2wWCJzd+BxjmU8W+0PGukBpd
         UFdMDTd7qYZhFtxn421uPMqlzEIuGiHyOF7/dHCv+cPKTMuu4RJNDBg/PJiY61zY2WF4
         7jVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116371; x=1795721171;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ed6ZuPWwDHIYUoQ+FZI+Wi1n/4SIGbM4V5gI4MqacGo=;
        b=AQY0DLzPB5DJsxzFZKaIybNK/ia8GYY1wik0fg6ZNjgGYvDDC130H77/+gTCuGdhR/
         SX5P5ijATieCS+pKV26PiroTWtGVcCeAeNUvfB/g5mhO2sjGAuN17DsMBrVAMz/3218T
         FQBYiiv6/2/5Hbt8hZSrva3aVgRABzfYpwr0GUlbcXwEfl0hPGOttHSZFfMThBEVGr2S
         5n8/u/OKEnm5rl0ftNaPWlXesg7HKuRJAeag4Rjz/mWTSf+NBttYIji6Z+wXuwSZyc8+
         8qWZvjj6eCOmCSN7jOMTNNkaRfic2an3i1D0Mh4JnKlNuGqHgKJFiUq2NmC1q91ZE5r7
         9q3g==
X-Forwarded-Encrypted: i=1; AL+hErFFK8+KRFXzF4aPMEzTCD1ub7mNgJMQtttJRw1ydyUzXl4c/Thrc2TqRRyLKml5US8MjQ5g7L1KwiF5@vger.kernel.org
X-Gm-Message-State: APuU4Z+oc2Vjh1zY0sYHS5B9fyNoDny/dWFhGtxWZXE7gk/3o0wDkDpa
	JHgan7u9bufkNR3j47+d8k5IauU/QU4bOQYJDa10v0KGP1A7IUoJ0HNCOPTnfX3F0lVUDfvyBAm
	3ch2p57llwA==
X-Received: from dyhd22.prod.google.com ([2002:a05:7300:8296:b0:381:d3ca:9f05])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6018:b0:381:9593:9984
 with SMTP id 5a478bee46e88-3857151d6abmr284926eec.37.1795116370935; Thu, 19
 Nov 2026 11:26:10 -0800 (PST)
Date: Thu, 19 Nov 2026 11:25:19 -0800
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
Message-ID: <20261119192520.1983406-9-irogers@google.com>
Subject: [PATCH v4 8/9] drm/amdkfd: Free queue in procfs_queue_type kobject
 release callback
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
index cd41b10e0873..636cc894223d 100644
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
2.56.1.708.g77570a6a1d-goog

