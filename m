Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140760;
	b=o093lx8+Kz3nceaiehUIy+N6NwzAkTvieb6FsboKpD8uLW8stsL0BbQEpo1JFSl5NUXn
	 aSGZWs5Wkeiw3TFmrvqAOAJOHHGidTDOmoRvJPHdqSFR12qNZDSqxc/jo+J4fCEayAbrL
	 AAba09peGk4zI32uHVo861p8yfSn9rizl+SaA1bSv/JWFG6lVbjJ/L5+8yELpdMx6E5y2
	 xyq8LSwEwnOkMsy83lpKccr1IAZ0Qhc5HX1VMWGQ3dnClXCEpM0onl4Yx7LrAwHW+PLm6
	 AzU0pa8DFqtvNr9XR7O0k/K9IGMwkCNTHblWIXHrhTRcfdsWWAOPDWe1SQQmN1wBK/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=beIsynJTUoVVYUibNrHvS9xq2J3rMWzpCblr3XGPomY=;
	b=pMYoxyedjhvsu/vdRtqlTKIEfDfjTCXB0D3R+qFfA5edgpLuZeIQRD5NhhzitzR6OcfB
	 i/wAKhcGiuT0kSx3FyozpUtM7ZONF3P5WHyoxUlwg2WqAijwKDXCPH2KDusRxixbmceNp
	 o2+SBPsypLFb8lCinAXDzF15Koq7I8SW75A8dzH075u0Fcp0TsBSUogtqCHrb/4buhkE4
	 xQyfx51W2kqYdCMK/+wviEmWyrv2e+UbvTWXIqCNl/gNSHBy5MOqrMF55yBT9fTdQsPl2
	 KYvVwxSo8xkucjOYzlkSkDlq6NENtZKESwAzD+podOD0Xwu/Ishxf/rHyvWWlB5J1TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kIMyUKFu;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A79E606A32A
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 22:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A79E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kIMyUKFu
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a05c820ecbso551608b3a.0
        for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 15:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140759; x=1793745559; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=beIsynJTUoVVYUibNrHvS9xq2J3rMWzpCblr3XGPomY=;
        b=kIMyUKFukUJtjlCB+ZE2zh2lwo3GQV3z3dUYxV09PKjXw0ZjE2jeWA5BuL5r+QkTsS
         5ZzU/9piUKJLhgATzOW69XBDirJSfUNdjU8bimvi6t/U9+77eeZV3sUpzjATUlpkTsmz
         gq3vyWIGNK0zFjlANK5GQZMvv0vsQLSwO9CijSJxrX9Vh1ynVxUpyQR+qXuUOzTQNEd2
         vqFNVi+/m+qyeN1OsBM/7m5G51CLC9ESLC5hoKgrvebdkKnbj7QYKY4thO4WPGJ0SxlV
         i2/3GcwAryD5MX3hH5HdRpHDIt1i8yx0VLeoNGibsE95Q6GYl69dtaAIBjedJgq+ugfg
         pXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140759; x=1793745559;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=beIsynJTUoVVYUibNrHvS9xq2J3rMWzpCblr3XGPomY=;
        b=PBrDWosu4JSOLxb6itfzqdeWAQARMXCQ08JSF2f6K7asaHqXjvv5ocQw7Qlp74nfEn
         h4HTUcRcyyyIVsdKXNHgWh0iE7wdAIHLleOBow+F+dbNXokF3wBbA9P51nNs3163lcgd
         +ywMQXBIMqXdAgcmFCvw4B5ZDM7krT63pIEk9/E/3I2M4hceckNASNRZ0utWWGKjh621
         mNTetYJs5fxNSPfaWfloFc1JyC+Adysd5LZJVgp1lOPuBLExo7a6tX8kL+6RvZabHdYf
         q5vH/DAVBvgXIuphArvWPdmtaiujd+p6My2FK8rH2gBRV5UFuxMq27DQcjAx52hY1fUC
         w3jg==
X-Forwarded-Encrypted: i=1; AKwUvBygQNGuoekLYCdJAC/ZLwdhKIrl1xb2mjA8NdYSBgGFdk1EuDxRj2N2Fh9ehgGoPyXi/5E052PjAXsp@vger.kernel.org
X-Gm-Message-State: AFq9FYK8uHzSqq0hU6kTOYRnOQX8DuhQZvywFzDokVJr+hWaW91kMvhH
	Qbl0pLBIjmI7LmE0o3YhufLgNIn+eQ6YRUOtWiF+iFVLXxCxCb/WysFzPiK3JI6t1DnKhxVORs5
	I2g17lGNZEA==
X-Received: from pfbdw21.prod.google.com ([2002:a05:6a00:3695:b0:89f:827e:eb47])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4293:b0:876:194e:b8fe
 with SMTP id d2e1a72fcca58-8a6e70e832amr492696b3a.26.1793140758450; Tue, 27
 Oct 2026 15:39:18 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:38 -0700
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
Message-ID: <20261027223847.652884-4-irogers@google.com>
Subject: [PATCH v2 3/9] sh: sq: Add missing kobject release callback to ktype_percpu_entry
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
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Paul Mundt <lethal@linux-sh.org>
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
2.56.0.313.g2479322e68-goog

