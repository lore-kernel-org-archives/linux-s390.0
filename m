Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F861EE00F
	for <linux-s390@vger.kernel.org>; Tue,  7 Jan 2025 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736264634; cv=none; b=koAoJ05a2Aneo5Uaeu3ssJDZpVdX0asg/fuQDJnV54QjcP9td2aMsYqkhX7OgO5kvQCTu7q0JCNM8L+z6ectL3P/g7hIBIY3Bf5Dm2mVxpmt90TKI2V7K0lCmWEtEaH4GqtJ/UthBmge3DfCng62dLq4/Bafoh4miYGMzW1Xl+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736264634; c=relaxed/simple;
	bh=kff/5MuiUSshICdL0Pz3Kwaact1TDCjVUg2HjOr3gSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1L/xBjVXgDQOgYuMIb8kGSodt5LHGP7QR/b2ZDooLE0DdDU1UEeLkU+umNy4vqtGVP2+pY3XZaswzXfAc3IVp5QyC6AbKg3EpyhhFmpruOADHJEIa/As5M3PgiqbwLUr26Scz9mfuHi1TVXWXf0x+ScxVTzFAzqnQvvbiQ5Vdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQnv+BdO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQnv+BdO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736264632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=be/xDpPjneQ7+z88xrOgXMm6ql8CC9vSv4tySFvSNk8=;
	b=SQnv+BdOjsYYMfAU2LTzbh9oU5RB3hydAxe09kyLYetiOA2zEWfjltjxRpParD5da54MFa
	PIDQow1CAtNTIJa9cnJK6EWFHIvcBAUXBaOKK91/foy7+TBFYAlyaYme6Me/N25II4esRs
	gC56lSS6B5yivZYLBmKTVvN+ZMxsvlA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-hL_4P3tqMJq3d5kAthAiJw-1; Tue, 07 Jan 2025 10:43:50 -0500
X-MC-Unique: hL_4P3tqMJq3d5kAthAiJw-1
X-Mimecast-MFC-AGG-ID: hL_4P3tqMJq3d5kAthAiJw
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-386333ea577so2800980f8f.1
        for <linux-s390@vger.kernel.org>; Tue, 07 Jan 2025 07:43:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736264629; x=1736869429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=be/xDpPjneQ7+z88xrOgXMm6ql8CC9vSv4tySFvSNk8=;
        b=lN+twsZEYzlKJXZjbQmHZ5n6DFgh9Gh8CscS0/hTv6oUtLjAfGJunGZbhyJ+V9Hhwm
         jIShgrWjWRvBZa3oBeMTc0zEX6MGdKQZDtoOxt94Q/rvYrgwHmG1om3TBuY9sA6E3fzK
         WYhzclfvXZzHug/fnfAdsms30W0je9qpcVsV4A9lkejJTZ+4Su6e8LAvtQl98MGboIgO
         CaJJtv7c6eSgqGbaK2Xy7dBksSxdtFhMM5VgIDOfUMYD2cJSD0PFJ45RWsw1yu1odDOb
         g5UcOEp+Mpfai1OQNyeZkLsW2/6tQoGpue7EjpYn3BUr6rgz8uDsvgA6QewyljpWZmV4
         9mCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZDk5CAKvkBFVHUZ54xXcKzXAboOiFVPMtoPa8U3KZLG3EykAE2hCVGrq9iuJ2EeSK8KdGgEM3ARbJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxKR1+hmjWJEgkfLWfDEhIRbkuAZRCELqQwgJjdudhzZi4zvvtK
	Pm8jhOBsw/OzF2NgEkGiKr5fz1mvhuh5zMjA3qgIxKHArASOauXEqEyXq7r/X+9hdzHRLk50ljS
	SRdbEEwC4FC85ibp2LwP1HepmJUVdaA8dnmFtc+IZ8cT3wX3Zshi/ObF+PvQ=
X-Gm-Gg: ASbGncuRyKMeOIQGOrLefe1SsfB6Au+Dh9ZYk81pIAQOedSxgcaIadB8Pbv0+jiDx0k
	PODoOJ3GDfr114eo8KVxU5dCYPt9/wsqpIo7N8ssNwFW+sBL8a+7T5uEC2jDF+GUULtePGHYiAB
	tXED2PFOU9rZhs6ggnKt10d17OKIJgHPYB/DdwV3199rC6TQz8dU93gOxwf6C9BREjNXluNqgae
	+nX6L92PWz8fyiBQIzHEfaSXyE7aacM4YXkEXGmim/+Y9G0AMDTAoevfUpa9hAw32Iih/y3d6ge
	RJLIhHgkczmYTc9WF0YaMuuiPEEgvFaaGUk4w0fV3w==
