Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6018752F64
	for <linux-s390@vger.kernel.org>; Mon,  3 Jun 2024 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717401757; cv=none; b=AeqkXbas2qjq4tb7IZs6s87+64nxiYrKHAMEOLZTqp2rKp1KAyuvu/gfJwxf0I0A9Mxj74wuydDMpwrx4Nty5JoYpN1EWooGaPeNH8yMWABTDsr7OfPzwY+3WKcY28pvepWY/LT8+fgNNw8YuQEqHCXzCpbiMWSVpU0EttwKAKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717401757; c=relaxed/simple;
	bh=yWTQCmiw4llmYam/bGTKz7lHQI6y+oAREBxoG7gqRkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lHloOf1KUcIp1OnIvSMWQEtRpVCiuLd80GWGulUIWsIWcHPG1TBGsLlN23w0dg5NEn7KA4IyqTwN3e5UuJ6sm0cZxm/dQPOeqsHn9K+vnOuwjJiPnj48gRUt52P96v0KQZHzj3w8FHYBCRt4fhcSGxC3P5oZL7lx808ZgjGPW00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DacFEVCn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DacFEVCn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717401755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ScFxO/z1YMI1dmk8FoS6VTnuVsBY6a6Y1MFjYPtT/MQ=;
	b=DacFEVCn2UrlHGcH8DC3uglIlZyDFYPsfLSNIO10elo4+71DJcUq/3CaPt7RUyaesVxDjD
	iz0E+aV1kmGBqAJ1x64uKXCqc+Kb32T1GjG4y/OTDsvqPR+X1ljU1UZIBXpdSdPP/NvTzW
	skdkqqsPKCITgfyAeTI0YDGNKoPWOYY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-KSZA082aM9ert8dtDWV_rw-1; Mon, 03 Jun 2024 04:02:31 -0400
X-MC-Unique: KSZA082aM9ert8dtDWV_rw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35582800281;
	Mon,  3 Jun 2024 08:02:31 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.65])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CF2B4C15BFC;
	Mon,  3 Jun 2024 08:02:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: kvm@vger.kernel.org,
	=?UTF-8?q?Nico=20B=C3=B6hr?= <nrb@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [kvm-unit-tests PATCH] MAINTAINERS: Add scripts/s390x/ to the s390x section
Date: Mon,  3 Jun 2024 10:02:28 +0200
Message-ID: <20240603080228.150742-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Make sure that the right people are CC:-ed when changing the
script in scripts/s390x/.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a2fa437d..6ceea991 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -112,6 +112,7 @@ R: Thomas Huth <thuth@redhat.com>
 L: linux-s390@vger.kernel.org
 F: s390x/
 F: lib/s390x/
+F: scripts/s390x/
 
 X86
 M: Paolo Bonzini <pbonzini@redhat.com>
-- 
2.45.1

