Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3ZpcdYH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1672FD4A
	for <linux-s390@vger.kernel.org>; Wed, 22 Nov 2023 23:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700725032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dNqYLkFiIJwwuHzYUt5fu8IOSkWjg/NNK5Ec2zATJ28=;
	b=W3ZpcdYHvVBEH06cdj+NxasTOqtQ+LgvD5525nLzTME1n1njrWl/dEGPbjVfcK3A3UJD32
	5RVJtZRSZdQs3QswpKX0+Gp2BP6rav73P1jYOUJSZteGOLAIBgHcbSxUB+UGmNUXbE4sm2
	ib+i2hYCdeafFNxafNbtxp30djGbQKg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-pvhi0avYMXu46SHWzNgkjw-1; Thu,
 23 Nov 2023 02:37:06 -0500
X-MC-Unique: pvhi0avYMXu46SHWzNgkjw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F8C61C05ABA;
	Thu, 23 Nov 2023 07:37:06 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.97])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 48D6C492BFA;
	Thu, 23 Nov 2023 07:37:02 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org,
	akpm@linux-foundation.org,
	ignat@cloudflare.com,
	eric_devolder@yahoo.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 2/3] drivers/base/cpu: crash data showing should depends on KEXEC_CORE
Date: Thu, 23 Nov 2023 15:36:51 +0800
Message-ID: <20231123073652.507034-3-bhe@redhat.com>
In-Reply-To: <20231123073652.507034-1-bhe@redhat.com>
References: <20231123073652.507034-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

When below kernel config items are set, compiling error are triggered.

CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_CRASH_DUMP=y
CONFIG_CRASH_HOTPLUG=y

------------------------------------------------------
drivers/base/cpu.c: In function ‘crash_hotplug_show’:
drivers/base/cpu.c:309:40: error: implicit declaration of function ‘crash_hotplug_cpu_support’; did you mean ‘crash_hotplug_show’? [-Werror=implicit-function-declaration]
  309 |         return sysfs_emit(buf, "%d\n", crash_hotplug_cpu_support());
      |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~
      |                                        crash_hotplug_show
cc1: some warnings being treated as errors
------------------------------------------------------

CONFIG_KEXEC is used to enable kexec_load interface, the
crash_notes/crash_notes_size/crash_hotplug showing depends on
CONFIG_KEXEC is incorrect. It should depend on KEXEC_CORE instead.

Fix it now.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/base/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 9ea22e165acd..548491de818e 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -144,7 +144,7 @@ static DEVICE_ATTR(release, S_IWUSR, NULL, cpu_release_store);
 #endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
 #endif /* CONFIG_HOTPLUG_CPU */
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 #include <linux/kexec.h>
 
 static ssize_t crash_notes_show(struct device *dev,
@@ -189,14 +189,14 @@ static const struct attribute_group crash_note_cpu_attr_group = {
 #endif
 
 static const struct attribute_group *common_cpu_attr_groups[] = {
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 	&crash_note_cpu_attr_group,
 #endif
 	NULL
 };
 
 static const struct attribute_group *hotplugable_cpu_attr_groups[] = {
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 	&crash_note_cpu_attr_group,
 #endif
 	NULL
-- 
2.41.0

