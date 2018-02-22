From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 22 Feb 2018 07:34:13 +0000
Subject: Re: [PATCH v3 1/3] Kconfig : Remove HAS_IOMEM dependency for Graphics support
Message-Id: <2af46f6f-d225-9802-c6f9-98099fb2c2c8@de.ibm.com>
References: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
 <2beec7645bac82e7bdef4f6df0b9f4fe28696575.1519053920.git.alifm@linux.vnet.ibm.com>
 <cce8b082-c780-3559-4491-c39eb09482b0@redhat.com>
 <6cae85dc-76d5-1b92-ab13-a5e441eb84a0@linux.vnet.ibm.com>
 <faffcd8e-4ef6-64bc-ab11-9b48ca488ed6@de.ibm.com>
 <f658ea9e-0153-a0e3-544a-8ce575284245@de.ibm.com>
 <20180221113217.11bb1c69.cohuck@redhat.com>
 <b742aa29-70b2-42e1-26d2-8ca0c8945863@de.ibm.com>
 <d1a89481-e5c9-b460-ea9c-f796dc28b748@redhat.com>
 <1f8907d4-c4a3-d41b-8834-679dcc85de4a@de.ibm.com>
 <5dfa9213-0e63-54d0-8700-1ced4efd4c28@redhat.com>
 <f6db4d0a-3578-4162-5de7-6e699f7a02c2@de.ibm.com>
 <20180221130755.17d15f89.cohuck@redhat.com>
 <6c1daae4-e1f6-5627-9023-f03d986c5639@de.ibm.com>
 <2170dce6-4456-3ab6-d07c-2169d99c4173@linux.vnet.ibm.com>
In-Reply-To: <2170dce6-4456-3ab6-d07c-2169d99c4173@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-fbdev/>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
To: Farhan Ali <alifm@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org, geert@linux-m68k.org, tomi.valkeinen@ti.com, b.zolnierkie@samsung.com
List-ID: <linux-s390.vger.kernel.org>



On 02/21/2018 05:39 PM, Farhan Ali wrote:
> 
> 
> On 02/21/2018 07:11 AM, Christian Borntraeger wrote:
>>
>>
>> On 02/21/2018 01:07 PM, Cornelia Huck wrote:
>> [...]
>>>>> But if you need to enable PCI to get IOMEM, I wonder why this patch here
>>>>> is needed at all? The Graphics menu / VT dummy console should be
>>>>> available in the config if IOMEM is enabled anyway?
>>>>
>>>> That is a good question. With CONFIG_PCI=y I can select virtio-gpu and dummy-console.
>>>> IIRC the issue was that with patch 3 we can have the situation where we have
>>>> CONFIG_VT = y and CONFIG_DUMMY_CONSOLE=n and this will crash early during boot as
>>>> conswitchp is NULL.
> 
> Yes, VT layer initializes very early in the boot process and looks for a console. If it can't find any it will crash. I believe that was the whole point of having the dummy console.
> 
>>>
>>> So in practice, CONFIG_VT depends on "there's a console available, even
>>> if it's only the dummy one"?
>>
>> Yes. Maybe we should simple move dummy_console outside of drivers/video/console/Kconfig
>> into something that is always available.
>>
> 
> I agree, but where should it go? consoles are kinda tightly tied to video/Graphics Support.
> 
>>>
>>>> This patches goal was to always enable dummy console even without
>>>> PCI, but it obviously fails to do so.
>>>
> This patch should enable the dummy console even without PCI but we won't have DRM/Virtio GPU.


All right. This patch then makes sure that VT does not crash since it guarantees
that DUMMY_CONSOLE is available. If the user want to have virtio-gpu it needs to
enable PCI due to the dependencies, but this is a different issue that we can fix
later.
So the patch is fine as long as you take care of these things

- add missing HAS_IOMEM dependency to VGA_CONSOLE

- extend "if HAS_IOMEM" in drivers/video/Kconfig to cover config items
  previously covered by this dependency (it should start before config
  HAVE_FB_ATMEL and end after config HDMI)

as requested by Bartlomiej 
