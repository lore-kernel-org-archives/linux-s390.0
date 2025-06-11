Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BFD1A3154;
	Wed, 11 Jun 2025 17:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749662557; cv=none; b=bBgFNcp8MNPyj2aEe/6ln1vy0o61ICeNkGZpjlTJt1pq6uJe9ZcAl86+5OayL0CQC/TB4b4IW/p8pEj/nAcepMyHy/Z7k+thuHtVg02vEsEFM6AA/Mvy9qYeIh6qhwE4qdHYjVYglGJs5r9a0T+nnozjaUdUhWPbDvSVLAPEHSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749662557; c=relaxed/simple;
	bh=Yu7E6ne2wmzeCeTB9QOux0GM4iebpctkf6tFykAS048=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kFecPW9/Wsc0orFbeoK+uV6peXD41xs5NJqEmMpszv4HB3GTmP2JI/4J/k9mJtXz56B4Y0wxybJDhjrHYMfLTKJCkrBznP+bp+WCjAoHgeiSHGLJ0xp66Hq+ecyoVimqEUfcWfACA912adb0+b8AWXL76tXq78JWpd//of9g1pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=FseFOgjt; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="FseFOgjt"
Received: from fedora.intra.ispras.ru (unknown [10.10.165.2])
	by mail.ispras.ru (Postfix) with ESMTPSA id B935A40755EE;
	Wed, 11 Jun 2025 17:22:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru B935A40755EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1749662545;
	bh=lCxU3qIlN1bUKIKmqXhs0N7ebKh/c0ah9xgB5KfswMM=;
	h=From:To:Cc:Subject:Date:From;
	b=FseFOgjteGGvzo/LWzMW+sWz81PaKaseSxROqD+XYyfoQ1JtLQeNxq/Bj4LcyhY9C
	 PtP31IBpx5qb3xxa1xXR1qmZFJoLyebWGlM4zrvKGrgJxE+/mw+B067sP9tkOxPkqe
	 hcVceEPku5LXGzgZwE0pqApZi3lalkCtkpTO16dM=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ingo Franzki <ifranzki@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] s390/pkey: prevent overflow in size calculation for memdup_user()
Date: Wed, 11 Jun 2025 20:21:15 +0300
Message-ID: <20250611172116.182343-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Number of apqn target list entries contained in 'nr_apqns' variable is
determined by userspace via an ioctl call so the result of the product in
calculation of size passed to memdup_user() may overflow.

In this case the actual size of the allocated area and the value
describing it won't be in sync leading to various types of unpredictable
behaviour later.

Return an error if an overflow is detected. Note that it is different
from when nr_apqns is zero - that case is considered valid and should be
handled in subsequent pkey_handler implementations.

Found by Linux Verification Center (linuxtesting.org).

Fixes: f2bbc96e7cfa ("s390/pkey: add CCA AES cipher key support")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/s390/crypto/pkey_api.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index cef60770f68b..a731fc9c62a7 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -83,10 +83,15 @@ static void *_copy_key_from_user(void __user *ukey, size_t keylen)
 
 static void *_copy_apqns_from_user(void __user *uapqns, size_t nr_apqns)
 {
+	size_t size;
+
 	if (!uapqns || nr_apqns == 0)
 		return NULL;
 
-	return memdup_user(uapqns, nr_apqns * sizeof(struct pkey_apqn));
+	if (check_mul_overflow(nr_apqns, sizeof(struct pkey_apqn), &size))
+		return ERR_PTR(-EINVAL);
+
+	return memdup_user(uapqns, size);
 }
 
 static int pkey_ioctl_genseck(struct pkey_genseck __user *ugs)
-- 
2.49.0

