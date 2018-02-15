From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 15 Feb 2018 11:56:44 +0000
Subject: Re: [PATCH] s390/console: enable dummy console for vt
Message-Id: <13a674d4-68d5-6fb4-5902-26c6b631b596@de.ibm.com>
References: <2324e2cc-ff55-4d57-2807-c7f72f9ea0ca@de.ibm.com>
 <20180215111423.96598-1-borntraeger@de.ibm.com>
 <CAMuHMdWCK1V3PWXHMNZUmFVMCSqi5xhs72mT_M=gE96TSzMN9w@mail.gmail.com>
In-Reply-To: <CAMuHMdWCK1V3PWXHMNZUmFVMCSqi5xhs72mT_M=gE96TSzMN9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-fbdev/>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, DRI Development <dri-devel@lists.freedesktop.org>, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Thomas Huth <thuth@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On 02/15/2018 12:26 PM, Geert Uytterhoeven wrote:
> Hi Christian,
> 
> On Thu, Feb 15, 2018 at 12:14 PM, Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
>> To enable the virtual terminal layer with virtio-gpu, we need to
>> provide the dummy console. This console is hidden behind CONFIG_IOMEM
>> via the graphics support. Instead of fully enabling the graphic
>> drivers lets just provide a Kconfig option for the dummy console.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>> New version: instead of moving around the graphic and console stuff,
>> let's just keep an s390 specific variant of CONFIG_DUMMY_CONSOLE
>>  arch/s390/Kconfig | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
>> index cbe1d978693a..a69690f616f3 100644
>> --- a/arch/s390/Kconfig
>> +++ b/arch/s390/Kconfig
>> @@ -952,6 +952,11 @@ config S390_HYPFS_FS
>>
>>  source "arch/s390/kvm/Kconfig"
>>
>> +config DUMMY_CONSOLE
>> +       bool
>> +       depends on VT
>> +       default y
>> +
>>  config S390_GUEST
>>         def_bool y
>>         prompt "s390 support for virtio devices"
> 
> Really?
> 
> You already have your own copy of HAS_IOMEM, which makes it hard for
> people to track which one applies where.
> 

I am open for better suggestions. One idea that I had was to reverse
the logic in s390 (and use the common code HAS_IOMEM)

like


diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index cbe1d978693a..123dd593ea20 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -715,8 +715,8 @@ endif       # PCI
 config PCI_DOMAINS
        def_bool PCI
 
-config HAS_IOMEM
-       def_bool PCI
+config NO_IOMEM
+       def_bool y if !PCI
 
 config IOMMU_HELPER
        def_bool PCI


This would enable CONFIG_VT and also CONFIG_DUMMY_CONSOLE as long as
PCI is enabled. If DUMMY_CONSOLE is not enabled (e.g. due to missing PCI),
we get a crash in the VT layer as conswitchp is then null.

Somewhat tricky.
