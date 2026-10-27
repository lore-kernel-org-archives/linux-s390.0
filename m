Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140768;
	b=AFITUhbwgku6OgOoAkBCpzhVe0qLwzGVPMbznnz28g1mumt5pCP58YS29m2YO1HNdHwH
	 wqfBnI3hm/kmVs9Qll9sHEgZ1nrTwjCZPhjAgqV+UBbvNYrZwwUAG94zzZI2NU/grPlN8
	 cRp2pAd2ha1QqHgLWX+HQUKqk1ns4Qh9K9ddAX0pNMRrtze4l2D4wNuQ0d9Lkxyuxqh6N
	 a4ck76P7NAW+8wjH06IwOxlAcUEtfJjiM8lMM1GR1NvCgNvxEe7Wm/DPHJwrX6lWOPYrC
	 WiSEx0v8ObybCEc5OcjxKzU/plNSKHi9/FefgDqm5P6GhjC/+dZKwjKCPt6A/BNnivg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=4zou/7CSV4h/YwAlF7A1OL9kEnFb2HIoLHCAQS8LrD8=;
	b=5KAn8VlofzO4ROk8+z4xMLHm8zCzRhBura3+4AJvQVU9XarEqY2NGgw8l5gH7kvkrqov
	 Wgwk+ttbrwVV7nLuzkgodhIKaH00D2wF7PeX0P4RkL47ARsbanlL0vIiAgvpUkq41frBN
	 RtVX93+3p/ONMGyqhlhDWwQPnErfxTHCctA8kcoBjLQprytIDX/xyD2NK/eHKAnY5M8l1
	 bM1oP9snftbUlOgLszT8Lk+i132awfMGRrZ56ZvpdaLiB5YHwRnc9cZkXTw+VKaNqHf1Q
	 QINgOngG1sLySXmcs57IP+uEvmcog6uffVzzgNJugh+R/0rPXfyAQPearKr5DMPyzvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=liNe3HMy;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9C460A3835
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 22:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA9C460A3835
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=liNe3HMy
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-147be78cd56so953118c88.1
        for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 15:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793140767; x=1793745567; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4zou/7CSV4h/YwAlF7A1OL9kEnFb2HIoLHCAQS8LrD8=;
        b=liNe3HMy55X9pJAx3yYfGsMeNT+e1JnZxB+AQx3A5J9VPGgN92YzVbYvd/za/Drr5k
         lst0PfcfRGocLlrgPC5UssnxEJctFzU+pQm+95FdUho7XQl8tD1ulM7rKwt/jNE+21Vf
         Z9LeRG62rYmnsPQmmg4JlXmw8+AffIjWCQze/e0A/NrbyHM8TP8o1608vrQLYJKc1eVF
         dF+siAZRQfjXJUi0LYKhvOuPmzmxcjf9I8fjPgny0U321qhAu1Pmw+Bv//U3MdnFtahJ
         7n34bb7IiC2Le1ntE29Feez7T+/eMXs0L62grlkW9U2pgTYjfEQQlg6qoj1bz6MQC6fW
         lCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140767; x=1793745567;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4zou/7CSV4h/YwAlF7A1OL9kEnFb2HIoLHCAQS8LrD8=;
        b=1pk5u4u9TXBBZ8/6gkxdAMcA4xp94ykF/nRxNvbDH6A+ptW+G615MIC4WywHY25jUQ
         lsTUySXJEMz+JIKI72JsBk3eigtN4/0JnWwvAlJfqGNyBz8ptHUK1qUSyqnVGUkzLSJv
         0ZOoDwjl6tp7EdtkbsxPO+jT9OpuViRNZZqoneBDH4z1aj9XS29cDiUIeYF7uJxlKq6e
         zfpKCxh6zG1sSDb5roB/wI5wZO9g2TsHprI/5DI5ogjGVVeiO5hgUQqgsUhrz93oBE7B
         LOC1CRhkGmU5Xta/GIs0gCV1AwA7+lAynvMyTsMdSdmbn6DsDX22Vx0kIbqS5ytqclUM
         uymA==
X-Forwarded-Encrypted: i=1; AKwUvBy8rvFam8fcEW4rxNIPxdO44ge//gQjNig4FyOrpr/+AmmM9LsvqM/XWY3sG8mi81EGrogpSneXMu6U@vger.kernel.org
X-Gm-Message-State: AFq9FYKZZRTI071zEuEVBxXkccTAhm9ppQIUW0ydWhzAQKg1FTs8KYQW
	yawmIHvbsmIt9vx3x+UAq4bnDn+/M8dSc1rqtATfomEasYyDCzo7tMeNw72y+d2U4a+2VurP5RD
	GcUDY7kbBKA==
X-Received: from dlbqq10.prod.google.com ([2002:a05:7022:ed0a:b0:1a0:a0b4:204c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f115:b0:1a3:6040:bf78
 with SMTP id a92af1059eb24-1a6cc34d07bmr917417c88.11.1793140766453; Tue, 27
 Oct 2026 15:39:26 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:38:41 -0700
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
Message-ID: <20261027223847.652884-7-irogers@google.com>
Subject: [PATCH v2 6/9] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
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
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
	Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
Content-Type: text/plain; charset="UTF-8"

hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
with kobject_create_and_add() (which allocates a dynamic kobject using
dynamic_kobj_ktype), and hypervisor_subsys_init() in
drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype with
&hyp_sysfs_kobj_type, which had no .release callback.

Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
kobject release behavior.

Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
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
2.56.0.313.g2479322e68-goog

