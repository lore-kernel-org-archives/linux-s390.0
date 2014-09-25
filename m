Return-Path: <linux-arch-owner@vger.kernel.org>
From: Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v2 14/22] MIPS/Xlp/MSI: Use MSI chip framework to configure MSI/MSI-X irq
Date: Thu, 25 Sep 2014 11:14:24 +0800
Message-ID: <1411614872-4009-15-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20140925031424.lKUrNSlY-DosLt7fj2szRJp9vn6KwC3ezAjM65fvMF8@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, arnab.basu@freescale.com, Bharat.Bhushan@freescale.com, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, xen-devel@lists.xenproject.org, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-mips@linux-mips.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>, Ralf Baechle <ralf@linux-mips.org>, Lucas Stach <l.stach@pengutronix.de>, David Vrabel <david.vrabel@citrix.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Michael Ellerman <mpe@ellerman.id.au>, Thierry Reding <thierry.reding@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Yijing Wang <wangyijing@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

Use MSI chip framework instead of arch MSI functions to configure
MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/mips/pci/msi-xlp.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pci/msi-xlp.c b/arch/mips/pci/msi-xlp.c
index e469dc7..6b791ef 100644
--- a/arch/mips/pci/msi-xlp.c
+++ b/arch/mips/pci/msi-xlp.c
@@ -245,7 +245,7 @@ static struct irq_chip xlp_msix_chip = {
 	.irq_unmask	= unmask_msi_irq,
 };
 
-void arch_teardown_msi_irq(unsigned int irq)
+void xlp_teardown_msi_irq(unsigned int irq)
 {
 }
 
@@ -450,7 +450,7 @@ static int xlp_setup_msix(uint64_t lnkbase, int node, int link,
 	return 0;
 }
 
-int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
+static int xlp_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 {
 	struct pci_dev *lnkdev;
 	uint64_t lnkbase;
@@ -472,6 +472,16 @@ int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 		return xlp_setup_msi(lnkbase, node, link, desc);
 }
 
+static struct msi_chip xlp_chip = {
+	.setup_irq = xlp_setup_msi_irq,
+	.teardown_irq = xlp_teardown_msi_irq,
+};
+
+struct msi_chip *arch_find_msi_chip(struct pci_dev *dev)
+{
+	return &xlp_chip;
+}
+
 void __init xlp_init_node_msi_irqs(int node, int link)
 {
 	struct nlm_soc_info *nodep;
-- 
1.7.1
