Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HMLsRAmr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE592D67
	for <linux-s390@vger.kernel.org>; Wed, 22 Nov 2023 23:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700725033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wTxZp7IAJ5tqHMXIk6EvW9Wy4WUO6cPHf5Pu383zIf4=;
	b=HMLsRAmrtvLK6FJwHF6RLemj0xevTlhWOG28BzgfiTtMNhHj/HmJF3I5BwrkAT0TSq9Z/K
	h1wzcDct5VKZHaj4gvYkvmMYxda+itiWntc0qWZSWp7LS7jPJsm2WV2UUto1MWNBzGz7Ua
	lrlTIUHQmuLx111WE0wA1VkdncUTCE4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-agVDURNePc2VBZtr2xZy6w-1; Thu,
 23 Nov 2023 02:37:10 -0500
X-MC-Unique: agVDURNePc2VBZtr2xZy6w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1885228EA6F3;
	Thu, 23 Nov 2023 07:37:10 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.97])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F2F6B492BFA;
	Thu, 23 Nov 2023 07:37:06 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org,
	akpm@linux-foundation.org,
	ignat@cloudflare.com,
	eric_devolder@yahoo.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 3/3] s390/Kconfig: drop select of KEXEC
Date: Thu, 23 Nov 2023 15:36:52 +0800
Message-ID: <20231123073652.507034-4-bhe@redhat.com>
In-Reply-To: <20231123073652.507034-1-bhe@redhat.com>
References: <20231123073652.507034-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

No proof is found to require that S390 architecture has to select
KEXEC. At least from my testing at below, dropping select of KEXEC won't
impact anything.

===testing 1===
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_CRASH_DUMP=y
===

===testing 2===
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_KEXEC_FILE=y
CONFIG_CRASH_DUMP=y
===

So drop the select of KEXEC now.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/s390/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 3bec98d20283..1aec2e692dca 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -217,7 +217,6 @@ config S390
 	select HAVE_VIRT_CPU_ACCOUNTING_IDLE
 	select IOMMU_HELPER		if PCI
 	select IOMMU_SUPPORT		if PCI
-	select KEXEC
 	select MMU_GATHER_MERGE_VMAS
 	select MMU_GATHER_NO_GATHER
 	select MMU_GATHER_RCU_TABLE_FREE
-- 
2.41.0

