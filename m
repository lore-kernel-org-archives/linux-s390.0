From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [RFC] asm-generic/pci_iomap.h: make custom PCI BAR requirements explicit
Date: Fri, 28 Aug 2015 17:17:27 -0700
Message-ID: <1440807447-584-1-git-send-email-mcgrof@do-not-panic.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: arnd@arndb.de, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, bp@suse.de, linux@roeck-us.net, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, rostedt@goodmis.org, "Luis R. Rodriguez" <mcgrof@suse.com>
List-ID: <linux-s390.vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

The S390 architecture requires a custom pci_iomap() implementation
as the asm-generic implementation assumes there are disjunctions
between PCI BARs, and on S390 PCI BAR are not disjunctive, S390 requires
the bar parameter in order to find the corresponding device and create
the mapping cookie.

This clash with the asm-generic pci_iomap() implementation is implicit,
there are no current semantics to make this incompatability explicit.
Make the S390 PCI BAR non-disjunction incompatibility explicit, and
also pave the way for alternative incompatibilities to be defined.

While at it, as with the ioremap*() variants, since we have no clear
semantics yet well defined provide a solution for them that returns
NULL. This allows architectures to move forward by defining pci_ioremap*()
variants without requiring immediate changes to all architectures. Each
architecture then can implement their own solution as needed and
when they get to it.

Build tested with allyesconfig on:

	* S390
	* x86_64

Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---

This came up as an idea after noting that S390 has no way to be
explicit about its requirements, this also means we don't have a
quick easy way to ensure that other architectures might have a
conflict as well. This provides an easy way to do that by having
the architectures define their incompatibilities and allowing those
then to negate GENERIC_PCI_IOMAP on lib/Kconfig.

I think a next cleanup could be the move of the pci_iounmap() out to
pci_iomap.h to avoid having each arch having to declare it. That's
a separate atomic change though so should go in separately.

I am not sure if this is the best name for this incompatibility, please
let me know.

 arch/s390/Kconfig                 |  8 +++++
 arch/s390/include/asm/io.h        | 11 -------
 arch/s390/include/asm/pci.h       |  2 --
 arch/s390/include/asm/pci_iomap.h | 33 +++++++++++++++++++++
 arch/s390/pci/pci.c               |  2 ++
 include/asm-generic/io.h          | 12 --------
 include/asm-generic/iomap.h       | 10 -------
 include/asm-generic/pci_iomap.h   | 62 +++++++++++++++++++++++++++++++++++----
 lib/Kconfig                       |  1 +
 lib/pci_iomap.c                   |  5 ++++
 10 files changed, 105 insertions(+), 41 deletions(-)
 create mode 100644 arch/s390/include/asm/pci_iomap.h

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 1d57000b1b24..1217b7db4265 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -614,6 +614,14 @@ endif	# PCI
 config PCI_DOMAINS
 	def_bool PCI
 
+config ARCH_PCI_NON_DISJUNCTIVE
+	def_bool PCI
+	help
+	  On the S390 architecture PCI BAR spaces are not disjunctive, as such
+	  the PCI bar is required on a series of otherwise asm generic PCI
+	  routines, as such S390 requires itw own implemention for these
+	  routines.
+
 config HAS_IOMEM
 	def_bool PCI
 
diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
index 437e9af96688..27443c778367 100644
--- a/arch/s390/include/asm/io.h
+++ b/arch/s390/include/asm/io.h
@@ -49,17 +49,6 @@ static inline void ioport_unmap(void __iomem *p)
 {
 }
 
-/*
- * s390 needs a private implementation of pci_iomap since ioremap with its
- * offset parameter isn't sufficient. That's because BAR spaces are not
- * disjunctive on s390 so we need the bar parameter of pci_iomap to find
- * the corresponding device and create the mapping cookie.
- */
-#define pci_iomap pci_iomap
-#define pci_iounmap pci_iounmap
-#define pci_iomap_wc pci_iomap
-#define pci_iomap_wc_range pci_iomap_range
-
 #define memcpy_fromio(dst, src, count)	zpci_memcpy_fromio(dst, src, count)
 #define memcpy_toio(dst, src, count)	zpci_memcpy_toio(dst, src, count)
 #define memset_io(dst, val, count)	zpci_memset_io(dst, val, count)
diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 34d960353a08..51a0a426a6e3 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -18,8 +18,6 @@
 
 #define pcibios_assign_all_busses()	(0)
 
-void __iomem *pci_iomap(struct pci_dev *, int, unsigned long);
-void pci_iounmap(struct pci_dev *, void __iomem *);
 int pci_domain_nr(struct pci_bus *);
 int pci_proc_domain(struct pci_bus *);
 
diff --git a/arch/s390/include/asm/pci_iomap.h b/arch/s390/include/asm/pci_iomap.h
new file mode 100644
index 000000000000..b897ff4cac59
--- /dev/null
+++ b/arch/s390/include/asm/pci_iomap.h
@@ -0,0 +1,33 @@
+#ifndef _S390_ASM_PCI_IOMAP_H
+#define _S390_ASM_PCI_IOMAP_H
+/*
+ *  S390 version
+ */
+#include <linux/kernel.h>
+#include <asm/page.h>
+#include <asm/pci_io.h>
+
+#ifdef CONFIG_PCI
+
+struct pci_dev;
+
+/*
+ * s390 needs a private implementation of pci_iomap since ioremap with its
+ * offset parameter isn't sufficient. That's because BAR spaces are not
+ * disjunctive on s390 so we need the bar parameter of pci_iomap to find
+ * the corresponding device and create the mapping cookie.
+ */
+
+/* XXX: in the future we'll remove these */
+#define pci_iounmap pci_iounmap
+void pci_iounmap(struct pci_dev *, void __iomem *);
+
+/* Annotate pci_iomap*() variant solutions have been reviewed and vetted */
+#define pci_iomap_wc pci_iomap
+#define pci_iomap_wc_range pci_iomap_range
+
+#include <asm-generic/pci_iomap.h>
+
+#endif /* CONFIG_PCI */
+
+#endif /* _S390_ASM_PCI_IOMAP_H */
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 7ef12a3ace3a..92dd561bc89f 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -18,6 +18,8 @@
 #define KMSG_COMPONENT "zpci"
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
+#include <asm/pci_iomap.h>
+
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/err.h>
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index eed3bbe88c8a..1f230d390740 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -704,18 +704,6 @@ static inline void iowrite32_rep(volatile void __iomem *addr,
 #include <linux/vmalloc.h>
 #define __io_virt(x) ((void __force *)(x))
 
-#ifndef CONFIG_GENERIC_IOMAP
-struct pci_dev;
-extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
-
-#ifndef pci_iounmap
-#define pci_iounmap pci_iounmap
-static inline void pci_iounmap(struct pci_dev *dev, void __iomem *p)
-{
-}
-#endif
-#endif /* CONFIG_GENERIC_IOMAP */
-
 /*
  * Change virtual addresses to physical addresses and vv.
  * These are pretty trivial
diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
index d8f8622fa044..af49a46585ad 100644
--- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@ -70,16 +70,6 @@ extern void ioport_unmap(void __iomem *);
 #define ioremap_wt ioremap_nocache
 #endif
 
-#ifdef CONFIG_PCI
-/* Destroy a virtual mapping cookie for a PCI BAR (memory or IO) */
-struct pci_dev;
-extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
-#elif defined(CONFIG_GENERIC_IOMAP)
-struct pci_dev;
-static inline void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
-{ }
-#endif
-
 #include <asm-generic/pci_iomap.h>
 
 #endif
diff --git a/include/asm-generic/pci_iomap.h b/include/asm-generic/pci_iomap.h
index b1e17fcee2d0..9f04547a00a9 100644
--- a/include/asm-generic/pci_iomap.h
+++ b/include/asm-generic/pci_iomap.h
@@ -12,16 +12,62 @@
 #define __ASM_GENERIC_PCI_IOMAP_H
 
 struct pci_dev;
+
 #ifdef CONFIG_PCI
-/* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
-extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
-extern void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long max);
 extern void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
 				     unsigned long offset,
 				     unsigned long maxlen);
+extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
+extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
+
+/**
+ * DOC: pci_iomap(), pci_iomap_range() and pci_iomap*() variants
+ *
+ * pci_iomap() creates a virtual mapping cookie for a PCI BAR (memory or IO).
+ *
+ * If your architecture supports PCI you must either rely on the asm-generic
+ * solution for pci_iomap() and pci_iomap_range() or your architecture must
+ * implement your own solution. You may require your own implementation if
+ * your architecture PCI requirements are outside the norm of other
+ * architectures. If your architecture adheres to the norm your architecture
+ * will select GENERIC_PCI_IOMAP. GENERIC_PCI_IOMAP will negate known
+ * incompatible architecture PCI solutions which require more special
+ * handling.
+ *
+ * There are also pci_iomap*() and pci_iomap_*_range() call variants, if you
+ * have custom PCI requirements you must define the proper implementation
+ * for these otherwise the defaults defined here will return NULL.
+ *
+ * If you selected CONFIG_GENERIC_PCI_IOMAP you can also override default
+ * pci_iomap*() variants by defining them in your architecture pci_iomap.h.
+ */
+#ifdef CONFIG_GENERIC_PCI_IOMAP
 extern void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
 					unsigned long offset,
 					unsigned long maxlen);
