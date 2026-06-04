Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB71345CC0
	for <linux-s390@vger.kernel.org>; Thu,  4 Jun 2026 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585339; cv=none; b=YMN/9V1G6jU4uOojPOcRR5m4+5F1nxMW/NSZVKg/5sATOMQo9OlOO9t4xTaj801TluxcJYYFX4JgnQ49IgGl9rwEsKyTR+CeHJnFyCjimbgLKzuZo40WXMD/ENUKG9b527R3Phfi1Hh6Yj+B6296hHdp6xpOsiDjc/QLQ3RQADc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585339; c=relaxed/simple;
	bh=HEZhNEeU8FUa55Fyehsm2ZlO878xVQM49YKBcnvzabM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYC+lvJtBDhoLqbvxcd08uoBRQwjjqPDBBQfgC0Fc+L4wutihJZXaw2MHDMbw8l6c1/VxQdsngs7ppPn5bnLxoqU5EcD7KNo7p31T0ZBdSMZUen2mVRMhU3vin5CcLmepqWflvVHOtm9J4Fc2QC44Ep7yc2D5a9VC39y2DEiJ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=swMyWR4f; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swMyWR4f"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bf3781ca51so9119935ad.0
        for <linux-s390@vger.kernel.org>; Thu, 04 Jun 2026 08:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585332; x=1781190132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Bo6bv9IyO26QNTtP+PpQ5foOOUKiHlTonbwk1FrZVg=;
        b=swMyWR4f0V3pwHqrSf/xmVcU3pEnzL3Q+RsBCby09bvG/XB+dnuqQADCCKKH9MpoJU
         bYpyp0qi0vqy6TAtqw5GPPiaIynZQm00prt6r0jCyCbWG2UkLaz9VVn3xgcdTq/Ek4pc
         XGQiizM9vAinYTyG+RmzP7j8hIEqOVrZjmLnF3OBHXxgXtgwTHXTlycbO73v3zb3qEeg
         BLNJqdYTx9Sq6EkGy4Enth2Bq592Dx4SVxNVwb5u7jX6uOG3DZRGydGdzGN9aobhuWjr
         BubmmiKWjPljVGwJEDKtkLWtMPCELflh8Nj3SShkHFaylve0ISj1PPc7hzkT6pzr7gpA
         vH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585332; x=1781190132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Bo6bv9IyO26QNTtP+PpQ5foOOUKiHlTonbwk1FrZVg=;
        b=kTpo3K24YSbvMEbcemZOzK6FEkhNyw6+NdwYJ4DxA36fRqxwiwmhpkglRmiudSlf+7
         LFL1vIx8h/4QtwGM5vQrr6H3zDogPCAMbLNTTUVivPwpztg6HrRPymJc9gLJhXqfDShh
         1xzGBd1/B1Mx3wX7flOvj+0Qv2u4RpBpdOLKJCk38eqAqfRifby5y2F0LutemqGfzyes
         wgtsgKVoNOTyaXWLq8HSZJmfGjFRTwYxNYq5toC03+CWUF+haLLQDvQ6WPi8qQgYhK2h
         HmEzCmKfDfAouM5/sgPPtxC455Mad67iKLPxWN4PdxTrSrCB5SxY35ORew5tYzZjzgns
         3mog==
X-Forwarded-Encrypted: i=1; AFNElJ/5Zst5qzsr9sgGTazznQOFUxqMhb7RB4wcFdZukV48mvREVQuEsGf7+OCnso1zM6IJ3jXZd3gsOyGx@vger.kernel.org
X-Gm-Message-State: AOJu0YyWzvVvsZwrxhEaVGnjI4tlkwx3SwrHC7oLghED1XSwpbkqA06H
	TRv8ah9E/NSEwUHUR+erZdUzUv85l/8iP/lgjI+AppGDV2x8PYgvsubW
