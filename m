Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39748C6FD19
	for <linux-s390@archiver.kernel.org>; Thu, 16 Mar 2023 09:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCPJdc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 16 Mar 2023 05:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjCPJdb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Mar 2023 05:33:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CB246173
        for <linux-s390@vger.kernel.org>; Thu, 16 Mar 2023 02:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678959210; x=1710495210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Es8gXpWFt4PFKee/2ySsCx37zzXpOdN7ikcR/wK0ZBA=;
  b=TndH2+O0czRxu+TiDSHNSVxa4oGAD2TM91a0sxkX5jTawZp0nU+XpiyK
   gAOOCAhSquzRMNFb+2EcppZDA9ol5clPVhxneDz8D8r/Le7XAZWF+RGcO
   ZLBGJGyCepuN9tC7rvlKTpwXRsSPET/kklE38Y9IbL3KHJMrITV9QBITM
   b93iYlBjhmxIs1dpec/8hP9jl2sviQKUajA0M526HVhutzyy3Ih3LFKUF
   4GFEtJ7Gl+4fS9CQEhMyQTiTDO3HvpT8V+0niPf4AQL2Vk8GuNi8oJJxI
   ebpXcfbXzXTJ3tJdqqpvUdSD9LSdrJ/3oImWnU7MZ+4vqKljAZBza5Luq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="339466429"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="339466429"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 02:33:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="710026418"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="710026418"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 16 Mar 2023 02:33:26 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcjzC-0008RU-0f;
        Thu, 16 Mar 2023 09:33:26 +0000
Date:   Thu, 16 Mar 2023 17:32:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>, akpm@linux-foundation.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v2 3/6] mm: Add VM_FAULT_ARCH_* codes
Message-ID: <202303161725.tJspbzJz-lkp@intel.com>
References: <20230315030359.14162-4-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315030359.14162-4-palmer@rivosinc.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Palmer,

I love your patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Palmer-Dabbelt/riscv-mm-fault-simplify-code-for-do_page_fault/20230315-111507
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230315030359.14162-4-palmer%40rivosinc.com
patch subject: [PATCH v2 3/6] mm: Add VM_FAULT_ARCH_* codes
config: s390-randconfig-r044-20230312 (https://download.01.org/0day-ci/archive/20230316/202303161725.tJspbzJz-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d25cdd69b804d954e31ad8835750a8707e11af32
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Palmer-Dabbelt/riscv-mm-fault-simplify-code-for-do_page_fault/20230315-111507
        git checkout d25cdd69b804d954e31ad8835750a8707e11af32
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303161725.tJspbzJz-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:102,
                    from include/trace/events/fs_dax.h:286,
                    from fs/dax.c:31:
   include/trace/events/fs_dax.h: In function 'trace_raw_output_dax_pmd_fault_class':
>> include/trace/stages/stage3_trace_output.h:70:37: error: expected expression before ',' token
      70 |                         { flag_array, { -1, NULL }};                    \
         |                                     ^
   include/trace/trace_events.h:203:34: note: in definition of macro 'DECLARE_EVENT_CLASS'
     203 |         trace_event_printf(iter, print);                                \
         |                                  ^~~~~
   include/trace/events/fs_dax.h:38:9: note: in expansion of macro 'TP_printk'
      38 |         TP_printk("dev %d:%d ino %#lx %s %s address %#lx vm_start "
         |         ^~~~~~~~~
   include/trace/events/fs_dax.h:50:17: note: in expansion of macro '__print_flags'
      50 |                 __print_flags(__entry->result, "|", VM_FAULT_RESULT_TRACE)
         |                 ^~~~~~~~~~~~~
   include/trace/events/fs_dax.h: In function 'trace_raw_output_dax_pte_fault_class':
>> include/trace/stages/stage3_trace_output.h:70:37: error: expected expression before ',' token
      70 |                         { flag_array, { -1, NULL }};                    \
         |                                     ^
   include/trace/trace_events.h:203:34: note: in definition of macro 'DECLARE_EVENT_CLASS'
     203 |         trace_event_printf(iter, print);                                \
         |                                  ^~~~~
   include/trace/events/fs_dax.h:174:9: note: in expansion of macro 'TP_printk'
     174 |         TP_printk("dev %d:%d ino %#lx %s %s address %#lx pgoff %#lx %s",
         |         ^~~~~~~~~
   include/trace/events/fs_dax.h:182:17: note: in expansion of macro '__print_flags'
     182 |                 __print_flags(__entry->result, "|", VM_FAULT_RESULT_TRACE)
         |                 ^~~~~~~~~~~~~


vim +70 include/trace/stages/stage3_trace_output.h

1bc191051dca28 include/trace/stages/stage3_defines.h Linus Torvalds          2022-03-23  65  
af6b9668e85ffd include/trace/stages/stage3_defines.h Steven Rostedt (Google  2022-03-03  66) #undef __print_flags
af6b9668e85ffd include/trace/stages/stage3_defines.h Steven Rostedt (Google  2022-03-03  67) #define __print_flags(flag, delim, flag_array...)			\
af6b9668e85ffd include/trace/stages/stage3_defines.h Steven Rostedt (Google  2022-03-03  68) 	({								\
af6b9668e85ffd include/trace/stages/stage3_defines.h Steven Rostedt (Google  2022-03-03  69) 		static const struct trace_print_flags __flags[] =	\
af6b9668e85ffd include/trace/stages/stage3_defines.h Steven Rostedt (Google  2022-03-03 @70) 			{ flag_array, { -1, NULL }};			\
af6b9668e85ffd include/trace/stages/stage3_defines.h Steven Rostedt (Google  2022-03-03  71) 		trace_print_flags_seq(p, delim, flag, __flags);	\
af6b9668e85ffd include/trace/stages/stage3_defines.h Steven Rostedt (Google  2022-03-03  72) 	})
af6b9668e85ffd include/trace/stages/stage3_defines.h Steven Rostedt (Google  2022-03-03  73) 

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
