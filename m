Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B862198A1A;
	Wed, 11 Jun 2025 19:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749669631; cv=none; b=TMxsuSSDhQibFZomhLBS15EPqmzLymAELZ61DVjUwsA1HaaEVZOmjmBGex7SbZKCD66OX+SAOWrR+3DCtl57evARcHoGsmYZXmlFCetBQ8F7gT+cbSJsg4VNNKP+uhfibb+UbuP3YPCH12BraiVJNkTEXQWpW0Q9yqXP0A+M0Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749669631; c=relaxed/simple;
	bh=9LJHRT+E/wk94eKXUDQqXwO8zes7SwCEbBLxYOlLXPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NmGdGHUCN2d8ALfC4B4PZ/wldL87kbhI+jBnHo3DZDznb9qSgKsZY1zMjYvoDURxxvhpHMw49X9IPWnFcUl864qoHiaDtL6QTLidCvJAOjKZCsM/QIRALgvlYDVq5SMNw2GZ5Ws3F36IzWSpbC4dgXM2uFll/q5kZy2m0F80ycg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=sWBPtAcx; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="sWBPtAcx"
Received: from fedora.intra.ispras.ru (unknown [10.10.165.2])
	by mail.ispras.ru (Postfix) with ESMTPSA id BC85340755EE;
	Wed, 11 Jun 2025 19:20:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru BC85340755EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1749669624;
	bh=X1XLZomizBfNBgtVPwKunjP0EbzXC94GEAJ74eLqJBI=;
	h=From:To:Cc:Subject:Date:From;
	b=sWBPtAcxFeab/kzIPH+A4A90p8TL0GUs/6Zbs6bR0Qt9HevJaYWCNNUB0hLvSck+T
	 fq97cZQrBNLj2MxLY7Uqif9HIg3AEKV26duY3eb6MasBY4eQaxh+wmf7bJBKDPwi4U
	 L4VJSRNWaA/NrxxUE/zx+VQXdUCjORoXEcoUqEeo=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ingo Franzki <ifranzki@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH v2] s390/pkey: prevent overflow in size calculation for memdup_user()
Date: Wed, 11 Jun 2025 22:20:10 +0300
Message-ID: <20250611192011.206057-1-pchelkin@ispras.ru>
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

Use a proper memdup_array_user() helper which returns an error if an
overflow is detected. Note that it is different from when nr_apqns is
initially zero - that case is considered valid and should be handled in
subsequent pkey_handler implementations.

Found by Linux Verification Center (linuxtesting.org).

Fixes: f2bbc96e7cfa ("s390/pkey: add CCA AES cipher key support")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

v2: use memdup_array_user() helper (Heiko Carstens)

 drivers/s390/crypto/pkey_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index cef60770f68b..b3fcdcae379e 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -86,7 +86,7 @@ static void *_copy_apqns_from_user(void __user *uapqns, size_t nr_apqns)
 	if (!uapqns || nr_apqns == 0)
 		return NULL;
 
-	return memdup_user(uapqns, nr_apqns * sizeof(struct pkey_apqn));
+	return memdup_array_user(uapqns, nr_apqns, sizeof(struct pkey_apqn));
 }
 
 static int pkey_ioctl_genseck(struct pkey_genseck __user *ugs)
-- 
2.49.0

