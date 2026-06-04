Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A46332573F
	for <linux-s390@vger.kernel.org>; Thu,  4 Jun 2026 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585320; cv=none; b=tew/cJKfba/1YZjdRAeJEsx05Z+sUaVvpvkS2Y+ZwurMXay7W7Gs7dI55kAiLvswT27FALxY6avDeS+3pLN5W4k2UA6bDUIrgIndDSaclpZRufGPJedmJUfeACpEHcmQX9hUywzKeX1Xo3EYe5NPVOl6Gh5PM8SjprgWUkE6spM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585320; c=relaxed/simple;
	bh=0Ar2O/m1mFA/SWPDJctjhrIohphzRzaX8wNTqWjqxQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMVnGljHF17ZQkJHGfQAliqyTBf8PQS0IzmHHq132W6Pobe1a43zb/GDunO3tBzNDHaWGuK+j/CiNuozkneDztGPhGRm/7zvckb2shtwGFu2s8Xv9MibBdvCB04igaI9zYT3ljtBEmatFuOXN5pq889xM/MoSKR8aqSutuumlIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFH3rHgk; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFH3rHgk"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c0c3543590so6138435ad.2
        for <linux-s390@vger.kernel.org>; Thu, 04 Jun 2026 08:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585319; x=1781190119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7P+ek6ocV5HFyMB6++Nc5HRt5X7Za6z5O1aRcqqwv/w=;
        b=VFH3rHgkaCzebI1QHg9oX9d2j6DtFpH71Wq0owy4t4ksi4/U77b0M4jI5GvLzNmze/
         7MkXztfCkCTk7D2h9wyk0KBoubOTFSGQN8eOXXmf9J56I8C4U28Ics+lj2hXZZviz+V5
         fTmpNEWjRo1Jkk8JY7Bsn1kCDD5k0KSJ6o7BBB+dfNjETPAp5pk5etaxjhKP1hZPjcwE
         lPZfqJaehyxPkNVp6e+wGgPDxlWmDEcvzlqqdjtoEqUpne+XvjRhnD0XGaOZ9VGMvvIA
         wOv6+PecTAFkTCfQc+sVN6lbRFK5sZzksnjhQ/yo6fiGmv45SKXScx9SVD5X88NkpziS
         /9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585319; x=1781190119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7P+ek6ocV5HFyMB6++Nc5HRt5X7Za6z5O1aRcqqwv/w=;
        b=Ooe0MEIV94tKCZcCCFmLRNJk9z3L1zIQjFqOx9O5g62iysXSb8vO+wp8oJrYnyeF80
         fUR0SKLl0TT1UWmCxl2XXT7XTsMwfpTq3pxKzhxMmklRjVGfRJuNLExwNgu6w3izROZF
         nD5ycpBMuqccdqKpgA2jHfruTxT4Wp/3EhTUG4gLc3ZhnL8Qc9aUd/EP8bFcjpYq502e
         Iv2cZf/yUtQXQZB3R0U2CwQOYdvQSAQKXgazi8Y7CgS0KGSXF8IBkJH1kWbaJoIDD6RX
         WSeH9+egUUlnPW3Jun3yaKQUSY06fW3rVya6FhoJkaCbCaxSenikDwRCf9yphjL6pDbm
         UGoA==
X-Forwarded-Encrypted: i=1; AFNElJ8KtcdA7tV8q0kkbYL9Zsr0ddolFER5k27t8dDTSQwW5+cDhyqIpaUbC3FgSmxznK3HHihzixsg04yo@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy+25wottO4NdpcYjMP65nZK1bv5EE9T4dgEIaDsqcUbYmkxlO
	QcOaVOXiUC6ygxEY9URLAxiEJByQMWeaa7cY9lcPVbxP0lf9vwfH5+fX
