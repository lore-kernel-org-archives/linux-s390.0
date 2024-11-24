Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BD818E743;
	Sun, 24 Nov 2024 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452018; cv=none; b=k7j0Qv8xt1eaoxvZEMsZpuj4LWdo9lC6ByZZ9hW1ubhYsnYAqHwS+tqZd5D5YGpm06wRgJ2fNDdHVSbvV811tZDGvA6I5jiAYjEA4sqDR4tOVeazeQwSmhgvuQSQ0SnXh2ggAxalrP5nx4vgBL8rBztf0JpXUINgMhcjso9Ms4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452018; c=relaxed/simple;
	bh=umtQx+XfR4zl9S+NYVbOe8Wbht6I/MuCQRZweYmlhTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVqHnRvyZJmi5aHXtB2ycG2oIVNu4/7S4ltlDQL8E/eZVHyNvfgwjdszjJ0UjaG8miZkW9UYXssdv5yI9dud2+eetpp9/7XNeu125wa9551O66r3AdStmGx2ePLDd82JOYT6Xxguw0FgMBothzeSxSsdqA39+IoOVNh1JcfoEWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ww4E3n2S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ww4E3n2S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB366C4CECC;
	Sun, 24 Nov 2024 12:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452018;
	bh=umtQx+XfR4zl9S+NYVbOe8Wbht6I/MuCQRZweYmlhTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ww4E3n2S3J2jqCRwlj0ykLxdFGZ8tAubqpyAHG5U8dZammwuTMM81DAQMsxHipIu3
	 j2J9SRYs+NNvt+GGSYwq6bBHcmOONb99Fn+dlfPQpgSiZ1BhJctu9UiPv/X8rm4S7e
	 94+TbaaAFAKDckH2pXjr0l78f/n43pZowq2M5IxItQ47wXi4P+WskBz1DmcJdYYGQH
	 3AgwNmRswCFPDe3f7/OSxc4ZnBn6NGpDHhYrpDLbvBL0Rq7UNJA3xkChF4LXqlYPBI
	 SSBcq+sLeZUXxlBhGfwnbVxNloYi4j7f2Qo221xCLuykPr7IG4/xhyXioYLb2Z4T1h
	 MvO721h6FE5tA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	lukas@wunner.de,
	jgg@ziepe.ca,
	mjrosato@linux.ibm.com,
	wintera@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 02/16] s390/pci: Use topology ID for multi-function devices
Date: Sun, 24 Nov 2024 07:39:39 -0500
Message-ID: <20241124124009.3336072-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124009.3336072-1-sashal@kernel.org>
References: <20241124124009.3336072-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Niklas Schnelle <schnelle@linux.ibm.com>

[ Upstream commit 126034faaac5f356822c4a9bebfa75664da11056 ]

The newly introduced topology ID (TID) field in the CLP Query PCI
Function explicitly identifies groups of PCI functions whose RIDs belong
to the same (sub-)topology. When available use the TID instead of the
PCHID to match zPCI busses/domains for multi-function devices. Note that
currently only a single PCI bus per TID is supported. This change is
required because in future machines the PCHID will not identify a PCI
card but a specific port in the case of some multi-port NICs while from
a PCI point of view the entire card is a subtopology.

Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/include/asm/pci.h     |  9 ++++++---
 arch/s390/include/asm/pci_clp.h |  8 +++++---
 arch/s390/pci/pci_bus.c         | 17 ++++++++++-------
 arch/s390/pci/pci_clp.c         |  3 +++
 4 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index fdec455892486..94b5ce797c63b 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -107,9 +107,10 @@ struct zpci_bus {
 	struct list_head	resources;
 	struct list_head	bus_next;
 	struct resource		bus_resource;
-	int			pchid;
+	int			topo;		/* TID if topo_is_tid, PCHID otherwise */
 	int			domain_nr;
-	bool			multifunction;
+	u8			multifunction	: 1;
+	u8			topo_is_tid	: 1;
 	enum pci_bus_speed	max_bus_speed;
 };
 
