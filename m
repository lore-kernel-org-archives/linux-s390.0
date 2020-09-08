Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729626AbgIHHxq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Sep 2020 03:53:46 -0400
Date: Tue, 8 Sep 2020 09:53:37 +0200
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] s390x: Add 3f program exception handler
Message-ID: <20200908075337.GA9170@osiris>
References: <20200907124700.10374-3-frankja@linux.ibm.com>
 <202009080542.UHmgfE5u%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009080542.UHmgfE5u%lkp@intel.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kbuild-all@lists.01.org, borntraeger@de.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, david@redhat.com

Hi Janosch,

On Tue, Sep 08, 2020 at 05:56:19AM +0800, kernel test robot wrote:
> All warnings (new ones prefixed by >>):
> 
> >> arch/s390/mm/fault.c:862:6: warning: no previous prototype for 'do_secure_storage_violation' [-Wmissing-prototypes]
>      862 | void do_secure_storage_violation(struct pt_regs *regs)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> # https://github.com/0day-ci/linux/commit/4aee662164217d48d050e0d9cf57a2cb2cdeaa8a
> git remote add linux-review https://github.com/0day-ci/linux
> git fetch --no-tags linux-review Janosch-Frank/s390x-pv-Fixes-and-improvements/20200908-021233
> git checkout 4aee662164217d48d050e0d9cf57a2cb2cdeaa8a
> vim +/do_secure_storage_violation +862 arch/s390/mm/fault.c
> 
>    861	
>  > 862	void do_secure_storage_violation(struct pt_regs *regs)

To get rid of this warning, please add the function prototype to
arch/s390/kernel/entry.h. Like we have them for all other program
check handlers for this reason as well.
