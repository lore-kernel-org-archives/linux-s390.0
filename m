Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140773;
	b=zZMjSKrtHw4HTAYw3h2OAtq/mP652LyW/M88DNFMPtaBA+aO7hoz6L6bGsfC+/yQEWn2
	 Kw/7BHT6vypauFIk4gpkKzOvQaXSZIB7ajUQRAFblrtPymyE+h/pE+D1Tda0yiuDoDO+I
	 FS/yl6BtJxgD9QmAY8kLbGRvb4JDPfTqfaV3HhWNbsnMJWUEBgoNposbuswyPg77+IW/K
	 PB99CEkDWYMDN8Le8R46YL6yVrAX1L5+k6mXcj7edFgStT7NX3avJAIS2hwaClyxKRQrj
	 twcG07CJk9T6NX1KZE95zc1RkX3vXQa8t8X2h+hw7a4h9EvzUSI9ysAJ13H/kD0D3yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140773;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=MTMJFM/nqHoym7HFBiG90k6OXEIlh5WHZZg+1coUz9A=;
	b=XmrbZFqkf2vwz0uRYmIk4TWwbT9XMefp9ULaBVZiYLbvNHTyvd3fGPsYGC6baqp0bZAr
	 hQGDqJ+YTPbpuMbngmuPiV8ma0jB+gKCcNciym1v28MelAvu1uEEVaaF1doEoQxgddToq
	 P1NdHYx5BLiMSRmZ9+IXQqbtJrF9n7P5a4/+A9bKkn9odJV1AfERr79hcYfHUvyJvHGal
	 VerUjjxxg3BEf7vsKiXbxj6AJfbv5pL4On/HGrvZMCd8qi8mdUd4KB3hsz22pl5Xs8bVO
	 D4L03OzvizOqn6SO7g9NVkOgmDXrv8fOUzvjSa5DTw5E7JxgfyG2UvzVtibtdPAROrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Dp0iJNhB;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4850260A6F51
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 22:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4850260A6F51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Dp0iJNhB
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-35cbea41088so456578eec.1
        for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 15:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140772; x=1793745572; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MTMJFM/nqHoym7HFBiG90k6OXEIlh5WHZZg+1coUz9A=;
        b=Dp0iJNhBHpLUpE9DPsmDbooUzph8SqzIzXcpOSTiX7wdcLCmIFY1BCbUKMKpx+pYuj
         R4Ee5ePmlxZ+HgUq7DT8Cs+EvRJ6Ru9oCOLjochaIG1lMIfd22VfMeWWnXTCDJLSeqPK
         vqP1vWS6CnNgtmZ9iGeCWC3k0cN6kX3mWNt6IFkSYvvDys8r9xmtyq3zKw66yZBM6RzC
         Tk/GpV+Xkodm/b1cO968NYTmMycXC2PmrOp5eBphq3FccRNOf2fGl7mbHauMIeV18Bht
         ArnbrX3U+cnF0GZXUn9no8+KhpPGozljtTMfpHzFjD4uoatF57z40G3FOvVg4z0AuIvU
         LtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140772; x=1793745572;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MTMJFM/nqHoym7HFBiG90k6OXEIlh5WHZZg+1coUz9A=;
        b=JI3YSlGmsAMVaYb8pAAeH03cDQzFcqTZP4vtuT4UGd7GMFs2rWdn/Jhl2JD2yyi+ho
         fe8VwYh8eti73AHa/M3tX6fk8jdLS9xFx76WSTkax2RRVWv0f+zFFB+OHbtdN0DisHTy
         Q0Nb3/r+ApOIb+jFCcdawF3bMFH44d8jsmfiH/5TvQouc1eErHZY3vM4/hoszWoYeFMc
         E6a4Lfno2rRzuffyrxrCgAzaHCN4/d/5TaXDlZgb2HknX23DcnZ/MQGcCr/UHruBPMpW
         N4VO9erOXE9cetvWw0AKRgKyg+45+BL7Qz2G8YYukiFgMIEeZJtKIoOh/mMZWs9KPuuL
         P3sQ==
X-Forwarded-Encrypted: i=1; AKwUvBwPEAfnhUnSKOBcAUoyICkx78B9Psj2ulilaHXyZiOiMvPGgT2jBAFVEOUIE+0AXWh+JmkgUjBFoDQ3@vger.kernel.org
X-Gm-Message-State: AFq9FYKUCq5KAImjemZJzDIwb6tj5M+clSWNrUrX0bWB4vJE841aXcxX
	VVnZjxH+WKTnr8p6QfrpekSnKbndr4YCxfqiX9XVnfyjFRF3N9U3LfM7e66bXtPKgnp8T1aZ6Es
	DQif3dFHIHg==
X-Received: from dlea12-n1.prod.google.com ([2002:a05:701b:420c:10b0:1a4:c892:b166])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2813:b0:143:6525:f9f6
 with SMTP id a92af1059eb24-1a6cd3a1575mr630918c88.13.1793140772067; Tue, 27
 Oct 2026 15:39:32 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:43 -0700
In-Reply-To: <20261027223847.652884-1-irogers@google.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027223847.652884-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027223847.652884-9-irogers@google.com>
Subject: [PATCH v2 8/9] drm/amdkfd: Free queue in procfs_queue_type kobject
 release callback
From: Ian Rogers <irogers@google.com>
To: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Amber Lin <Amber.Lin@amd.com>
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
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 12 +++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c   |  5 ++++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 226f52626e84..8e6136d52a50 100644
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
index ae3e7c54014a..4666110aebe0 100644
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
2.56.0.313.g2479322e68-goog

