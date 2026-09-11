Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C5636B92D
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137771; cv=none; b=sThLxjuP4Y0jNvvvV+8rx5rPMayfQqClWTItz2aZwwTvDP1qweNdKgnC5cm+hipusVNl7CL6s2+upwvuw2zwrW8InlgcQf6d5RzjjECKxSGpOJwTJNUOla1WLWNdKOx0oFuLMMOXuW10W1jRgJEoa6pFpb7AHB/YLnrZ3IhQij4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137771; c=relaxed/simple;
	bh=ETAktZ2QqHsWv3xS6bFropZQnc1xNBFVWMWX5r49MRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eW9tTxNbC8E7DRUTxou5Go00LP7NisQd6CAQtBEECjXeUAmfpFkN87YSWQlRzlCVIyMDB/cY0SnMd1lDCUqRn3jhoNEprtGQy7/rlaJUkOvik+IXBoeaPjTNBfwVEUy6mRKqZHqc9BAXjqzLZhCw20olIXHas+3R4e8OSaj0PCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KMuTAQ60; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KMuTAQ60"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49d0b98d6d0so12252375e9.0
        for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 07:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789137767; x=1789742567; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zmqtfnwwI+zawdSfV+Bb8zoK3g+hxNVqzzOe1wmmaFk=;
        b=KMuTAQ60E1CNCd4URXitK1S0G1TPbtFo/8O8pHis1hFlmUoTVHMXiXNQVvL5tTNkJk
         7xlpb9OjCsSQguxNa/njBoRk0dh9fLjoT1Jd7nLCVirRR7lR6ptF/nwcTO/oZ2dn1Z6J
         v/5m1+jI+XymI4y1S8B3tamh5a47cE053BCWZf76epFHDHjDpUXVJfXrVWVBkDD8aAxm
         VRP90l7RbEnDe6d+8TPz19FyjXodJnFsbAK94SJA9xssWf+u9KJx+brm2OWPM6zHNCdr
         F7I1coQzJHToof84FKaohuh4fKiA+446oeAEh5dIYeYntLaXFQ5zrY8jKVuo18z1Bw83
         9hzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789137767; x=1789742567;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zmqtfnwwI+zawdSfV+Bb8zoK3g+hxNVqzzOe1wmmaFk=;
        b=CiOP2/D+qbwMaPqG9sxYcl3dm++kMiLgBf4Tq7sbvbdXTwRk3+StExbBwLC9oHVlxd
         CY6uYXXXiAUIK6Hg3oqUcKJXR4KnXiLlYERatJoFua2s/nJX6XiQSksvpyWqZhINEq8R
         BMDw3TrLZGIJUqPiFNPL6HC2DQCj3XHPu7gIcOuPmy3IJuFzFUmEcsXENxiNc8riUNDc
         u/Sxf26R8C0kSLi8ZJ3vdjt07vh1nedohX7Geo7mprmwN7FSDMdi87Ha6jmxysUQ6U5g
         Occ2vcLeba5xIPOPEh92wAjPvYaGZByzIaYRhoe0UYmCOTOGCVYQBN7m8LuRT2M2ULZQ
         Vq3w==
X-Forwarded-Encrypted: i=1; AKwUvByCF8PxEZdAz3mKZbSueLgloLg+i6SyyeOMRju+Rz4uD7VrrNQtkCX+QTkJ6SFsR3N4xR6ynkVCLQX2@vger.kernel.org
X-Gm-Message-State: AFuF++kqW3oDNWz87rRFgtoH5faIp9UNihn0iUHjLv/q633NLm2PIhzk
	ZBi21pBsc+HiRllAImQD0tP3BVNcbo5FyoujL5qPefYne1+1or688L0oILwLcj2yWDk=
X-Gm-Gg: AYBFou0CiBW0mMgOI2NDBEHun5PaHcJ534kOvzH0yZ/4cln0wqyGRDa9PAXutFXlTk4
	yiPV8rt1vVEsBsDYSxVhAPvKD66Gg46whgc8HCmC9M/1LsY7g1+DWnshKi5h1lydl0fheH9KAn/
	RcGdaSEBLMs6JvDlGojPW07UFaISHrkAI6W5PBPa89jU2tzbvuTS1p94e4I3OuCDppB5onIHdje
	zXl9NGta1yMEZPMOJ41rK8Je6RmEMA1A6HYaiP2sFox/lvPmkrIP39DZYrXPoFfQrRtAeB04IGb
	uGzKeVIrr8Jv+jzFvrorGdxRD/XqP/upCzw5c4cK6md+D6nNJOrrZ2sQSPCOMqkd1SfWG0Sjb1w
	LKCHursnJe8YWgwxYTOjjgEoYk0CVs8NZFjh4bvctzIMOCUgV1/RA/xVG3R5TuUj4iDPB4KvHfi
	UvFcGH6FbKWP7W9M9kaidr9761h+tSg5Zn6iwWZogco2LfzdRQJuVek1zFdhiFVpQPI33snx6Yh
	rS1UPc=
X-Received: by 2002:a05:600c:1d1c:b0:49d:2562:d670 with SMTP id 5b1f17b1804b1-49e6199243amr52252455e9.14.1789137766949;
        Fri, 11 Sep 2026 07:42:46 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60ababd5sm107038405e9.4.2026.09.11.07.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:42:46 -0700 (PDT)
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
Subject: [PATCH v2 3/6] drivers: Include linux/slab.h for kmalloc() functions
Date: Fri, 11 Sep 2026 16:40:33 +0200
Message-ID: <20260911-module-include-elf-v2-3-954c732975fb@suse.com>
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

drivers/char/tpm/tpm_crb_ffa.c and
drivers/virt/coco/arm-cca-guest/arm-cca-guest.c use kmalloc() functions,
which are declared in linux/slab.h. They currently rely on this header
being included indirectly through linux/module.h -> linux/elf.h.

Add the missing includes in preparation for removing the linux/elf.h
include from linux/module.h.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 drivers/char/tpm/tpm_crb_ffa.c                  | 1 +
 drivers/virt/coco/arm-cca-guest/arm-cca-guest.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
index 025c4d4b17ca..af4466cdc297 100644
--- a/drivers/char/tpm/tpm_crb_ffa.c
+++ b/drivers/char/tpm/tpm_crb_ffa.c
@@ -12,6 +12,7 @@
 #include <linux/arm_ffa.h>
 #include <linux/delay.h>
 #include <linux/moduleparam.h>
+#include <linux/slab.h>
 #include "tpm_crb_ffa.h"
 
 static unsigned int busy_timeout_ms = 2000;
diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c b/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
index 0eeddd1ff05b..54dcfc1681ab 100644
--- a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
+++ b/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/device-id/platform.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 #include <linux/smp.h>
 #include <linux/tsm.h>
 #include <linux/types.h>

-- 
2.55.0
