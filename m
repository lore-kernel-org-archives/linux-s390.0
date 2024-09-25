Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D042136664
	for <linux-s390@vger.kernel.org>; Wed, 25 Sep 2024 04:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727238604; cv=none; b=OAQklfbyp9lcSIu4nrbEqXgsBWWDo2DKIR3VIcOrlcAbWIs5QPGCkl07W6FLJ+RsUSnncHE83oGGS0/YWq1AIlCQPwmQoJ/E5aEPPoZwnAbzNRNSEsNy1llbHqhHX5He/0VtmdtC0gQ6w2UUDpCFAbO+KHjYZgfsPcXR17oDy5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727238604; c=relaxed/simple;
	bh=88Hamdqrs751sKw4WbPe7RM1gSHiZTGXQ9Dvvm9fad0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rs8TUu4Lbvh5ZpaNjJs84gJEyGW91rXrYVPbXCwNr0fscKkh/YP4U6yaMCousUkQmhUvZdIC3kmyNZB/tODZtnuBErbuTUAWy18x6kEaaU5rDc4tNulaH3DurI7u2T3MNn1WgGBTDWtAhEcACSZpj2hc1131s54+A9LoVYlVGYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EKN34Ybd; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EKN34Ybd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727238602; x=1758774602;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=88Hamdqrs751sKw4WbPe7RM1gSHiZTGXQ9Dvvm9fad0=;
  b=EKN34Ybd5YEBhMOUkdaN+5YUIPyIjPrFwUVRtaO5Tjn6kPOaly+x2ypg
   8wp+BzIH3jVogtqRGKOew44HkcOUPta8v6nJs2o3GID4iOpKj6zaqOpQm
   brKUsB2NEa8OBPIedntQXuZ0brGOs+hmf8dvjvDYZBdjKoXADyIYYUbV3
   Dwiw4Xh9vJS4wJN2uj1+xoUBrALhqtae8yQA76b+vD1IMefnfPAbOcXeq
   EpsG4KAjokRHgWkROCXndGZL29BnxBP/2nuU+m0dskLjcCunS0scWWSEo
   MJ8FoKHIBlvvJEeI1ydnx5jMI8GEheVJNPNtaEeM73asaZK7382lgt1Lt
   Q==;
X-CSE-ConnectionGUID: dlr7PnX7SrW0xN7lTkPlTw==
X-CSE-MsgGUID: IPYK2zVlT/2CEj0mJQ1Cxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="26085157"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="26085157"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 21:30:01 -0700
X-CSE-ConnectionGUID: IiEJSzoNR7inXt3ce7pHUA==
X-CSE-MsgGUID: J1vYhL6hRT+PwCrVonfoXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="76575425"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 24 Sep 2024 21:29:57 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stJf1-000J8F-19;
	Wed, 25 Sep 2024 04:29:55 +0000
Date: Wed, 25 Sep 2024 12:29:03 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: oe-kbuild-all@lists.linux.dev,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Alistair Popple <apopple@nvidia.com>, linux-s390@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] dcssblk: Mark DAX broken
Message-ID: <202409251251.i8yVl4yR-lkp@intel.com>
References: <172721874675.497781.3277495908107141898.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172721874675.497781.3277495908107141898.stgit@dwillia2-xfh.jf.intel.com>

Hi Dan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on s390/features]
[also build test WARNING on brauner-vfs/vfs.all akpm-mm/mm-everything linus/master v6.11 next-20240924]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dan-Williams/dcssblk-Mark-DAX-broken/20240925-070047
base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
patch link:    https://lore.kernel.org/r/172721874675.497781.3277495908107141898.stgit%40dwillia2-xfh.jf.intel.com
patch subject: [PATCH] dcssblk: Mark DAX broken
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20240925/202409251251.i8yVl4yR-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240925/202409251251.i8yVl4yR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409251251.i8yVl4yR-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/s390/block/dcssblk.c: In function 'dcssblk_add_store':
>> drivers/s390/block/dcssblk.c:571:28: warning: unused variable 'dax_dev' [-Wunused-variable]
     571 |         struct dax_device *dax_dev;
         |                            ^~~~~~~


vim +/dax_dev +571 drivers/s390/block/dcssblk.c

