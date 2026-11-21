Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795262541;
	b=HmF1gsdBcBrB93a/FD33f8hlO5btIRCGQYnKuvvJeJc2fZq3XGipotWGxUlSmVs7k15n
	 CW8dhwoqvDKHA+EgY9mdEor1zZMvTp8tT56bOwQ1DH/E2cP+kTvoiVIfu7t9H58KiwjJV
	 nhadvD8PpFvx4LduyoZTXG93TwQttjAK3kuBVZCvIxN3QZ2dHxCphWrzDRvQgco/aGfLy
	 eOFmo53APQ96A0CG9HrKwKpEBChdNBKR1Xgtc1VdZJsQjGEYthboPK+8mJSQsOHtay1lF
	 18sKfmy7Ij3K/8Qxx4wH/Ihi6iaYVcPLR/EiutjF4/XphFuDwBNkGiqa0e8ar5Y7Uyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795262541;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=PbAv1us9HdouZq9hBUL7raj+IUgCOfT9Bkr5fu4RIiw=;
	b=5GDQz0EK8rG6Yxox1fWYITTUrIn5pbmtYmqlAThhc52bj4YQ3DRnRd8601ELSJTabBHB
	 PXXbU+3rvQulhF0Z+fUT36lRAgERgXGZvHsK7MDx4ppWgKhZ2bjCuMDdygw7LFncxZspC
	 Zng1J7IW8lsRqfzHUpKahfm5ehqER3zI+lHjOYRZbYqtklxkLdJKK5QAawQVZ9cxSN56J
	 VeF8Ot0yHsHpHPUjRqFk8xEMPn5OkLER5C2TbGZQTmStFr1dViw0f6rAGy3oG6wUxh68h
	 sG1uWxC0SLcTfaYpRkiyEnbOwhC2yv4ZmZEH5oEuHuC6jJ14dskWumnKu3pmlE8LT0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TaDV1DCl;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD8D606A320;
	Sat, 21 Nov 2026 12:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FD8D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TaDV1DCl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795262541; x=1826798541;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YCdP8OB2HvkWl/omwLPrcGPAcUnRnZ92M0pgI5LSpjA=;
  b=TaDV1DCl9O/PHBijt0wA1BLgIhuh4c9e7PnvVkd5wvtSQt5c48XXfvzl
   xwB2ZOXR7wVgFm0vYbzV0DjRFDevchSQx1gp6HbhVALpICEWJmRbGCmvx
   4LN01J3EouT4G3vArS/sTkQEzVOZgOL8lfCa3RkYGvQKS53JjCSA0ZkLS
   ZnkzavdyWj9+m84cS/BZpojpCiT11aMxyfnNxo2MlehNazbzHRh8I/OvO
   ZTjp7yjg6jkXtNUaXLEyuYclFVe38jOsUX0sBP0qooXOUC1i0wy8LYvod
   OGennNhscxGs1qbjy85FLBI+YFz/hWVFElCJ0KLLEWM4qen9qP/7ePGo8
   A==;
X-CSE-ConnectionGUID: fOlZjXc8Q4iQo4XWB0wEsg==
X-CSE-MsgGUID: 1Og2H5ljR8+YdMYtnio/qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4118799"
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="4118799"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2026 04:02:09 -0800
X-CSE-ConnectionGUID: PcmNyewOSt6LniGQD01MiQ==
X-CSE-MsgGUID: +pivHS+iSOWajqfhEPoMtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="11199182"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 21 Nov 2026 04:02:03 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xUjn6-00000001Jzr-1GYu;
	Sat, 21 Nov 2026 12:02:00 +0000
Date: Sat, 21 Nov 2026 20:01:20 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolas Schier <nsc@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Nicolas Schier <nsc@kernel.org>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kbuild@vger.kernel.org, linux-s390@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org, "kernelci.org bot" <bot@kernelci.org>
Subject: Re: [PATCH] Move struct cpu_feature to a
 <linux/device-id/cpu_feature.h>
Message-ID: <202611211941.G0rlpNpN-lkp@intel.com>
References: <20261120202712.3377691-1-nsc@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120202712.3377691-1-nsc@kernel.org>

Hi Nicolas,

kernel test robot noticed the following build errors:

[auto build test ERROR on kvm/queue]
[also build test ERROR on kvm/next linus/master v7.4-rc3]
[cannot apply to kvm/linux-next next-20261119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nicolas-Schier/Move-struct-cpu_feature-to-a-linux-device-id-cpu_feature-h/20261120-212711
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
patch link:    https://lore.kernel.org/r/20261120202712.3377691-1-nsc%40kernel.org
patch subject: [PATCH] Move struct cpu_feature to a <linux/device-id/cpu_feature.h>
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20261121/202611211941.G0rlpNpN-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 3b14d7c370558b46e5f0c6494a05c492e59bf32c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261121/202611211941.G0rlpNpN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611211941.G0rlpNpN-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/s390/crypto/pkey_cca.c:22:45: error: array has incomplete element type 'struct ap_device_id'
      22 | static struct ap_device_id pkey_cca_card_ids[] = {
         |                                             ^
   drivers/s390/crypto/ap_bus.h:158:9: note: forward declaration of 'struct ap_device_id'
     158 |         struct ap_device_id *ids;
         |                ^
   1 error generated.
--
>> drivers/s390/crypto/pkey_ep11.c:23:46: error: array has incomplete element type 'struct ap_device_id'
      23 | static struct ap_device_id pkey_ep11_card_ids[] = {
         |                                              ^
   drivers/s390/crypto/ap_bus.h:158:9: note: forward declaration of 'struct ap_device_id'
     158 |         struct ap_device_id *ids;
         |                ^
   1 error generated.


vim +22 drivers/s390/crypto/pkey_cca.c

8fcc231ce3bea12 Harald Freudenberger 2024-08-22  20  
8fcc231ce3bea12 Harald Freudenberger 2024-08-22  21  #if IS_MODULE(CONFIG_PKEY_CCA)
8fcc231ce3bea12 Harald Freudenberger 2024-08-22 @22  static struct ap_device_id pkey_cca_card_ids[] = {
8fcc231ce3bea12 Harald Freudenberger 2024-08-22  23  	{ .dev_type = AP_DEVICE_TYPE_CEX4 },
8fcc231ce3bea12 Harald Freudenberger 2024-08-22  24  	{ .dev_type = AP_DEVICE_TYPE_CEX5 },
8fcc231ce3bea12 Harald Freudenberger 2024-08-22  25  	{ .dev_type = AP_DEVICE_TYPE_CEX6 },
8fcc231ce3bea12 Harald Freudenberger 2024-08-22  26  	{ .dev_type = AP_DEVICE_TYPE_CEX7 },
8fcc231ce3bea12 Harald Freudenberger 2024-08-22  27  	{ .dev_type = AP_DEVICE_TYPE_CEX8 },
8fcc231ce3bea12 Harald Freudenberger 2024-08-22  28  	{ /* end of list */ },
8fcc231ce3bea12 Harald Freudenberger 2024-08-22  29  };
8fcc231ce3bea12 Harald Freudenberger 2024-08-22  30  MODULE_DEVICE_TABLE(ap, pkey_cca_card_ids);
8fcc231ce3bea12 Harald Freudenberger 2024-08-22  31  #endif
8fcc231ce3bea12 Harald Freudenberger 2024-08-22  32  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
