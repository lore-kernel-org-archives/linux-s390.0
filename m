Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE771F3D20
	for <linux-s390@vger.kernel.org>; Tue,  7 Jan 2025 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736264638; cv=none; b=qsHVC6dj93r6zfxsgWbHr50nPA8y7sNLA9ERS0f5q6dVSON9x/HttFxZHMFmga1rUTg2NjOpNGvUGIZk6xi7Ch00PyYptHOOZEfl0g2bs8IIJyRFgfpwF3j/3i4udzo26mWYptPnnFIEwFFI2F724EUfmblRWmIQHXaSElIyhQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736264638; c=relaxed/simple;
	bh=us/gybqfWlRp+ZsJNbaLvVR85yeT4xyjGChYxOQOMFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8/J13q29VXJbvGomRLfm/v4ZvQpluTbVvP2HpliHpX6TL2+EtqkCKCaqGWR0HrkBxm4FWmVpXSaJbs7ECDcAazoogbaKzgqz5UJvpa3yMKdHhTjGAdf5+CVLvld7effixSKN7xZ4YX1y+3v/6u30JS1afmXjk4HFLUh3HYYI+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cb/IvHVy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cb/IvHVy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736264635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1wRqChhOxLKlA65I6C1ssgvb1d066+xZqhJzJYv/kMc=;
	b=Cb/IvHVyC2NRV7Bu2oTiAfhtUOAJPs0Xyos41VGUu1RVyZJDqN6IlNysmXT5PtRizmFCHO
	WvoWExZLjtE9h1/bMC1oNr1okOPftcjvIXrxZ3EE7NKUk3XkXFcDnbCTfrRi0Xnpu+VJQ1
	rkyaZ+s0C375KyGL7uoGh6IpJi9tDsc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-iUQ7I4W0NeeCM2LnNSvXFw-1; Tue, 07 Jan 2025 10:43:52 -0500
X-MC-Unique: iUQ7I4W0NeeCM2LnNSvXFw-1
X-Mimecast-MFC-AGG-ID: iUQ7I4W0NeeCM2LnNSvXFw
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385d51ba2f5so6658293f8f.2
        for <linux-s390@vger.kernel.org>; Tue, 07 Jan 2025 07:43:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736264631; x=1736869431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wRqChhOxLKlA65I6C1ssgvb1d066+xZqhJzJYv/kMc=;
        b=xEv2vsvoHXh2Ck1YTot+K6fhuhvHo2gMX+zXhkp4TqafeDIoFLYzFq0Urlr/MwIP6B
         wuvFgHV3hF41Ke4ljA5DKErM4L4/xDeo/lmDbeu8JyosXx+2dKlADAiupkYOg/FMFLGG
         tKIQbQIQN3k9d1xEFLgBCTWFQXyTulThUKpEtJqy6xWq7OVhPrvgjn+60RUAX/sJ+fFb
         ifqutUfJt6b2SyIERXL+90Z/DMbta/R+DYtWBknY1zJgvxKzBpGt+tKmYjio7uvGmLoM
         qIcNsXk2HoujM3YpFPx7HYrTnc2UQU5u9qIy4XniGcqjeYG6/S96hZ8yZrHX/Ry945Yv
         VRSg==
X-Forwarded-Encrypted: i=1; AJvYcCVgGxR2AREGlhYfVwciQlxpQRBnq5Wheyic1Ib+OMoSfH3Zp2m9b8wRFi9W29w+uxjpnQ4bkNyJMpHd@vger.kernel.org
X-Gm-Message-State: AOJu0YxnUL4uNJagfCi44x/sKoNqfNwkW8FibsgB98X+FHQpPoLdR8E0
	bs26fRQwpzoUHMfajStWTYfsTUQwMzgov1pKckek50sb1LkliR7XhKC0v5XSCJ5mJw2OB6k9rH+
	MU90L8MIN1mQgf3HgEMQ6XJFR2j3p5KP1XEOaWmGZNRL0cY0TrP4tBEG5aSA=
X-Gm-Gg: ASbGncunbzaezU3OCAgacBWpi7uPGkQds61u5X1Ihkv6R+wT/4irZ8dmOn6PnlK/xs6
	imnqgHBSH1MCc29puYTcHbqnifVd9P1QJqyzjdMGru3fKxTN7UagIushCl/HXmbV9XyBJ89A4nP
	+0RuA2FZvK/kIIEtE6G9fxMqibIZ8cUHsEzJuPMuYFx8K7/DffCFI7BrZMxJeFHJQDRWFSFn8MX
	ESVd6svFAgNt1Srs/I684nx++zNO0qQcULt60V5KNwnyNJ0kSCJ6yP37///NhiCllVvgVqDiofh
	B7nlR2j0yE4sSw8eEhfq3vz6tTZs9DNVrouFds3ubA==
X-Received: by 2002:a5d:64c9:0:b0:385:f17b:de54 with SMTP id ffacd0b85a97d-38a221f11f9mr58228922f8f.5.1736264631012;
        Tue, 07 Jan 2025 07:43:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLoECKEzTyvVm/DKjeX8M+3c6FmHlgXx3op9ZadVYNTen3ZEo0J6qV8cTI63InkqFC8SLJEA==
