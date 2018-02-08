From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 08 Feb 2018 15:30:21 +0000
Subject: Re: [PATCH v2 1/3] Kconfig : Remove HAS_IOMEM dependency for Graphics support
Message-Id: <b93b12b9-bfcc-8ae4-ad74-fd4f262872a8@de.ibm.com>
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
Cc: Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org, geert@linux-m68k.org, stefan.kristiansson@saunalahti.fi, tomi.valkeinen@ti.com, schwidefsky@de.ibm.com, dri-devel@lists.freedesktop.org, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
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

I can add this patch to my next tree (after merge window) and check for
any errors from all the build bots.
