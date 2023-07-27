Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACDBC0015E
	for <linux-s390@archiver.kernel.org>; Thu, 27 Jul 2023 17:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjG0RDZ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 27 Jul 2023 13:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjG0RDT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 27 Jul 2023 13:03:19 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924972701;
        Thu, 27 Jul 2023 10:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690477396; x=1722013396;
  h=date:from:to:cc:subject:message-id;
  bh=+Ww5693C/UDK3tNyftzRZzJEBm3+QYIP8agAOrPSnmo=;
  b=UQC21rs0sA3nUsSLXSnFr3h+Gue4L8qLB/eO/dl8ZCRGfNurFSNWMO/K
   m80atDWVgi31+k/s4VxHmDHAOys0p0ZETcjnnv5X9Vjp3aKdC9H8bFn8o
   IF2W/3+5+0noE96ahQk7NcJDIKUYDo/ysN7lwasfvtBItt4w6Mf4Y3q9h
   yKknzXzULOnzgGU5vTQhzqNO7b8hAc0bUAG7SnjLYwOkybRC/kU/BkjP3
   5dr0DcB0LmcAJx9sqOSVAGqbmoUQy4+hhpbItmTZUXxpDlkDvlSVQ961E
   9LmoqGuO/PgFa72qyaU87FfB/leKd606h1J55v9v5DGdZ+6ehcuvhmm30
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="353285657"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="353285657"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 10:01:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="900928144"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="900928144"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 27 Jul 2023 10:01:25 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qP4Mf-0002RL-0A;
        Thu, 27 Jul 2023 17:01:25 +0000
Date:   Fri, 28 Jul 2023 01:01:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        linux-s390@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [linux-next:master] BUILD REGRESSION
 451cc82bd11eb6a374f4dbcfc1cf007eafea91ab
Message-ID: <202307280106.CXKJsML9-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 451cc82bd11eb6a374f4dbcfc1cf007eafea91ab  Add linux-next specific files for 20230727

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202307181450.sfbuvMf5-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202307251531.p8ZLFTMZ-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

../lib/gcc/loongarch64-linux/12.3.0/plugin/include/config/loongarch/loongarch-opts.h:31:10: fatal error: loongarch-def.h: No such file or directory
arch/s390/kernel/mcount.S:133:2: error: instruction requires: distinct-ops
drivers/regulator/max77857-regulator.c:312:16: error: initializer element is not a compile-time constant
drivers/regulator/max77857-regulator.c:56:24: warning: cast to smaller integer type 'enum max77857_id' from 'void *' [-Wvoid-pointer-to-enum-cast]

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/tty/serial/8250/8250_men_mcb.c:218 serial_8250_men_mcb_probe() warn: unsigned 'data->line[i]' is never less than zero.

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-m021-20230727
|   `-- drivers-tty-serial-8250_men_mcb.c-serial_8250_men_mcb_probe()-warn:unsigned-data-line-i-is-never-less-than-zero.
|-- loongarch-allmodconfig
|   `-- lib-gcc-loongarch64-linux-..-plugin-include-config-loongarch-loongarch-opts.h:fatal-error:loongarch-def.h:No-such-file-or-directory
`-- loongarch-randconfig-r005-20230727
    `-- lib-gcc-loongarch64-linux-..-plugin-include-config-loongarch-loongarch-opts.h:fatal-error:loongarch-def.h:No-such-file-or-directory
clang_recent_errors
|-- arm64-randconfig-r032-20230727
|   |-- drivers-regulator-max77857-regulator.c:error:initializer-element-is-not-a-compile-time-constant
|   `-- drivers-regulator-max77857-regulator.c:warning:cast-to-smaller-integer-type-enum-max77857_id-from-void
|-- i386-randconfig-i006-20230727
|   `-- drivers-regulator-max77857-regulator.c:error:initializer-element-is-not-a-compile-time-constant
|-- i386-randconfig-r006-20230727
|   `-- drivers-regulator-max77857-regulator.c:error:initializer-element-is-not-a-compile-time-constant
`-- s390-randconfig-r016-20230726
    `-- arch-s390-kernel-mcount.S:error:instruction-requires:distinct-ops

elapsed time: 722m

configs tested: 113
configs skipped: 7

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r012-20230727   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r036-20230727   gcc  
arc                  randconfig-r043-20230727   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   gcc  
arm                      footbridge_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                          pxa168_defconfig   clang
arm                  randconfig-r033-20230727   gcc  
arm                  randconfig-r046-20230727   clang
arm                        shmobile_defconfig   gcc  
arm                       versatile_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r032-20230727   clang
csky                                defconfig   gcc  
hexagon              randconfig-r011-20230727   clang
hexagon              randconfig-r041-20230727   clang
hexagon              randconfig-r045-20230727   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230727   clang
i386                 randconfig-i002-20230727   clang
i386                 randconfig-i003-20230727   clang
i386                 randconfig-i004-20230727   clang
i386                 randconfig-i005-20230727   clang
i386                 randconfig-i006-20230727   clang
i386                 randconfig-i011-20230727   gcc  
i386                 randconfig-i012-20230727   gcc  
i386                 randconfig-i013-20230727   gcc  
i386                 randconfig-i014-20230727   gcc  
i386                 randconfig-i015-20230727   gcc  
i386                 randconfig-i016-20230727   gcc  
i386                 randconfig-r006-20230727   clang
i386                 randconfig-r013-20230727   gcc  
i386                 randconfig-r021-20230727   gcc  
i386                 randconfig-r023-20230727   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230727   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r031-20230727   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1000-neo_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r024-20230727   gcc  
nios2                randconfig-r033-20230726   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230727   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                      ppc40x_defconfig   gcc  
powerpc                      ppc44x_defconfig   clang
powerpc                         wii_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r016-20230727   gcc  
riscv                randconfig-r034-20230727   clang
riscv                randconfig-r042-20230727   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230727   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r003-20230727   gcc  
sh                           se7750_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r026-20230727   gcc  
um                               alldefconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r035-20230727   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r014-20230727   gcc  
x86_64               randconfig-x001-20230727   gcc  
x86_64               randconfig-x002-20230727   gcc  
x86_64               randconfig-x003-20230727   gcc  
x86_64               randconfig-x004-20230727   gcc  
x86_64               randconfig-x005-20230727   gcc  
x86_64               randconfig-x006-20230727   gcc  
x86_64               randconfig-x011-20230727   clang
x86_64               randconfig-x012-20230727   clang
x86_64               randconfig-x013-20230727   clang
x86_64               randconfig-x014-20230727   clang
x86_64               randconfig-x015-20230727   clang
x86_64               randconfig-x016-20230727   clang
x86_64                          rhel-8.3-rust   clang
xtensa               randconfig-r002-20230727   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
