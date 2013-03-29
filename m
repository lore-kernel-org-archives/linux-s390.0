From: Fengguang Wu <fengguang.wu@intel.com>
Date: Fri, 29 Mar 2013 02:14:16 +0000
Subject: drivers/tty/serial/serial_core.c:694:2: error: implicit declaration of function 'irq_canonicalize'
Message-Id: <20130329021416.GA9131@localhost>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

FYI, a long standing build error related to s390.

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux master
head:   9064171268d838b8f283fe111ef086b9479d059a
commit: ab4382d27412e7e3e7c936e8d50d8888dfac3df8 tty: move drivers/serial/ to drivers/tty/serial/
date:   2 years, 2 months ago
config: make ARCH=s390 allmodconfig

All error/warnings:

   drivers/tty/serial/serial_core.c: In function 'uart_set_info':
>> drivers/tty/serial/serial_core.c:694:2: error: implicit declaration of function 'irq_canonicalize' [-Werror=implicit-function-declaration]
   drivers/tty/serial/serial_core.c: In function 'uart_suspend_port':
   drivers/tty/serial/serial_core.c:1979:21: warning: variable 'tty' set but not used [-Wunused-but-set-variable]
   cc1: some warnings being treated as errors

vim +/irq_canonicalize +694 drivers/tty/serial/serial_core.c

^1da177e drivers/serial/serial_core.c Linus Torvalds 2005-04-16  688  		return -EFAULT;
^1da177e drivers/serial/serial_core.c Linus Torvalds 2005-04-16  689  
^1da177e drivers/serial/serial_core.c Linus Torvalds 2005-04-16  690  	new_port = new_serial.port;
^1da177e drivers/serial/serial_core.c Linus Torvalds 2005-04-16  691  	if (HIGH_BITS_OFFSET)
^1da177e drivers/serial/serial_core.c Linus Torvalds 2005-04-16  692  		new_port += (unsigned long) new_serial.port_high << HIGH_BITS_OFFSET;
^1da177e drivers/serial/serial_core.c Linus Torvalds 2005-04-16  693  
^1da177e drivers/serial/serial_core.c Linus Torvalds 2005-04-16 @694  	new_serial.irq = irq_canonicalize(new_serial.irq);
^1da177e drivers/serial/serial_core.c Linus Torvalds 2005-04-16  695  	close_delay = new_serial.close_delay * 10;
^1da177e drivers/serial/serial_core.c Linus Torvalds 2005-04-16  696  	closing_wait = new_serial.closing_wait == ASYNC_CLOSING_WAIT_NONE ?
016af53a drivers/serial/serial_core.c Alan Cox       2009-09-19  697  			ASYNC_CLOSING_WAIT_NONE : new_serial.closing_wait * 10;



---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
