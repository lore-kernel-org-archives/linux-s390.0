Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C37224F6
	for <linux-s390@vger.kernel.org>; Thu, 24 Jul 2025 13:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363867; cv=none; b=ntRCt0ljjwhJlczOn4nUhELjvO6PUjXnxTbHAvL8ERN52QcgZ1YmeLVh57raIKsLYxVQx/5BnnHd7FUyUlIzCNTOAQdG4gmLSrmwxgUbAj06eISXigmw+zN8K+OjIr+sssMfUy1oj6WYVhl2f75ZYwv3zyK2dlXbuZV96MGFKEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363867; c=relaxed/simple;
	bh=k9gAyqzok4sTUtsAlTBlX+YJidX+nmDzcjoqbBXlurs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T7cu34o5uixKXJF8GpLn1/DIurI1/jo60prn3BV9+kt51u8OZZlRErOYWoFayK8+wHE2mHGl3oj9/Q3SilSt18GoTKlcxOdIeAWn23SqSKcTOXnUN5PQp5kEy85fydXjDoe2D42fdtLSBOQadgfGbLVBpGhfgzPxJMnDyaChPLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BUh0gOxD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUh0gOxD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753363864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uh6BZwyJXcSYQ1q1apdUOd5VW0oyNqWbdqse1odGKyE=;
	b=BUh0gOxDIqQabVSjuSDNKNnbnx/yCnddIBwaPWV5zPSeiszYc5p5/Ezafobm1T4d+OA1xZ
	5zK4cIIKxJf7xcQkma74rnYydP5uBTNXuNoxovQ1A4uEsD0QxTUFt/2c3GzGu6hvN246bh
	e7tNGgFQNNLdUMUb74HGzebaVpzUmTc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-eOIwZvrxM1merg-WiKMiDA-1; Thu,
 24 Jul 2025 09:30:58 -0400
X-MC-Unique: eOIwZvrxM1merg-WiKMiDA-1
X-Mimecast-MFC-AGG-ID: eOIwZvrxM1merg-WiKMiDA_1753363856
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9145D1800446;
	Thu, 24 Jul 2025 13:30:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.82])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 82693300018D;
	Thu, 24 Jul 2025 13:30:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: kvm@vger.kernel.org,
	=?UTF-8?q?Nico=20B=C3=B6hr?= <nrb@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	linux-s390@vger.kernel.org
Subject: [kvm-unit-tests PATCH 0/3] Improvements for the s390x panic-loop tests
Date: Thu, 24 Jul 2025 15:30:48 +0200
Message-ID: <20250724133051.44045-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The panic-loop tests sometimes fail in our downstream CI. The first
patch fixes this issue. While we're at it, add the tests to the
upstream CI, too (second patch). The third patch is a RFC: Is it ok
to drop our dependecy on "jq" for these tests by replacing it with "grep"?

Thomas Huth (3):
  s390x: Fix unreliable panic-loop tests
  .gitlab-ci.yml: Add the s390x panic-loop tests to the CI
  scripts/arch-run.bash: Drop the dependency on "jq"

 .gitlab-ci.yml        |  2 ++
 scripts/arch-run.bash | 27 +++++----------------------
 2 files changed, 7 insertions(+), 22 deletions(-)

-- 
2.50.1

