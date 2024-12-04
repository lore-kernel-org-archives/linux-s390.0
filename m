Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECED1CDA09
	for <linux-s390@vger.kernel.org>; Wed,  4 Dec 2024 12:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316905; cv=none; b=tS+ET41RD3C477eAJVPiCBlOpC76D5NAtAkxWlpSKK+fqcf2rt8PsixRRSaUaWU40AucSVTewwRwqHT+RG9Zf8na8UU3rYp+XMB3yfrqYNxn6cyPjgPOI+qA0HMkijxepXAVJAf8Oy8T8cvLbFTRsM1UnvwFcgn3PqVZCOGRlA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316905; c=relaxed/simple;
	bh=BgMJzD3uvTJhEKjQ1/IdIeY2entK2KsTWNxYBemJ1qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anvpoDbz3eMIiOcJiVImfNGM/fLPPzE7YntC/GUR7nzii5gaUQw3D7N/4BlnL/z0RivXP42ACeEocYpBDvSyrzQHcGsml8UTw1GGGH5yapRNXJ4+ZqzYqjFp2IYCaNfCpJac6V0uRWs247mSnD5qvPxpAXwmfLk9YKkI1tGTNgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GW5FMw+a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GW5FMw+a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WYRTkbcHet+ClCO8Q7Li/qxr/6/P0nWlLIIrfww7Knk=;
	b=GW5FMw+auNEG6EXHPF67S/0tV49wAULCi+mreQUSFeALvtdoZnysb8nz7ceYBWJX8tboi6
	6THrdZYOxdNTeB8XtoD4xUNnG2si2Oi+iP0khCca39ZyoeLPibNnGcrLKfPpZzVaGt+q1r
	MYrncwTcwGvU1JJON8ONB/E8ruFTBgU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-VXXD8gP7MnSwJ2xMX9K3Sw-1; Wed, 04 Dec 2024 07:55:01 -0500
X-MC-Unique: VXXD8gP7MnSwJ2xMX9K3Sw-1
X-Mimecast-MFC-AGG-ID: VXXD8gP7MnSwJ2xMX9K3Sw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434a467e970so47936845e9.2
        for <linux-s390@vger.kernel.org>; Wed, 04 Dec 2024 04:55:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316900; x=1733921700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYRTkbcHet+ClCO8Q7Li/qxr/6/P0nWlLIIrfww7Knk=;
        b=KevZdMrB1HkY36EuT2gPuf2bHi73o1R7cHVLqky6HxV0uYOfDXv+YBJ9VPOxLrQSea
         d767PMddLCBHsA39H7AgogBSljoNSlBnK9JOsymOhq69WiJj0uRVOxVQgigXcDnlnDvT
         x+dmU4rbNCHTqJkYkc4Bjdw9yRq2CaQJ/P6JzIH2TZcS8wUE9D2gwsbYppqJxB098yLu
         RxX0+TGP64lGpqd62Dq8w7DrUgDRzLaOVb+FDoWe8rpAI0SRrD6H3Jn3hwAL9mbe1IOX
         ojWMoUclxgjIU6tEqUv/wKMgK0TosLYp9NPTa1UgTDstJPIpdZSwP4vhDou7sAKDUmNS
         7ByA==
X-Forwarded-Encrypted: i=1; AJvYcCXPbTfYa2oTX9FZ9VWEvvRr4vIVOcOh5PLMx1zsylR1FALsiFJRZAnlDc4O+1pk9CXkw43zHbV7yf/8@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6cvzQcXDI06jQzXulJu956F6IrVQLiOaCeNKsL0djj2HBv0JR
	lpnBfCPUV94kwjj5I+I5xflOcXQ08AmzUCEZSHuncDjvpIioc8vEWI7HxOew7kxR/oNqeeQ6q+z
	jOfgZGJnDRg00OYnKhKK8DD44/Kri7A37DK3qV+AI5bMZsxXb6/9XER2SFyY=
X-Gm-Gg: ASbGncsEJqm9PMyJxqo0JxwNuQmfVDcCQgcjacGlYqPBBYNTG35qV0aj8LgAu6ouqvy
	dtsbNYNwf6WkiEruA+/n2kHuBLJ2Md33PThmcGWmymnV7+mTXQD7C+ozAkYFOeAlgPit7CkGrAW
	71mpACpLNh+m0ZF6jT76gKrjT5W54M3Reua+Nmyn8aICEuUBuNl+ANzlpmwJGpc5+tG2M2Ok/yb
	RR7JjXFeBOwGUCZ6y7V+00Kg0TTuSRY6K7UI73iEC+J5uaCgAgnN4mnLPvE9aEFbOCsnqCGSpOo
	UxsPK0aV464iTyQspqBJftHaOZstAzdvlEk=
X-Received: by 2002:a5d:6c62:0:b0:385:f677:85af with SMTP id ffacd0b85a97d-385fd53ee5fmr5431764f8f.47.1733316900257;
        Wed, 04 Dec 2024 04:55:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkIZLfFS9dd4mzise8YhuqVkFTd47qC7aw9US3336mGUo5e0+UH/rIIT1Petk2to7fPbudFQ==
X-Received: by 2002:a5d:6c62:0:b0:385:f677:85af with SMTP id ffacd0b85a97d-385fd53ee5fmr5431725f8f.47.1733316899810;
        Wed, 04 Dec 2024 04:54:59 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-385ccd2e1bdsm18785865f8f.9.2024.12.04.04.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:54:58 -0800 (PST)
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
Subject: [PATCH v2 04/12] fs/proc/vmcore: prefix all pr_* with "vmcore:"
Date: Wed,  4 Dec 2024 13:54:35 +0100
Message-ID: <20241204125444.1734652-5-david@redhat.com>
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

Let's use "vmcore: " as a prefix, converting the single "Kdump:
vmcore not initialized" one to effectively be "vmcore: not initialized".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/vmcore.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 16faabe5ea30..13dfc128d07e 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -8,6 +8,8 @@
  *
  */
 
+#define pr_fmt(fmt) "vmcore: " fmt
+
 #include <linux/mm.h>
 #include <linux/kcore.h>
 #include <linux/user.h>
@@ -1580,7 +1582,7 @@ static int __init vmcore_init(void)
 	rc = parse_crash_elf_headers();
 	if (rc) {
 		elfcorehdr_free(elfcorehdr_addr);
-		pr_warn("Kdump: vmcore not initialized\n");
+		pr_warn("not initialized\n");
 		return rc;
 	}
 	elfcorehdr_free(elfcorehdr_addr);
-- 
2.47.1

