Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2F133F59A
	for <linux-s390@vger.kernel.org>; Thu,  4 Jun 2026 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585335; cv=none; b=n6X9b5i0QHTamLPo8e29xgPj7vUJTyfWvBvhkOLLGUTcl1hRGP/H3luJjYhThob4dKnIkNptb9FZCk8wHU4UlzjRo8GB5/yh7x3m8/8ylWo99+43vGo71dpQyxteeFFfQAWDCaPr7TzvEVdKXMs3tatgzLthRYmxBYnAxBnwHRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585335; c=relaxed/simple;
	bh=tReqjMVmX8uLzSTwc3ozu852Tj7RgIMuKLWFv2xESLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udb5UJcBWi/Y45JYrVbvrUJkeRQfAcimULWNd546OvK0IPc4NqW+yRv+f9pfxCrjaQ09VkZf4++ooIdP8GbFSiXC8uC3KlrThO6pGZ6Z1xx3HTu26DnOK4sBzW3/HEk0rOfxzRIjTiu6fAQQc76n/Obnk/b1eM6P099uxJv42F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AStqxT8J; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AStqxT8J"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0aa420401so6580495ad.3
        for <linux-s390@vger.kernel.org>; Thu, 04 Jun 2026 08:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585330; x=1781190130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQ5QlRlqJf2BWfjEpgZtMhqYoBzzggdHeyuHigzWBDQ=;
        b=AStqxT8J4d+U3PJKtHoBsu6k2npRaUJiPATtnTiw8izzOc3m6W485/174c6Y/T0U1c
         FUVzjtBPUTN5jBZcHwkUbssAOFlHMjGHjrMyBtOwPxVe9uiSKOBo7OhVbvi4jDcGe6Ns
         QEeol3C95KapGGQbUmToSzzB8HrwxqdW4KMozHqKKkT43VU5JwGMz9/IzWwYHQ/oPwi0
         KZ61AZymwp71lJFN2sxtWJ41qw7HAKgYkcJEgynVx7EKT/uMT1g6Z2PSgL+1kNWrqLfh
         NbORZ1X8qEKteaMJFCfABuuq4gMfVT1woMQWP0qXGP+LPGHrT1UfXU75AneXAyXFDULk
         zisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585330; x=1781190130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DQ5QlRlqJf2BWfjEpgZtMhqYoBzzggdHeyuHigzWBDQ=;
        b=ZxZlxKWUMRvxE6filVTy/VSXr/ZAMr3Q300HfqBn5M/AljUIGTnlHJigOiYQxMdhVF
         vUrvoMGqBM6t7L1rLukYz8QoNZIp0nQQp07dkDyAy1pLyc+/M5tKz7123dSJ/I5YO8Qe
         vnV2ThFpBwTVnyBYznVxLXMZoMvw152zB/WuXyvyagC53iABWZyLRnFL6peCKNiBKNJg
         8DNx/z8MJZydSf+JWcPo1MCmIRBYK8sx16zmHiKnDAjOczan8txGd9W8b/w1yFtZT4uA
         t4t9ZTMotoxWb2P+BONXK8yCZuK6ssP625oKE2OwLhpix5MjMN21VWRSA7XcDwA48lXR
         gTXg==
X-Forwarded-Encrypted: i=1; AFNElJ9dZkqGW2oD9+U112BKRb0jZzbUCr+8mZ9QH0ORnCXSOgsSTjQHiHkd03ci+vcSIG1RzrBa7rO5o4dE@vger.kernel.org
X-Gm-Message-State: AOJu0YwebzG+EyHMezKlHOwWlkBtHfoI+Hi1j3J9+/znLuIShA6REp8m
	4mrPMMYCHPr8w36agNJwX7QN/vcsT5o0sjOWcM77PpdR/GhtTRP7QFKv