@@ -131,6 +132,7 @@ struct zpci_dev {
 	u16		pchid;		/* physical channel ID */
 	u16		maxstbl;	/* Maximum store block size */
 	u16		rid;		/* RID as supplied by firmware */
+	u16		tid;		/* Topology for which RID is valid */
 	u8		pfgid;		/* function group ID */
 	u8		pft;		/* pci function type */
 	u8		port;
@@ -141,7 +143,8 @@ struct zpci_dev {
 	u8		is_physfn	: 1;
 	u8		util_str_avail	: 1;
 	u8		irqs_registered	: 1;
-	u8		reserved	: 2;
+	u8		tid_avail	: 1;
+	u8		reserved	: 1;
 	unsigned int	devfn;		/* DEVFN part of the RID*/
 
 	u8 pfip[CLP_PFIP_NR_SEGMENTS];	/* pci function internal path */
diff --git a/arch/s390/include/asm/pci_clp.h b/arch/s390/include/asm/pci_clp.h
index f0c677ddd2706..14afb9ce91f3b 100644
--- a/arch/s390/include/asm/pci_clp.h
+++ b/arch/s390/include/asm/pci_clp.h
@@ -110,7 +110,8 @@ struct clp_req_query_pci {
 struct clp_rsp_query_pci {
 	struct clp_rsp_hdr hdr;
 	u16 vfn;			/* virtual fn number */
-	u16			:  3;
+	u16			:  2;
+	u16 tid_avail		:  1;
 	u16 rid_avail		:  1;
 	u16 is_physfn		:  1;
 	u16 reserved1		:  1;
@@ -130,8 +131,9 @@ struct clp_rsp_query_pci {
 	u64 edma;			/* end dma as */
 #define ZPCI_RID_MASK_DEVFN 0x00ff
 	u16 rid;			/* BUS/DEVFN PCI address */
-	u16 reserved0;
-	u32 reserved[10];
+	u32 reserved0;
+	u16 tid;
+	u32 reserved[9];
 	u32 uid;			/* user defined id */
 	u8 util_str[CLP_UTIL_STR_LEN];	/* utility string */
 	u32 reserved2[16];
diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
index daa5d7450c7d3..54879e773e4a3 100644
--- a/arch/s390/pci/pci_bus.c
+++ b/arch/s390/pci/pci_bus.c
@@ -232,13 +232,13 @@ static void zpci_bus_put(struct zpci_bus *zbus)
 	kref_put(&zbus->kref, zpci_bus_release);
 }
 
-static struct zpci_bus *zpci_bus_get(int pchid)
+static struct zpci_bus *zpci_bus_get(int topo, bool topo_is_tid)
 {
 	struct zpci_bus *zbus;
 
 	mutex_lock(&zbus_list_lock);
 	list_for_each_entry(zbus, &zbus_list, bus_next) {
-		if (pchid == zbus->pchid) {
+		if (topo_is_tid == zbus->topo_is_tid && topo == zbus->topo) {
 			kref_get(&zbus->kref);
 			goto out_unlock;
 		}
@@ -249,7 +249,7 @@ static struct zpci_bus *zpci_bus_get(int pchid)
 	return zbus;
 }
 
-static struct zpci_bus *zpci_bus_alloc(int pchid)
+static struct zpci_bus *zpci_bus_alloc(int topo, bool topo_is_tid)
 {
 	struct zpci_bus *zbus;
 
@@ -257,7 +257,8 @@ static struct zpci_bus *zpci_bus_alloc(int pchid)
 	if (!zbus)
 		return NULL;
 
-	zbus->pchid = pchid;
+	zbus->topo = topo;
+	zbus->topo_is_tid = topo_is_tid;
 	INIT_LIST_HEAD(&zbus->bus_next);
 	mutex_lock(&zbus_list_lock);
 	list_add_tail(&zbus->bus_next, &zbus_list);
@@ -321,8 +322,9 @@ static int zpci_bus_add_device(struct zpci_bus *zbus, struct zpci_dev *zdev)
 
 int zpci_bus_device_register(struct zpci_dev *zdev, struct pci_ops *ops)
 {
+	bool topo_is_tid = zdev->tid_avail;
 	struct zpci_bus *zbus = NULL;
-	int rc = -EBADF;
+	int topo, rc = -EBADF;
 
 	if (zpci_nb_devices == ZPCI_NR_DEVICES) {
 		pr_warn("Adding PCI function %08x failed because the configured limit of %d is reached\n",
@@ -333,11 +335,12 @@ int zpci_bus_device_register(struct zpci_dev *zdev, struct pci_ops *ops)
 	if (zdev->devfn >= ZPCI_FUNCTIONS_PER_BUS)
 		return -EINVAL;
 
+	topo = topo_is_tid ? zdev->tid : zdev->pchid;
 	if (!s390_pci_no_rid && zdev->rid_available)
-		zbus = zpci_bus_get(zdev->pchid);
+		zbus = zpci_bus_get(topo, topo_is_tid);
 
 	if (!zbus) {
-		zbus = zpci_bus_alloc(zdev->pchid);
+		zbus = zpci_bus_alloc(topo, topo_is_tid);
 		if (!zbus)
 			return -ENOMEM;
 	}
diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index 3049e4eb01fe7..658802b82f9eb 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -170,6 +170,9 @@ static int clp_store_query_pci_fn(struct zpci_dev *zdev,
 		zdev->rid = response->rid;
 	if (!s390_pci_no_rid && zdev->rid_available)
 		zdev->devfn = response->rid & ZPCI_RID_MASK_DEVFN;
+	zdev->tid_avail = response->tid_avail;
+	if (zdev->tid_avail)
+		zdev->tid = response->tid;
 
 	memcpy(zdev->pfip, response->pfip, sizeof(zdev->pfip));
 	if (response->util_str_avail) {
-- 
2.43.0

