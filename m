From: Randy Dunlap <rdunlap@infradead.org>
Subject: Build regressions/improvements in v4.20-rc1
 (sound/pci/hda/patch_ca0132.c)
Date: Mon, 5 Nov 2018 17:04:47 -0800
Message-ID: <80f2f98b-9ab1-2a1c-0962-63e3be1dd742@infradead.org>
References: <20181105220559.27458-1-geert@linux-m68k.org>
 <CAMuHMdWGpjvwunNWgFujPO9_j+=QiNsi346s4-xBF1g4DT5xZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <CAMuHMdWGpjvwunNWgFujPO9_j+=QiNsi346s4-xBF1g4DT5xZw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
List-Archive: <https://lore.kernel.org/alsa-devel/>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-ID: <linux-s390.vger.kernel.org>

On 11/5/18 2:12 PM, Geert Uytterhoeven wrote:
> On Mon, Nov 5, 2018 at 11:07 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> Below is the list of build error/warning regressions/improvements in
>> v4.20-rc1[1] compared to v4.19[2].
>>
>> Summarized:
>>   - build errors: +3/-0
>>   - build warnings: +449/-2712
>>
>> Happy fixing! ;-)
>>
>> Thanks to the linux-next team for providing the build service.
>>
>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/651022382c7f8da46cb4872a545ee1da6d097d2a/ (all 240 configs)
>> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d/ (all 240 configs)
>>
>>
>> *** ERRORS ***
>>
>>   + /kisskb/src/sound/pci/hda/patch_ca0132.c: error: implicit declaration of function 'pci_iomap' [-Werror=implicit-function-declaration]:  => 8799:3
> 
> sh4-all{mod,yes}config
> 
> Looks like d9b84a15892c0233 ("ALSA: hda: Fix implicit definition of
> pci_iomap() on SH")
> is not sufficient?

Different problem.  This is about "select":

config SND_SOC_ALL_CODECS
	tristate "Build all ASoC CODEC drivers"

That enables (sets):
	select SND_SOC_HDAC_HDA
which selects SND_HDA even though CONFIG_PCI is not enabled.

After SND_HDA is selected (above), the Kconfig symbols in
sound/pci/hda/Kconfig are available for enabling, so
SND_HDA_CODEC_CA0132 is enabled but will not build.


One simple solution (but possibly too naive) is:

---
 sound/soc/codecs/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-420-rc1.orig/sound/soc/codecs/Kconfig
+++ lnx-420-rc1/sound/soc/codecs/Kconfig
@@ -82,7 +82,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_ES7241
 	select SND_SOC_GTM601
 	select SND_SOC_HDAC_HDMI
-	select SND_SOC_HDAC_HDA
+	select SND_SOC_HDAC_HDA if PCI
 	select SND_SOC_ICS43432
 	select SND_SOC_INNO_RK3036
 	select SND_SOC_ISABELLE if I2C




-- 
~Randy
