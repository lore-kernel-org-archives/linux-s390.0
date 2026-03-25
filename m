Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F8A3CC9F8;
	Wed, 25 Mar 2026 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774441898; cv=none; b=YO/6tHY4VmjfZzPdzuXBN2U/fwZTszxLP0R+VZcpfYsR0sF7ED2wh3IpFWtgMlrz38pO2yno1aFdh0zBRpbw7/838rfH2oTSY1VPPw4UOxPLwcHoFfYcLHpCqpbcEEpVuAF9iWBlqplIwHYqe0wWYAHu0/od6uPKFj81hAnS5UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774441898; c=relaxed/simple;
	bh=KJ5Xqvb2OG1R7yYsNeFHe2+aJkViXBJd9c9qkEO48B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzQXT321synhhJaHDV92GLZPvZR6+8GPLTxRWqUZuhC5dQqM+xykAGr4A5LdizDuiG9kcWG7ir2cRTyk86NnWhL7CAThLnnpXVs3fTZPQSKkJTnqkAPqMGFUPr91lMveMtsYtbat6/Zo0kH01gKIDX7t/78bf2R87gRdoBS0TL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l0aOVehQ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l0aOVehQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774441897; x=1805977897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KJ5Xqvb2OG1R7yYsNeFHe2+aJkViXBJd9c9qkEO48B4=;
  b=l0aOVehQncRKY8PBmY39rPVCEelMmx7LmCnRlpyJNTN5ywryL7SHaX93
   9gSPMmheMe2XKmmfeL6cj1iDM101bZpDNryWBGIVxigWCM0O+wAnYChii
   5MHpBThCCDrOBNuzCpbBU01tbFhRfTjFeu2IW5oRAgRPOOjelHRXkgkfo
   QpUVnU9qv2ORAHLMBMlXG1ldEhM7sFP4l8EtQq/+QXhjMBdrdeq3LBCgJ
   Y7n3NGXydBobbogpooNLi5zifdnTLnrgKHigUNQDpF8PAlprMlkxhaMnr
   GjNkVMbiuHaJQd0J1owWbrN2hBFz00HWClfilB7YDB2th1rz6S5iF5BjX
   w==;
X-CSE-ConnectionGUID: jve4HZ/2R8Oc2Va6h6rjKA==
X-CSE-MsgGUID: /r4Aq5IDSqGztvhvcnFP5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75364095"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75364095"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 05:31:37 -0700
X-CSE-ConnectionGUID: H+EfNkIHT0GjZldPbtfawQ==
X-CSE-MsgGUID: Y6+AxHyvTA+3Fz5C8oA0JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="248184779"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 25 Mar 2026 05:31:33 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5NOU-000000006oL-31qE;
	Wed, 25 Mar 2026 12:31:30 +0000
Date: Wed, 25 Mar 2026 20:30:58 +0800
From: kernel test robot <lkp@intel.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
	seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
	hca@linux.ibm.com, david@kernel.org
Subject: Re: [PATCH v3 8/9] KVM: s390: vsie: Fix guest page tables protection
Message-ID: <202603252045.f3Juk9sU-lkp@intel.com>
References: <20260324174301.232921-9-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324174301.232921-9-imbrenda@linux.ibm.com>

