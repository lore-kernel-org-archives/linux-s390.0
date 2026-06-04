Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4078933DEE6
	for <linux-s390@vger.kernel.org>; Thu,  4 Jun 2026 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585333; cv=none; b=p1Fg3iQiqnjsIww2bXYw06ajO5v/CrqU7mtRbs1L61CxR+AKn9GmPadXS/ojrwBaTq+mSuoNM9TkYTatwWWDkAQH4VhGkBnMl0lHguGH0xlOCtBs6+NHBHw56jHkTuw51oW0wNCE1aucdqqUBVg4U0sU98wG0SnPi5S/z5i/EsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585333; c=relaxed/simple;
	bh=erygiitwDy4YmB08G9h7pAsR+JU/XPxDN4q/O/ZrVis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TdGf1mXyH5FAj6csuopxzNY06L/4anB3qLiUjW9dhTk4fqPCGtGmfnicb8USwz/Lce1iNzFjeWj/LwuB50JHtkB0QIZk02G4e4Kq5ulU28EwDGt05AO2GfrRx2vj68X6ohGg6kjdQxqZYvYfpaot8hz5L4LRUqlYOloShwJnV+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JE2T19ua; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE2T19ua"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bf77d4a4e2so11469085ad.1
        for <linux-s390@vger.kernel.org>; Thu, 04 Jun 2026 08:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585328; x=1781190128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoqDAswymnFuDctzAHclbYUv6AH/JbUjYrzVeObwiVA=;
        b=JE2T19uae59stK8GJ9thV+VCiyqSWFka4ew/ZB7naaqvGqNFvgG5kHNILA5dgDPmo9
         /WHpu1G4vktmY+KRtbKleTUA1f8D8ANzcpKuSr8zldPR+ex+1vWwfJdYv2FlAMaXdbZb
         uIotZGafEHueALPSficbmjZNidkkCYfBohsl5Ho6MNlpiyHAOfAhzI236vYudKjiH3cl
         Fw4HJjU4ojtW0UK3sXZuARfaPTPB1dDdh7z2LqrXotuRGXWMATU/uvwBTHV/yrFvOiSX
         nzsF5aOmX7KxbeEnB9N7pTSoB8GQ93REbDfdcFhg5a1ZwXAX8CgU0TYBJFfK0Uv6XEKP
         TSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585328; x=1781190128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WoqDAswymnFuDctzAHclbYUv6AH/JbUjYrzVeObwiVA=;
        b=giR8POaYoycUO8kCHlCh83BZRbmo9YH6ZLKCbqgMgzpX8YGuKKDT0V6BWF6R92RedN
         qG9lBGSetcrtWaKRFJwENWtNZhfUehpde9FX3BFxTYADwIcYsG4+LMv0fCkY4SVO8ppt
         O1v6iRkMGLVRkKx2nop/FQli7geNh4QeCJy5R8d0RFwcpAizT1lRbOcdc9CK7ALjzdfp
         FUvEeKh5VYXPVhi9s7/z2BNKVZVFCF2IJehL8QUVJxqFdYdZ3jTbhg776TqVhVCrB2XK
         ycIbnDVgzqcuSVAWYXf526I38Ttia0BqbGzBvDNk3JrcE9WIj/JTX1OUdSGfq4JVIgBX
         wXkA==
X-Forwarded-Encrypted: i=1; AFNElJ+DrEFbbc4XiwaTka65vTt/fRq1kFbYUxh36ahQ5dO50NtiKGrXupnjd/MZRGcGoWaMe0rEwmiDbDRn@vger.kernel.org
X-Gm-Message-State: AOJu0YwP004IfbuEQIgVfMzio3VFXgz90lz+nxyQlWKG0PdefwBLM7/G
	hvMy8XvBgRvaTgN266+cqofY2d80jYX0BzuBsdXi3T9b7ag5UNty2v6M
X-Gm-Gg: Acq92OF17HvN8z7V0gjQBgm9QZgwLpo/vgo5Q59WWg51WbvOnEfYMpvPgz6fkw/wRuF
	hKWYodEhOAuDg+6Ipe1W+mbHgS5zS6uOMZzD6MJ2FhXli3Zc8vUabJp08xs9ybMXE6LJW09cjgr
	qGqhV0LH5rvOQMvI9grmfOp4H2voj6eEE1vhortVMHW5QaCB1PFR8RXHIIjThKufK0h3pFggoWG
	2KUWBEFSb0Z512pKEWJiq1/7/L3MlxRKiWea3HtrvBZExFlON4UWAxXbFPdnKAZb+CfPFh6NTVp
	gkOS9+WwULF+8hTfyjQUMmGVvSL+MyySioY5QLeJjw1XVWDm/JF0DT8+yLIlLG6sKh6QzxpgVVs
	6idcuFJUuTlj1ci9eSd2Jwb5udr6hK/LBnQqRxLI1faiylKqaNUvcebUwD9qisjadNtxC7x9oOH
	IqH7kl4p+ZFi6j7F9KjBWRTwAoOD195p+RZQM+1U0=
