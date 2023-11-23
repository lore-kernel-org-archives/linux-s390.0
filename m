Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pi562C6i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED063E7
	for <linux-s390@vger.kernel.org>; Wed, 22 Nov 2023 23:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700725023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hZIGK99oC3oMtW4db/aQjrmivwq8vYdu48PqdNRtXGY=;
	b=Pi562C6isv9kll0lBz4afPqHDIOvdVztw58j5DmmeT5bn//g3UFag63PunfW2HBC1HBsmp
	UJ7juusprWPSE+YvnkvBrVCNGvHjBEGhTjhxuvehH4bIxzcUy1HkztdHjgMNbvj15NHn9M
	zrwN3oJhK8UR21l/vrBlpwMnYm6sIBY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-F6EtF1WONh674lmkSKKmXA-1; Thu, 23 Nov 2023 02:36:59 -0500
X-MC-Unique: F6EtF1WONh674lmkSKKmXA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7F8485A58A;
	Thu, 23 Nov 2023 07:36:58 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.97])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C8052492BFA;
	Thu, 23 Nov 2023 07:36:55 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org,
	akpm@linux-foundation.org,
	ignat@cloudflare.com,
	eric_devolder@yahoo.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/3] kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP
Date: Thu, 23 Nov 2023 15:36:49 +0800
Message-ID: <20231123073652.507034-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Ignat reported a potential config regression was introduced by
commit 89cde455915f ("kexec: consolidate kexec and crash options
into kernel/Kconfig.kexec"). Please click below link for more details:

https://lore.kernel.org/all/CALrw=nHpRQQaQTP_jZfREgrQEMpS8jBF8JQCv4ygqXycE-StaA@mail.gmail.com/T/#u

The patch 1 fix the regression by removing incorrect CONFIG_KEXEC
ifdeffery scope adding in arm's <asm/kexec.h>, then dropping the
select of KEXEC for CRASH_DUMP. This is tested and passed a cross
comiping of arm.

Patch 2 is to fix a build failure when I tested patch 1 on x86_64, the
wrong CONFIG_KEXEC iddeffery is replaced with CONFIG_KEXEC_CORE. Test
passed on x86_64.

Patch 3 is to fix an unnecessary 'select KEXEC' in s390 ARCH. Removing
the select won't impact anything. Test passed on a ibm-z system.

Baoquan He (3):
  kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP
  drivers/base/cpu: crash data showing should depends on KEXEC_CORE
  s390/Kconfig: drop select of KEXEC

 arch/arm/include/asm/kexec.h | 4 ----
 arch/s390/Kconfig            | 1 -
 drivers/base/cpu.c           | 6 +++---
 kernel/Kconfig.kexec         | 1 -
 4 files changed, 3 insertions(+), 9 deletions(-)

-- 
2.41.0