X-Gm-Gg: Acq92OEkS62DEcsJQpZoe97zK1e/N7ARHQ2XZLIz1AefGTOGUPkeidphEJUa493/ncU
	05fPZg043DsXA0Bj/4UQRguT/UNe2EfmTLg+8awbBVQs5ZD8Z8iZ7xpwScExbue4PWmhiaK8ZVy
	YyK4+SArc2ESnLmBvrqRWZ8MZ3PwoIUGIkYt+U4H+7ujEcdzIihfz8jj7QrChmSK48qSDhT11yO
	qC95u8fFkGDXizBzEtGsXqxdro8IGchkJ9pjMBfkFsd1VQXeYOKM8At7ZJg7LndIiJLdmEMzD50
	MhzUTN2paxf+8j+LWQNoMQlcc/PefVWMkpT0Nki6qvca/W5OhKXRg/UWH/uug+q32/TKF8L9x9d
	Bn1HyA33j1IOzp781X0GgA1seQRWrxW+GPBuuQ0cG7iem1H58F9nQhfDagYwB4/qoRYseEY6bM/
	er9o62mIHiJYPQ4ukn6fQPvmn/Aci3SIvegNTcQdHr5FEGS9fu
X-Received: by 2002:a17:903:1b07:b0:2c0:eee2:fc45 with SMTP id d9443c01a7336-2c163a28b9fmr86640905ad.4.1780585329440;
        Thu, 04 Jun 2026 08:02:09 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609df79sm62219485ad.42.2026.06.04.08.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:02:08 -0700 (PDT)
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
Subject: [RFC 09/12] PCI: Add helper to compute VF Routing ID to pci.h
Date: Thu,  4 Jun 2026 08:01:50 -0700
Message-ID: <20260604150153.3619662-10-dimitri.daskalakis1@gmail.com>
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

The VF RID computation is identical for SR-IOV and SIOV. Add a common
helper so we can share the logic across both.

No functional changes.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 drivers/pci/iov.c |  8 ++++----
 drivers/pci/pci.h | 12 ++++++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 4aed4f6a42c3..5d65413ce98d 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -25,16 +25,16 @@ int pci_iov_virtfn_bus(struct pci_dev *dev, int vf_id)
 {
 	if (!pci_is_sriov_physfn(dev))
 		return -EINVAL;
-	return dev->bus->number + ((dev->devfn + dev->sriov->offset +
-				    dev->sriov->stride * vf_id) >> 8);
+	return pci_virtfn_routing_id(dev, dev->sriov->offset,
+				  dev->sriov->stride, vf_id) >> 8;
 }
 
 int pci_iov_virtfn_devfn(struct pci_dev *dev, int vf_id)
 {
 	if (!pci_is_sriov_physfn(dev))
 		return -EINVAL;
-	return (dev->devfn + dev->sriov->offset +
-		dev->sriov->stride * vf_id) & 0xff;
+	return pci_virtfn_routing_id(dev, dev->sriov->offset,
+				  dev->sriov->stride, vf_id) & 0xff;
 }
 EXPORT_SYMBOL_GPL(pci_iov_virtfn_devfn);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 73b913bcb87a..45411960fd2e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1017,6 +1017,18 @@ static inline int pci_resource_num_to_vf_bar(int resno)
 }
 #endif /* CONFIG_PCI_IOV */
 
+#if defined(CONFIG_PCI_IOV) || defined(CONFIG_PCI_SIOV)
+/*
+ * Compute the Routing ID (bus/devfn) for a VF or SDI under @pf, given the
+ * capability's offset and stride.
+ */
+static inline u16 pci_virtfn_routing_id(struct pci_dev *pf, u16 offset,
+				     u16 stride, int id)
+{
+	return (pf->bus->number << 8) + pf->devfn + offset + stride * id;
+}
+#endif
+
 #ifdef CONFIG_PCIE_TPH
 void pci_restore_tph_state(struct pci_dev *dev);
 void pci_save_tph_state(struct pci_dev *dev);
-- 
2.52.0