X-Received: by 2002:a17:902:820e:b0:2c0:a858:8128 with SMTP id d9443c01a7336-2c197b1805fmr25629535ad.1.1780585327615;
        Thu, 04 Jun 2026 08:02:07 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:4d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d042sm63879855ad.60.2026.06.04.08.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:02:06 -0700 (PDT)
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
Subject: [RFC 08/12] PCI: Add is_sriov bit to struct pci_dev
Date: Thu,  4 Jun 2026 08:01:49 -0700
Message-ID: <20260604150153.3619662-9-dimitri.daskalakis1@gmail.com>
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

We need a way to disambiguate the virtualization type of a PF/VF.
PFs may support multiple types of virtualization, while a VF should
only support one.

Tighten pci_is_sriov_physfn() / pci_is_sriov_virtfn() to ensure the
is_sriov bit is set. This allows the existing is_physfn/is_virtfn
bits to be agnostic of virtualization type.

No functional changes for SR-IOV.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 arch/s390/pci/pci_iov.c | 1 +
 drivers/pci/iov.c       | 4 ++++
 include/linux/pci.h     | 5 +++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/s390/pci/pci_iov.c b/arch/s390/pci/pci_iov.c
index 13050ce5c3e9..82e9ef1f132f 100644
--- a/arch/s390/pci/pci_iov.c
+++ b/arch/s390/pci/pci_iov.c
@@ -53,6 +53,7 @@ static int zpci_iov_link_virtfn(struct pci_dev *pdev, struct pci_dev *virtfn, in
 		return rc;
 
 	virtfn->is_virtfn = 1;
+	virtfn->is_sriov = 1;
 	virtfn->multifunction = 0;
 	virtfn->physfn = pci_dev_get(pdev);
 
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 5de26057b99a..4aed4f6a42c3 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -326,6 +326,7 @@ static struct pci_dev *pci_iov_scan_device(struct pci_dev *dev, int id,
 	virtfn->vendor = dev->vendor;
 	virtfn->device = iov->vf_device;
 	virtfn->is_virtfn = 1;
+	virtfn->is_sriov = 1;
 	virtfn->physfn = pci_dev_get(dev);
 	virtfn->no_command_memory = 1;
 
@@ -897,6 +898,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
 		iov->dev = dev;
 
 	dev->sriov = iov;
+	dev->is_sriov = 1;
 	dev->is_physfn = 1;
 	rc = compute_max_vf_buses(dev);
 	if (rc)
@@ -906,6 +908,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
 
 fail_max_buses:
 	dev->sriov = NULL;
+	dev->is_sriov = 0;
 	dev->is_physfn = 0;
 failed:
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
@@ -926,6 +929,7 @@ static void sriov_release(struct pci_dev *dev)
 
 	kfree(dev->sriov);
 	dev->sriov = NULL;
+	dev->is_sriov = 0;
 }
 
 static void sriov_restore_vf_rebar_state(struct pci_dev *dev)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 28892243f49f..ca84f66425b2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -479,6 +479,7 @@ struct pci_dev {
 	unsigned int	state_saved:1;
 	unsigned int	is_physfn:1;
 	unsigned int	is_virtfn:1;
+	unsigned int	is_sriov:1;		/* SR-IOV is enabled on this device (PF or VF) */
 	unsigned int	is_hotplug_bridge:1;
 	unsigned int	is_pciehp:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
@@ -606,12 +607,12 @@ static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
 
 static inline bool pci_is_sriov_physfn(const struct pci_dev *dev)
 {
-	return dev->is_physfn;
+	return dev->is_physfn && dev->is_sriov;
 }
 
 static inline bool pci_is_sriov_virtfn(const struct pci_dev *dev)
 {
-	return dev->is_virtfn;
+	return dev->is_virtfn && dev->is_sriov;
 }
 
 struct pci_dev *pci_alloc_dev(struct pci_bus *bus);
-- 
2.52.0

