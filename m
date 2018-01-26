From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 26 Jan 2018 12:38:29 +0000
Subject: Re: [PATCH v1 2/2] fbdev: Kconfig: Add HAS_IOMEM dependency for FB_OPENCORES
Message-Id: <1fae3814-705e-a221-5e58-cef8da3a2f7d@ti.com>
References: <cover.1516892845.git.alifm@linux.vnet.ibm.com>
 <033e4a497792b2fa484c1288b9ed05c068565088.1516892845.git.alifm@linux.vnet.ibm.com>
 <036978d8-0628-9841-4bc1-b09c5231b577@redhat.com>
In-Reply-To: <036978d8-0628-9841-4bc1-b09c5231b577@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-fbdev/>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, stefan.kristiansson@saunalahti.fi
List-ID: <linux-s390.vger.kernel.org>

On 26/01/18 14:33, Thomas Huth wrote:
> On 25.01.2018 16:47, Farhan Ali wrote:
>> The Opencores framebuffer device uses I/O memory and with
>> CONFIG_HAS_IOMEM disabled will lead to build errors:
>>
>> ERROR: "devm_ioremap_resource" [drivers/video/fbdev/ocfb.ko] undefined!
>>
>> Fix this by adding HAS_IOMEM dependency for FB_OPENCORES.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
>> ---
>>  drivers/video/fbdev/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
>> index 5e58f5e..8667e5d 100644
>> --- a/drivers/video/fbdev/Kconfig
>> +++ b/drivers/video/fbdev/Kconfig
>> @@ -976,7 +976,7 @@ config FB_PVR2
>>  
>>  config FB_OPENCORES
>>  	tristate "OpenCores VGA/LCD core 2.0 framebuffer support"
>> -	depends on FB && HAS_DMA
>> +	depends on FB && HAS_DMA && HAS_IOMEM
>>  	select FB_CFB_FILLRECT
>>  	select FB_CFB_COPYAREA
>>  	select FB_CFB_IMAGEBLIT
> 
> I think it would be better if fbdevs in general would depend on
> HAS_IOMEM ... or could there be any frame buffer devices without IOMEM ?

There are some small ones which are updated with, say, i2c
(ssd1307fb.c). I think those don't need iomem.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
