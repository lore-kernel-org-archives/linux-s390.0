Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691BC3043B2
	for <linux-s390@vger.kernel.org>; Tue, 24 Feb 2026 06:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771915988; cv=none; b=eoz9+dliUm1rCqWrNik8efdKjq52bHa15zkABufHZt1D96XKiZvG93nmnX/wIdSm3LonBt8KDSHNi1TGd5F14W8Pzz0hFiLd5aJj1Tm6PsLcX53iGO4bd4BpHf1yFqc26wssvKVFiRri0JmXORtLjew2JEIi1mIXMRM+0oEUIJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771915988; c=relaxed/simple;
	bh=Q6pUjI0RLoqFpaTePFMSPCib2kDkUwktCKJi72ESlY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IIfWQTsMh8no0Hi/OUrWhNL3gWhff1jk+8bUwiQnX8X8xaikQfaXuDsG5QGngSb7Ee/YDimvlsf17JJRXMkZVwKHDsmanEAHVtlUtUFqLuc1mKBT4kAIW9HYto57bC9MXRarvojvGizcj96ajV8OJMeOIE0bc7jIUzOr66uvF1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fT860j2t; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fT860j2t"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4359a316d89so4667490f8f.0
        for <linux-s390@vger.kernel.org>; Mon, 23 Feb 2026 22:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771915985; x=1772520785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qQVpfXtyFGdivv9D9qL1lZIFEzO3kt1eLPHHoCbWwhk=;
        b=fT860j2tLSX2Pei/KHylbUDV65+CJVbZ3ncXgi7DBXfykBpRe1ZzYPfHleY695Jgcm
         p9LaKQuqoEeXDobiHnHyFk2VzHQbUWCm4ivCucoppWu4xD5MzEqe/rcrX+dE1k1dvzj5
         JlY5tiuhHv9NcAI3p6ABor/iz0lIurIelUe42Nn005auZX51mJe0GISe9VqPgs0QJhLq
         1WiPEcenEzJTTrlM3fJiX722nWuhb9fJTW1Xg+EyWS67o9osAYdJHN933PvfsN/9tbQE
         lO+hGvAT/hO8gxEQgVgJj7c1q2vqzRtxmq2qCkJyO/D6uxW+UBg/0zl5wZIeHMXN8edD
         EolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771915985; x=1772520785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQVpfXtyFGdivv9D9qL1lZIFEzO3kt1eLPHHoCbWwhk=;
        b=Xfbwr1767E2bwGRB8/zmWjKx7Mhd9vvnG0gfEkwQq64E51D4EqWiE1LQJQLLUfW1Qw
         MhUkUtjNFRiLkGRix5fejX07GhjxVHUOsnJdjhSvbUPdYlckW0J+FDNlEd1hFbguWgDo
         RL/heuJtDCm5bpsAp7B2a6c8kWiefS0ZgKQWOTSyzpWFjKmXMz2+LfIjeiUT41k1cszr
         YJ8UvXJuMuUJGKrng0ijfiVLx8kZI802v/s4DjLvlei1Tv/JaXkWHKUMr2XEIHwg8iWl
         j2tJnsFIb4n3/sw63mgPfnVW6cL1d5NOaLR3ZGyJpECN2VgB4SDUrx6iTAIe1kwBtxJo
         AIhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFwyHTYxGEuNJHIknSI9HD6mMdIvm5ZtwXDeyHTnRw21F6YI4dlq+0mAoaKEDVpdGY0ya7DI8wmJk2@vger.kernel.org
X-Gm-Message-State: AOJu0YxAG5OpW1AYKpGiv6FE7YOfaEHOxchnywV5JbHfpB5rVGTXnNrh
	wqI66i43At4QIKrxg17RMCDqiE4EO8hwf7xpB+Hf0amCAkF/ZAhagKQ2
