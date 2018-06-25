Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: s390 qemu boot failure in -next
From: Christian Borntraeger <borntraeger@de.ibm.com>
References: <20180622194736.GA5794@roeck-us.net>
 <126ac556-0602-b927-58f5-cb5f65a5e0ec@de.ibm.com>
Date: Mon, 25 Jun 2018 09:27:59 +0200
MIME-Version: 1.0
In-Reply-To: <126ac556-0602-b927-58f5-cb5f65a5e0ec@de.ibm.com>
Content-Language: en-US
Message-Id: <88d9afed-f91d-c320-13c8-9a93fc52b700@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Also adding QEMU.

On 06/25/2018 09:10 AM, Christian Borntraeger wrote:
> 
> 
> On 06/22/2018 09:47 PM, Guenter Roeck wrote:
>> Hi,
>>
>> starting with commit 's390/boot: make head.S and als.c be part of the
>> decompressor only' in -next, s390 immages no longer boot in qemu.
>> As far as I can see, the reason is that the command line is no longer
>> passed from qemu to the kernel, which results in a panic because the
>> root file system can not be mounted.
>>
>> Was this change made on purpose ? If so, is there a way to get qemu
>> back to working ?
> 
> Certainly not on purpose.
> 
> Vasily, I can reproduce this with KVM and an external kernel boot of the vmlinux file (the elf file)
> 
> e.g.
> 
> qemu-system-s390 -enable-kvm -nographic -kernel vmlinux -append "this string no longer is command line"
> 
> The compressed image (bzImage) seems to work fine though.
> 
> This seems to be an unfortunate side effect of QEMUs ways to "guess" its Linux (checking for start
> address 0x10000, which is no longer true for the vmlinux file). With the pure vmlinux elf file
> the load address is 0x100000 as there is no unpacker.
> 
> Guenter, can you check if arch/s390/boot/bzImage works for you as a workaround?

Something like this in QEMU 

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index f278036fa7..14153ce880 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -187,11 +187,13 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
          */
         if (pentry == KERN_IMAGE_START || pentry == 0x800) {
             ipl->start_addr = KERN_IMAGE_START;
-            /* Overwrite parameters in the kernel image, which are "rom" */
-            strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);
         } else {
             ipl->start_addr = pentry;
         }
+       if (ipl->cmdline) {
+            /* If there is a command line, put it in the right place */
+            strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);
+       }
 
         if (ipl->initrd) {
             ram_addr_t initrd_offset;

would put the command line in no matter what the start address is.
