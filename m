Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AD431715F
	for <linux-s390@vger.kernel.org>; Thu,  4 Jun 2026 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585346; cv=none; b=t1TN4aSdyGes6EH4Cs7HHoJ/oCotnIxBHMoU0GIdM6+90IrWgyebs1iEhSvU6+x2E86kl9t2VeUYtRQgjoRCcNZRxIvy9y2PvEICvAC/79bgDVCZuhmO6KQ2CLeLJO+5sweZTLRmdwzkSONzMa2eM1WuQgRDRrdQ7be6uMwG0UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585346; c=relaxed/simple;
	bh=ZJl9Mt7FKyzs5qgOjy9m7k+4Cm+afJHGMPi8nILaAoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=om6eLbidMglstemA72Mjc8TMLsCnqogziNhzchy4FLQE9AAEfNpGYS325DNu4y9I7foKVmHwhPV+uoKofMVBZWy8nkQAafIsVoFxfZFXMlvHzoCEMdflB1rQeLZiEoAhMhnCQ0qfR+OwfeHCPduCp074hLjvSREo1hfSJTuNq0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMWO7Lx/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMWO7Lx/"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8419ab3a297so375163b3a.2
        for <linux-s390@vger.kernel.org>; Thu, 04 Jun 2026 08:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585345; x=1781190145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRdDzAJ66h/qKzlMtNZ7QYJac4Hlkm37yqxsR8KWCKU=;
        b=XMWO7Lx/DLXw07/hz7BBBd0JylnPel3mtpsWUmZwEuiTABHwf658XiZSFdECSIZR3r
         dOOMAjV5t5wIPeZVriIJ0gzIBur+5Y19bnfQu301Gdl5HgdRR+MHlMRtFi2TMUtg4my1
         4zB5tZojJ3zCbaBm3mi5IddzuZWkPCzE30Hctbuuf5H3OicCRAOEGolcSs4znYbLWqE9
         sYiitKFIXza7zeKMdfMnWId+QNG33ltVD+6y4nlK5bQQfC07KwGb5/JS0RdgpYQm03Tj
         gfB21XvxRMfjz4dtmcELeqSBYIUQByKMxEsxpqbkKI0VUaeKnzd9aoOnkzyCmV1BB3Zk
         mLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585345; x=1781190145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xRdDzAJ66h/qKzlMtNZ7QYJac4Hlkm37yqxsR8KWCKU=;
        b=kYwJEcrkSllxvLTnlTaKonrOh2aupcGYeT0Fjhj7gpoCKeqjWE6omPvMvRzHamALMA
         yCtEZUUhnB+eCwM2tqSB2L2CTj7IwO1o8+WxIXmnn6D3hxWaN2WsC8JFHZK5WDhPlgIM
         rePu8TT6mtBi2ViJDGLHmFMYEqJlb5fGQTdf9RPINlLdH0/9/l7E/VD3TXZP8xWTgMIL
         sh7nrjuFc5cCE09N8y/Qc+FnPCJtRy02kgSDZ+vS0I3axcTHTV9T/0bsAKxqkoe7Ixxq
         FIGKZQDHL85o0PE0qE77ZozGmuOiK1xfLart1yvpq2LT58YAAdyvpoxmpMaAq4ik0wiL
         4Vog==
X-Forwarded-Encrypted: i=1; AFNElJ/r2qWdYcxS9D2tu/IAmvTOdUqKeYZQkiN+Z+Si4GjE+TxAJERjXr5lBh7ExZZokjdJl1My56hL5tzU@vger.kernel.org
X-Gm-Message-State: AOJu0YzfKOxCY7hnX1bKRpCZP5ryE+4fJzW8AkPdmDUHLQ26f9cUhELy
	OgzicJxynwvi8Zyat3HbT2JSZE3JgYo3SL1OGrFgKQNEeLNBXs02u8xO