X-Gm-Gg: ATEYQzwbZwBQaCkgorKGJ4BnIl+WZ6I+70VQnRTv/EXFJ7+7Y5/nlImlw9W3eYGRaJ0
	sOglaAxMCBgvMpruwsOPQm9rbDBxH5iO2ZjSBQ0Qi8VJHvWnpdk1tWghg8G9+hLsvEDugI37E55
	NLBCWm167ssayuGseusgBHjXR1kHWJnQPfzv3OxvkaMX6Zo801SOv9PkdmywOWFZx8L/h7DpUHM
	cvHvtpVI77fTJ0B/MOzw5XJWZ4FYT4Zq/XLwvGIaU6WspbvrLdVrZocQ5Mrh92uQeiv15LdoGTs
	Y1s0aNZ9aoideoatuk0hOyc7oWovKqXIJ+Rv1gL5SZ/oxAOGo99VW0LAVJGmE6kkd/mlaR8FQBv
	KHZvtgCkU8K1m/U2J98oKv31256pYBPWamOClAli0M9RwKjxwJZdwNgLiA7yQRwuS+zf8FRFOU7
	R59ANcXAP31yl6B3+SknyFd+wDua0=
X-Received: by 2002:a5d:588b:0:b0:437:6839:d5e with SMTP id ffacd0b85a97d-4396f153aacmr18288101f8f.13.1771915984464;
        Mon, 23 Feb 2026 22:53:04 -0800 (PST)
