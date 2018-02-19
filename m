From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Mon, 19 Feb 2018 16:38:59 +0000
Subject: Re: [PATCH v3 1/3] Kconfig : Remove HAS_IOMEM dependency for Graphics support
Message-Id: <6cae85dc-76d5-1b92-ab13-a5e441eb84a0@linux.vnet.ibm.com>
References: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
 <2beec7645bac82e7bdef4f6df0b9f4fe28696575.1519053920.git.alifm@linux.vnet.ibm.com>
 <cce8b082-c780-3559-4491-c39eb09482b0@redhat.com>
In-Reply-To: <cce8b082-c780-3559-4491-c39eb09482b0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-fbdev/>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: geert@linux-m68k.org, borntraeger@de.ibm.com, tomi.valkeinen@ti.com, b.zolnierkie@samsung.com
List-ID: <linux-s390.vger.kernel.org>



On 02/19/2018 11:25 AM, Thomas Huth wrote:
> On 19.02.2018 16:47, Farhan Ali wrote:
>> The 'commit e25df1205f37 ("[S390] Kconfig: menus with depends on HAS_IOMEM.")'
>> added the HAS_IOMEM dependecy for "Graphics support". This disabled the
>> "Graphics support" menu for S390. But if we enable VT layer for S390,
>> we would also need to enable the dummy console. So let's remove the
>> HAS_IOMEM dependency.
>>
>> Move this dependency to sub menu items and console drivers that use
>> io memory.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
>> ---
>>   drivers/video/Kconfig         | 21 +++++++++++----------
>>   drivers/video/console/Kconfig |  4 ++--
>>   2 files changed, 13 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
>> index 3c20af9..8f10915 100644
>> --- a/drivers/video/Kconfig
>> +++ b/drivers/video/Kconfig
>> @@ -3,7 +3,6 @@
>>   #
>>   
>>   menu "Graphics support"
>> -	depends on HAS_IOMEM
>>   
>>   config HAVE_FB_ATMEL
>>   	bool
>> @@ -11,20 +10,22 @@ config HAVE_FB_ATMEL
>>   config SH_LCD_MIPI_DSI
>>   	bool
>>   
>> -source "drivers/char/agp/Kconfig"
>> +if HAS_IOMEM
>> +	source "drivers/char/agp/Kconfig"
>>   
>> -source "drivers/gpu/vga/Kconfig"
>> +	source "drivers/gpu/vga/Kconfig"
>>   
>> -source "drivers/gpu/host1x/Kconfig"
>> -source "drivers/gpu/ipu-v3/Kconfig"
>> +	source "drivers/gpu/host1x/Kconfig"
>> +	source "drivers/gpu/ipu-v3/Kconfig"
>>   
>> -source "drivers/gpu/drm/Kconfig"
>> +	source "drivers/gpu/drm/Kconfig"
>>   
>> -menu "Frame buffer Devices"
>> -source "drivers/video/fbdev/Kconfig"
>> -endmenu
>> +	menu "Frame buffer Devices"
>> +	source "drivers/video/fbdev/Kconfig"
>> +	endmenu
>>   
>> -source "drivers/video/backlight/Kconfig"
>> +        source "drivers/video/backlight/Kconfig"
>> +endif
>>   
>>   config VGASTATE
>>          tristate
>> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
>> index 7f1f1fb..0023b16 100644
>> --- a/drivers/video/console/Kconfig
>> +++ b/drivers/video/console/Kconfig
>> @@ -85,7 +85,7 @@ config MDA_CONSOLE
>>   
>>   config SGI_NEWPORT_CONSOLE
>>           tristate "SGI Newport Console support"
>> -        depends on SGI_IP22
>> +        depends on SGI_IP22 && HAS_IOMEM
>>           select FONT_SUPPORT
>>           help
>>             Say Y here if you want the console on the Newport aka XL graphics
>> @@ -153,7 +153,7 @@ config FRAMEBUFFER_CONSOLE_ROTATION
>>   
>>   config STI_CONSOLE
>>           bool "STI text console"
>> -        depends on PARISC
>> +        depends on PARISC && HAS_IOMEM
>>           select FONT_SUPPORT
>>           default y
>>           help
>>
> 
> Maybe config VGA_CONSOLE should depend on HAS_IOMEM, too? I think you
> can hardly use a VGA card without IOMEM, can you?

True, you can't. And I did think of adding the dependency for VGA, but 
VGA already is fenced off by many (almost all) architectures and I 
wasn't sure if it would be necessary. But I can add it.

> Anyway, this approach now looks reasonable to me, so either way, feel
> free to add my:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

Thank you so much for reviewing. Appreciate your feedback :)