X-Received: by 2002:a05:6000:1f88:b0:386:4034:f9a0 with SMTP id ffacd0b85a97d-38a22408cbemr49437408f8f.52.1736264629542;
        Tue, 07 Jan 2025 07:43:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECHU3QXEd9DSMtt+gL3jnHOKISExr8ZSLHane3TsnWNkBR9T163eXOTOHhVFPDdEe315KvNw==
X-Received: by 2002:a05:6000:1f88:b0:386:4034:f9a0 with SMTP id ffacd0b85a97d-38a22408cbemr49437388f8f.52.1736264629175;
        Tue, 07 Jan 2025 07:43:49 -0800 (PST)
Received: from localhost (p200300cbc719170056dc6a88b509d3f3.dip0.t-ipconnect.de. [2003:cb:c719:1700:56dc:6a88:b509:d3f3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38a1c828d39sm52310207f8f.9.2025.01.07.07.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 07:43:48 -0800 (PST)
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
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	stable@vger.kernel.org
Subject: [PATCH v1 1/4] KVM: s390: vsie: fix some corner-cases when grabbing vsie pages
Date: Tue,  7 Jan 2025 16:43:41 +0100
Message-ID: <20250107154344.1003072-2-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107154344.1003072-1-david@redhat.com>
References: <20250107154344.1003072-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We try to reuse the same vsie page when re-executing the vsie with a
given SCB address. The result is that we use the same shadow SCB --
residing in the vsie page -- and can avoid flushing the TLB when
re-running the vsie on a CPU.

So, when we allocate a fresh vsie page, or when we reuse a vsie page for
a different SCB address -- reusing the shadow SCB in different context --
we set ihcpu=0xffff to trigger the flush.

However, after we looked up the SCB address in the radix tree, but before
we grabbed the vsie page by raising the refcount to 2, someone could reuse
the vsie page for a different SCB address, adjusting page->index and the
radix tree. In that case, we would be reusing the vsie page with a
wrong page->index.

Another corner case is that we might set the SCB address for a vsie
page, but fail the insertion into the radix tree. Whoever would reuse
that page would remove the corresponding radix tree entry -- which might
now be a valid entry pointing at another page, resulting in the wrong
vsie page getting removed from the radix tree.

Let's handle such races better, by validating that the SCB address of a
vsie page didn't change after we grabbed it (not reuse for a different
SCB; the alternative would be performing another tree lookup), and by
setting the SCB address to invalid until the insertion in the tree
succeeded (SCB addresses are aligned to 512, so ULONG_MAX is invalid).

These scenarios are rare, the effects a bit unclear, and these issues were
only found by code inspection. Let's CC stable to be safe.

Fixes: a3508fbe9dc6 ("KVM: s390: vsie: initial support for nested virtualization")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kvm/vsie.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 150b9387860ad..0fb527b33734c 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1362,8 +1362,14 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 	page = radix_tree_lookup(&kvm->arch.vsie.addr_to_page, addr >> 9);
 	rcu_read_unlock();
 	if (page) {
-		if (page_ref_inc_return(page) == 2)
-			return page_to_virt(page);
+		if (page_ref_inc_return(page) == 2) {
+			if (page->index == addr)
+				return page_to_virt(page);
+			/*
+			 * We raced with someone reusing + putting this vsie
+			 * page before we grabbed it.
+			 */
+		}
 		page_ref_dec(page);
 	}
 
@@ -1393,15 +1399,20 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 			kvm->arch.vsie.next++;
 			kvm->arch.vsie.next %= nr_vcpus;
 		}
-		radix_tree_delete(&kvm->arch.vsie.addr_to_page, page->index >> 9);
+		if (page->index != ULONG_MAX)
+			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
+					  page->index >> 9);
 	}
-	page->index = addr;
-	/* double use of the same address */
+	/* Mark it as invalid until it resides in the tree. */
+	page->index = ULONG_MAX;
+
+	/* Double use of the same address or allocation failure. */
 	if (radix_tree_insert(&kvm->arch.vsie.addr_to_page, addr >> 9, page)) {
 		page_ref_dec(page);
 		mutex_unlock(&kvm->arch.vsie.mutex);
 		return NULL;
 	}
+	page->index = addr;
 	mutex_unlock(&kvm->arch.vsie.mutex);
 
 	vsie_page = page_to_virt(page);
@@ -1496,7 +1507,9 @@ void kvm_s390_vsie_destroy(struct kvm *kvm)
 		vsie_page = page_to_virt(page);
 		release_gmap_shadow(vsie_page);
 		/* free the radix tree entry */
-		radix_tree_delete(&kvm->arch.vsie.addr_to_page, page->index >> 9);
+		if (page->index != ULONG_MAX)
+			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
+					  page->index >> 9);
 		__free_page(page);
 	}
 	kvm->arch.vsie.page_count = 0;
-- 
2.47.1