+extern void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long max);
+#else /* !CONFIG_GENERIC_PCI_IOMAP */
+
+#ifndef pci_iomap_wc
+#define pci_iomap_wc pci_iomap_wc
+static inline void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long max)
+{
+	return NULL;
+}
+#endif
+
+#ifndef pci_iomap_wc_range
+#define pci_iomap_wc_range pci_iomap_wc_range
+static inline void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
+					       unsigned long offset,
+					       unsigned long maxlen)
+{
+	return NULL;
+}
+#endif
+
+#endif /* !CONFIG_GENERIC_PCI_IOMAP */
+
 /* Create a virtual mapping cookie for a port on a given PCI device.
  * Do not call this directly, it exists to make it easier for architectures
  * to override */
@@ -32,7 +78,7 @@ extern void __iomem *__pci_ioport_map(struct pci_dev *dev, unsigned long port,
 #define __pci_ioport_map(dev, port, nr) ioport_map((port), (nr))
 #endif
 
-#elif defined(CONFIG_GENERIC_PCI_IOMAP)
+#else /* !CONFIG_PCI */
 static inline void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max)
 {
 	return NULL;
@@ -54,6 +100,10 @@ static inline void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
 {
 	return NULL;
 }
-#endif
 
-#endif /* __ASM_GENERIC_IO_H */
+static inline void pci_iounmap(struct pci_dev *dev, void __iomem *p)
+{
+}
+#endif /* !CONFIG_PCI */
+
+#endif /* __ASM_GENERIC_PCI_IOMAP_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index 34f99838c20f..1416a41e9ea7 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -41,6 +41,7 @@ config NO_GENERIC_PCI_IOPORT_MAP
 
 config GENERIC_PCI_IOMAP
 	bool
+	depends on !ARCH_PCI_NON_DISJUNCTIVE
 
 config GENERIC_IOMAP
 	bool
diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
index c10fba461454..2502711c06ed 100644
--- a/lib/pci_iomap.c
+++ b/lib/pci_iomap.c
@@ -48,6 +48,7 @@ void __iomem *pci_iomap_range(struct pci_dev *dev,
 }
 EXPORT_SYMBOL(pci_iomap_range);
 
+#ifndef pci_iomap_wc_range
 /**
  * pci_iomap_wc_range - create a virtual WC mapping cookie for a PCI BAR
  * @dev: PCI device that owns the BAR
@@ -92,6 +93,7 @@ void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(pci_iomap_wc_range);
+#endif
 
 /**
  * pci_iomap - create a virtual mapping cookie for a PCI BAR
@@ -113,6 +115,7 @@ void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
 }
 EXPORT_SYMBOL(pci_iomap);
 
+#ifndef pci_iomap_wc
 /**
  * pci_iomap_wc - create a virtual WC mapping cookie for a PCI BAR
  * @dev: PCI device that owns the BAR
@@ -133,4 +136,6 @@ void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long maxlen)
 	return pci_iomap_wc_range(dev, bar, 0, maxlen);
 }
 EXPORT_SYMBOL_GPL(pci_iomap_wc);
+#endif
+
 #endif /* CONFIG_PCI */
-- 
2.4.3
