Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8CBC433EF
	for <linux-s390@archiver.kernel.org>; Fri, 26 Nov 2021 08:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359462AbhKZIcg (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 26 Nov 2021 03:32:36 -0500
Received: from mga01.intel.com ([192.55.52.88]:42677 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347286AbhKZIag (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 26 Nov 2021 03:30:36 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="259533058"
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="259533058"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 00:22:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="539184991"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 26 Nov 2021 00:22:20 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqWUu-0007pJ-0X; Fri, 26 Nov 2021 08:22:20 +0000
Date:   Fri, 26 Nov 2021 16:21:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-s390@vger.kernel.org,
        kexec@lists.infradead.org, hca@linux.ibm.com, prudo@redhat.com,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2 1/2] s390/kexec: check the return value of
 ipl_report_finish
Message-ID: <202111261649.WZQbFG5g-lkp@intel.com>
References: <20211116032557.14075-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116032557.14075-1-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Baoquan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on s390/features]
[also build test WARNING on kvms390/next]
[cannot apply to linux/master linus/master v5.16-rc2 next-20211126]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Baoquan-He/s390-kexec-check-the-return-value-of-ipl_report_finish/20211116-112827
base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20211126/202111261649.WZQbFG5g-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/27ed543b2d76a1d948c64d4404c180ba31ca8cff
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Baoquan-He/s390-kexec-check-the-return-value-of-ipl_report_finish/20211116-112827
        git checkout 27ed543b2d76a1d948c64d4404c180ba31ca8cff
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/s390/kernel/ipl.c: In function 'ipl_report_finish':
>> arch/s390/kernel/ipl.c:2159:24: warning: returning 'void *' from a function with return type 'int' makes integer from pointer without a cast [-Wint-conversion]
    2159 |                 return ERR_PTR(-ENOMEM);
         |                        ^~~~~~~~~~~~~~~~


vim +2159 arch/s390/kernel/ipl.c

937347ac56bfca Martin Schwidefsky 2019-02-25  2146  
27ed543b2d76a1 Baoquan He         2021-11-16  2147  int ipl_report_finish(struct ipl_report *report, void **ipl_buf)
937347ac56bfca Martin Schwidefsky 2019-02-25  2148  {
937347ac56bfca Martin Schwidefsky 2019-02-25  2149  	struct ipl_report_certificate *cert;
937347ac56bfca Martin Schwidefsky 2019-02-25  2150  	struct ipl_report_component *comp;
937347ac56bfca Martin Schwidefsky 2019-02-25  2151  	struct ipl_rb_certificates *certs;
937347ac56bfca Martin Schwidefsky 2019-02-25  2152  	struct ipl_parameter_block *ipib;
937347ac56bfca Martin Schwidefsky 2019-02-25  2153  	struct ipl_rb_components *comps;
937347ac56bfca Martin Schwidefsky 2019-02-25  2154  	struct ipl_rl_hdr *rl_hdr;
937347ac56bfca Martin Schwidefsky 2019-02-25  2155  	void *buf, *ptr;
937347ac56bfca Martin Schwidefsky 2019-02-25  2156  
937347ac56bfca Martin Schwidefsky 2019-02-25  2157  	buf = vzalloc(report->size);
937347ac56bfca Martin Schwidefsky 2019-02-25  2158  	if (!buf)
937347ac56bfca Martin Schwidefsky 2019-02-25 @2159  		return ERR_PTR(-ENOMEM);
937347ac56bfca Martin Schwidefsky 2019-02-25  2160  	ptr = buf;
937347ac56bfca Martin Schwidefsky 2019-02-25  2161  
937347ac56bfca Martin Schwidefsky 2019-02-25  2162  	memcpy(ptr, report->ipib, report->ipib->hdr.len);
937347ac56bfca Martin Schwidefsky 2019-02-25  2163  	ipib = ptr;
937347ac56bfca Martin Schwidefsky 2019-02-25  2164  	if (ipl_secure_flag)
937347ac56bfca Martin Schwidefsky 2019-02-25  2165  		ipib->hdr.flags |= IPL_PL_FLAG_SIPL;
937347ac56bfca Martin Schwidefsky 2019-02-25  2166  	ipib->hdr.flags |= IPL_PL_FLAG_IPLSR;
937347ac56bfca Martin Schwidefsky 2019-02-25  2167  	ptr += report->ipib->hdr.len;
937347ac56bfca Martin Schwidefsky 2019-02-25  2168  	ptr = PTR_ALIGN(ptr, 8);
937347ac56bfca Martin Schwidefsky 2019-02-25  2169  
937347ac56bfca Martin Schwidefsky 2019-02-25  2170  	rl_hdr = ptr;
937347ac56bfca Martin Schwidefsky 2019-02-25  2171  	ptr += sizeof(*rl_hdr);
937347ac56bfca Martin Schwidefsky 2019-02-25  2172  
937347ac56bfca Martin Schwidefsky 2019-02-25  2173  	comps = ptr;
937347ac56bfca Martin Schwidefsky 2019-02-25  2174  	comps->rbt = IPL_RBT_COMPONENTS;
937347ac56bfca Martin Schwidefsky 2019-02-25  2175  	ptr += sizeof(*comps);
937347ac56bfca Martin Schwidefsky 2019-02-25  2176  	list_for_each_entry(comp, &report->components, list) {
937347ac56bfca Martin Schwidefsky 2019-02-25  2177  		memcpy(ptr, &comp->entry, sizeof(comp->entry));
937347ac56bfca Martin Schwidefsky 2019-02-25  2178  		ptr += sizeof(comp->entry);
937347ac56bfca Martin Schwidefsky 2019-02-25  2179  	}
937347ac56bfca Martin Schwidefsky 2019-02-25  2180  	comps->len = ptr - (void *)comps;
937347ac56bfca Martin Schwidefsky 2019-02-25  2181  
937347ac56bfca Martin Schwidefsky 2019-02-25  2182  	certs = ptr;
937347ac56bfca Martin Schwidefsky 2019-02-25  2183  	certs->rbt = IPL_RBT_CERTIFICATES;
937347ac56bfca Martin Schwidefsky 2019-02-25  2184  	ptr += sizeof(*certs);
937347ac56bfca Martin Schwidefsky 2019-02-25  2185  	list_for_each_entry(cert, &report->certificates, list) {
937347ac56bfca Martin Schwidefsky 2019-02-25  2186  		memcpy(ptr, &cert->entry, sizeof(cert->entry));
937347ac56bfca Martin Schwidefsky 2019-02-25  2187  		ptr += sizeof(cert->entry);
937347ac56bfca Martin Schwidefsky 2019-02-25  2188  	}
937347ac56bfca Martin Schwidefsky 2019-02-25  2189  	certs->len = ptr - (void *)certs;
937347ac56bfca Martin Schwidefsky 2019-02-25  2190  	rl_hdr->len = ptr - (void *)rl_hdr;
937347ac56bfca Martin Schwidefsky 2019-02-25  2191  
937347ac56bfca Martin Schwidefsky 2019-02-25  2192  	list_for_each_entry(cert, &report->certificates, list) {
937347ac56bfca Martin Schwidefsky 2019-02-25  2193  		memcpy(ptr, cert->key, cert->entry.len);
937347ac56bfca Martin Schwidefsky 2019-02-25  2194  		ptr += cert->entry.len;
937347ac56bfca Martin Schwidefsky 2019-02-25  2195  	}
937347ac56bfca Martin Schwidefsky 2019-02-25  2196  
937347ac56bfca Martin Schwidefsky 2019-02-25  2197  	BUG_ON(ptr > buf + report->size);
27ed543b2d76a1 Baoquan He         2021-11-16  2198  	*ipl_buf = buf;
27ed543b2d76a1 Baoquan He         2021-11-16  2199  
27ed543b2d76a1 Baoquan He         2021-11-16  2200  	return 0;
937347ac56bfca Martin Schwidefsky 2019-02-25  2201  }
937347ac56bfca Martin Schwidefsky 2019-02-25  2202  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
