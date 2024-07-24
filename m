Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB24877F15
	for <linux-s390@vger.kernel.org>; Wed, 24 Jul 2024 20:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721851848; cv=none; b=la5oXjYauIGFD+ARAIMfBYA6Uwaw3S6icrieI2CJbfKMxlti/9NKliS3tvaqJTsvaPFJRl+kqg9k5mxQSxSTR5/qYHea6xarTrcmLNgtxbvpB9Kl39diZvEgqpxb/mCauc08Pw3I98bslwtEKuv4V4ylbD46vBFEFXLqHFw1F8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721851848; c=relaxed/simple;
	bh=jLkje1TMaMcDFZ1isivzibz735Gz2ysL24u90U03b/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A7H/+d82jPCGpx9SlUwCIUHnU6ktYxsCQCKPxxpDP54OcbGqdbC5EqTRmjC/lLRc7e7GD7dH5yMAAq0yszkuJl69XtC5GePcOFIeBvKyYPuFGj78cQtzOKblZIor+P2CJk9B/roTuQH0VGRWDb/fWtn5oEVPzOa+qpt6KSFL8iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JIepS2gg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIepS2gg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721851845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B+KGAhlehjnwvrQJqvaNqFPQndDkZyQpii0lamAO9o4=;
	b=JIepS2ggcQc5NH5MTtxTACH98quEbgRKfTp1tWyuoYyNBeIGccWFtk7OcNB2+OzvXBuEbp
	mL6W+3LeleZN8JXBY/Ac3GysmHTRRlHmIJQ5WA34bJaC03o8RqTxRkZDyklReQTNJtd8r2
	yxNb0twNmpeANn5wdjQ6jbvCNCCB5KE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-PNLVw-IsPMmHl6nqa7JusQ-1; Wed,
 24 Jul 2024 16:10:41 -0400
X-MC-Unique: PNLVw-IsPMmHl6nqa7JusQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32B2119560B3;
	Wed, 24 Jul 2024 20:10:39 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.33.84])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7BDEE1955D42;
	Wed, 24 Jul 2024 20:10:36 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Cc: akpm@linux-foundation.org,
	shuah@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Subject: [PATCH] selftests: mm: add s390 to ARCH check
Date: Wed, 24 Jul 2024 14:09:55 -0600
Message-ID: <20240724200955.14882-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

When compiling with ARCH already set, the s390x ARCH is actually s390.
Add s390 to the ARCH check list, so we can properly build selftests for
s390.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 tools/testing/selftests/mm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 901e0d07765b..7b8a5def54a1 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -110,7 +110,7 @@ endif
 
 endif
 
-ifneq (,$(filter $(ARCH),arm64 ia64 mips64 parisc64 powerpc riscv64 s390x sparc64 x86_64))
+ifneq (,$(filter $(ARCH),arm64 ia64 mips64 parisc64 powerpc riscv64 s390x sparc64 x86_64 s390))
 TEST_GEN_FILES += va_high_addr_switch
 TEST_GEN_FILES += virtual_address_range
 TEST_GEN_FILES += write_to_hugetlbfs
-- 
2.45.2

