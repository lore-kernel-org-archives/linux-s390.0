Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233685;
	b=eqfX4uYwgsqclmxjX45sSNdhRJwkWA4k3rLhjBGoI6hW9JjtzSsOiZhemoSkmIyCupQy
	 B+YCRu9axmmjU+vgzyFQR48dCBbRMEPZJvY457sUUfjogg0V8FPCeF6lCR4i5fY5UaS4x
	 5d9hXvvncfO21vgp0RbzI5+HoeOCn8wX1jAmcY8HIhMEkz+ozbqav0fv+9yTjiJVf3/h7
	 f5xop69SJUIrmRDeSj3ot/xxcUGA+SiglhL7bhP31N6UwHqUulDMO5x5u28z0kC7WMk+z
	 F5uBJ/UKr7zBjHma4xifWADUnE/NADOMb3TKf5hX7FUWLvbI7Jp2H8UXk2+5qxeTrzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233685;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KvGluDL24aWowt+wZfDMO+grbry8oqWMKLH72uldgbo=;
	b=OIh6Fv7OW1QVcLcOjs/dpuM6uue/elCH6bJluSYVv7Wu+LfYcrHw0IDXqdD0OJdu45xd
	 yIyLYTQUxTF/oANkY97ehGbaGs+NMBo9tVGI9eNZ8lR+sqOaSAnRbfsPXOvoq0V2W6xk5
	 f1kv+9qdCQLj4VxuB5/c2a9hXdmuyY/RUwLHZ5Ly+cR8DQUZ1xNoq7Ktus65Fe0ep5Fq/
	 UsFdECaOrXRJO8n41LmW7jIF4d1VqyiFO5/0gEC3diPhRlpiuum1uuF218+Gc1pI2VkD0
	 PFre3LP7JmEaE4FZoX+7FHDqRVmLvomhxnZzif8f9vw+KNvtRHabkTWhypAmWtBGFeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OCp4z9Sm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A4A606D80F;
	Mon,  9 Nov 2026 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OCp4z9Sm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C820E1F008A4;
	Mon,  9 Nov 2026 14:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794233684;
	bh=KvGluDL24aWowt+wZfDMO+grbry8oqWMKLH72uldgbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OCp4z9Sm77WMj+IAG0pQC/1oft1VAT0yMbbKu92/I1LI6XFvbkaQOUkQFcxeO51eA
	 IzTTgbX5XxksL/P1AFZQp7oiC+B24z8qL7H06he8MxID/IlxxIutqOUBfC/BGnkM/e
	 UpQdd+wuS45RoNAW+XhjAodldOYW4cX7uPoWYo0EK7upcYhWTghi4KEz/FTEVfKAV2
	 rbZxBM+hjhEHcMiUc8MPtS4yD/1mSsqbqWezBBUb2yEW/rCT2wvYbhj8uLqG3Pr4go
	 DI/epFaeHyCV4cjqcC7X1sg7QgNvhpw3dYQQ0WTDvykTXzWGn3wsiVoUm31UGAZkLj
	 UyTPPClrIeEJA==
From: Sasha Levin <sashal@kernel.org>
To: Nicolas Schier <nsc@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kbuild@vger.kernel.org,
	linux-s390@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"kernelci.org bot" <bot@kernelci.org>
Subject: [PATCH 1/2] s390/pkey: Include <linux/device-id/ap.h> for struct ap_device_id
Date: Mon,  9 Nov 2026 09:14:40 -0500
Message-ID: <66e4ee9c7f9b4bc48fcee92a94b6bb6d92fe1ad2.1794233316.git.sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179416565740.60865.16102443399828949110.b4-review@b4>
References: <cover.1792144769.git.u.kleine-koenig@baylibre.com> <179416565740.60865.16102443399828949110.b4-review@b4>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pkey_cca.c and pkey_ep11.c got struct ap_device_id from
<linux/mod_devicetable.h> by way of <linux/cpufeature.h>. Commit
cdfdbc11552b ("Move struct cpu_feature to <linux/cpufeature.h>") dropped
that include, so s390 defconfig no longer builds:

  drivers/s390/crypto/pkey_cca.c:22:28: error: array type has incomplete element type 'struct ap_device_id'
  drivers/s390/crypto/pkey_ep11.c:23:28: error: array type has incomplete element type 'struct ap_device_id'

Include the header that defines it, as the other AP drivers do.

Reported-by: kernelci.org bot <bot@kernelci.org>
Closes: https://d.kernelci.org/i/maestro:7baaa311bc9c30a8ad43f42c24225ab2fead866a
Fixes: cdfdbc11552b ("Move struct cpu_feature to <linux/cpufeature.h>")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/pkey_cca.c  | 1 +
 drivers/s390/crypto/pkey_ep11.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/s390/crypto/pkey_cca.c b/drivers/s390/crypto/pkey_cca.c
index e8dc2f77c137b..f95d61fd5b090 100644
--- a/drivers/s390/crypto/pkey_cca.c
+++ b/drivers/s390/crypto/pkey_cca.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/cpufeature.h>
+#include <linux/device-id/ap.h>
 
 #include "zcrypt_ccamisc.h"
 #include "pkey_base.h"
diff --git a/drivers/s390/crypto/pkey_ep11.c b/drivers/s390/crypto/pkey_ep11.c
index f99c19323f3d7..f66fc97ad5adc 100644
--- a/drivers/s390/crypto/pkey_ep11.c
+++ b/drivers/s390/crypto/pkey_ep11.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/cpufeature.h>
+#include <linux/device-id/ap.h>
 
 #include "zcrypt_ccamisc.h"
 #include "zcrypt_ep11misc.h"
-- 
2.53.0

