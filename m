From: Guenter Roeck <linux@roeck-us.net>
Subject: Build failures (s390) in -next due to 'mm, printk: introduce new
 format string for flags'
Date: Fri, 29 Jan 2016 07:35:22 -0800
Message-ID: <56AB86BA.8020507@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

s390 builds in -next fail with lots of errors such as:

include/linux/jump_label.h: In function 'static_key_count':
include/linux/jump_label.h:122:2: error: implicit declaration of function 'atomic_read' [-Werror=implicit-function-declaration]
   return atomic_read(&key->enabled);
...
./arch/s390/include/asm/atomic.h: At top level:
./arch/s390/include/asm/atomic.h:74:19: error: static declaration of 'atomic_read' follows non-static declaration
  static inline int atomic_read(const atomic_t *v)

As far as I can see this is due to recursive inclusion of linux/atomic.h
(which in turn is triggered by recursive inclusion of linux/mmdebug.h).

I was able to "fix" the problem by removing the inclusion of mmdebug.h from
arch/s390/include/asm/cmpxchg.h. That is not a proper fix, though, since the file
uses VM_BUG_ON(), which is defined in mmdebug.h.

The problem was introduced with 'mm, printk: introduce new format string for flags'.

Guenter