Hi Claudio,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kvm/queue]
[also build test WARNING on kvm/next linus/master v7.0-rc5 next-20260324]
[cannot apply to kvms390/next kvm/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Claudio-Imbrenda/KVM-s390-vsie-Fix-dat_split_ste/20260325-092851
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
patch link:    https://lore.kernel.org/r/20260324174301.232921-9-imbrenda%40linux.ibm.com
patch subject: [PATCH v3 8/9] KVM: s390: vsie: Fix guest page tables protection
config: s390-defconfig (https://download.01.org/0day-ci/archive/20260325/202603252045.f3Juk9sU-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 054e11d1a17e5ba88bb1a8ef32fad3346e80b186)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260325/202603252045.f3Juk9sU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603252045.f3Juk9sU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/s390/kvm/gaccess.c:1522:6: warning: variable 'gl' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    1522 |         if (w->level <= LEVEL_MEM) {
         |             ^~~~~~~~~~~~~~~~~~~~~
   arch/s390/kvm/gaccess.c:1555:10: note: uninitialized use occurs here
    1555 |         if (l < gl) {
         |                 ^~
   arch/s390/kvm/gaccess.c:1522:2: note: remove the 'if' if its condition is always false
    1522 |         if (w->level <= LEVEL_MEM) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1523 |                 l = TABLE_TYPE_PAGE_TABLE;
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~
    1524 |                 hl = TABLE_TYPE_REGION1;
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~
    1525 |                 goto real_address_space;
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~
    1526 |         }
         |         ~
   arch/s390/kvm/gaccess.c:1500:22: note: initialize the variable 'gl' to silence this warning
    1500 |         int flags, i, hl, gl, l, rc;
         |                             ^
         |                              = 0
   1 warning generated.


vim +1522 arch/s390/kvm/gaccess.c

  1495	
  1496	static int _gaccess_do_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *sg,
  1497				      unsigned long saddr, struct pgtwalk *w)
  1498	{
  1499		struct guest_fault *entries;
  1500		int flags, i, hl, gl, l, rc;
  1501		union crste *table, *host;
  1502		union pte *ptep, *ptep_h;
  1503	
  1504		lockdep_assert_held(&sg->kvm->mmu_lock);
  1505		lockdep_assert_held(&sg->parent->children_lock);
  1506	
  1507		entries = get_entries(w);
  1508		ptep_h = NULL;
  1509		ptep = NULL;
  1510	
  1511		rc = dat_entry_walk(NULL, gpa_to_gfn(saddr), sg->asce, DAT_WALK_ANY, TABLE_TYPE_PAGE_TABLE,
  1512				    &table, &ptep);
  1513		if (rc)
  1514			return rc;
  1515	
  1516		/* A race occurred. The shadow mapping is already valid, nothing to do */
  1517		if ((ptep && !ptep->h.i && ptep->h.p == w->p) ||
  1518		    (!ptep && crste_leaf(*table) && !table->h.i && table->h.p == w->p))
  1519			return 0;
  1520	
  1521		/* In case of a real address space */
> 1522		if (w->level <= LEVEL_MEM) {
  1523			l = TABLE_TYPE_PAGE_TABLE;
  1524			hl = TABLE_TYPE_REGION1;
  1525			goto real_address_space;
  1526		}
  1527	
  1528		gl = get_level(table, ptep);
  1529	
  1530		/*
  1531		 * Skip levels that are already protected. For each level, protect
  1532		 * only the page containing the entry, not the whole table.
  1533		 */
  1534		for (i = gl ; i >= w->level; i--) {
  1535			rc = gmap_protect_rmap(mc, sg, entries[i].gfn, gpa_to_gfn(saddr),
  1536					       entries[i].pfn, i + 1, entries[i].writable);
  1537			if (rc)
  1538				return rc;
  1539			if (!sg->parent)
  1540				return -EAGAIN;
  1541		}
  1542	
  1543		rc = dat_entry_walk(NULL, entries[LEVEL_MEM].gfn, sg->parent->asce, DAT_WALK_LEAF,
  1544				    TABLE_TYPE_PAGE_TABLE, &host, &ptep_h);
  1545		if (rc)
  1546			return rc;
  1547	
  1548		hl = get_level(host, ptep_h);
  1549		/* Get the smallest granularity */
  1550		l = min3(gl, hl, w->level);
  1551	
  1552	real_address_space:
  1553		flags = DAT_WALK_SPLIT_ALLOC | (uses_skeys(sg->parent) ? DAT_WALK_USES_SKEYS : 0);
  1554		/* If necessary, create the shadow mapping */
  1555		if (l < gl) {
  1556			rc = dat_entry_walk(mc, gpa_to_gfn(saddr), sg->asce, flags, l, &table, &ptep);
  1557			if (rc)
  1558				return rc;
  1559		}
  1560		if (l < hl) {
  1561			rc = dat_entry_walk(mc, entries[LEVEL_MEM].gfn, sg->parent->asce,
  1562					    flags, l, &host, &ptep_h);
  1563			if (rc)
  1564				return rc;
  1565		}
  1566	
  1567		if (KVM_BUG_ON(l > TABLE_TYPE_REGION3, sg->kvm))
  1568			return -EFAULT;
  1569		if (l == TABLE_TYPE_PAGE_TABLE)
  1570			return _do_shadow_pte(sg, saddr, ptep_h, ptep, entries + LEVEL_MEM, w->p);
  1571		return _do_shadow_crste(sg, saddr, host, table, entries + LEVEL_MEM, w->p);
  1572	}
  1573	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
