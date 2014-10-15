From: Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v3 16/27] Mips/MSI: Save msi chip in pci sysdata
Date: Wed, 15 Oct 2014 11:07:04 +0800
Message-ID: <1413342435-7876-17-git-send-email-wangyijing@huawei.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Xinwei Hu <huxinwei@huawei.com>, Wuyun <wuyun.wu@huawei.com>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, arnab.basu@freescale.com, Bharat.Bhushan@freescale.com, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, xen-devel@lists.xenproject.org, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-mips@linux-mips.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Save msi chip in pci sysdata, add arch pci_find_msi_chip()
to extract out msi chip.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/mips/include/asm/pci.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 974b0e3..287661b 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -43,6 +43,9 @@ struct pci_controller {
 
 	int iommu;
 
+#ifdef CONFIG_PCI_MSI
+	struct msi_chip *msi_chip;
+#endif
 	/* Optional access methods for reading/writing the bus number
 	   of the PCI controller */
 	int (*get_busno)(void);
@@ -54,6 +57,17 @@ struct pci_controller {
  */
 extern void register_pci_controller(struct pci_controller *hose);
 
+#ifdef CONFIG_PCI_MSI
+
+static inline struct msi_chip *pci_msi_chip(struct pci_bus *bus)
+{
+	struct pci_controller *control = (struct pci_controller *)bus->sysdata;
+
+	return control->msi_chip;
+}
+
+#endif
+
 /*
  * board supplied pci irq fixup routine
  */
-- 
1.7.1
