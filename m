Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF522D4B68
	for <linux-s390@vger.kernel.org>; Thu, 24 Jul 2025 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363874; cv=none; b=thIcbB+vY3c1HuPBNGbCo9jiRgUBsaC0Z+cg9teX6Qqv5cfo3dHEpkJONlNt/sz2B7h0f6JbJSTRrXSbmqOnQ/76vEFGHxtWoNU1wOqgt781aTCZOP5kEFhZm7Rj8XYSRpgdzi1zB+VQceyca10qDIfb66gFYInwv589zjlhYe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363874; c=relaxed/simple;
	bh=0WJ+3UFOLj0EjL30KYoYtpD8DQbBcXcXMSak85Blh+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/UO8b3Rau8kPXqACrztSRJjkzYm0lV4Xgdl9GFMKNC5f+3eby2Ew7zECbDwV5lS6GGrNf0pIvOOCgd+z88R/M8IHwErngojD+Vcg8PzGnBnDaQryJ0sSGOaPFMLYP6nu8c7NFs+ZBzam5xPI/1afN2nb0pjET5SxX0tC7+ol+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JrPZh5ev; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrPZh5ev"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753363872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=duaQyAVRbkBAk+diiySFaCJuDFBkhYfgf7V2EYmBFeg=;
	b=JrPZh5evsyzWZDdzlj33LdG4Bw/SU7XKDsYX6T4UHrrvmJWSZuDWZR46pTU0OGPKDHwpds
	8CYwDA72l0aJ5rjpY47rkvGCM8sUMuU38S3VI7CAua5xazSCQqBpfKjR2Z54TVRDy8vGop
	k7pgemItOO0rlwItDLaRRFmwA0t4plQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-3tnBbaBgP7aCulIIFfy5Gg-1; Thu,
 24 Jul 2025 09:31:08 -0400
X-MC-Unique: 3tnBbaBgP7aCulIIFfy5Gg-1
X-Mimecast-MFC-AGG-ID: 3tnBbaBgP7aCulIIFfy5Gg_1753363867
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67B361800360;
	Thu, 24 Jul 2025 13:31:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.82])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3211300018D;
	Thu, 24 Jul 2025 13:30:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: kvm@vger.kernel.org,
	=?UTF-8?q?Nico=20B=C3=B6hr?= <nrb@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	linux-s390@vger.kernel.org
Subject: [kvm-unit-tests PATCH 2/3] .gitlab-ci.yml: Add the s390x panic-loop tests to the CI
Date: Thu, 24 Jul 2025 15:30:50 +0200
Message-ID: <20250724133051.44045-3-thuth@redhat.com>
In-Reply-To: <20250724133051.44045-1-thuth@redhat.com>
References: <20250724133051.44045-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Thomas Huth <thuth@redhat.com>

Now that these tests should work reliable, we should also run them
in our CI.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index aa69ca59..7e3d4661 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -517,6 +517,8 @@ s390x-kvm:
       migration-sck
       migration-skey-parallel
       migration-skey-sequential
+      panic-loop-extint
+      panic-loop-pgm
       pfmf
       sclp-1g
       sclp-3g
-- 
2.50.1

