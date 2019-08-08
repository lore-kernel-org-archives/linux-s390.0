Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:45885 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727884AbfHHCly (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 7 Aug 2019 22:41:54 -0400
Date: Thu, 8 Aug 2019 10:41:27 +0800
From: kbuild test robot <lkp@intel.com>
Subject: [s390:zlib 2/5] include/asm-generic/bug.h:199:2: error: implicit
 declaration of function 'no_printk'; did you mean '__printf'?
Message-ID: <201908081024.7BR7jqP5%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k5d27gsqtsqp4ijg"
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc: kbuild-all@01.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>


--k5d27gsqtsqp4ijg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/s390/linux.git zlib
head:   cd020aae5488f8576ee8c289b7c32fb4a05f60bb
commit: 01d3bf07477782187e2fbc217977e405b5faefa4 [2/5] Add s390 hardware support for kernel zlib_inflate
config: arm-allnoconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 01d3bf07477782187e2fbc217977e405b5faefa4
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=arm 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arm/include/asm/bug.h:60:0,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:12,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arm/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:10,
                    from arch/arm/boot/compressed/../../../../lib/zlib_inflate/infutil.h:15,
                    from arch/arm/boot/compressed/../../../../lib/zlib_inflate/inflate.c:16,
                    from arch/arm/boot/compressed/../../../../lib/decompress_inflate.c:12,
                    from arch/arm/boot/compressed/decompress.c:38:
   include/linux/thread_info.h: In function 'copy_overflow':
>> include/asm-generic/bug.h:199:2: error: implicit declaration of function 'no_printk'; did you mean '__printf'? [-Werror=implicit-function-declaration]
     no_printk(format);      \
     ^
   include/linux/thread_info.h:134:2: note: in expansion of macro 'WARN'
     WARN(1, "Buffer overflow detected (%d < %lu)!\n", size, count);
     ^~~~
   In file included from include/linux/spinlock.h:58:0,
                    from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:10,
                    from arch/arm/boot/compressed/../../../../lib/zlib_inflate/infutil.h:15,
                    from arch/arm/boot/compressed/../../../../lib/zlib_inflate/inflate.c:16,
                    from arch/arm/boot/compressed/../../../../lib/decompress_inflate.c:12,
                    from arch/arm/boot/compressed/decompress.c:38:
   include/linux/bottom_half.h: In function 'local_bh_disable':
   include/linux/bottom_half.h:19:24: error: '_THIS_IP_' undeclared (first use in this function)
     __local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
                           ^~~~~~~~~
   include/linux/bottom_half.h:19:24: note: each undeclared identifier is reported only once for each function it appears in
   include/linux/bottom_half.h: In function 'local_bh_enable':
   include/linux/bottom_half.h:32:23: error: '_THIS_IP_' undeclared (first use in this function)
     __local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
                          ^~~~~~~~~
   In file included from include/linux/spinlock.h:318:0,
                    from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:10,
                    from arch/arm/boot/compressed/../../../../lib/zlib_inflate/infutil.h:15,
                    from arch/arm/boot/compressed/../../../../lib/zlib_inflate/inflate.c:16,
                    from arch/arm/boot/compressed/../../../../lib/decompress_inflate.c:12,
                    from arch/arm/boot/compressed/decompress.c:38:
   include/linux/spinlock.h: In function 'spin_lock_bh':
   include/linux/spinlock_api_up.h:34:30: error: '_THIS_IP_' undeclared (first use in this function)
      do { __local_bh_disable_ip(_THIS_IP_, SOFTIRQ_LOCK_OFFSET); ___LOCK(lock); } while (0)
                                 ^
   include/linux/spinlock_api_up.h:62:35: note: in expansion of macro '__LOCK_BH'
    #define _raw_spin_lock_bh(lock)   __LOCK_BH(lock)
                                      ^~~~~~~~~
   include/linux/spinlock.h:281:33: note: in expansion of macro '_raw_spin_lock_bh'
    #define raw_spin_lock_bh(lock)  _raw_spin_lock_bh(lock)
                                    ^~~~~~~~~~~~~~~~~
   include/linux/spinlock.h:343:2: note: in expansion of macro 'raw_spin_lock_bh'
     raw_spin_lock_bh(&lock->rlock);
     ^~~~~~~~~~~~~~~~
   include/linux/spinlock.h: In function 'spin_unlock_bh':
   include/linux/spinlock_api_up.h:49:29: error: '_THIS_IP_' undeclared (first use in this function)
      do { __local_bh_enable_ip(_THIS_IP_, SOFTIRQ_LOCK_OFFSET); \
                                ^
   include/linux/spinlock_api_up.h:78:36: note: in expansion of macro '__UNLOCK_BH'
    #define _raw_spin_unlock_bh(lock)  __UNLOCK_BH(lock)
                                       ^~~~~~~~~~~
   include/linux/spinlock.h:290:34: note: in expansion of macro '_raw_spin_unlock_bh'
    #define raw_spin_unlock_bh(lock) _raw_spin_unlock_bh(lock)
                                     ^~~~~~~~~~~~~~~~~~~
   include/linux/spinlock.h:383:2: note: in expansion of macro 'raw_spin_unlock_bh'
     raw_spin_unlock_bh(&lock->rlock);
     ^~~~~~~~~~~~~~~~~~
   In file included from <command-line>:0:0:
   include/linux/spinlock.h: In function 'spin_trylock_bh':
   include/linux/spinlock_api_up.h:34:30: error: '_THIS_IP_' undeclared (first use in this function)
      do { __local_bh_disable_ip(_THIS_IP_, SOFTIRQ_LOCK_OFFSET); ___LOCK(lock); } while (0)
                                 ^
   include/linux/compiler_types.h:45:28: note: in definition of macro '__cond_lock'
    # define __cond_lock(x,c) (c)
                               ^
   include/linux/spinlock_api_up.h:74:40: note: in expansion of macro '__LOCK_BH'
    #define _raw_spin_trylock_bh(lock)  ({ __LOCK_BH(lock); 1; })
                                           ^~~~~~~~~
   include/linux/spinlock.h:293:20: note: in expansion of macro '_raw_spin_trylock_bh'
     __cond_lock(lock, _raw_spin_trylock_bh(lock))
                       ^~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock.h:398:9: note: in expansion of macro 'raw_spin_trylock_bh'
     return raw_spin_trylock_bh(&lock->rlock);
            ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/log2.h:12:0,
                    from include/asm-generic/div64.h:53,
                    from arch/arm/include/asm/div64.h:127,
                    from include/linux/math64.h:6,
                    from include/linux/time64.h:5,
                    from include/linux/restart_block.h:10,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arm/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:10,
                    from arch/arm/boot/compressed/../../../../lib/zlib_inflate/infutil.h:15,
                    from arch/arm/boot/compressed/../../../../lib/zlib_inflate/inflate.c:16,
                    from arch/arm/boot/compressed/../../../../lib/decompress_inflate.c:12,
                    from arch/arm/boot/compressed/decompress.c:38:
   include/linux/bitmap.h: In function 'bitmap_zero':
   include/linux/bitops.h:8:27: error: implicit declaration of function 'DIV_ROUND_UP'; did you mean 'DIV64_U64_ROUND_UP'? [-Werror=implicit-function-declaration]
    #define BITS_TO_LONGS(nr) DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
                              ^
   include/linux/bitmap.h:217:21: note: in expansion of macro 'BITS_TO_LONGS'
     unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
--
     container_of(ptr, type, member)
                       ^~~~
   include/linux/mmzone.h:141:9: note: in expansion of macro 'list_first_entry_or_null'
     return list_first_entry_or_null(&area->free_list[migratetype],
            ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/srcu.h:47:0,
                    from include/linux/notifier.h:16,
                    from include/linux/memory_hotplug.h:7,
                    from include/linux/mmzone.h:802,
                    from include/linux/gfp.h:6,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:13,
                    from arch/arm/boot/compressed/../../../../lib/zlib_inflate/infutil.h:15,
                    from arch/arm/boot/compressed/../../../../lib/zlib_inflate/inflate.c:16,
                    from arch/arm/boot/compressed/../../../../lib/decompress_inflate.c:12,
                    from arch/arm/boot/compressed/decompress.c:38:
   include/linux/srcutiny.h: In function 'srcu_torture_stats_print':
   include/linux/srcutiny.h:84:2: error: implicit declaration of function 'pr_alert' [-Werror=implicit-function-declaration]
     pr_alert("%s%s Tiny SRCU per-CPU(idx=%d): (%hd,%hd)\n",
     ^~~~~~~~
   In file included from include/linux/mmzone.h:802:0,
                    from include/linux/gfp.h:6,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:13,
                    from arch/arm/boot/compressed/../../../../lib/zlib_inflate/infutil.h:15,
                    from arch/arm/boot/compressed/../../../../lib/zlib_inflate/inflate.c:16,
                    from arch/arm/boot/compressed/../../../../lib/decompress_inflate.c:12,
                    from arch/arm/boot/compressed/decompress.c:38:
   include/linux/memory_hotplug.h: In function 'mhp_notimplemented':
   include/linux/memory_hotplug.h:268:2: error: implicit declaration of function 'printk'; did you mean '__printf'? [-Werror=implicit-function-declaration]
     printk(KERN_WARNING "%s() called, with CONFIG_MEMORY_HOTPLUG disabled\n", func);
     ^~~~~~
     __printf
   include/linux/memory_hotplug.h:268:9: error: 'KERN_WARNING' undeclared (first use in this function); did you mean 'WARN_TAINT'?
     printk(KERN_WARNING "%s() called, with CONFIG_MEMORY_HOTPLUG disabled\n", func);
            ^~~~~~~~~~~~
            WARN_TAINT
   include/linux/memory_hotplug.h:268:22: error: expected ')' before string constant
     printk(KERN_WARNING "%s() called, with CONFIG_MEMORY_HOTPLUG disabled\n", func);
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/memory_hotplug.h:269:2: error: implicit declaration of function 'dump_stack'; did you mean 'dump_vma'? [-Werror=implicit-function-declaration]
     dump_stack();
     ^~~~~~~~~~
     dump_vma
   In file included from include/linux/gfp.h:6:0,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:13,
                    from arch/arm/boot/compressed/../../../../lib/zlib_inflate/infutil.h:15,
                    from arch/arm/boot/compressed/../../../../lib/zlib_inflate/inflate.c:16,
                    from arch/arm/boot/compressed/../../../../lib/decompress_inflate.c:12,
                    from arch/arm/boot/compressed/decompress.c:38:
   include/linux/mmzone.h: In function 'lruvec_pgdat':
   include/linux/mmzone.h:829:30: error: expected expression before 'struct'
     return container_of(lruvec, struct pglist_data, lruvec);
                                 ^~~~~~
   In file included from include/linux/percpu.h:9:0,
                    from include/linux/topology.h:34,
                    from include/linux/gfp.h:9,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:13,
                    from arch/arm/boot/compressed/../../../../lib/zlib_inflate/infutil.h:15,
                    from arch/arm/boot/compressed/../../../../lib/zlib_inflate/inflate.c:16,
                    from arch/arm/boot/compressed/../../../../lib/decompress_inflate.c:12,
                    from arch/arm/boot/compressed/decompress.c:38:
   include/linux/printk.h: At top level:
   include/linux/printk.h:215:5: error: conflicting types for 'printk'
    int printk(const char *s, ...)
        ^~~~~~
   include/linux/printk.h:216:1: note: a parameter list with an ellipsis can't match an empty parameter name list declaration
    {
    ^
   In file included from include/linux/mmzone.h:802:0,
                    from include/linux/gfp.h:6,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:13,
                    from arch/arm/boot/compressed/../../../../lib/zlib_inflate/infutil.h:15,
                    from arch/arm/boot/compressed/../../../../lib/zlib_inflate/inflate.c:16,
                    from arch/arm/boot/compressed/../../../../lib/decompress_inflate.c:12,
                    from arch/arm/boot/compressed/decompress.c:38:
   include/linux/memory_hotplug.h:268:2: note: previous implicit declaration of 'printk' was here
     printk(KERN_WARNING "%s() called, with CONFIG_MEMORY_HOTPLUG disabled\n", func);
     ^~~~~~
   In file included from include/linux/percpu.h:9:0,
                    from include/linux/topology.h:34,
                    from include/linux/gfp.h:9,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:13,
                    from arch/arm/boot/compressed/../../../../lib/zlib_inflate/infutil.h:15,
                    from arch/arm/boot/compressed/../../../../lib/zlib_inflate/inflate.c:16,
                    from arch/arm/boot/compressed/../../../../lib/decompress_inflate.c:12,
                    from arch/arm/boot/compressed/decompress.c:38:
   include/linux/printk.h:268:20: warning: conflicting types for 'dump_stack'
    static inline void dump_stack(void)
                       ^~~~~~~~~~
>> include/linux/printk.h:268:20: error: static declaration of 'dump_stack' follows non-static declaration
   In file included from include/linux/mmzone.h:802:0,
                    from include/linux/gfp.h:6,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:13,
                    from arch/arm/boot/compressed/../../../../lib/zlib_inflate/infutil.h:15,
                    from arch/arm/boot/compressed/../../../../lib/zlib_inflate/inflate.c:16,
                    from arch/arm/boot/compressed/../../../../lib/decompress_inflate.c:12,
                    from arch/arm/boot/compressed/decompress.c:38:
   include/linux/memory_hotplug.h:269:2: note: previous implicit declaration of 'dump_stack' was here
     dump_stack();
     ^~~~~~~~~~
   In file included from include/linux/radix-tree.h:18:0,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:13,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/module.h:17,
                    from arch/arm/boot/compressed/../../../../lib/zlib_inflate/infutil.h:15,
                    from arch/arm/boot/compressed/../../../../lib/zlib_inflate/inflate.c:16,
                    from arch/arm/boot/compressed/../../../../lib/decompress_inflate.c:12,
                    from arch/arm/boot/compressed/decompress.c:38:
   include/linux/xarray.h:1100:17: error: variably modified 'tags' at file scope
      unsigned long tags[XA_MAX_MARKS][XA_MARK_LONGS];
                    ^~~~
   include/linux/xarray.h:1101:17: error: variably modified 'marks' at file scope
      unsigned long marks[XA_MAX_MARKS][XA_MARK_LONGS];
                    ^~~~~
   In file included from include/linux/module.h:17:0,
                    from arch/arm/boot/compressed/../../../../lib/zlib_inflate/infutil.h:15,
                    from arch/arm/boot/compressed/../../../../lib/zlib_inflate/inflate.c:16,
                    from arch/arm/boot/compressed/../../../../lib/decompress_inflate.c:12,
                    from arch/arm/boot/compressed/decompress.c:38:
   include/linux/kobject.h: In function 'to_kset':
   include/linux/kobject.h:209:35: error: expected expression before 'struct'
     return kobj ? container_of(kobj, struct kset, kobj) : NULL;
                                      ^~~~~~
   In file included from include/linux/module.h:21:0,
                    from arch/arm/boot/compressed/../../../../lib/zlib_inflate/infutil.h:15,
                    from arch/arm/boot/compressed/../../../../lib/zlib_inflate/inflate.c:16,
                    from arch/arm/boot/compressed/../../../../lib/decompress_inflate.c:12,
                    from arch/arm/boot/compressed/decompress.c:38:
   include/linux/rbtree_latch.h: In function '__lt_from_rb':
   include/linux/rbtree_latch.h:72:28: error: expected expression before 'struct'
     return container_of(node, struct latch_tree_node, node[idx]);
                               ^~~~~~
   cc1: some warnings being treated as errors

vim +199 include/asm-generic/bug.h

b607e70ec6a982 Josh Triplett 2014-04-07  195  
b607e70ec6a982 Josh Triplett 2014-04-07  196  #ifndef WARN
b607e70ec6a982 Josh Triplett 2014-04-07  197  #define WARN(condition, format...) ({					\
b607e70ec6a982 Josh Triplett 2014-04-07  198  	int __ret_warn_on = !!(condition);				\
4e50ebde32bed6 Josh Triplett 2014-04-07 @199  	no_printk(format);						\
b607e70ec6a982 Josh Triplett 2014-04-07  200  	unlikely(__ret_warn_on);					\
b607e70ec6a982 Josh Triplett 2014-04-07  201  })
b607e70ec6a982 Josh Triplett 2014-04-07  202  #endif
b607e70ec6a982 Josh Triplett 2014-04-07  203  

:::::: The code at line 199 was first introduced by commit
:::::: 4e50ebde32bed67a9aec8c239bbd89e5d0b8727b bug: when !CONFIG_BUG, make WARN call no_printk to check format and args

:::::: TO: Josh Triplett <josh@joshtriplett.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--k5d27gsqtsqp4ijg
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
yyHfVwAA

--k5d27gsqtsqp4ijg--
