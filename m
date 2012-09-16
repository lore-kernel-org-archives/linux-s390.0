From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [-next]: s390 *_irq() link errors
Date: Sun, 16 Sep 2012 21:07:54 +0200
Message-ID: <CAMuHMdXqsPgfToNyjbxJ-WM=-kEEvAweE03wb3vtkwVO+-RR3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: Linux-Next <linux-next@vger.kernel.org>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

After applying http://www.spinics.net/lists/linux-next/msg21973.html,
the s390 allmodconfig build in linux-next fails in the linking stage with:

ERROR: "free_irq" [drivers/power/smb347-charger.ko] undefined!
ERROR: "free_irq" [drivers/power/sbs-battery.ko] undefined!
ERROR: "enable_irq" [drivers/power/max17042_battery.ko] undefined!
ERROR: "request_irq" [drivers/power/max17042_battery.ko] undefined!
ERROR: "free_irq" [drivers/power/max17042_battery.ko] undefined!
ERROR: "disable_irq" [drivers/power/max17042_battery.ko] undefined!
ERROR: "request_irq" [drivers/power/lp8727_charger.ko] undefined!
ERROR: "free_irq" [drivers/power/lp8727_charger.ko] undefined!
ERROR: "request_irq" [drivers/nfc/pn544_hci.ko] undefined!
ERROR: "free_irq" [drivers/nfc/pn544_hci.ko] undefined!
ERROR: "request_irq" [drivers/nfc/pn544.ko] undefined!
ERROR: "free_irq" [drivers/nfc/pn544.ko] undefined!
ERROR: "request_irq" [drivers/misc/fsa9480.ko] undefined!
ERROR: "free_irq" [drivers/misc/fsa9480.ko] undefined!
ERROR: "request_irq" [drivers/misc/bh1770glc.ko] undefined!
ERROR: "free_irq" [drivers/misc/bh1770glc.ko] undefined!
ERROR: "request_irq" [drivers/misc/apds990x.ko] undefined!
ERROR: "free_irq" [drivers/misc/apds990x.ko] undefined!

What should these drivers depend on? GENERIC_HARDIRQS?

S390 is the only non-GENERIC_HARDIRQS architecture left, but all
other former non-GENERIC_HARDIRQS architectures did provide e.g. request_irq()
and free_irq().

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