X-Received: by 2002:a5d:64c9:0:b0:385:f17b:de54 with SMTP id ffacd0b85a97d-38a221f11f9mr58228911f8f.5.1736264630656;
        Tue, 07 Jan 2025 07:43:50 -0800 (PST)
Received: from localhost (p200300cbc719170056dc6a88b509d3f3.dip0.t-ipconnect.de. [2003:cb:c719:1700:56dc:6a88:b509:d3f3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38a1c89e140sm51822558f8f.79.2025.01.07.07.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 07:43:50 -0800 (PST)
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
Subject: [PATCH v1 2/4] KVM: s390: vsie: stop using page->index
Date: Tue,  7 Jan 2025 16:43:42 +0100
Message-ID: <20250107154344.1003072-3-david@redhat.com>
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

Let's stop using page->index, and instead use a field inside "struct
vsie_page" to hold that value. We have plenty of space left in there.

This is one part of stopping using "struct page" when working with vsie
pages. We place the "page_to_virt(page)" strategically, so the next
cleanups requires less churn.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kvm/vsie.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 0fb527b33734c..00cd9a27fd8fc 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -46,7 +46,13 @@ struct vsie_page {
 	gpa_t gvrd_gpa;				/* 0x0240 */
 	gpa_t riccbd_gpa;			/* 0x0248 */
 	gpa_t sdnx_gpa;				/* 0x0250 */
-	__u8 reserved[0x0700 - 0x0258];		/* 0x0258 */
+	/*
+	 * guest address of the original SCB. Remains set for free vsie
+	 * pages, so we can properly look them up in our addr_to_page
+	 * radix tree.
+	 */
+	gpa_t scb_gpa;				/* 0x0258 */
+	__u8 reserved[0x0700 - 0x0260];		/* 0x0260 */
 	struct kvm_s390_crypto_cb crycb;	/* 0x0700 */
 	__u8 fac[S390_ARCH_FAC_LIST_SIZE_BYTE];	/* 0x0800 */
 };
@@ -1362,9 +1368,10 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 	page = radix_tree_lookup(&kvm->arch.vsie.addr_to_page, addr >> 9);
 	rcu_read_unlock();
 	if (page) {
+		vsie_page = page_to_virt(page);
 		if (page_ref_inc_return(page) == 2) {
-			if (page->index == addr)
-				return page_to_virt(page);
+			if (vsie_page->scb_gpa == addr)
+				return vsie_page;
 			/*
 			 * We raced with someone reusing + putting this vsie
 			 * page before we grabbed it.
@@ -1386,6 +1393,7 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 			mutex_unlock(&kvm->arch.vsie.mutex);
 			return ERR_PTR(-ENOMEM);
 		}
+		vsie_page = page_to_virt(page);
 		page_ref_inc(page);
 		kvm->arch.vsie.pages[kvm->arch.vsie.page_count] = page;
 		kvm->arch.vsie.page_count++;
@@ -1393,18 +1401,19 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 		/* reuse an existing entry that belongs to nobody */
 		while (true) {
 			page = kvm->arch.vsie.pages[kvm->arch.vsie.next];
+			vsie_page = page_to_virt(page);
 			if (page_ref_inc_return(page) == 2)
 				break;
 			page_ref_dec(page);
 			kvm->arch.vsie.next++;
 			kvm->arch.vsie.next %= nr_vcpus;
 		}
-		if (page->index != ULONG_MAX)
+		if (vsie_page->scb_gpa != ULONG_MAX)
 			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
-					  page->index >> 9);
+					  vsie_page->scb_gpa >> 9);
 	}
 	/* Mark it as invalid until it resides in the tree. */
-	page->index = ULONG_MAX;
+	vsie_page->scb_gpa = ULONG_MAX;
 
 	/* Double use of the same address or allocation failure. */
 	if (radix_tree_insert(&kvm->arch.vsie.addr_to_page, addr >> 9, page)) {
@@ -1412,10 +1421,9 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 		mutex_unlock(&kvm->arch.vsie.mutex);
 		return NULL;
 	}
-	page->index = addr;
+	vsie_page->scb_gpa = addr;
 	mutex_unlock(&kvm->arch.vsie.mutex);
 
-	vsie_page = page_to_virt(page);
 	memset(&vsie_page->scb_s, 0, sizeof(struct kvm_s390_sie_block));
 	release_gmap_shadow(vsie_page);
 	vsie_page->fault_addr = 0;
@@ -1507,9 +1515,9 @@ void kvm_s390_vsie_destroy(struct kvm *kvm)
 		vsie_page = page_to_virt(page);
 		release_gmap_shadow(vsie_page);
 		/* free the radix tree entry */
-		if (page->index != ULONG_MAX)
+		if (vsie_page->scb_gpa != ULONG_MAX)
 			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
-					  page->index >> 9);
+					  vsie_page->scb_gpa >> 9);
 		__free_page(page);
 	}
 	kvm->arch.vsie.page_count = 0;
-- 
2.47.1