X-Gm-Gg: Acq92OHhUHIIbCex8zTu0MaoRlLmzn9BGQJfWYTMHOces6Mv4nNw6/Rj399j45uQOmC
	DoBUcW8Fw42RQ1utj66xrdf2iBPapsVx8gDNTHrlU/dE4BNmGRG9FqcQOygUPNFn4u266LtpFm+
	6Qxdd+NN7GTmmP1apZKRRAj+my6J9IZfSEyqyOD/nfksSNC1AUgZuRcs29Lgd8xTMv2HNXL3ybZ
	o5wrvd/SCrCgea51iz9HJbLTA3fecT+OJDPKZRAyMp46uFeWTVk9oIW9Jhn9JkxKrOScBjo5Whn
	kAVu3hRY9sEaRj4Xor9IE49W9pvreBq1OyJETvkZq0pKNjkMWTUNbnUJULe0xZlxbYUjuxHCCPS
	K04GWNI04aZ1MzgN148DPL6B707rgM2WPxBR05H7ZhlNSrXOug1h4vCuB8TnV5Piq5Aif
X-Received: by 2002:a17:903:948:b0:2bf:305a:310b with SMTP id d9443c01a7336-2c1639edf93mr84099595ad.1.1780585318015;
        Thu, 04 Jun 2026 08:01:58 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d40asm57714915ad.64.2026.06.04.08.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:01:57 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Keith Busch <kbusch@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: [RFC 02/12] PCI: Convert iov.c to pci_is_sriov_* helpers
Date: Thu,  4 Jun 2026 08:01:43 -0700
Message-ID: <20260604150153.3619662-3-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dimitri Daskalakis <daskald@meta.com>

