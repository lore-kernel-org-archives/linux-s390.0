Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FF0A55;
	Thu, 17 Apr 2025 10:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744885708; cv=none; b=YaY9n3u8HZnqStrzLXmLdHpPlD9MLjAyXennm1i5xvWV7IbPmE9bbnZrs7jjbqBC+7iHEqzBNsZKhhhOt2kBsl2zoobvFWgz0XhqeskcEbX6lgnQS2zbjHW470qHT/jIfwScsPTL+xR46FWopLlK0PYt3SVlOwlSpHkHUGGQ19s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744885708; c=relaxed/simple;
	bh=PICkPqUm0CX+9/Dl7pPQQlHEsgy3kQ9EPKX+nFgBVTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T41gcMLAkPtjcRQ1xGvEUAdCyApDC4X/oUYSuOgMhWhFZnA7M6COidSL0UjJTGVyqWrT4Vl7n7n6AWi1o7DPCoM24GohYO2mqek2mrJsbsXQvHQAlYvXxRM5XMP6GrbwXJKOVbjm/S6hhvnwcj5OyQ9Tzc8RNjcJLUyW+7XU1K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wn7ag7pe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wn7ag7pe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78C6C4CEE4;
	Thu, 17 Apr 2025 10:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744885707;
	bh=PICkPqUm0CX+9/Dl7pPQQlHEsgy3kQ9EPKX+nFgBVTQ=;
	h=From:Date:Subject:To:Cc:From;
	b=Wn7ag7pe9Ip88HqglwEIrZL9lWDNUlMT9XRaWFx8nz1sfNAOgUBrR7kyPKoNsfllY
	 1cRMQaQePBV1JZaUwYYTQgxPV1swHI9Eln3FiI4vwm7zMmcXLp0CIA1Yv9TZlZ5Vd1
	 qFNpWdmGbmV/CW4AikUzlOC7dhGaX6neThCfCPn8T138lvIYjSXWHxiZzhKHMRc9Fo
	 nU+SrFVcAOF61qZSPgkuCmkFukcO/Tz7SvMv70SWSsiD6B5mylUTnVUkwIko6AAtYE
	 WEvQ/q40DyGNY8Nrxekrk9HpAYwRoQh/CETeYkAqlUMrkXp7jJcKX3MQiYXrquQtCp
	 pyETcG69ukpvw==
From: Simon Horman <horms@kernel.org>
Date: Thu, 17 Apr 2025 11:28:23 +0100
Subject: [PATCH net-next] s390: ism: Pass string literal as format argument
 of dev_set_name()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-ism-str-fmt-v1-1-9818b029874d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMbXAGgC/x3MTQqAIBBA4avIrBtIKfq5SrQIHWsWWTgSQnj3p
 OW3eO8FocgkMKsXIj0sfIUK3SiwxxZ2QnbVYFrTt50ekOVESRH9mdDYgbQ202i9g1rckTzn/7Z
 AoISBcoK1lA9sDpQrZwAAAA==
To: Alexandra Winter <wintera@linux.ibm.com>, 
 Thorsten Winkler <twinkler@linux.ibm.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, netdev@vger.kernel.org, 
 linux-s390@vger.kernel.org
X-Mailer: b4 0.14.0

GCC 14.2.0 reports that passing a non-string literal as the
format argument of dev_set_name() is potentially insecure.

drivers/s390/net/ism_drv.c: In function 'ism_probe':
drivers/s390/net/ism_drv.c:615:2: warning: format not a string literal and no format arguments [-Wformat-security]
  615 |  dev_set_name(&ism->dev, dev_name(&pdev->dev));
      |  ^~~~~~~~~~~~

It seems to me that as pdev is a PCIE device then the dev_name
call above should always return the device's BDF, e.g. 00:12.0.
That this should not contain format escape sequences. And thus
the current usage is safe.

But, it seems better to be safe than sorry. And, as a bonus, compiler
output becomes less verbose by addressing this issue.

Compile tested only.
No functional change intended.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/s390/net/ism_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 60ed70a39d2c..b7f15f303ea2 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -611,7 +611,7 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	ism->dev.parent = &pdev->dev;
 	ism->dev.release = ism_dev_release;
 	device_initialize(&ism->dev);
-	dev_set_name(&ism->dev, dev_name(&pdev->dev));
+	dev_set_name(&ism->dev, "%s", dev_name(&pdev->dev));
 	ret = device_add(&ism->dev);
 	if (ret)
 		goto err_dev;

