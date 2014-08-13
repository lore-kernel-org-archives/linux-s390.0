From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v4 1/8] ARC: Remove redundant PCI_IOBASE declaration
Date: Wed, 13 Aug 2014 12:28:51 +0200
Message-ID: <1407925738-26170-2-git-send-email-thierry.reding@gmail.com>
References: <1407925738-26170-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1407925738-26170-1-git-send-email-thierry.reding@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, sparclinux@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Sam Ravnborg <sam@ravnborg.org>, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

ARC's asm/io.h includes the asm-generic/io.h which already defines the
PCI_IOBASE variable in exactly the same way, so it can be dropped from
the architecture specific header.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v4:
- new patch

 arch/arc/include/asm/io.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arc/include/asm/io.h b/arch/arc/include/asm/io.h
index 334ce7017a18..cabd518cb253 100644
--- a/arch/arc/include/asm/io.h
+++ b/arch/arc/include/asm/io.h
@@ -13,8 +13,6 @@
 #include <asm/byteorder.h>
 #include <asm/page.h>
 
-#define PCI_IOBASE ((void __iomem *)0)
-
 extern void __iomem *ioremap(unsigned long physaddr, unsigned long size);
 extern void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
 				  unsigned long flags);
-- 
2.0.4