X-Gm-Gg: Acq92OGk5jZ/oODSlraipCUxHcaruhA7gjdC5yEyfvfh4RGurMUY2LkprOnMJdRRL4J
	uY57ofjAMKOrf/Z7EfiZptN0WKkfvGWxUbFC7IJYdgTLh98WoI905N0N9ma9FXpXvZgCspXAhaO
	K55xSbnKGBPXaxGIUETAo4afvD2XCkfH7qcoQx6znz5wKxk7ezBuRS5DV2d/EmwgbylY+I+tATF
	mZGNHbbQciX4iydOjh4ZCHOJLHzqGIkChTsNYHiyK3r8tri+mk3eUoBpnZI8QAXHZdNhabZ2VJg
	MCjm6YvQU/tlJ/ofT5mkhnR19rZjlMsZZcqtmfFPf+id4FNILrJpr48lheYrarWjkrEbEPRL5CO
	/NBEZvXHVgIFNiHDWeUHQ8TksFpa6u2lcS1Plpbv0PBSl7Whw4ST9Ap7Ej20GMu8/BklflK00gH
	oH9+OhR93CM0x1ylN6hkamXAbyDa2YWYgQpqGM3iCEn6moZuT1
X-Received: by 2002:a17:902:ced1:b0:2bd:5ab:af95 with SMTP id d9443c01a7336-2c1634f9212mr84880605ad.0.1780585331912;
        Thu, 04 Jun 2026 08:02:11 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609df79sm62220215ad.42.2026.06.04.08.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:02:11 -0700 (PDT)
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
Subject: [RFC 10/12] PCI: Add Scalable I/O Virtualization data structure definitions
Date: Thu,  4 Jun 2026 08:01:51 -0700
Message-ID: <20260604150153.3619662-11-dimitri.daskalakis1@gmail.com>
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

Define the PCIe SIOV extended capability registers per the PCIe 7.0
spec, and introduce the kernel-internal data structures needed to track
SIOV state on a Physical Function. PCI-SIG members can access the spec
here https://members.pcisig.com/wg/PCI-SIG/document/previewpdf/22464.

The PCI_SIOV kconfig selects PCI_ATS rather than attempting to decouple
the sriov/physfn union within struct pci_dev from CONFIG_PCI_ATS. If
desired this can be done in the future, since ATS is optional
for SR-IOV and SIOV.

Inspired by struct pci_sriov, struct pci_siov records the
capability position, total SDI count, routing ID offset/stride, and
driver-configurable limits.

Add an is_siov bit to struct pci_dev along with helpers to identify
SIOV PFs/VFs.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 drivers/pci/Kconfig           | 11 +++++++++++
 drivers/pci/pci.h             | 13 +++++++++++++
 include/linux/pci.h           | 16 +++++++++++++++-
 include/uapi/linux/pci_regs.h | 12 +++++++++++-
 4 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 33c88432b728..930231835c40 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -164,6 +164,17 @@ config PCI_IOV
 
 	  If unsure, say N.
 
+config PCI_SIOV
+	bool "PCI Scalable IOV support"
+	select PCI_ATS
+	help
+	  Scalable I/O Virtualization is a PCIe feature that allows devices
+	  to expose lightweight Scalable Device Interfaces (SDIs). Unlike
+	  SR-IOV Virtual Functions, SDIs have no config space or BARs and
+	  rely on software to compose the control path.
+
+	  If unsure, say N.
+
 config PCI_NPEM
 	bool "Native PCIe Enclosure Management"
 	depends on LEDS_CLASS=y
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 45411960fd2e..fd7c04e26c16 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -683,6 +683,19 @@ struct pci_sriov {
 	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
 };
 
