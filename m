Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1762 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1775769AbgJZREV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 26 Oct 2020 13:04:21 -0400
Subject: Re: [PATCH v11 08/14] s390/vfio-ap: hot plug/unplug queues on
 bind/unbind of queue device
References: <20201022171209.19494-9-akrowiak@linux.ibm.com>
 <202010230422.zcNkhr2n-lkp@intel.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <6f8c339e-3d7e-c8c5-cda3-782ba5e68219@linux.ibm.com>
Date: Mon, 26 Oct 2020 13:04:13 -0400
MIME-Version: 1.0
In-Reply-To: <202010230422.zcNkhr2n-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: kbuild-all@lists.01.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com



On 10/22/20 4:30 PM, kernel test robot wrote:
> Hi Tony,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on s390/features]
> [also build test WARNING on linus/master kvms390/next linux/master v5.9 next-20201022]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Tony-Krowiak/s390-vfio-ap-dynamic-configuration-support/20201023-011543
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
> config: s390-allyesconfig (attached as .config)
> compiler: s390-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/0day-ci/linux/commit/aea9ab29b77facc3bb09415ebe464fd6a22ec22e
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Tony-Krowiak/s390-vfio-ap-dynamic-configuration-support/20201023-011543
>          git checkout aea9ab29b77facc3bb09415ebe464fd6a22ec22e
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=s390
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>     drivers/s390/crypto/vfio_ap_ops.c:1370:5: warning: no previous prototype for 'vfio_ap_mdev_reset_queue' [-Wmissing-prototypes]
>      1370 | int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
>           |     ^~~~~~~~~~~~~~~~~~~~~~~~

My mistake, need to be a static function.

>>> drivers/s390/crypto/vfio_ap_ops.c:1617:6: warning: no previous prototype for 'vfio_ap_mdev_hot_unplug_queue' [-Wmissing-prototypes]
>      1617 | void vfio_ap_mdev_hot_unplug_queue(struct vfio_ap_queue *q)
>           |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ditto here, but this was reported for patch 01/14 and will be fixed there.

>
> vim +/vfio_ap_mdev_hot_unplug_queue +1617 drivers/s390/crypto/vfio_ap_ops.c
>
>    1616	
>> 1617	void vfio_ap_mdev_hot_unplug_queue(struct vfio_ap_queue *q)
>    1618	{
>    1619		unsigned long apid = AP_QID_CARD(q->apqn);
>    1620	
>    1621		if ((q->matrix_mdev == NULL) || !vfio_ap_mdev_has_crycb(q->matrix_mdev))
>    1622			return;
>    1623	
>    1624		/*
>    1625		 * If the APID is assigned to the guest, then let's
>    1626		 * go ahead and unplug the adapter since the
>    1627		 * architecture does not provide a means to unplug
>    1628		 * an individual queue.
>    1629		 */
>    1630		if (test_bit_inv(apid, q->matrix_mdev->shadow_apcb.apm)) {
>    1631			clear_bit_inv(apid, q->matrix_mdev->shadow_apcb.apm);
>    1632	
>    1633			if (bitmap_empty(q->matrix_mdev->shadow_apcb.apm, AP_DEVICES))
>    1634				bitmap_clear(q->matrix_mdev->shadow_apcb.aqm, 0,
>    1635					     AP_DOMAINS);
>    1636	
>    1637			vfio_ap_mdev_commit_shadow_apcb(q->matrix_mdev);
>    1638		}
>    1639	}
>    1640	
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
