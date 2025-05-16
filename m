Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52F623F40E
	for <linux-s390@vger.kernel.org>; Fri, 16 May 2025 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747399196; cv=none; b=K05t1ZkJ6bw74H9ILEWf+vjfzVrMF3cT4LADd6Qbb5c/LjMTko7Uk+QpQE2e3cQkgajwGNszlsRyW4ja972iNYmg+a/KF42F1asKQK3q2Tg/hIbFFU5+00OT2k82fZVt09xH2mE6uEGHryLXLfDHFyz5Pb2VXLsLXtSpOhBpISk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747399196; c=relaxed/simple;
	bh=NmMEnvYRjcgEyI5M5m7hBi79ExciAcqQbeWQvpSCOTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upqWUTfZQxmfJJ6ExiFwtPFBAm9tAQXqGmf59X4rXdGFAutM5vbfwbu+nrBx0pXHdtQQ6R1KlY7W8FirZNSL6TSMEtAiZU5i4F2LMQm4nopwJpG+9hO49b3CvUoOaVQklNsnh8I9WwYTGLXSOfFZGQzUZ1cdy4NYf0VN5SO4lXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HJp0rFIw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJp0rFIw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747399193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dD4s5BjWgdY0XRygYfoiKVTZtRM5PGr6HfbLhrnOYkc=;
	b=HJp0rFIw/4KdU2ihKrOou43c+zZzN7YDSXQDamf+9ua5o9nNNUdgsvpNMCYApv9L5CTZX/
	+j4rCu135M0zHuLoaf3zVfzAhvneh33tmQNXeDPXs2dkjppDAiH9cqMiLaojI5xu+bakeR
	HpLYbheRVNvFZNK1rcrQV+hl0QcPSH8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-bAoRhdsaPku_o5si3HPclQ-1; Fri, 16 May 2025 08:39:52 -0400
X-MC-Unique: bAoRhdsaPku_o5si3HPclQ-1
X-Mimecast-MFC-AGG-ID: bAoRhdsaPku_o5si3HPclQ_1747399191
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a0b570a73eso1338486f8f.1
        for <linux-s390@vger.kernel.org>; Fri, 16 May 2025 05:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747399191; x=1748003991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dD4s5BjWgdY0XRygYfoiKVTZtRM5PGr6HfbLhrnOYkc=;
        b=Vsn5U0Brqjs4kZl+GHfMLLB9SDmOmMzMI461QwyxdVsVzzGyp7j++n483z3odiWJrt
         zwR5b7toHJuMmheuK9qRaxO/nvQGH7bZ6An7Ul7Dr6yYpMpLskidi7WlYOVA39/pf0gL
         YdYm8p0PRLh8EvlW4etrv8uzXsZMKOT2/zuqQXjzACaE1zOoDH55mvv8exwMy+s+yZRX
         UOTCJZEyNjIuD+KL7a/pYkf61DyoWZohIIhbaHt6ox1pL/IkXt0uKtXdSRG63j+yv3ez
         DiAy3lT9NGMPrA092Hvdwar/eQDheKmn0S0zbIKdqnDh2nOyDzj9jrogE1qwn37n1VGV
         rqgw==
X-Gm-Message-State: AOJu0YzeNxNTTkyoZzUt2MSPLaRgZCimwtSHlzrzM9zMk4OWmBTQXIAz
	LSex+d26XidCMB519QLxuP/ydKpEIMqisExMGv6oU5SBxo9pdISd3BBwdIhWr5RDsGyPJHrGUjm
	Uvu0GY33dgYYeJ7XTryT9uatZ7v4e1h2/BHqOsnUt66BHDY6+uvrouXp8JDdpPog=
X-Gm-Gg: ASbGncubrRbsQ+ugcK1zvpo/BBOhKQxMUPA0mh3vzc+Qcom/G7TYkGOmmWxTA1RqzGJ
	sc9jBZer+HbN5jCfP/POtvuRLY2q+rofslNJyOWh5A6NItsI3cprzylfrXjz12bp3V58ZpTt0DH
	RHIQPiKvk6dpcBVljQoN4KFDVLJAnkMbnwnCElwuga78LlmMxMWyqWpnYMr2tpN6GZCXJpbA6Gy
	788oI47BUUGv/vJSDExB5YB/LuajFD0UYzKtAK5SfinMnJlTcUXWotqoYyDBu1rZ41ZuKK33sit
	v5ysGfwBaBB0MyC6w9+jr/kvDMrdQOOHiUTI+J96VYUk2jZVgNi/Hboo0TX+2DzTmWt5Q4LC
X-Received: by 2002:a05:6000:2305:b0:3a0:7f9c:189a with SMTP id ffacd0b85a97d-3a35c7dd97fmr3453601f8f.0.1747399191338;
        Fri, 16 May 2025 05:39:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv93D7EpnmZ+BrL8Zcx6nM5iZBOF7WC9roZjSuYlsEHMwzBOdkSWq8EgsH051sEEAROR2png==
X-Received: by 2002:a05:6000:2305:b0:3a0:7f9c:189a with SMTP id ffacd0b85a97d-3a35c7dd97fmr3453568f8f.0.1747399190948;
        Fri, 16 May 2025 05:39:50 -0700 (PDT)
Received: from localhost (p200300d82f474700e6f9f4539ece7602.dip0.t-ipconnect.de. [2003:d8:2f47:4700:e6f9:f453:9ece:7602])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a35ca62c70sm2792386f8f.54.2025.05.16.05.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 05:39:49 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Huth <thuth@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Zi Yan <ziy@nvidia.com>,
	Sebastian Mitterle <smitterl@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH v1 1/3] s390/uv: don't return 0 from make_hva_secure() if the operation was not successful
Date: Fri, 16 May 2025 14:39:44 +0200
Message-ID: <20250516123946.1648026-2-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516123946.1648026-1-david@redhat.com>
References: <20250516123946.1648026-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If s390_wiggle_split_folio() returns 0 because splitting a large folio
succeeded, we will return 0 from make_hva_secure() even though a retry
is required. Return -EAGAIN in that case.

Otherwise, we'll return 0 from gmap_make_secure(), and consequently from
unpack_one(). In kvm_s390_pv_unpack(), we assume that unpacking
succeeded and skip unpacking this page. Later on, we run into issues
and fail booting the VM.

So far, this issue was only observed with follow-up patches where we
split large pagecache XFS folios. Maybe it can also be triggered with
shmem?

We'll cleanup s390_wiggle_split_folio() a bit next, to also return 0
if no split was required.

Fixes: d8dfda5af0be ("KVM: s390: pv: fix race when making a page secure")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kernel/uv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 9a5d5be8acf41..2cc3b599c7fe3 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -393,8 +393,11 @@ int make_hva_secure(struct mm_struct *mm, unsigned long hva, struct uv_cb_header
 	folio_walk_end(&fw, vma);
 	mmap_read_unlock(mm);
 
-	if (rc == -E2BIG || rc == -EBUSY)
+	if (rc == -E2BIG || rc == -EBUSY) {
 		rc = s390_wiggle_split_folio(mm, folio, rc == -E2BIG);
+		if (!rc)
+			rc = -EAGAIN;
+	}
 	folio_put(folio);
 
 	return rc;
-- 
2.49.0