+/* Scalable I/O Virtualization */
+struct pci_siov {
+	struct pci_dev	*self;		/* This PF */
+	u32		cap;		/* SIOV Capabilities */
+	u16		pos;		/* Capability position */
+	u16		total_SDIs;	/* Total SDIs associated with the PF */
+	u16		num_SDIs;	/* Number of SDIs currently enabled */
+	u16		offset;		/* First SDI Routing ID offset */
+	u16		stride;		/* Following SDI stride */
+	u16		driver_max_SDIs;/* Max num SDIs driver supports */
+	u8		max_SDI_buses;	/* Max buses consumed by SDIs */
+};
+
 #ifdef CONFIG_PCI_DOE
 void pci_doe_init(struct pci_dev *pdev);
 void pci_doe_destroy(struct pci_dev *pdev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ca84f66425b2..eba562474017 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -480,6 +480,7 @@ struct pci_dev {
 	unsigned int	is_physfn:1;
 	unsigned int	is_virtfn:1;
 	unsigned int	is_sriov:1;		/* SR-IOV is enabled on this device (PF or VF) */
+	unsigned int	is_siov:1;		/* SIOV is enabled on this device (PF or VF/SDI) */
 	unsigned int	is_hotplug_bridge:1;
 	unsigned int	is_pciehp:1;
 	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
@@ -549,6 +550,9 @@ struct pci_dev {
 	u16		ats_cap;	/* ATS Capability offset */
 	u8		ats_stu;	/* ATS Smallest Translation Unit */
 #endif
+#ifdef CONFIG_PCI_SIOV
+	struct pci_siov	*siov;		/* PF: Scalable IOV info */
+#endif
 #ifdef CONFIG_PCI_PRI
 	u16		pri_cap;	/* PRI Capability offset */
 	u32		pri_reqs_alloc; /* Number of PRI requests allocated */
@@ -598,7 +602,7 @@ struct pci_dev {
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
 {
-#ifdef CONFIG_PCI_IOV
+#if defined(CONFIG_PCI_IOV) || defined(CONFIG_PCI_SIOV)
 	if (dev->is_virtfn)
 		dev = dev->physfn;
 #endif
@@ -615,6 +619,16 @@ static inline bool pci_is_sriov_virtfn(const struct pci_dev *dev)
 	return dev->is_virtfn && dev->is_sriov;
 }
 
+static inline bool pci_is_siov_physfn(const struct pci_dev *dev)
+{
+	return dev->is_physfn && dev->is_siov;
+}
+
+static inline bool pci_is_siov_virtfn(const struct pci_dev *dev)
+{
+	return dev->is_virtfn && dev->is_siov;
+}
+
 struct pci_dev *pci_alloc_dev(struct pci_bus *bus);
 
 #define	to_pci_dev(n) container_of(n, struct pci_dev, dev)
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 14f634ab9350..0f81c8c72b05 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -763,7 +763,8 @@
 #define PCI_EXT_CAP_ID_DEV3	0x2F	/* Device 3 Capability/Control/Status */
 #define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
 #define PCI_EXT_CAP_ID_PL_64GT	0x31	/* Physical Layer 64.0 GT/s */
-#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_64GT
+#define PCI_EXT_CAP_ID_SIOV	0x38	/* Scalable I/O Virtualization */
+#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_SIOV
 
 #define PCI_EXT_CAP_DSN_SIZEOF	12
 #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
@@ -1005,6 +1006,15 @@
 #define  PCI_SRIOV_VFM_AV	0x3	/* Active.Available */
 #define PCI_EXT_CAP_SRIOV_SIZEOF 0x40
 
+/* Scalable I/O Virtualization */
+#define PCI_SIOV_CAP		0x04	/* SIOV Capabilities */
+#define PCI_SIOV_TOTAL_SDI	0x08	/* Total SDIs */
+#define PCI_SIOV_STATUS		0x0B	/* SIOV Status */
+#define PCI_SIOV_STATUS_ENABLED 0x01	/* At least one SDI is enabled */
+#define PCI_SIOV_SDI_OFFSET	0x0C	/* First SDI Offset */
+#define PCI_SIOV_SDI_STRIDE	0x0E	/* SDI Stride */
+#define PCI_EXT_CAP_SIOV_SIZEOF	0x10
+
 #define PCI_LTR_MAX_SNOOP_LAT	0x4
 #define PCI_LTR_MAX_NOSNOOP_LAT	0x6
 #define  PCI_LTR_VALUE_MASK	0x000003ff
-- 
2.52.0

