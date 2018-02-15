From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 15 Feb 2018 11:02:18 +0000
Subject: Re: [PATCH v2 1/3] Kconfig : Remove HAS_IOMEM dependency for Graphics support
Message-Id: <b1a3933e-6a8f-bd24-3629-5da730398f32@de.ibm.com>
References: <cover.1517508744.git.alifm@linux.vnet.ibm.com>
 <CGME20180202080007epcas5p306896fe66e4bbf4bf5f8d91306a5d016@epcas5p3.samsung.com>
 <246f92c9-15dc-223f-59d9-b2f0756cdf5e@de.ibm.com>
 <1610039.4trOurtpys@amdc3058>
 <2324e2cc-ff55-4d57-2807-c7f72f9ea0ca@de.ibm.com>
In-Reply-To: <2324e2cc-ff55-4d57-2807-c7f72f9ea0ca@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-fbdev/>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Chen Liqin <liqin.linux@gmail.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, stefan.kristiansson@saunalahti.fi, tomi.valkeinen@ti.com, geert@linux-m68k.org, schwidefsky@de.ibm.com, Lennox Wu <lennox.wu@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

An even simpler approach would be:

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index cbe1d978693a..35b7aba4b6a0 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -952,6 +952,10 @@ config S390_HYPFS_FS
 
 source "arch/s390/kvm/Kconfig"
 
+config DUMMY_CONSOLE
+       bool
+       default y
+
 config S390_GUEST
        def_bool y
        prompt "s390 support for virtio devices"
