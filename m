Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725981AbgKMVGe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 13 Nov 2020 16:06:34 -0500
Subject: Re: [PATCH v11 12/14] s390/vfio-ap: handle host AP config change
 notification
References: <20201022171209.19494-13-akrowiak@linux.ibm.com>
 <202011031740.6Uu0Z5yG-lkp@intel.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <7507e3aa-699b-05a7-1a45-d9c0b8a40003@linux.ibm.com>
Date: Fri, 13 Nov 2020 16:06:27 -0500
MIME-Version: 1.0
In-Reply-To: <202011031740.6Uu0Z5yG-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: kernel test robot <lkp@intel.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: kbuild-all@lists.01.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com

Fixed the errors.

On 11/3/20 4:48 AM, kernel test robot wrote:
> Hi Tony,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on s390/features]
> [also build test ERROR on linus/master v5.10-rc2 next-20201103]
> [cannot apply to kvms390/next linux/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Tony-Krowiak/s390-vfio-ap-dynamic-configuration-support/20201023-011543
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
> config: s390-allmodconfig (attached as .config)
> compiler: s390-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/0day-ci/linux/commit/32786ef6d4ba3703d993a8894ea1d763785fd3a4
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Tony-Krowiak/s390-vfio-ap-dynamic-configuration-support/20201023-011543
>          git checkout 32786ef6d4ba3703d993a8894ea1d763785fd3a4
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=s390
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>     drivers/s390/crypto/vfio_ap_ops.c:1316:5: warning: no previous prototype for 'vfio_ap_mdev_reset_queue' [-Wmissing-prototypes]
>      1316 | int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
>           |     ^~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/s390/crypto/vfio_ap_ops.c:1568:6: warning: no previous prototype for 'vfio_ap_mdev_hot_unplug_queue' [-Wmissing-prototypes]
>      1568 | void vfio_ap_mdev_hot_unplug_queue(struct vfio_ap_queue *q)
>           |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/s390/crypto/vfio_ap_ops.c: In function 'vfio_ap_mdev_on_cfg_remove':
>     drivers/s390/crypto/vfio_ap_ops.c:1777:7: warning: variable 'unassigned' set but not used [-Wunused-but-set-variable]
>      1777 |  bool unassigned = false;
>           |       ^~~~~~~~~~
>     drivers/s390/crypto/vfio_ap_ops.c: At top level:
>     drivers/s390/crypto/vfio_ap_ops.c:1813:6: warning: no previous prototype for 'vfio_ap_mdev_on_cfg_add' [-Wmissing-prototypes]
>      1813 | void vfio_ap_mdev_on_cfg_add(void)
>           |      ^~~~~~~~~~~~~~~~~~~~~~~
>     In file included from drivers/s390/crypto/vfio_ap_ops.c:11:
>     In function 'memcpy',
>         inlined from 'vfio_ap_mdev_unassign_apids' at drivers/s390/crypto/vfio_ap_ops.c:1655:3,
>         inlined from 'vfio_ap_mdev_on_cfg_remove' at drivers/s390/crypto/vfio_ap_ops.c:1800:8,
>         inlined from 'vfio_ap_on_cfg_changed' at drivers/s390/crypto/vfio_ap_ops.c:1836:2:
>>> include/linux/string.h:402:4: error: call to '__read_overflow2' declared with attribute error: detected read beyond size of object passed as 2nd parameter
>       402 |    __read_overflow2();
>           |    ^~~~~~~~~~~~~~~~~~
>
> vim +/__read_overflow2 +402 include/linux/string.h
>
> 6974f0c4555e285 Daniel Micay  2017-07-12  393
> 6974f0c4555e285 Daniel Micay  2017-07-12  394  __FORTIFY_INLINE void *memcpy(void *p, const void *q, __kernel_size_t size)
> 6974f0c4555e285 Daniel Micay  2017-07-12  395  {
> 6974f0c4555e285 Daniel Micay  2017-07-12  396  	size_t p_size = __builtin_object_size(p, 0);
> 6974f0c4555e285 Daniel Micay  2017-07-12  397  	size_t q_size = __builtin_object_size(q, 0);
> 6974f0c4555e285 Daniel Micay  2017-07-12  398  	if (__builtin_constant_p(size)) {
> 6974f0c4555e285 Daniel Micay  2017-07-12  399  		if (p_size < size)
> 6974f0c4555e285 Daniel Micay  2017-07-12  400  			__write_overflow();
> 6974f0c4555e285 Daniel Micay  2017-07-12  401  		if (q_size < size)
> 6974f0c4555e285 Daniel Micay  2017-07-12 @402  			__read_overflow2();
> 6974f0c4555e285 Daniel Micay  2017-07-12  403  	}
> 6974f0c4555e285 Daniel Micay  2017-07-12  404  	if (p_size < size || q_size < size)
> 6974f0c4555e285 Daniel Micay  2017-07-12  405  		fortify_panic(__func__);
> 47227d27e2fcb01 Daniel Axtens 2020-06-03  406  	return __underlying_memcpy(p, q, size);
> 6974f0c4555e285 Daniel Micay  2017-07-12  407  }
> 6974f0c4555e285 Daniel Micay  2017-07-12  408
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
