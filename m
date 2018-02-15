From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 15 Feb 2018 09:40:04 +0000
Subject: Re: [PATCH v2 1/3] Kconfig : Remove HAS_IOMEM dependency for Graphics support
Message-Id: <2324e2cc-ff55-4d57-2807-c7f72f9ea0ca@de.ibm.com>
References: <cover.1517508744.git.alifm@linux.vnet.ibm.com>
 <CGME20180202080007epcas5p306896fe66e4bbf4bf5f8d91306a5d016@epcas5p3.samsung.com>
 <246f92c9-15dc-223f-59d9-b2f0756cdf5e@de.ibm.com>
 <1610039.4trOurtpys@amdc3058>
In-Reply-To: <1610039.4trOurtpys@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-fbdev/>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Chen Liqin <liqin.linux@gmail.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, stefan.kristiansson@saunalahti.fi, tomi.valkeinen@ti.com, geert@linux-m68k.org, schwidefsky@de.ibm.com, Lennox Wu <lennox.wu@gmail.com>
List-ID: <linux-s390.vger.kernel.org>



On 02/08/2018 02:11 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> [ dri-devel ML & arch/[score,um] Maintainers added to Cc: ]
> 
> On Friday, February 02, 2018 08:59:57 AM Christian Borntraeger wrote:
>> On 02/01/2018 07:41 PM, Farhan Ali wrote:
>>> The 'commit e25df1205f37 ("[S390] Kconfig: menus with depends on HAS_IOMEM.")'
>>> added the HAS_IOMEM dependecy for "Graphics support". This disabled the
>>> "Graphics support" menu for S390. But if we enable VT layer for S390,
>>> we would also need to enable the dummy console. So let's remove the
>>> HAS_IOMEM dependency.
>>>
>>> Move this dependency to Opencores framebuffer driver which would fail to build
>>> with CONFIG_HAS_IOMEM disabled:
>>>
>>> ERROR: "devm_ioremap_resource" [drivers/video/fbdev/ocfb.ko] undefined!
> 
> "Graphics support" menu covers other things (i.e. DRM), I assume that
> they were also checked to not break due to this change?
> 
> Moreover it seems that after this change "Graphics support" menu will
> be also enabled (besides s390) for score, tile and um architectures,
> I assume that this is okay?



Turns out that patch fails to build with.

So what about the following approach instead:

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 3c20af999893..5ae512fe52ed 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -47,3 +47,28 @@ endif
 
 
 endmenu
+
+config DUMMY_CONSOLE
+       bool
+       depends on VGA_CONSOLE!=y || SGI_NEWPORT_CONSOLE!=y
+       default y
+
+config DUMMY_CONSOLE_COLUMNS
+        int "Initial number of console screen columns"
+        depends on DUMMY_CONSOLE && !ARM
+        default 160 if PARISC
+        default 80
+        help
+          On PA-RISC, the default value is 160, which should fit a 1280x1024
+          monitor.
+          Select 80 if you use a 640x480 resolution by default.
+
+config DUMMY_CONSOLE_ROWS
+        int "Initial number of console screen rows"
+        depends on DUMMY_CONSOLE && !ARM
+        default 64 if PARISC
+        default 25
+        help
+          On PA-RISC, the default value is 64, which should fit a 1280x1024
+          monitor.
+          Select 25 if you use a 640x480 resolution by default.
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 7f1f1fbcef9e..97ae3c349666 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -91,31 +91,6 @@ config SGI_NEWPORT_CONSOLE
           Say Y here if you want the console on the Newport aka XL graphics
           card of your Indy.  Most people say Y here.
 
-config DUMMY_CONSOLE
-       bool
-       depends on VGA_CONSOLE!=y || SGI_NEWPORT_CONSOLE!=y 
-       default y
-
-config DUMMY_CONSOLE_COLUMNS
-        int "Initial number of console screen columns"
-        depends on DUMMY_CONSOLE && !ARM
-        default 160 if PARISC
-        default 80
-        help
-          On PA-RISC, the default value is 160, which should fit a 1280x1024
-          monitor.
-          Select 80 if you use a 640x480 resolution by default.
-
-config DUMMY_CONSOLE_ROWS
-        int "Initial number of console screen rows"
-        depends on DUMMY_CONSOLE && !ARM
-        default 64 if PARISC
-        default 25
-        help
-          On PA-RISC, the default value is 64, which should fit a 1280x1024
-          monitor.
-          Select 25 if you use a 640x480 resolution by default.
-
 config FRAMEBUFFER_CONSOLE
        bool "Framebuffer Console support"
        depends on FB && !UML
