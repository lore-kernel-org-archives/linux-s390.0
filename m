Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACE53246ED
	for <linux-s390@vger.kernel.org>; Thu,  4 Jun 2026 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585319; cv=none; b=E2/7jPf+iKzGWw5690fSN4z91f2P35qqHvXLcr6Vc0ym8w8UYSFRXMOoQiPs/C+IafOnv5lDx62plKDHcml89AGqdooXRI4XVZLu3XtAgfokO4hkG/cbd9dJ00hsVKTYZ2MsnOpCMpI8k07k0UuJHMt0HIofUDZ4/SvtNf4Rj34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585319; c=relaxed/simple;
	bh=1Hbl5Tk6BAE0V7gO4BCDGqQK5b7r6ozkSuW8/n3pCu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YL/CaTgg+ttmju21xOnIGJTFElxfb7ejQiMGrCLGV0pEbbCgMr7qLZREPigjdYpNY3kB9x+s814EbYsdowOcOAGx3gICDCQ5r6CD524dFBnSXcl6FbwsM/zuU7rY0oTRcaBHfSwAsr9ttBnZTeVGparq9Zo4AwHyi5xEbr+u7B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qAILAdFo; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qAILAdFo"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so358307a12.3
        for <linux-s390@vger.kernel.org>; Thu, 04 Jun 2026 08:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585317; x=1781190117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnSLmeLJV6kE0iVS5+3SJmFGhHsRiD3c0F7TGZf1V5w=;
        b=qAILAdFoYY2zB/+tu0xDFqfySALoJC/HXq+8tgNW4C6WSj45sEp8IyvcNQMDXxbU3u
         y9p3OzkMnUR045U6xZ97bael+M00BERez6XSOMEadRXuZkKr1JHyMLq+d0YrIvnOU27n
         iqOwzNMCPN56DV4D5u5InXH4qBcvXqmeZ9vc/O1w3aUcaP+SeQFihqpTdHsm+niPpryJ
         y2GnPr3nH2Md03ClN9EbQhVqFxUhxWXRXWvlMBfVE1cwLlo7ksHje5YUK8U1V4TkhE8c
         GtN69e2Gf4L6P4r5yVNNIVkmfXGSH2KOsgh5PqyDRFoHfKRwB/puriCdcGlhMB0YRufR
         cP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585317; x=1781190117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jnSLmeLJV6kE0iVS5+3SJmFGhHsRiD3c0F7TGZf1V5w=;
        b=kLWDxTHN7Tjy0fKmnsG2sqIBQrwr/2jpl+ABPR67hCpVrKtglzTtYsgfr9QdJr0Cxp
         dwn7qyQzCD13WvX+pzQkAvJ2frkK68bj6KWWifCEf+c3LWofQhu34Lbdzgg8UEchogJj
         gpswkGejnZ2XRlNnVMe7SLD6Qns6IYZeFJBTU30zpQx6j0+ONXkF/OLj2iIgFohMuPVa
         0mg1nk/EwUNxfoIL2g0YHNcEHDfNaLtwclB1XiYyrYK2U3CleW66Kk2zvOKcblakRL7A
         iWq3OmDuslN5ctjtYLQ48dK+h/WtEi0M41TurfIC+66Pew2BFHxZkdLgoivAdwbaESkQ
         /zPw==
X-Forwarded-Encrypted: i=1; AFNElJ8Up+aAPa3+39tLLsUGHBklYOS+AYE86SGueUM6URzPU0bgsd4qwBbpvtWvBo9tMOFbVI9wNkeGisHj@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1IZAe4bMVsFwH5BxG5MfY+Md664SwdsG72DkPodCiQGMGQgtu
	srCsF5HDH0BldRPWqoSc6uWN5z6NC+w785uMasbBy7C7v2s57nF1bC8N
X-Gm-Gg: Acq92OEEyWpQz1KPXaWizrGfdwbiYj181c8wzXm9TC9Pa6rRLcpi6iRaXXIMK32/R9L
	d4QWSs0o58O/bF3ueZEFo2rh+6EP/AWkULc9+/GRl6YEGK5adXAFOcD6ojJRGiVLrOJ3ec1c3k2
	+Wu2j4/TXK9AUqnoVPj4kYRX1UC1oOb6RFC/PQ502ppDnX+NsWaoB5883aZInFrjiKGULKKkv0B
	PiV7xrz9LFkHgNSTtz/mu7nh4S/uIx/gfy5vfMD1VfpNvB1uS/pBZEZaLk0ZY8Tq8bOr+/Su0IM
	AHdpZJEW7KuMWHrrYgZiShoFtLZdQfqEKNE/XdiX0jfYa9PyKEawVN65Hwlqkj1kVE8Sulx6C/f
	s0QJoipw1qy7xlWAWFedmAipjGWdeBtVRYqUL6fTeRo3SBHuMPrQMJ0bSn41fQ7XO8yFT2D7RIQ
	HdgUxBRA+lrFq6Us3kNVDX0IGkTzaRUAHVCsCb3UI=
X-Received: by 2002:a05:6a21:6083:b0:3a3:a9c4:3d60 with SMTP id adf61e73a8af0-3b4975cdbe8mr9228482637.27.1780585316708;
        Thu, 04 Jun 2026 08:01:56 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:5e::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0bdbe4sm5661594a12.32.2026.06.04.08.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:01:56 -0700 (PDT)
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
Subject: [RFC 01/12] PCI: Add helpers to identify SR-IOV PFs/VFs.
Date: Thu,  4 Jun 2026 08:01:42 -0700
Message-ID: <20260604150153.3619662-2-dimitri.daskalakis1@gmail.com>
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

Throughout core the pci_dev attribute is_physfn is used to determine
whether or not a PF has SR-IOV active. And is_virtfn is used to check
if a device is a SR-IOV VF.

These attributes should be generalized to represent PFs/VFs for any type
of virtualization. So in preparation, wrap the existing usage in
helpers and use helpers in subsequent patches to ease the transition.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 include/linux/pci.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..28892243f49f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -604,6 +604,16 @@ static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
 	return dev;
 }
 
+static inline bool pci_is_sriov_physfn(const struct pci_dev *dev)
+{
+	return dev->is_physfn;
+}
+
+static inline bool pci_is_sriov_virtfn(const struct pci_dev *dev)
+{
+	return dev->is_virtfn;
+}
+
 struct pci_dev *pci_alloc_dev(struct pci_bus *bus);
 
 #define	to_pci_dev(n) container_of(n, struct pci_dev, dev)
@@ -1277,6 +1287,7 @@ void pcibios_setup_bridge(struct pci_bus *bus, unsigned long type);
 void pci_sort_breadthfirst(void);
 #define dev_is_pci(d) ((d)->bus == &pci_bus_type)
 #define dev_is_pf(d) ((dev_is_pci(d) ? to_pci_dev(d)->is_physfn : false))
+#define dev_is_sriov_pf(d) ((dev_is_pci(d) ? pci_is_sriov_physfn(to_pci_dev(d)) : false))
 
 /* Generic PCI functions exported to card drivers */
 
@@ -2207,6 +2218,7 @@ static inline struct pci_dev *pci_dev_get(struct pci_dev *dev) { return NULL; }
 
 #define dev_is_pci(d) (false)
 #define dev_is_pf(d) (false)
+#define dev_is_sriov_pf(d) (false)
 static inline bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
 { return false; }
 static inline int pci_irqd_intx_xlate(struct irq_domain *d,
-- 
2.52.0

