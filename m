Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6133F1D8A16
	for <linux-s390@vger.kernel.org>; Tue,  7 Jan 2025 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736264634; cv=none; b=aY9s06hzzWo7eAVovic3ViQi3gWmPxwEscMqt1AbDmYC/EFsVDzG7vF6Ajgb1/E5eJm2hrCn0bDXOLqPk1Lq7bohLvyOkSkFDBsfVSPcxvy23dZPrutBoVwJjbqWNZ0C9Tvt0WgZB8xIxmMWQtcLryYH6Sk/Wsmc5MmzZwXh74M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736264634; c=relaxed/simple;
	bh=hjUxddgNgIench8tTN/A4/cad+LVlRD3ay1rqEPRWIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GlOiG3GeB5FzifdUgrfvtxWsOmkyXFZZyGjkfePbcjzRoXBd6TbdANS3URhJkFpRhnpa6t1q8QkQ1fzxub2R1OMpRLFy6iMHz9v8mEWY9rf8a9C+TqBLJjZOS+4t905+bYCA01BjRrPYtMJCU1QM3W9WmPbdlm1LstFfmyVkFEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jMl5yXmC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMl5yXmC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736264631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=no+Cud0jOAk4dWVRpdO5fYUlo8Ug9zs65TpfSMAqw2s=;
	b=jMl5yXmCl08AELw4k8tG3aI7YDA++krDbfUWXK5Z8lwEILquR8aV5yA7pvKvVOhRA8x1nx
	/ML77cciaZjeUfsYxKtCJVtuH1DBH/l4m1DAvNhKM62jNcneNOxdHrapYF4FsSieBOUKbv
	BRwxjIUPW+kJXUJ6bOsADx3plqSk64k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-HKNTxGjjNye3MloPlRzmLg-1; Tue, 07 Jan 2025 10:43:48 -0500
X-MC-Unique: HKNTxGjjNye3MloPlRzmLg-1
X-Mimecast-MFC-AGG-ID: HKNTxGjjNye3MloPlRzmLg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43623bf2a83so114362285e9.0
        for <linux-s390@vger.kernel.org>; Tue, 07 Jan 2025 07:43:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736264627; x=1736869427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=no+Cud0jOAk4dWVRpdO5fYUlo8Ug9zs65TpfSMAqw2s=;
        b=ThQPIBQi2xi+OI+/HfiEIysebcVBq0UkBRXanlBC02IfB1ngeaKX3yKDisFi3pXRud
         jEXRnGvoeKgCZMN3yL4ddJUD6iqph/9oqbJd/IkJzSW4zONcqsI0sOgk8O/uwdH3z3HD
         r3XfceAtf5pUSRcWXwPtrMILBrraQG7tVvkpd/dvm8HMmoA2IS/0abdNgIGCGB9IoRQI
         8PlpJsBOgCTSztO+GLE13SUFPaClD7V7GtiiiHm9bsjvpVkLIaIkY/FRp5GhPjLOYnAs
         AzpWpwytWLJyHqmCCFJBDDEIdIUaFpFZgW2lheTUNDpY+CGV5MHoulnzoODrNplyUccu
         LceA==
X-Forwarded-Encrypted: i=1; AJvYcCWn5Bxc4kSglBTAuJe5eMqAHlCBcF3gVbylHBLxgKnDn6FNgKEi8mxKWZ/tAEuXDXVPvp9Ch4DxN1t1@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi8U8+53XfhIbmJNQnjm2D5zurrak0Tr54xqzadm+wuk7Eihe/
	5ncgZFFXUJuZJlFAFmrxMKc5T5pjESmNxPeD6E9so1E/sqrhWnbnfaj5jz9Sr03cnNUKwxOTrPJ
	Ydkh2tN46J1+DZgGMGls67uzD2bYL0Y3Av1GBNci9hSdBhMkd4E2VRwOP0Bc=
X-Gm-Gg: ASbGnctYwc5uFCIJhRf7k64GKT+3C6b94xSz6VnFqi0Y2f2LbbxUr3abzJ6Ah5i0Bkf
	kZfwoHExM1WDngLRasZ9GpFwUolaMqcI8A+OxYrEC79ds1dbrOFNpfC6UPztEW65WV43wszCZjb
	+P8clsT0lK6/ULcIuM2EPutZPuP0nXeeR3WD/RmAxeqGKSbgXGSQwrvEHK7RhDZjU2d3w9q6zU5
	NGDDgqGWc1l1aEllBMrjIpeqJqXAvAulS2XoFfuBZtmUKmmgKlzfRvsp83hUA1LAhJen9xFF7A6
	mI53NH0ga6QP1gxxKHLLFzWNOsVcWVs6Z3zJoZhCCg==
X-Received: by 2002:a05:600c:45cf:b0:434:f297:8e78 with SMTP id 5b1f17b1804b1-4366854896cmr459739915e9.7.1736264626946;
        Tue, 07 Jan 2025 07:43:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtLanc3Hb6BIOTSGukfIzYS1Co4sBL6WU3f6+RlroOR2If65sti0csBVLD4eTv+aaDHFjzXg==
X-Received: by 2002:a05:600c:45cf:b0:434:f297:8e78 with SMTP id 5b1f17b1804b1-4366854896cmr459739685e9.7.1736264626629;
        Tue, 07 Jan 2025 07:43:46 -0800 (PST)
Received: from localhost (p200300cbc719170056dc6a88b509d3f3.dip0.t-ipconnect.de. [2003:cb:c719:1700:56dc:6a88:b509:d3f3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4366128a62asm596318625e9.44.2025.01.07.07.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 07:43:46 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Huth <thuth@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v1 0/4] KVM: s390: vsie: vsie page handling fixes + rework
Date: Tue,  7 Jan 2025 16:43:40 +0100
Message-ID: <20250107154344.1003072-1-david@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We want to get rid of page->index, so let's make vsie code stop using it
for the vsie page.

While at it, also remove the usage of page refcount, so we can stop messing
with "struct page" completely.

... of course, looking at this code after quite some years, I found some
corner cases that should be fixed.

Briefly sanity tested with kvm-unit-tests running inside a KVM VM, and
nothing blew up.

Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>

David Hildenbrand (4):
  KVM: s390: vsie: fix some corner-cases when grabbing vsie pages
  KVM: s390: vsie: stop using page->index
  KVM: s390: vsie: stop messing with page refcount
  KVM: s390: vsie: stop using "struct page" for vsie page

 arch/s390/include/asm/kvm_host.h |   4 +-
 arch/s390/kvm/vsie.c             | 104 ++++++++++++++++++++-----------
 2 files changed, 69 insertions(+), 39 deletions(-)


base-commit: fbfd64d25c7af3b8695201ebc85efe90be28c5a3
-- 
2.47.1

