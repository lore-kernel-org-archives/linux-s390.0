From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] Build regressions/improvements in v4.20-rc1
 (sound/pci/hda/patch_ca0132.c)
Date: Tue, 6 Nov 2018 08:56:39 -0600
Message-ID: <eccd20fa-5be3-957d-7905-9cc4021ba94e@linux.intel.com>
References: <20181105220559.27458-1-geert@linux-m68k.org>
 <CAMuHMdWGpjvwunNWgFujPO9_j+=QiNsi346s4-xBF1g4DT5xZw@mail.gmail.com>
 <80f2f98b-9ab1-2a1c-0962-63e3be1dd742@infradead.org>
 <CAMuHMdViTrKqQzci3=YJzk2+kQKqbWcr0oaaR1ZQM_VqT33RvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdViTrKqQzci3=YJzk2+kQKqbWcr0oaaR1ZQM_VqT33RvA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Mark Brown <broonie@kernel.org>
List-ID: <linux-s390.vger.kernel.org>


>>>>
>>>> *** ERRORS ***
>>>>
>>>>    + /kisskb/src/sound/pci/hda/patch_ca0132.c: error: implicit declaration of function 'pci_iomap' [-Werror=implicit-function-declaration]:  => 8799:3
>>> sh4-all{mod,yes}config
>>>
>>> Looks like d9b84a15892c0233 ("ALSA: hda: Fix implicit definition of
>>> pci_iomap() on SH")
>>> is not sufficient?
>> Different problem.  This is about "select":
>>
>> config SND_SOC_ALL_CODECS
>>          tristate "Build all ASoC CODEC drivers"
>>
>> That enables (sets):
>>          select SND_SOC_HDAC_HDA
>> which selects SND_HDA even though CONFIG_PCI is not enabled.
>>
>> After SND_HDA is selected (above), the Kconfig symbols in
>> sound/pci/hda/Kconfig are available for enabling, so
>> SND_HDA_CODEC_CA0132 is enabled but will not build.
> Thanks for looking into this!
>
>> One simple solution (but possibly too naive) is:
>>
>> ---
>>   sound/soc/codecs/Kconfig |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- lnx-420-rc1.orig/sound/soc/codecs/Kconfig
>> +++ lnx-420-rc1/sound/soc/codecs/Kconfig
>> @@ -82,7 +82,7 @@ config SND_SOC_ALL_CODECS
>>          select SND_SOC_ES7241
>>          select SND_SOC_GTM601
>>          select SND_SOC_HDAC_HDMI
>> -       select SND_SOC_HDAC_HDA
>> +       select SND_SOC_HDAC_HDA if PCI
>>          select SND_SOC_ICS43432
>>          select SND_SOC_INNO_RK3036
>>          select SND_SOC_ISABELLE if I2C
> I guess that will work. There are already plenty of "select foo if bar" lines.
> However, looking at what else can enable SND_HDA, I think it should be
>
>      select SND_SOC_HDAC_HDA if SND_PCI || ARCH_TEGRA

This codec can only be used by the Skylake driver (and the upcoming SOF 
one). For Tegra this module will never be used unless they follow the 
same path of enabling ASoC to deal with the HDaudio codecs instead of 
the legacy.

Likewise HDAC_HDMI will only work on Intel platforms for now.

>
> That still leaves the issue that pci_iomap() on SH should be an empty stub if
> PCI is not available, like on other architectures.

I thought Mark Brown provided a fix to SH maintainers?
