Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55292 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728857AbgGFHbJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Jul 2020 03:31:09 -0400
Subject: Re: [PATCH v1 4/9] s390/vmemmap: cleanup when vmemmap_populate()
 fails
References: <20200703133917.39045-5-david@redhat.com>
 <202007040129.TlExXvvF%lkp@intel.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <03e828a4-a363-0977-c49f-d9b424ec27d1@redhat.com>
Date: Mon, 6 Jul 2020 09:30:56 +0200
MIME-Version: 1.0
In-Reply-To: <202007040129.TlExXvvF%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org
Cc: kbuild-all@lists.01.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>

On 03.07.20 19:09, kernel test robot wrote:
> Hi David,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on s390/features]
> [also build test ERROR on next-20200703]
> [cannot apply to linux/master kvms390/next linus/master v5.8-rc3]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use  as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/David-Hildenbrand/s390-implement-and-optimize-vmemmap_free/20200703-214348
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
> config: s390-alldefconfig (attached as .config)
> compiler: s390-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=s390 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>):
> 
>    arch/s390/mm/vmem.c: In function 'vmemmap_populate':
>>> arch/s390/mm/vmem.c:368:3: error: implicit declaration of function 'vmemmap_free'; did you mean 'vmem_altmap_free'? [-Werror=implicit-function-declaration]
>      368 |   vmemmap_free(start, end, altmap);
>          |   ^~~~~~~~~~~~
>          |   vmem_altmap_free
>    arch/s390/mm/vmem.c: At top level:
>    arch/s390/mm/vmem.c:372:6: warning: no previous prototype for 'vmemmap_free' [-Wmissing-prototypes]
>      372 | void vmemmap_free(unsigned long start, unsigned long end,
>          |      ^~~~~~~~~~~~
>>> arch/s390/mm/vmem.c:372:6: warning: conflicting types for 'vmemmap_free'
>    arch/s390/mm/vmem.c:368:3: note: previous implicit declaration of 'vmemmap_free' was here
>      368 |   vmemmap_free(start, end, altmap);
>          |   ^~~~~~~~~~~~
>    cc1: some warnings being treated as errors

Ah, vmemmap_free() is only defined with CONFIG_MEMORY_HOTPLUG. Easy to fix.


-- 
Thanks,

David / dhildenb
