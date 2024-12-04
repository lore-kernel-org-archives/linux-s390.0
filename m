Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1151F8AC4
	for <linux-s390@vger.kernel.org>; Wed,  4 Dec 2024 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316913; cv=none; b=Rg2VjO2eITW/Vjs3Cao2oHnj9wN2FgF9gt9AoxieQ60E6GUQcGvPnhTRKm20kfXB4pVgGQOJKSsTKIPTL5lu2YrOwkRSOypQKSzEzP3cdb297aaOTnE/ckC3r4ZtkmOao1QYq+j8ZgFy2y7/rqxpVfpdhxmUDcSlqmBzU5Rqt+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316913; c=relaxed/simple;
	bh=8EJBn/hbfhsOHacsaBstPaeEQTFd5MZoCB7W0faV+24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSLhCOJotYTaexHwN8Liz+0kIme9lq8wrdQD6Q9lcMUdR+xDygb2TdipWNTiP4JfCBYv7HVi098gKX6UPz5p9ClWkLL4yqZ479kNO8mhRjeDZZ8PwEJi2jtbawshu++vJyPrk0VwQbHBcAk6d1h+2B3i+HFo7XB6Z5Sy5MIH3zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HW9TwMYZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HW9TwMYZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/hPjJFLUCb0ZdSDAqGVI3uh+hCPNkczr7XmzIQmCEzE=;
	b=HW9TwMYZcntEQr7xS7j4/OtJZ/LxnuMjXcoifWK0hbxH3ifBovz2sKwBlhzTulR+yA0BAc
	nSd/tDtSw8MB2kOt2TcE0DKXl9jhTkMv2wojCjz1KBGy/Fls8+n44PORqicAKaDoKosuvE
	Gq2EmsKtWgsd+tuS01suX2Knx1B1IMo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-n7wfrEcpOfWs8XYRLaO-wQ-1; Wed, 04 Dec 2024 07:55:10 -0500
X-MC-Unique: n7wfrEcpOfWs8XYRLaO-wQ-1
X-Mimecast-MFC-AGG-ID: n7wfrEcpOfWs8XYRLaO-wQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4349df2d87dso62398715e9.2
        for <linux-s390@vger.kernel.org>; Wed, 04 Dec 2024 04:55:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316909; x=1733921709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hPjJFLUCb0ZdSDAqGVI3uh+hCPNkczr7XmzIQmCEzE=;
        b=htlDzhS658VdEzf7cY7I8rAYfno57x2RI9ZUuOb+tzjtLbYIb5sBNqEDD1Qu1AIouj
         lOPjmR/BBwcG27M1uUCJe3IblWHvt84MRPimw0kupcmR/dPKhLkn21Yz0ZeMJ+deIaSH
         W5FLP6uNRtA3/S6p6S2vvBh5y/ANBPusFkFEln2FNF9JiP5qvyusvI40dxEBHXnzNI7s
         Om+vwyTVJYA3YVHAAaIQQCXRVGHZR2XiKweYB5opZXMbitpu0IwVcUrBGYbMSOjW9OvT
         OK52m57g3I5VovkuCnnX/2NY8+tny/hqHrY8OxBN+Enccvmw5vlJ7K2Rnh79HQwt3LnV
         LpMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXarRUX9WhwJ9rSgTRreWo6B92uDVxMJ+yAJqjxXN7aUcczO2ztO1sqTqeZXqsO5bbsTFfMjTg0z3OP@vger.kernel.org
X-Gm-Message-State: AOJu0YyBSrU432ztcW8CiM1KTRkq73yAdsgzBkzN9kQQH/Q2gcz7oNUj
	xaVLimxz9AC+bbeWoLDTEzxs17cFHzBOfSKncg9FOOS/JjhBf+eboPRrRs0b830INCV0nEnLed0
	5UbuKQ033d6tOfbfcEnjcmS7ACUqSlgIblNlbc1XnywXTx5vW29K18kSt2yE=
X-Gm-Gg: ASbGncsQz08jR1XpWiFbDsAcUe55+lJXZqMTqvg7Yom1B2+IWmMP+/uPxknwRwfRtdR
	T/xjczPrMdD4Nd+NREwz/rzaW1xh4jBm9IxjnwemCpGg1VcTdpMsH3eVUiWndAhPz0DZ2rJNc3F
	G2veZXjRn2U6PiGaUN26keBrYwZl43FsVgh5g6Lz8yYkc5tPCnScVNEpK+YMUaQwyMQBl/3gVSK
	LkxBr05GDBbIBu1YPehGnMw2VuDbNsITbPpCdxROrrw3h9G4RNViF8u31022qRpNzf/KKnWaqnZ
	JE0Cgyru7+dS6RpipFnhN7m/KL8PIYNc2Mo=
X-Received: by 2002:a05:600c:1989:b0:431:6083:cd30 with SMTP id 5b1f17b1804b1-434d09b2a75mr60274845e9.6.1733316908759;
        Wed, 04 Dec 2024 04:55:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKlYOU/tZlshqWyJGjVsl03zkEzffSPE/+D71b9Tfd5+g4TqcfXtmwO5t6x/22DC/lF4E/bA==
X-Received: by 2002:a05:600c:1989:b0:431:6083:cd30 with SMTP id 5b1f17b1804b1-434d09b2a75mr60274425e9.6.1733316908112;
        Wed, 04 Dec 2024 04:55:08 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-385db7f86dasm16267209f8f.66.2024.12.04.04.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:55:06 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 07/12] fs/proc/vmcore: factor out freeing a list of vmcore ranges
Date: Wed,  4 Dec 2024 13:54:38 +0100
Message-ID: <20241204125444.1734652-8-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204125444.1734652-1-david@redhat.com>
References: <20241204125444.1734652-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's factor it out into include/linux/crash_dump.h, from where we can
use it also outside of vmcore.c later.

Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c           |  9 +--------
 include/linux/crash_dump.h | 11 +++++++++++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 9b72e255dd03..e7b3cde44890 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1592,14 +1592,7 @@ void vmcore_cleanup(void)
 		proc_vmcore = NULL;
 	}
 
-	/* clear the vmcore list. */
-	while (!list_empty(&vmcore_list)) {
-		struct vmcore_range *m;
-
-		m = list_first_entry(&vmcore_list, struct vmcore_range, list);
-		list_del(&m->list);
-		kfree(m);
-	}
+	vmcore_free_ranges(&vmcore_list);
 	free_elfcorebuf();
 
 	/* clear vmcore device dump list */
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 9717912ce4d1..5d61c7454fd6 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -135,6 +135,17 @@ static inline int vmcore_alloc_add_range(struct list_head *list,
 	return 0;
 }
 
+/* Free a list of vmcore ranges. */
+static inline void vmcore_free_ranges(struct list_head *list)
+{
+	struct vmcore_range *m, *tmp;
+
+	list_for_each_entry_safe(m, tmp, list, list) {
+		list_del(&m->list);
+		kfree(m);
+	}
+}
+
 #else /* !CONFIG_CRASH_DUMP */
 static inline bool is_kdump_kernel(void) { return false; }
 #endif /* CONFIG_CRASH_DUMP */
-- 
2.47.1

