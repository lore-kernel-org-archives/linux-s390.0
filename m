Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9492415ADAB;
	Wed, 16 Oct 2024 03:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729048474; cv=none; b=iLh1oYEfbBoJNssDr8JeoLxJwG9KQgnZJ5KdO6UQCAAsKFtWgH/2fciRsvsYaIqSB160OEj5HJJeWN4fFwO8FK/M2EcRD8IROmuYQMRcOw/4QOnqIEGZhq+Bz4PSaBuNIrLnFwLYNMaKEnGkpOjiyRG/QN7E1bR3Nmr0/Qs4D3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729048474; c=relaxed/simple;
	bh=J21Q/FdpS1/n/qG3YN/40e/ec8go/5nH1hBln/gewSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otP91mUiL92m3jsQkmbpU54tab/9aXntOSMY+j7u2kJcumr69z7Pr98hXNMEhwLqEPDJsmRfmpJsMeb/jb7aol6X2oQJgddAkoHKMHESjp4oO+o1D+hmsgWPSYx4FmoIsPuDv7/jU3G7IfS6c7ALDHdrkpMtPVcCFjltMFZ0ylk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xxz+IUpx; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xxz+IUpx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729048473; x=1760584473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J21Q/FdpS1/n/qG3YN/40e/ec8go/5nH1hBln/gewSc=;
  b=Xxz+IUpxUK+zsL1GB20ZzDE2wqGqma/lXb8GZTLcIbT7lybdyVCt8WGa
   zyccR2TKFU30DPnWEHjTGq+3IF8CJ+rTeelw1wDGvjmVdQu0obq8v3tWT
   a65kFe2xm7+AhOyHLf7GWYA7uUkdFKTq3KEmoSQiP1UAGz65sEXPjMoMj
   lplJXJ4wydri6UtEMMalc+bTO27ShtmX9AnTzFzIjprg3o7J+ZRiO/hRW
   /0mYFGVZ5KNec8OIQZ1R/2TRpBp8cO7JELQ5XUcqPFF4ucWQv5QlTDafh
   1ntY+21uvem2Kj22Um2exYcHpT8qyt81bPfOm9VxXqnxKjn1MSeja8GCN
   Q==;
X-CSE-ConnectionGUID: 1GqZsVbcSL+BLSgIJXgs7A==
X-CSE-MsgGUID: GFejiFfnT5qAP8Mw8PnCaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45954846"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="45954846"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:14:33 -0700
X-CSE-ConnectionGUID: A+E1x8n0RAKtDDkDmMAb+w==
X-CSE-MsgGUID: sTDaXdnRQ4GWw2ABjdbUVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="78265207"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 15 Oct 2024 20:14:30 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0uUV-000KDH-0n;
	Wed, 16 Oct 2024 03:14:27 +0000
Date: Wed, 16 Oct 2024 11:13:49 +0800
From: kernel test robot <lkp@intel.com>
To: Steffen Eiden <seiden@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Ingo Franzki <ifranzki@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Christoph Schlameuss <schlameuss@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v3 5/6] s390/uvdevice: Add List Secrets Ext IOCTL
Message-ID: <202410161057.pV9QsHAq-lkp@intel.com>
References: <20241015112859.3069210-6-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015112859.3069210-6-seiden@linux.ibm.com>

Hi Steffen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kvms390/next]
[also build test WARNING on s390/features linus/master v6.12-rc3 next-20241015]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steffen-Eiden/s390-boot-uv-c-Use-a-constant-for-more-data-rc/20241015-193108
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git next
patch link:    https://lore.kernel.org/r/20241015112859.3069210-6-seiden%40linux.ibm.com
patch subject: [PATCH v3 5/6] s390/uvdevice: Add List Secrets Ext IOCTL
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20241016/202410161057.pV9QsHAq-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241016/202410161057.pV9QsHAq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410161057.pV9QsHAq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/s390/char/uvdevice.c:302: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * The actual list(_ext) IOCTL.


vim +302 drivers/s390/char/uvdevice.c

   300	
   301	/**
 > 302	 * The actual list(_ext) IOCTL.
   303	 * If list_ext is true, the first two bytes of the user buffer set the starting
   304	 * index of the list-UVC.
   305	 */
   306	static int list_secrets(struct uvio_ioctl_cb *uv_ioctl, bool list_ext)
   307	{
   308		void __user *user_buf_arg = (void __user *)uv_ioctl->argument_addr;
   309		u16 __user *user_index = (u16 __user *)uv_ioctl->argument_addr;
   310		u16 start_idx = 0;
   311		u8 *secrets;
   312		int ret = 0;
   313	
   314		BUILD_BUG_ON(UVIO_LIST_SECRETS_LEN != PAGE_SIZE);
   315		if (uv_ioctl->argument_len != UVIO_LIST_SECRETS_LEN)
   316			return -EINVAL;
   317		/* The extended call accepts an u16 index as input */
   318		if (list_ext && get_user(start_idx, user_index))
   319			return -EFAULT;
   320		secrets = (u8 *)get_zeroed_page(GFP_KERNEL);
   321		if (!secrets)
   322			return -ENOMEM;
   323		uv_list_secrets(secrets, start_idx, &uv_ioctl->uv_rc, &uv_ioctl->uv_rrc);
   324		if (copy_to_user(user_buf_arg, secrets, UVIO_LIST_SECRETS_LEN))
   325			ret = -EFAULT;
   326	
   327		free_pages((unsigned long)secrets, 0);
   328		return ret;
   329	}
   330	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