No functional changes.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 drivers/pci/iov.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 91ac4e37ecb9..5de26057b99a 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -23,7 +23,7 @@
 
 int pci_iov_virtfn_bus(struct pci_dev *dev, int vf_id)
 {
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return -EINVAL;
 	return dev->bus->number + ((dev->devfn + dev->sriov->offset +
 				    dev->sriov->stride * vf_id) >> 8);
@@ -31,7 +31,7 @@ int pci_iov_virtfn_bus(struct pci_dev *dev, int vf_id)
 
 int pci_iov_virtfn_devfn(struct pci_dev *dev, int vf_id)
 {
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return -EINVAL;
 	return (dev->devfn + dev->sriov->offset +
 		dev->sriov->stride * vf_id) & 0xff;
@@ -42,7 +42,7 @@ int pci_iov_vf_id(struct pci_dev *dev)
 {
 	struct pci_dev *pf;
 
-	if (!dev->is_virtfn)
+	if (!pci_is_sriov_virtfn(dev))
 		return -EINVAL;
 
 	pf = pci_physfn(dev);
@@ -71,7 +71,7 @@ void *pci_iov_get_pf_drvdata(struct pci_dev *dev, struct pci_driver *pf_driver)
 {
 	struct pci_dev *pf_dev;
 
-	if (!dev->is_virtfn)
+	if (!pci_is_sriov_virtfn(dev))
 		return ERR_PTR(-EINVAL);
 	pf_dev = dev->physfn;
 	if (pf_dev->driver != pf_driver)
@@ -152,7 +152,7 @@ static void virtfn_remove_bus(struct pci_bus *physbus, struct pci_bus *virtbus)
 
 resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
 {
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return 0;
 
 	return dev->sriov->barsz[pci_resource_num_to_vf_bar(resno)];
@@ -300,7 +300,7 @@ static umode_t sriov_vf_attrs_are_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	if (!pdev->is_virtfn)
+	if (!pci_is_sriov_virtfn(pdev))
 		return 0;
 
 	return a->mode;
@@ -604,7 +604,7 @@ static umode_t sriov_pf_attrs_are_visible(struct kobject *kobj,
 {
 	struct device *dev = kobj_to_dev(kobj);
 
-	if (!dev_is_pf(dev))
+	if (!dev_is_sriov_pf(dev))
 		return 0;
 
 	return a->mode;
@@ -707,7 +707,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 		if (!pdev)
 			return -ENODEV;
 
-		if (!pdev->is_physfn) {
+		if (!pci_is_sriov_physfn(pdev)) {
 			pci_dev_put(pdev);
 			return -ENOSYS;
 		}
@@ -814,7 +814,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
 
 	ctrl = 0;
 	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
-		if (pdev->is_physfn)
+		if (pci_is_sriov_physfn(pdev))
 			goto found;
 
 	pdev = NULL;
@@ -1006,7 +1006,7 @@ int pci_iov_init(struct pci_dev *dev)
  */
 void pci_iov_release(struct pci_dev *dev)
 {
-	if (dev->is_physfn)
+	if (pci_is_sriov_physfn(dev))
 		sriov_release(dev);
 }
 
@@ -1018,7 +1018,7 @@ void pci_iov_remove(struct pci_dev *dev)
 {
 	struct pci_sriov *iov = dev->sriov;
 
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return;
 
 	iov->driver_max_VFs = iov->total_VFs;
@@ -1035,7 +1035,7 @@ void pci_iov_remove(struct pci_dev *dev)
  */
 void pci_iov_update_resource(struct pci_dev *dev, int resno)
 {
-	struct pci_sriov *iov = dev->is_physfn ? dev->sriov : NULL;
+	struct pci_sriov *iov = pci_is_sriov_physfn(dev) ? dev->sriov : NULL;
 	struct resource *res = pci_resource_n(dev, resno);
 	int vf_bar = pci_resource_num_to_vf_bar(resno);
 	struct pci_bus_region region;
@@ -1111,7 +1111,7 @@ resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno)
  */
 void pci_restore_iov_state(struct pci_dev *dev)
 {
-	if (dev->is_physfn) {
+	if (pci_is_sriov_physfn(dev)) {
 		sriov_restore_vf_rebar_state(dev);
 		sriov_restore_state(dev);
 	}
@@ -1124,7 +1124,7 @@ void pci_restore_iov_state(struct pci_dev *dev)
  */
 void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool auto_probe)
 {
-	if (dev->is_physfn)
+	if (pci_is_sriov_physfn(dev))
 		dev->sriov->drivers_autoprobe = auto_probe;
 }
 
@@ -1141,7 +1141,7 @@ int pci_iov_bus_range(struct pci_bus *bus)
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		if (!dev->is_physfn)
+		if (!pci_is_sriov_physfn(dev))
 			continue;
 		if (dev->sriov->max_VF_buses > max)
 			max = dev->sriov->max_VF_buses;
@@ -1161,7 +1161,7 @@ int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn)
 {
 	might_sleep();
 
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return -ENOSYS;
 
 	return sriov_enable(dev, nr_virtfn);
@@ -1176,7 +1176,7 @@ void pci_disable_sriov(struct pci_dev *dev)
 {
 	might_sleep();
 
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return;
 
 	sriov_disable(dev);
@@ -1191,7 +1191,7 @@ EXPORT_SYMBOL_GPL(pci_disable_sriov);
  */
 int pci_num_vf(struct pci_dev *dev)
 {
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return 0;
 
 	return dev->sriov->num_VFs;
@@ -1212,7 +1212,7 @@ int pci_vfs_assigned(struct pci_dev *dev)
 	unsigned short dev_id;
 
 	/* only search if we are a PF */
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return 0;
 
 	/*
@@ -1228,7 +1228,7 @@ int pci_vfs_assigned(struct pci_dev *dev)
 		 * It is considered assigned if it is a virtual function with
 		 * our dev as the physical function and the assigned bit is set
 		 */
-		if (vfdev->is_virtfn && (vfdev->physfn == dev) &&
+		if (pci_is_sriov_virtfn(vfdev) && (vfdev->physfn == dev) &&
 			pci_is_dev_assigned(vfdev))
 			vfs_assigned++;
 
@@ -1254,7 +1254,7 @@ EXPORT_SYMBOL_GPL(pci_vfs_assigned);
  */
 int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
 {
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return -ENOSYS;
 
 	if (numvfs > dev->sriov->total_VFs)
@@ -1279,7 +1279,7 @@ EXPORT_SYMBOL_GPL(pci_sriov_set_totalvfs);
  */
 int pci_sriov_get_totalvfs(struct pci_dev *dev)
 {
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return 0;
 
 	return dev->sriov->driver_max_VFs;
@@ -1301,7 +1301,7 @@ int pci_sriov_configure_simple(struct pci_dev *dev, int nr_virtfn)
 
 	might_sleep();
 
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return -ENODEV;
 
 	if (pci_vfs_assigned(dev)) {
-- 
2.52.0