Received: from x-factory.. ([105.74.5.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c977sm25403023f8f.32.2026.02.23.22.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 22:53:04 -0800 (PST)
From: Yousef El Bouzidi <elbouzidyyousef@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	tglx@kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	lee@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	ansuelsmth@gmail.com,
	atenart@kernel.org,
	wens@kernel.org,
	hauke@hauke-m.de,
	andrew+netdev@lunn.ch,
	kuba@kernel.org,
	david.e.box@linux.intel.com,
	akrowiak@linux.ibm.com,
	pasic@linux.ibm.com,
	jjherne@linux.ibm.com,
	hca@linux.ibm.com,
	driver-core@lists.linux.dev,
	linux-crypto@vger.kernel.org,
	netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Yousef El Bouzidi <elbouzidyyousef@gmail.com>
Subject: [PATCH] treewide: fix duplicated word "the" in comments
Date: Tue, 24 Feb 2026 06:52:45 +0000
Message-ID: <20260224065300.454633-1-elbouzidyyousef@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove duplicated word "the" from comments across various subsystems.
All instances are clear typos where "the" appeared twice in
succession, often merged with the following word (e.g. "the they",
"the there", "the these", "the them").

Files fixed:
  - drivers/base/platform.c
  - drivers/crypto/inside-secure/eip93/eip93-hash.c
  - drivers/mfd/axp20x.c
  - drivers/net/ethernet/lantiq_xrx200.c
  - drivers/platform/x86/intel/chtwc_int33fe.c
  - drivers/platform/x86/intel/pmt/class.c
  - drivers/s390/crypto/vfio_ap_ops.c
  - kernel/irq/migration.c

Signed-off-by: Yousef El Bouzidi <elbouzidyyousef@gmail.com>
---
 drivers/base/platform.c                         | 2 +-
 drivers/crypto/inside-secure/eip93/eip93-hash.c | 2 +-
 drivers/mfd/axp20x.c                            | 2 +-
 drivers/net/ethernet/lantiq_xrx200.c            | 2 +-
 drivers/platform/x86/intel/chtwc_int33fe.c      | 2 +-
 drivers/platform/x86/intel/pmt/class.c          | 2 +-
 drivers/s390/crypto/vfio_ap_ops.c               | 2 +-
 kernel/irq/migration.c                          | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index b45d41b018ca..3e3b6fcfa194 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -565,7 +565,7 @@ struct platform_object {
 };
 
 /*
- * Set up default DMA mask for platform devices if the they weren't
+ * Set up default DMA mask for platform devices if they weren't
  * previously set by the architecture / DT.
  */
 static void setup_pdev_dma_masks(struct platform_device *pdev)
diff --git a/drivers/crypto/inside-secure/eip93/eip93-hash.c b/drivers/crypto/inside-secure/eip93/eip93-hash.c
index 2705855475b2..d91a1ac152f0 100644
--- a/drivers/crypto/inside-secure/eip93/eip93-hash.c
+++ b/drivers/crypto/inside-secure/eip93/eip93-hash.c
@@ -432,7 +432,7 @@ static int eip93_hash_update(struct ahash_request *req)
 
 /*
  * With map_data true, we map the sa_record and sa_state. This is needed
- * for finup() as the they are mapped before calling update()
+ * for finup() as they are mapped before calling update()
  */
 static int __eip93_hash_final(struct ahash_request *req, bool map_dma)
 {
diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 679364189ea5..0c6e93eb3955 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -1417,7 +1417,7 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
 	 * 1 bit customizable at the factory, and 1 bit depending on the
 	 * state of an external pin. The latter is writable. The device
 	 * will only respond to operations to its other registers when
-	 * the these device addressing bits (in the upper 4 bits of the
+	 * these device addressing bits (in the upper 4 bits of the
 	 * registers) match.
 	 *
 	 * By default we support an AXP806 chained to an AXP809 in slave
diff --git a/drivers/net/ethernet/lantiq_xrx200.c b/drivers/net/ethernet/lantiq_xrx200.c
index b8766fb7a844..dde651d901c8 100644
--- a/drivers/net/ethernet/lantiq_xrx200.c
+++ b/drivers/net/ethernet/lantiq_xrx200.c
@@ -157,7 +157,7 @@ static int xrx200_open(struct net_device *net_dev)
 	/* The boot loader does not always deactivate the receiving of frames
 	 * on the ports and then some packets queue up in the PPE buffers.
 	 * They already passed the PMAC so they do not have the tags
-	 * configured here. Read the these packets here and drop them.
+	 * configured here. Read these packets here and drop them.
 	 * The HW should have written them into memory after 10us
 	 */
 	usleep_range(20, 40);
diff --git a/drivers/platform/x86/intel/chtwc_int33fe.c b/drivers/platform/x86/intel/chtwc_int33fe.c
index d183aa53c318..1fca9fdd8f5b 100644
--- a/drivers/platform/x86/intel/chtwc_int33fe.c
+++ b/drivers/platform/x86/intel/chtwc_int33fe.c
@@ -14,7 +14,7 @@
  *
  * So this driver is a stub / pseudo driver whose only purpose is to
  * instantiate I²C clients for chips 2 - 4, so that standard I²C drivers
- * for these chips can bind to the them.
+ * for these chips can bind to them.
  */
 
 #include <linux/dmi.h>
diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
index be3c8d9e4fff..99bf7e0afdf1 100644
--- a/drivers/platform/x86/intel/pmt/class.c
+++ b/drivers/platform/x86/intel/pmt/class.c
@@ -239,7 +239,7 @@ static int intel_pmt_populate_entry(struct intel_pmt_entry *entry,
 
 		/*
 		 * Some hardware use a different calculation for the base address
-		 * when access_type == ACCESS_LOCAL. On the these systems
+		 * when access_type == ACCESS_LOCAL. On these systems
 		 * ACCESS_LOCAL refers to an address in the same BAR as the
 		 * header but at a fixed offset. But as the header address was
 		 * supplied to the driver, we don't know which BAR it was in.
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 44b3a1dcc1b3..334aaa2d97b2 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -610,7 +610,7 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 	matrix_mdev = container_of(vcpu->kvm->arch.crypto.pqap_hook,
 				   struct ap_matrix_mdev, pqap_hook);
 
-	/* If the there is no guest using the mdev, there is nothing to do */
+	/* If there is no guest using the mdev, there is nothing to do */
 	if (!matrix_mdev->kvm) {
 		vfio_ap_le_guid_to_be_uuid(&matrix_mdev->mdev->uuid, uuid);
 		VFIO_AP_DBF_WARN("%s: mdev %08lx-%04lx-%04lx-%04lx-%04lx%08lx not in use: apqn=0x%04x\n",
diff --git a/kernel/irq/migration.c b/kernel/irq/migration.c
index f2b2929986ff..b29d13baee55 100644
--- a/kernel/irq/migration.c
+++ b/kernel/irq/migration.c
@@ -89,7 +89,7 @@ void irq_move_masked_irq(struct irq_data *idata)
 
 		ret = irq_do_set_affinity(data, desc->pending_mask, false);
 		/*
-		 * If the there is a cleanup pending in the underlying
+		 * If there is a cleanup pending in the underlying
 		 * vector management, reschedule the move for the next
 		 * interrupt. Leave desc->pending_mask intact.
 		 */
-- 
2.43.0