X-Gm-Gg: Acq92OF3wq4qMBH0KdxNKWaKq8twd3rJdrwFpa83R8zyJVBeRu6mA8/gdJMSGtL6/dl
	ml3ypgDQle5vm9mE1FNuib52KgNxsJL56/J+yehuPu8azzV1YR7s+x4jpixuDVmZVWCWRXtEWAZ
	DyNuqDF+evcDvJdz4QxENn5eKSV4iugaF8d5fHylC7Y+B/1EpRHsc2pkbMRKAS5bTH3ZQLhMgs1
	nJ0RLl12pUtIPolzf8Hz+9Zn0ona+SvSZKzuLebOJ/LhHsQcpD3Te3kXuSB5XWCNvv9WvxbvabV
	qlj6E9gayK72uPziP706zV0QOioA3hlYuvoJItQJUNA2O6HHsS6Szx6hjV6+Bc6wBucIKGMFPUl
	CzQ+7RHjRQ2e8WGlh7THC9K4He3YExaFu6M96QWoWEn2t0SCEOwUGz40TEtWPt8O4wJTrNqThuR
	P5CZ6ClICwFGjBgLl2myK+BLEB/LxsOjtlk+0zl9h3/WB5h4525w==
X-Received: by 2002:a05:6a00:218e:b0:842:5ad6:2d3 with SMTP id d2e1a72fcca58-84284ef2c41mr8159937b3a.38.1780585335784;
        Thu, 04 Jun 2026 08:02:15 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:51::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428291a837sm6331464b3a.60.2026.06.04.08.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:02:15 -0700 (PDT)
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
Subject: [RFC 12/12] PCI: Reserve bus range for SIOV devices
Date: Thu,  4 Jun 2026 08:01:53 -0700
Message-ID: <20260604150153.3619662-13-dimitri.daskalakis1@gmail.com>
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

SDI routing IDs are computed from the PF's devfn plus an offset and
stride, exactly like SR-IOV VFs. When the stride pushes routing IDs
past the current bus number, additional bus numbers must be reserved
during PCI bus scanning to ensure the SDIs can be enumerated.

Add pci_siov_bus_range(), which walks all SIOV-capable PFs on a bus
and returns the maximum number of additional buses required. This
parallels pci_iov_bus_range() for SR-IOV.

The bus range is pre-computed during siov_init() by computing the bus
number of the last valid SDI.

Note: The PCIe 7.0 spec outlines an alternative RID assignment
algorithm for SDIs. The spec states a Virtualization Intermediary
(likely a hypervisor) after boot can compute the set of RIDs that are
valid for SDIs. There is a six step algorithm to compute this
RID allowlist. To keep things simple, we are only adding support for
strided RID assignments.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 drivers/pci/probe.c |  4 ++--
 drivers/pci/siov.c  | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bebc32c8d374..9ef6827ab345 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3100,8 +3100,8 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 	for (devnr = 0; devnr < PCI_MAX_NR_DEVS; devnr++)
 		pci_scan_slot(bus, PCI_DEVFN(devnr, 0));
 
-	/* Reserve buses for SR-IOV capability */
-	used_buses = pci_iov_bus_range(bus);
+	/* Reserve buses for SR-IOV and SIOV capability */
+	used_buses = max(pci_iov_bus_range(bus), pci_siov_bus_range(bus));
 	max += used_buses;
 
 	/*
diff --git a/drivers/pci/siov.c b/drivers/pci/siov.c
index 7372ce95714b..6405a8830052 100644
--- a/drivers/pci/siov.c
+++ b/drivers/pci/siov.c
@@ -111,3 +111,24 @@ void pci_siov_release(struct pci_dev *dev)
 	if (dev->siov)
 		siov_release(dev);
 }
+
+/**
+ * pci_siov_bus_range - find the max bus number consumed by SDIs
+ * @bus: the PCI bus
+ *
+ * Returns max additional buses consumed across all SIOV PFs on this bus.
+ */
+int pci_siov_bus_range(struct pci_bus *bus)
+{
+	int max = 0;
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (!dev->siov)
+			continue;
+		if (dev->siov->max_SDI_buses > max)
+			max = dev->siov->max_SDI_buses;
+	}
+
+	return max ? max - bus->number : 0;
+}
-- 
2.52.0

