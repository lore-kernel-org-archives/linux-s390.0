From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 21 Feb 2018 12:11:42 +0000
Subject: Re: [PATCH v3 1/3] Kconfig : Remove HAS_IOMEM dependency for Graphics support
Message-Id: <6c1daae4-e1f6-5627-9023-f03d986c5639@de.ibm.com>
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
In-Reply-To: <20180221130755.17d15f89.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-fbdev/>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org, geert@linux-m68k.org, tomi.valkeinen@ti.com, b.zolnierkie@samsung.com
List-ID: <linux-s390.vger.kernel.org>



On 02/21/2018 01:07 PM, Cornelia Huck wrote:
[...]
>>> But if you need to enable PCI to get IOMEM, I wonder why this patch here
>>> is needed at all? The Graphics menu / VT dummy console should be
>>> available in the config if IOMEM is enabled anyway?  
>>
>> That is a good question. With CONFIG_PCI=y I can select virtio-gpu and dummy-console.
>> IIRC the issue was that with patch 3 we can have the situation where we have
>> CONFIG_VT = y and CONFIG_DUMMY_CONSOLE=n and this will crash early during boot as
>> conswitchp is NULL. 
> 
> So in practice, CONFIG_VT depends on "there's a console available, even
> if it's only the dummy one"?

Yes. Maybe we should simple move dummy_console outside of drivers/video/console/Kconfig
into something that is always available.

> 
>> This patches goal was to always enable dummy console even without
>> PCI, but it obviously fails to do so.
> 
> OTOH, the dummy console really should not depend on anything, as it is
> only doing dummy things.
> 
>>
>> So what about allowing CONFIG_VT on s390 only if we have PCI?
>>
>>
>> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
>> index 84810075a6a0..1c7fe09d6f90 100644
>> --- a/drivers/tty/Kconfig
>> +++ b/drivers/tty/Kconfig
>> @@ -11,7 +11,7 @@ if TTY
>>  
>>  config VT
>>         bool "Virtual terminal" if EXPERT
>> -       depends on !UML
>> +       depends on !UML && (!S390 || PCI)
>>         select INPUT
>>         default y
>>         ---help---
>>
> 
> Would cover your use case, but feels wrong to me... config dependencies
> aren't fun :/
> 
