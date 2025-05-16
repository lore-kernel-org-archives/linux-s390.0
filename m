Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC3223E354
	for <linux-s390@vger.kernel.org>; Fri, 16 May 2025 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747399194; cv=none; b=NR7b+yALBqqWiWCyXLDJleGjkSx3V6E27SXojJZtkA2qq23cKXCRF0UuA1vOhKShu5FCAyBnkkyWzBdSrSKz992BtVAtdyaSODaTMzQVSuh7BzzLlCohtwD2Juq+vOnZ1DhCFe2y0Q2O9lRioJ5zNkaego1pN0hEUHppq6IaClI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747399194; c=relaxed/simple;
	bh=bmgaT7YD2EJBkYL7K7imFqPWf1lV68fhOx0CtwG7grA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ekA4Ul3nu3KUrbmEe8Jx78ZLHfds4QDklzxuBndTzt1XpFU/MUskrCsmrRJbY4GRItyNNOgkej9twZ+rlWCMcb9aj79Qaoe0mJAMUNcrX9zJL802SMxpyX84OL++6rjlQMTOEd0h3Lx1TvNCM2nf17LrjtAexoqcupv8XF3dIbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nhwc9ZZ4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nhwc9ZZ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747399191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uhz3U140ohpt6ccWc+FSce3umZsRmkKP4Ya4jbqjSpE=;
	b=Nhwc9ZZ4XSIx89kP9N4+Iju1pM0htTxbPmFX9J/5MORuZdyyilEQxioThsBpHaaKZGSyZv
	LblO3W+XYJkSTW7GZK3GBvvf/+2YUOP362VXfWEhkcezHIEvpql4Hd3mXN2eKNQDFCSqYm
	GDkNyDbrGdDQCcUBbiulxa6j+3HVOes=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-tnkyGMgEOMmEPofv-aRpVw-1; Fri, 16 May 2025 08:39:49 -0400
X-MC-Unique: tnkyGMgEOMmEPofv-aRpVw-1
X-Mimecast-MFC-AGG-ID: tnkyGMgEOMmEPofv-aRpVw_1747399189
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ceeaf1524so12066495e9.1
        for <linux-s390@vger.kernel.org>; Fri, 16 May 2025 05:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747399189; x=1748003989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhz3U140ohpt6ccWc+FSce3umZsRmkKP4Ya4jbqjSpE=;
        b=TLg5eQtyLqKfJbrlWetuJAutkheaJKAoFddCvlRiR9kunZ/Yv0L79tOa87HRpX5fPg
         Z3C/e69Mpz9B5sdgYEyGD+JufVyRCkzpXDDMGTckAyhJGdsLRuZehsQIMIYRCHhiOVP3
         ydS34/1swn3gkL+op0EOxRHqrfqb1lHrxSjKnPMDgvK1aNMVLjTSZxVwxtL2Yjs7pc9Z
         mJmXNH134vVcAVfxV81Vq9KypFmODRs5rtqWEkngP7ZgGz6wztEFyON5riFKkiVdwKPK
         diVGkA4YCGpWj68yv1ZG50seTePGjnYIr2H8hGRnZmVVaK8W9pd2WfPXSy1GCWpncV9i
         IPxw==
X-Gm-Message-State: AOJu0YyocDlTE4Hkuqjnd0rntA7ePwmUbjgl0cCtYcfSFCHkgyPJQlKI
	0GYr4rfq0W/IRyOZ/c69ASmnU1yvMlyRZM+VCgqo+U1rF7OMOSsNqxsj+WAWITCP4WS2LeLsoso
	miJ75XW6kcVDNYZPQAY9MDNUgYlVvRv5vpR7q3ifM5/25nJEYMDQlOelBWv/lVfY=
X-Gm-Gg: ASbGncvwgsiKnPXMJwKg8x7fgRtKh5+wI8s2qUtbKQcaQtXFAZuM1TcbN0r6lMahtLE
	yoN2noJN4Vq3WiKRbNuSoHT85fY9sKRzVMsO67N3mHUpgXCklNGzNyqCiNDEGErQ9cyCLVfwUjy
	PaCpa/UYvq7VjEwUFcAmWSahWVHQrYDqhMi4squ57rpEOu9WI1y1An96f4oDKFZqZSYlqN5LX6I
	4yATupp7875K3PTLHzhhMMheBaPF4lgIcGhUifzojJbbwtyvCF+j4UEBk+o3IfwKqCZgJDa2H6m
	15zgyt41Fh3bCxSIpmLIPA9zLVn2rYJ422inZ6SlAXvEfg4+kAoJqwNb58gr07YmOLqHtNo0
X-Received: by 2002:a05:600c:154c:b0:43b:c857:e9d7 with SMTP id 5b1f17b1804b1-442fd93d4fcmr26794555e9.5.1747399188652;
        Fri, 16 May 2025 05:39:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG02eCs69TcqCLt8j2+2wKH4FlJPCCyiADW1BjCbtX8Ej+iIBeRfP51iBLLuyg6K1U4dIYtGg==
X-Received: by 2002:a05:600c:154c:b0:43b:c857:e9d7 with SMTP id 5b1f17b1804b1-442fd93d4fcmr26794325e9.5.1747399188282;
        Fri, 16 May 2025 05:39:48 -0700 (PDT)
Received: from localhost (p200300d82f474700e6f9f4539ece7602.dip0.t-ipconnect.de. [2003:d8:2f47:4700:e6f9:f453:9ece:7602])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-442fd50b30csm31929825e9.9.2025.05.16.05.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 05:39:47 -0700 (PDT)
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
	Sebastian Mitterle <smitterl@redhat.com>
Subject: [PATCH v1 0/3] s390/uv: handle folios that cannot be split while dirty
Date: Fri, 16 May 2025 14:39:43 +0200
Message-ID: <20250516123946.1648026-1-david@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From patch #3:

"
Currently, starting a PV VM on an iomap-based filesystem with large
folio support, such as XFS, will not work. We'll be stuck in
unpack_one()->gmap_make_secure(), because we can't seem to make progress
splitting the large folio.

The problem is that we require a writable PTE but a writable PTE under such
filesystems will imply a dirty folio.

So whenever we have a writable PTE, we'll have a dirty folio, and dirty
iomap folios cannot currently get split, because
split_folio()->split_huge_page_to_list_to_order()->filemap_release_folio()
will fail in iomap_release_folio().

So we will not make any progress splitting such large folios.
"

Let's fix one related problem during unpack first, to then handle such
folios by triggering writeback before immediately trying to split them
again.

This makes it work on XFS with large folios again.

Long-term, we should cleanly supporting splitting such folios even
without writeback, but that's a bit harder to implement and not a quick
fix.

Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Sebastian Mitterle <smitterl@redhat.com>

David Hildenbrand (3):
  s390/uv: don't return 0 from make_hva_secure() if the operation was
    not successful
  s390/uv: always return 0 from s390_wiggle_split_folio() if successful
  s390/uv: improve splitting of large folios that cannot be split while
    dirty

 arch/s390/kernel/uv.c | 85 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 72 insertions(+), 13 deletions(-)


base-commit: 088d13246a4672bc03aec664675138e3f5bff68c
-- 
2.49.0

