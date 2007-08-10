Return-Path: <linux-kernel-owner+w=401wt.eu-S934316AbXHJP5W@vger.kernel.org>
Date: Fri, 10 Aug 2007 17:56:56 +0200
From: Adrian Bunk <bunk@kernel.org>
Subject: 2.6.23-rc2-mm2: drivers/s390/char/keyboard.c compile error
Message-ID: <20070810155656.GH18938@stusta.de>
References: <20070809224254.11f42716.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20070809224254.11f42716.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Aug 09, 2007 at 10:42:54PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.23-rc1-mm2:
>...
> +unicode-diacritics-support.patch
>...
>  misc
>...

The change to drivers/s390/char/keyboard.c doesn't compile:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/s390/built-in.o: In function `kbd_ioctl':
(.text+0x2d666): undefined reference to `conv_uni_to_8bit'
drivers/s390/built-in.o: In function `kbd_ioctl':
(.text+0x2d67c): undefined reference to `conv_uni_to_8bit'
drivers/s390/built-in.o: In function `kbd_ioctl':
(.text+0x2d692): undefined reference to `conv_uni_to_8bit'
drivers/s390/built-in.o: In function `kbd_ioctl':
(.text+0x2d906): undefined reference to `conv_8bit_to_uni'
drivers/s390/built-in.o: In function `kbd_ioctl':
(.text+0x2d920): undefined reference to `conv_8bit_to_uni'
drivers/s390/built-in.o: In function `kbd_ioctl':
(.text+0x2d93a): undefined reference to `conv_8bit_to_uni'
make[1]: *** [.tmp_vmlinux1] Error 1
make: *** [_all] Error 2

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
