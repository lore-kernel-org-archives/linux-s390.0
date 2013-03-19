Return-Path: <geert@linux-m68k.org>
Date: Tue, 19 Mar 2013 21:52:49 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
Subject: Re: Build regressions/improvements in v3.9-rc3
In-Reply-To: <alpine.DEB.2.00.1303192148530.18971@ayla.of.borg>
Message-ID: <alpine.DEB.2.00.1303192149210.18990@ayla.of.borg>
References: <alpine.DEB.2.00.1303192148530.18971@ayla.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Cc: linux-s390@vger.kernel.org, Linux/PPC Development <linuxppc-dev@lists.ozlabs.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 19 Mar 2013, Geert Uytterhoeven wrote:
> JFYI, when comparing v3.9-rc3 to v3.9-rc2[3], the summaries are:
>   - build errors: +10/-12

10 regressions:
  + arch/powerpc/kvm/book3s_hv.c: error: implicit declaration of function 'inhibit_secondary_onlining' [-Werror=implicit-function-declaration]:  => 1855:2
  + arch/powerpc/kvm/book3s_hv.c: error: implicit declaration of function 'uninhibit_secondary_onlining' [-Werror=implicit-function-declaration]:  => 1862:2

ppc64_defconfig+UP

  + error: "devm_request_threaded_irq" [drivers/dma/dw_dmac.ko] undefined!:  => N/A
  + error: "devm_request_threaded_irq" [drivers/i2c/busses/i2c-ocores.ko] undefined!:  => N/A
  + error: "devm_request_threaded_irq" [drivers/i2c/i2c-smbus.ko] undefined!:  => N/A
  + error: "devm_request_threaded_irq" [drivers/media/platform/sh_veu.ko] undefined!:  => N/A
  + error: "devm_request_threaded_irq" [drivers/spi/spi-altera.ko] undefined!:  => N/A
  + error: "mfd_add_devices" [drivers/mfd/lpc_sch.ko] undefined!:  => N/A
  + error: "mfd_remove_devices" [drivers/mfd/lpc_sch.ko] undefined!:  => N/A

s390-allmodconfig

  + error: "vgacon_remap_base" [drivers/video/vga16fb.ko] undefined!:  => N/A

powerpc-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/5993/ (118 out of 117 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/5972/ (all 117 configs)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
