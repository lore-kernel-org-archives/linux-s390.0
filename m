Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DB6369D76
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137770; cv=none; b=Zamo0oBizGO0fZfPCxyfW4rZz1eXhZYiryL1b3osLlUpGvxG7hkWT/YhtX8KoAyRcIZHx7UF86p83oEJCUZGIQCulhMRdOytO/OA2vp2c5zD3bzR/g9gDyO8F1rCwtfvzp1hQsXMe+gHm87sTO5cqHKhe9Vx6wtuFHD0LQ/jDwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137770; c=relaxed/simple;
	bh=gz51FBCWhizVrU+7SLeOKliZNk1p8rWeS98CiQ+wXUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQHfDqob6mJP5V5/skaB9eAathXxtehBr7tGd9TIgpTJJt22uv+K/u7pcnakApjZJOAMfSkVNInYWMFH3mtWhAM/tbb01WFphMDIPZfwy/mYi8wNSRz4kj9zZMWO2ybVDNMb8lBLLaAa7VSTuQl4Oh0iyai8F/BH+9rzQuhBGpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TMvGMq1K; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TMvGMq1K"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49cca4ffdcfso8727965e9.0
        for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 07:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789137765; x=1789742565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hNkJ+Y4UNh/VmhAHfWRxswemkYstE9GZTmx6wz4UC8Q=;
        b=TMvGMq1KXCQ8s+RpmILsIeGf8K0plpbDc3xU0HxW5q69wJ4IuhPeLCr5JbpsWff46R
         R339YRUVqRi6/PFpgzO+b+Us8b3f0Fv3RavXH/rvTME6crQSeuZQX5fhsYwkFumrKmhE
         MEMcuIHBwGYYUdn5MYSsoLeQRLHg/AjEpHokj7Aaii7ap4k7cJKFOQG/tiZUWjFTnYaP
         lsPtlukinpLRNsdB7EuXrUMMC5LQpfj6AItmxEaYlmVgQ+Cj3hNca/7UM3Qz9RNHGCD0
         a+6gAPL2hEEwWw9sRZRHyAcQZxk+Xn8ONLqvZvqEgWqJuBbWYpFcDFky37P6I126tOtP
         Fcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789137765; x=1789742565;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hNkJ+Y4UNh/VmhAHfWRxswemkYstE9GZTmx6wz4UC8Q=;
        b=nk60/Hu9XT6MV+6i9++3M85ZJEryRu3bFHynJ3R6p7Il+ZycQvBbh89WDbUaMzeD+l
         26mgWp0faFyoutQb0tGdCGF0by2unoY0nXqe/zhlovbP6JrGLv3xDC12u2lWsGBsmJx3
         SjU1+ag2w4BOe53TBd1v9OxKB2e6DJvDCYnNwRJMLa8IGtjQsvzyjsWgNrn5eTbBw0BA
         xFN039SDJW9jx/5DOcxt7L6o3FHm7zTA+0XJ74dYIvxBJwm8TSJEw+5IKR6+FxPMCNQy
         0guCECJIxwu7cbCWbAsmgnv4pYsex20kg/ySCQMHIm2n6c54XJVqJjsPEggZDdQDtDpT
         YBkQ==
X-Forwarded-Encrypted: i=1; AKwUvBxVky/NysmG0Na+DmUVX9BMwf/E0w60IrNDkFWAtdKKEsqACc5gzfOlbFCJKuUjqImN30+D1WkT5iNA@vger.kernel.org
X-Gm-Message-State: AFuF++k8WlJVNEN9zejL1BLshvEbM+NRJgka66f1TqRDi8GWmpvDYT3V
	9dYtZ+F0KlUd49DEO/DQt1yY1ywSYsLerntFerGYrDawsckj354C02dkNr1ib1lt/Uc=
X-Gm-Gg: AYBFou3vNlubWdMbyTUPGXrbYuDRbpHuqK+dBm4rklPJkqxI+BTP6GgKA0omUr2Lol0
	EkDgrUzGmLcGKg94+Ha/alzmth44JdYot+/1/3qHFSuvdfE3aZJun+LNWJAESHSwJHnnX6o1p9U
	ZC+Bl6Ghdgkmg1NqNPgsAIrWKXMWJ0lnnhvrJajSUviOXWhsZulygW3QYpDArqaWpg/HWiexEiK
	hhRvFJvtR9qouLRnXsQZJ/mhMTs3F41FW23Q2p2+G7SvF7l83DnLpBLnibcnkWJ40b1EjiB9eDd
	+K30Y/NQ8574g1/OTsp8thhoSzJwytZ6V/q2yPMyiCRl0xGTCem8vuvmyJZFmAa9+AM3a7ukucg
	8yxKti/Uqw18o1umfIfjc8GkWG2p7ftXLajbzWWPy9YZ2tMsSp/G3SYbeN+uAJsUGm6kZn5rUA/
	jOxrcaq1+YshonWgZCV+1Leh/e1oPcVEV0bAbiow0gjj/OYr7a4Ns4+eTwnC7FaIgJHa1jxQXtz
	MDpI3p8mlWheYZo
X-Received: by 2002:a05:600c:e557:20b0:49d:1d6a:4cfb with SMTP id 5b1f17b1804b1-49e619836d6mr35798025e9.1.1789137765611;
        Fri, 11 Sep 2026 07:42:45 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60ababd5sm107038405e9.4.2026.09.11.07.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:42:45 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Xin Li <xin@zytor.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Aaron Tomlin <atomlin@atomlin.com>,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] s390: Avoid indirect includes through linux/module.h -> linux/elf.h
Date: Fri, 11 Sep 2026 16:40:32 +0200
Message-ID: <20260911-module-include-elf-v2-2-954c732975fb@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911-module-include-elf-v2-0-954c732975fb@suse.com>
References: <20260911-module-include-elf-v2-0-954c732975fb@suse.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Several s390 files use declarations that are provided indirectly through
linux/module.h -> linux/elf.h:

* arch/s390/kernel/nospec-branch.c: s390_kernel_write() -> linux/uaccess.h,
* drivers/s390/char/uvdevice.c: copy_to_user(), copy_from_user(),
  put_user(), get_user() -> linux/uaccess.h; file_operations -> linux/fs.h.

Add the missing includes to these files in preparation for removing the
linux/elf.h include from linux/module.h.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 arch/s390/kernel/nospec-branch.c | 1 +
 drivers/s390/char/uvdevice.c     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/s390/kernel/nospec-branch.c b/arch/s390/kernel/nospec-branch.c
index e11ec15960a1..b62da9e81e79 100644
--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/cpu.h>
+#include <linux/uaccess.h>
 #include <asm/nospec-branch.h>
 
 int nobp = IS_ENABLED(CONFIG_KERNEL_NOBP);
diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
index 4d274a2ee84d..402b8a225d6b 100644
--- a/drivers/s390/char/uvdevice.c
+++ b/drivers/s390/char/uvdevice.c
@@ -28,6 +28,8 @@
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/cpufeature.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
 
 #include <asm/uvdevice.h>
 #include <asm/uv.h>

-- 
2.55.0