e265834f5da2c4 Dan Williams          2024-09-24  557  
^1da177e4c3f41 Linus Torvalds        2005-04-16  558  /*
^1da177e4c3f41 Linus Torvalds        2005-04-16  559   * device attribute for adding devices
^1da177e4c3f41 Linus Torvalds        2005-04-16  560   */
^1da177e4c3f41 Linus Torvalds        2005-04-16  561  static ssize_t
e404e274f62665 Yani Ioannou          2005-05-17  562  dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
^1da177e4c3f41 Linus Torvalds        2005-04-16  563  {
af190c53c995bf Christoph Hellwig     2024-02-15  564  	struct queue_limits lim = {
af190c53c995bf Christoph Hellwig     2024-02-15  565  		.logical_block_size	= 4096,
f467fee48da450 Christoph Hellwig     2024-06-17  566  		.features		= BLK_FEAT_DAX,
af190c53c995bf Christoph Hellwig     2024-02-15  567  	};
b2300b9efe1b81 Hongjie Yang          2008-10-10  568  	int rc, i, j, num_of_segments;
^1da177e4c3f41 Linus Torvalds        2005-04-16  569  	struct dcssblk_dev_info *dev_info;
b2300b9efe1b81 Hongjie Yang          2008-10-10  570  	struct segment_info *seg_info, *temp;
cf7fe690abbbe5 Mathieu Desnoyers     2024-02-15 @571  	struct dax_device *dax_dev;
^1da177e4c3f41 Linus Torvalds        2005-04-16  572  	char *local_buf;
^1da177e4c3f41 Linus Torvalds        2005-04-16  573  	unsigned long seg_byte_size;
^1da177e4c3f41 Linus Torvalds        2005-04-16  574  
^1da177e4c3f41 Linus Torvalds        2005-04-16  575  	dev_info = NULL;
b2300b9efe1b81 Hongjie Yang          2008-10-10  576  	seg_info = NULL;
^1da177e4c3f41 Linus Torvalds        2005-04-16  577  	if (dev != dcssblk_root_dev) {
^1da177e4c3f41 Linus Torvalds        2005-04-16  578  		rc = -EINVAL;
^1da177e4c3f41 Linus Torvalds        2005-04-16  579  		goto out_nobuf;
^1da177e4c3f41 Linus Torvalds        2005-04-16  580  	}
b2300b9efe1b81 Hongjie Yang          2008-10-10  581  	if ((count < 1) || (buf[0] == '\0') || (buf[0] == '\n')) {
b2300b9efe1b81 Hongjie Yang          2008-10-10  582  		rc = -ENAMETOOLONG;
b2300b9efe1b81 Hongjie Yang          2008-10-10  583  		goto out_nobuf;
b2300b9efe1b81 Hongjie Yang          2008-10-10  584  	}
b2300b9efe1b81 Hongjie Yang          2008-10-10  585  
^1da177e4c3f41 Linus Torvalds        2005-04-16  586  	local_buf = kmalloc(count + 1, GFP_KERNEL);
^1da177e4c3f41 Linus Torvalds        2005-04-16  587  	if (local_buf == NULL) {
^1da177e4c3f41 Linus Torvalds        2005-04-16  588  		rc = -ENOMEM;
^1da177e4c3f41 Linus Torvalds        2005-04-16  589  		goto out_nobuf;
^1da177e4c3f41 Linus Torvalds        2005-04-16  590  	}
b2300b9efe1b81 Hongjie Yang          2008-10-10  591  
^1da177e4c3f41 Linus Torvalds        2005-04-16  592  	/*
^1da177e4c3f41 Linus Torvalds        2005-04-16  593  	 * parse input
^1da177e4c3f41 Linus Torvalds        2005-04-16  594  	 */
b2300b9efe1b81 Hongjie Yang          2008-10-10  595  	num_of_segments = 0;
3a9f9183bdd341 Ameen Ali             2015-02-24  596  	for (i = 0; (i < count && (buf[i] != '\0') && (buf[i] != '\n')); i++) {
42cfc6b590c5eb Martin Schwidefsky    2015-08-19  597  		for (j = i; j < count &&
42cfc6b590c5eb Martin Schwidefsky    2015-08-19  598  			(buf[j] != ':') &&
b2300b9efe1b81 Hongjie Yang          2008-10-10  599  			(buf[j] != '\0') &&
42cfc6b590c5eb Martin Schwidefsky    2015-08-19  600  			(buf[j] != '\n'); j++) {
b2300b9efe1b81 Hongjie Yang          2008-10-10  601  			local_buf[j-i] = toupper(buf[j]);
b2300b9efe1b81 Hongjie Yang          2008-10-10  602  		}
b2300b9efe1b81 Hongjie Yang          2008-10-10  603  		local_buf[j-i] = '\0';
b2300b9efe1b81 Hongjie Yang          2008-10-10  604  		if (((j - i) == 0) || ((j - i) > 8)) {
^1da177e4c3f41 Linus Torvalds        2005-04-16  605  			rc = -ENAMETOOLONG;
b2300b9efe1b81 Hongjie Yang          2008-10-10  606  			goto seg_list_del;
^1da177e4c3f41 Linus Torvalds        2005-04-16  607  		}
b2300b9efe1b81 Hongjie Yang          2008-10-10  608  
b2300b9efe1b81 Hongjie Yang          2008-10-10  609  		rc = dcssblk_load_segment(local_buf, &seg_info);
b2300b9efe1b81 Hongjie Yang          2008-10-10  610  		if (rc < 0)
b2300b9efe1b81 Hongjie Yang          2008-10-10  611  			goto seg_list_del;
^1da177e4c3f41 Linus Torvalds        2005-04-16  612  		/*
^1da177e4c3f41 Linus Torvalds        2005-04-16  613  		 * get a struct dcssblk_dev_info
^1da177e4c3f41 Linus Torvalds        2005-04-16  614  		 */
b2300b9efe1b81 Hongjie Yang          2008-10-10  615  		if (num_of_segments == 0) {
b2300b9efe1b81 Hongjie Yang          2008-10-10  616  			dev_info = kzalloc(sizeof(struct dcssblk_dev_info),
b2300b9efe1b81 Hongjie Yang          2008-10-10  617  					GFP_KERNEL);
^1da177e4c3f41 Linus Torvalds        2005-04-16  618  			if (dev_info == NULL) {
^1da177e4c3f41 Linus Torvalds        2005-04-16  619  				rc = -ENOMEM;
^1da177e4c3f41 Linus Torvalds        2005-04-16  620  				goto out;
^1da177e4c3f41 Linus Torvalds        2005-04-16  621  			}
^1da177e4c3f41 Linus Torvalds        2005-04-16  622  			strcpy(dev_info->segment_name, local_buf);
b2300b9efe1b81 Hongjie Yang          2008-10-10  623  			dev_info->segment_type = seg_info->segment_type;
b2300b9efe1b81 Hongjie Yang          2008-10-10  624  			INIT_LIST_HEAD(&dev_info->seg_list);
b2300b9efe1b81 Hongjie Yang          2008-10-10  625  		}
b2300b9efe1b81 Hongjie Yang          2008-10-10  626  		list_add_tail(&seg_info->lh, &dev_info->seg_list);
b2300b9efe1b81 Hongjie Yang          2008-10-10  627  		num_of_segments++;
b2300b9efe1b81 Hongjie Yang          2008-10-10  628  		i = j;
b2300b9efe1b81 Hongjie Yang          2008-10-10  629  
b2300b9efe1b81 Hongjie Yang          2008-10-10  630  		if ((buf[j] == '\0') || (buf[j] == '\n'))
b2300b9efe1b81 Hongjie Yang          2008-10-10  631  			break;
b2300b9efe1b81 Hongjie Yang          2008-10-10  632  	}
b2300b9efe1b81 Hongjie Yang          2008-10-10  633  
b2300b9efe1b81 Hongjie Yang          2008-10-10  634  	/* no trailing colon at the end of the input */
b2300b9efe1b81 Hongjie Yang          2008-10-10  635  	if ((i > 0) && (buf[i-1] == ':')) {
b2300b9efe1b81 Hongjie Yang          2008-10-10  636  		rc = -ENAMETOOLONG;
b2300b9efe1b81 Hongjie Yang          2008-10-10  637  		goto seg_list_del;
b2300b9efe1b81 Hongjie Yang          2008-10-10  638  	}
820109fb11f24b Wolfram Sang          2022-08-18  639  	strscpy(local_buf, buf, i + 1);
b2300b9efe1b81 Hongjie Yang          2008-10-10  640  	dev_info->num_of_segments = num_of_segments;
b2300b9efe1b81 Hongjie Yang          2008-10-10  641  	rc = dcssblk_is_continuous(dev_info);
b2300b9efe1b81 Hongjie Yang          2008-10-10  642  	if (rc < 0)
b2300b9efe1b81 Hongjie Yang          2008-10-10  643  		goto seg_list_del;
b2300b9efe1b81 Hongjie Yang          2008-10-10  644  
b2300b9efe1b81 Hongjie Yang          2008-10-10  645  	dev_info->start = dcssblk_find_lowest_addr(dev_info);
b2300b9efe1b81 Hongjie Yang          2008-10-10  646  	dev_info->end = dcssblk_find_highest_addr(dev_info);
b2300b9efe1b81 Hongjie Yang          2008-10-10  647  
ef283688f54cc8 Kees Cook             2014-06-10  648  	dev_set_name(&dev_info->dev, "%s", dev_info->segment_name);
^1da177e4c3f41 Linus Torvalds        2005-04-16  649  	dev_info->dev.release = dcssblk_release_segment;
521b3d790c16fa Sebastian Ott         2012-10-01  650  	dev_info->dev.groups = dcssblk_dev_attr_groups;
^1da177e4c3f41 Linus Torvalds        2005-04-16  651  	INIT_LIST_HEAD(&dev_info->lh);
af190c53c995bf Christoph Hellwig     2024-02-15  652  	dev_info->gd = blk_alloc_disk(&lim, NUMA_NO_NODE);
74fa8f9c553f7b Christoph Hellwig     2024-02-15  653  	if (IS_ERR(dev_info->gd)) {
74fa8f9c553f7b Christoph Hellwig     2024-02-15  654  		rc = PTR_ERR(dev_info->gd);
b2300b9efe1b81 Hongjie Yang          2008-10-10  655  		goto seg_list_del;
^1da177e4c3f41 Linus Torvalds        2005-04-16  656  	}
^1da177e4c3f41 Linus Torvalds        2005-04-16  657  	dev_info->gd->major = dcssblk_major;
0692ef289f067d Christoph Hellwig     2021-05-21  658  	dev_info->gd->minors = DCSSBLK_MINORS_PER_DISK;
^1da177e4c3f41 Linus Torvalds        2005-04-16  659  	dev_info->gd->fops = &dcssblk_devops;
^1da177e4c3f41 Linus Torvalds        2005-04-16  660  	dev_info->gd->private_data = dev_info;
a41a11b4009580 Gerald Schaefer       2022-10-27  661  	dev_info->gd->flags |= GENHD_FL_NO_PART;
b2300b9efe1b81 Hongjie Yang          2008-10-10  662  
^1da177e4c3f41 Linus Torvalds        2005-04-16  663  	seg_byte_size = (dev_info->end - dev_info->start + 1);
^1da177e4c3f41 Linus Torvalds        2005-04-16  664  	set_capacity(dev_info->gd, seg_byte_size >> 9); // size in sectors
93098bf0157876 Hongjie Yang          2008-12-25  665  	pr_info("Loaded %s with total size %lu bytes and capacity %lu "
93098bf0157876 Hongjie Yang          2008-12-25  666  		"sectors\n", local_buf, seg_byte_size, seg_byte_size >> 9);
^1da177e4c3f41 Linus Torvalds        2005-04-16  667  
^1da177e4c3f41 Linus Torvalds        2005-04-16  668  	dev_info->save_pending = 0;
^1da177e4c3f41 Linus Torvalds        2005-04-16  669  	dev_info->is_shared = 1;
^1da177e4c3f41 Linus Torvalds        2005-04-16  670  	dev_info->dev.parent = dcssblk_root_dev;
^1da177e4c3f41 Linus Torvalds        2005-04-16  671  
^1da177e4c3f41 Linus Torvalds        2005-04-16  672  	/*
^1da177e4c3f41 Linus Torvalds        2005-04-16  673  	 *get minor, add to list
^1da177e4c3f41 Linus Torvalds        2005-04-16  674  	 */
^1da177e4c3f41 Linus Torvalds        2005-04-16  675  	down_write(&dcssblk_devices_sem);
b2300b9efe1b81 Hongjie Yang          2008-10-10  676  	if (dcssblk_get_segment_by_name(local_buf)) {
04f64b5756872b Gerald Schaefer       2008-08-21  677  		rc = -EEXIST;
b2300b9efe1b81 Hongjie Yang          2008-10-10  678  		goto release_gd;
04f64b5756872b Gerald Schaefer       2008-08-21  679  	}
^1da177e4c3f41 Linus Torvalds        2005-04-16  680  	rc = dcssblk_assign_free_minor(dev_info);
b2300b9efe1b81 Hongjie Yang          2008-10-10  681  	if (rc)
b2300b9efe1b81 Hongjie Yang          2008-10-10  682  		goto release_gd;
^1da177e4c3f41 Linus Torvalds        2005-04-16  683  	sprintf(dev_info->gd->disk_name, "dcssblk%d",
d0591485e15ccd Gerald Schaefer       2009-06-12  684  		dev_info->gd->first_minor);
^1da177e4c3f41 Linus Torvalds        2005-04-16  685  	list_add_tail(&dev_info->lh, &dcssblk_devices);
^1da177e4c3f41 Linus Torvalds        2005-04-16  686  
^1da177e4c3f41 Linus Torvalds        2005-04-16  687  	if (!try_module_get(THIS_MODULE)) {
^1da177e4c3f41 Linus Torvalds        2005-04-16  688  		rc = -ENODEV;
b2300b9efe1b81 Hongjie Yang          2008-10-10  689  		goto dev_list_del;
^1da177e4c3f41 Linus Torvalds        2005-04-16  690  	}
^1da177e4c3f41 Linus Torvalds        2005-04-16  691  	/*
^1da177e4c3f41 Linus Torvalds        2005-04-16  692  	 * register the device
^1da177e4c3f41 Linus Torvalds        2005-04-16  693  	 */
^1da177e4c3f41 Linus Torvalds        2005-04-16  694  	rc = device_register(&dev_info->dev);
b2300b9efe1b81 Hongjie Yang          2008-10-10  695  	if (rc)
521b3d790c16fa Sebastian Ott         2012-10-01  696  		goto put_dev;
^1da177e4c3f41 Linus Torvalds        2005-04-16  697  
e265834f5da2c4 Dan Williams          2024-09-24  698  	rc = dcssblk_setup_dax(dev_info);
fb08a1908cb119 Christoph Hellwig     2021-11-29  699  	if (rc)
fb08a1908cb119 Christoph Hellwig     2021-11-29  700  		goto out_dax;
7a2765f6e82063 Dan Williams          2017-01-26  701  
521b3d790c16fa Sebastian Ott         2012-10-01  702  	get_device(&dev_info->dev);
1a5db707c859a4 Gerald Schaefer       2021-09-27  703  	rc = device_add_disk(&dev_info->dev, dev_info->gd, NULL);
1a5db707c859a4 Gerald Schaefer       2021-09-27  704  	if (rc)
fb08a1908cb119 Christoph Hellwig     2021-11-29  705  		goto out_dax_host;
436d1bc7fe6e78 Christian Borntraeger 2007-12-04  706  
^1da177e4c3f41 Linus Torvalds        2005-04-16  707  	switch (dev_info->segment_type) {
^1da177e4c3f41 Linus Torvalds        2005-04-16  708  		case SEG_TYPE_SR:
^1da177e4c3f41 Linus Torvalds        2005-04-16  709  		case SEG_TYPE_ER:
^1da177e4c3f41 Linus Torvalds        2005-04-16  710  		case SEG_TYPE_SC:
^1da177e4c3f41 Linus Torvalds        2005-04-16  711  			set_disk_ro(dev_info->gd,1);
^1da177e4c3f41 Linus Torvalds        2005-04-16  712  			break;
^1da177e4c3f41 Linus Torvalds        2005-04-16  713  		default:
^1da177e4c3f41 Linus Torvalds        2005-04-16  714  			set_disk_ro(dev_info->gd,0);
^1da177e4c3f41 Linus Torvalds        2005-04-16  715  			break;
^1da177e4c3f41 Linus Torvalds        2005-04-16  716  	}
^1da177e4c3f41 Linus Torvalds        2005-04-16  717  	up_write(&dcssblk_devices_sem);
^1da177e4c3f41 Linus Torvalds        2005-04-16  718  	rc = count;
^1da177e4c3f41 Linus Torvalds        2005-04-16  719  	goto out;
^1da177e4c3f41 Linus Torvalds        2005-04-16  720  
fb08a1908cb119 Christoph Hellwig     2021-11-29  721  out_dax_host:
c8f40a0bccefd6 Gerald Schaefer       2023-08-10  722  	put_device(&dev_info->dev);
fb08a1908cb119 Christoph Hellwig     2021-11-29  723  	dax_remove_host(dev_info->gd);
1a5db707c859a4 Gerald Schaefer       2021-09-27  724  out_dax:
1a5db707c859a4 Gerald Schaefer       2021-09-27  725  	kill_dax(dev_info->dax_dev);
1a5db707c859a4 Gerald Schaefer       2021-09-27  726  	put_dax(dev_info->dax_dev);
521b3d790c16fa Sebastian Ott         2012-10-01  727  put_dev:
^1da177e4c3f41 Linus Torvalds        2005-04-16  728  	list_del(&dev_info->lh);
8b9ab62662048a Christoph Hellwig     2022-06-19  729  	put_disk(dev_info->gd);
b2300b9efe1b81 Hongjie Yang          2008-10-10  730  	list_for_each_entry(seg_info, &dev_info->seg_list, lh) {
b2300b9efe1b81 Hongjie Yang          2008-10-10  731  		segment_unload(seg_info->segment_name);
b2300b9efe1b81 Hongjie Yang          2008-10-10  732  	}
^1da177e4c3f41 Linus Torvalds        2005-04-16  733  	put_device(&dev_info->dev);
^1da177e4c3f41 Linus Torvalds        2005-04-16  734  	up_write(&dcssblk_devices_sem);
^1da177e4c3f41 Linus Torvalds        2005-04-16  735  	goto out;
b2300b9efe1b81 Hongjie Yang          2008-10-10  736  dev_list_del:
^1da177e4c3f41 Linus Torvalds        2005-04-16  737  	list_del(&dev_info->lh);
b2300b9efe1b81 Hongjie Yang          2008-10-10  738  release_gd:
8b9ab62662048a Christoph Hellwig     2022-06-19  739  	put_disk(dev_info->gd);
b2300b9efe1b81 Hongjie Yang          2008-10-10  740  	up_write(&dcssblk_devices_sem);
b2300b9efe1b81 Hongjie Yang          2008-10-10  741  seg_list_del:
b2300b9efe1b81 Hongjie Yang          2008-10-10  742  	if (dev_info == NULL)
b2300b9efe1b81 Hongjie Yang          2008-10-10  743  		goto out;
b2300b9efe1b81 Hongjie Yang          2008-10-10  744  	list_for_each_entry_safe(seg_info, temp, &dev_info->seg_list, lh) {
b2300b9efe1b81 Hongjie Yang          2008-10-10  745  		list_del(&seg_info->lh);
b2300b9efe1b81 Hongjie Yang          2008-10-10  746  		segment_unload(seg_info->segment_name);
b2300b9efe1b81 Hongjie Yang          2008-10-10  747  		kfree(seg_info);
b2300b9efe1b81 Hongjie Yang          2008-10-10  748  	}
^1da177e4c3f41 Linus Torvalds        2005-04-16  749  	kfree(dev_info);
^1da177e4c3f41 Linus Torvalds        2005-04-16  750  out:
^1da177e4c3f41 Linus Torvalds        2005-04-16  751  	kfree(local_buf);
^1da177e4c3f41 Linus Torvalds        2005-04-16  752  out_nobuf:
^1da177e4c3f41 Linus Torvalds        2005-04-16  753  	return rc;
^1da177e4c3f41 Linus Torvalds        2005-04-16  754  }
^1da177e4c3f41 Linus Torvalds        2005-04-16  755  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
