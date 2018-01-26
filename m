From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Fri, 26 Jan 2018 16:26:19 +0000
Subject: Re: [PATCH v1 0/2] Kconfig changes to enable Graphics Support for S390
Message-Id: <85ab024b-6af2-8b58-f9e8-7920d132cefb@linux.vnet.ibm.com>
References: <cover.1516892845.git.alifm@linux.vnet.ibm.com>
 <CAMuHMdW7jR2Oa6dsameR76FLhSnX+kZ7jXqpfQC+oHy_uaMJaQ@mail.gmail.com>
 <19306e74-7c9b-5644-6f08-bbaef226afd8@linux.vnet.ibm.com>
 <CAMuHMdUFCKtdAHHt6SwBSQXiRgSKvnqFXUvrQ1jFkb8J0nuSMw@mail.gmail.com>
In-Reply-To: <CAMuHMdUFCKtdAHHt6SwBSQXiRgSKvnqFXUvrQ1jFkb8J0nuSMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-fbdev/>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>
List-ID: <linux-s390.vger.kernel.org>



On 01/26/2018 10:06 AM, Geert Uytterhoeven wrote:
>> Hi Geert,
>>
>> I wasn't sure what would be the best ordering since we would never hit the
>> issue if patch 1 didn't exist. But if the preference is to invert the
>> ordering of patches, then I will change the ordering.
> Alternatively, you can combine two patches into a single patch, which
> moves the dependency from the whole subsystem to the driver that needs
> it (are there more?).
> 
> Gr{oetje,eeting}s,
> 
>                          Geert


I like the idea of combining both patches into one.

There are other fbdev drivers that use iomem (found by grepping for 
"devm_ioremap_resource"):

CONFIG_FB_S3C (s3c-fb.c)

CONFIG_FB_CLPS711X (clps711x-fb.c)

CONFIG_FB_JZ4740 (jz4740_fb.c)

CONFIG_FB_DA8XX (da8xx-fb.c)

CONFIG_FB_WM8505 (wm8505fb.c)

CONFIG_OMAP2_VRFB (omap2/omapfb/vrfb.c)

CONFIG_FB_OMAP2 (omap2/omapfb/dss/*

CONFIG_FB_MXS (mxsfb.c)

CONFIG_PXA3XX_GCU (pxa3xx-gcu.c)

CONFIG_FB_XILINX (xilinxfb.c)


All of these are already fenced off by architecture dependencies (which 
I am assuming enables CONFIG_HAS_IOMEM by default). If we want to be 
cautious I can add HAS_IOMEM dependency for all of them.

Thanks
Farhan
