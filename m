Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH resend] s390/purgatory: Make sure we fail the build if
 purgatory has missing symbols
References: <20191212205304.191610-1-hdegoede@redhat.com>
 <201912180823.P38gmVhW%lkp@intel.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 18 Dec 2019 09:12:53 +0100
MIME-Version: 1.0
In-Reply-To: <201912180823.P38gmVhW%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <9c999218-0a2d-dd8d-71b7-e7f552957261@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kbuild test robot <lkp@intel.com>, Hans de Goede <hdegoede@redhat.com>
Cc: kbuild-all@lists.01.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org


On 18.12.19 01:25, kbuild test robot wrote:
> Hi Hans,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on s390/features]
> [also build test ERROR on v5.5-rc2 next-20191217]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Hans-de-Goede/s390-purgatory-Make-sure-we-fail-the-build-if-purgatory-has-missing-symbols/20191216-045305
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
> config: s390-randconfig-a001-20191217 (attached as .config)
> compiler: s390-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=s390 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>

This actually looks like the patch is doing exactly what it should.
It seems we must not build the purgatory with kasan. Will have a look
> 
> All errors (new ones prefixed by >>):
> 
>    arch/s390/purgatory/purgatory: In function `verify_sha256_digest':
>>> (.text+0x20c6): undefined reference to `__asan_report_load8_noabort'
>    (.text+0x20e8): undefined reference to `__asan_report_load8_noabort'
>    (.text+0x212a): undefined reference to `memcmp'
>    arch/s390/purgatory/purgatory: In function `sha256_update':
>    (.text+0x21e4): undefined reference to `__asan_report_load8_noabort'
>>> (.text+0x22b6): undefined reference to `__asan_report_load4_noabort'
>>> (.text+0x2308): undefined reference to `__asan_report_store4_noabort'
>    (.text+0x236e): undefined reference to `__asan_report_load4_noabort'
>    (.text+0x23d8): undefined reference to `__asan_report_load4_noabort'
>    (.text+0x2432): undefined reference to `__asan_report_load4_noabort'
>    (.text+0x2498): undefined reference to `__asan_report_load4_noabort'
>    (.text+0x24f2): undefined reference to `__asan_report_store4_noabort'
>    (.text+0x254c): undefined reference to `__asan_report_load4_noabort'
>    (.text+0x25a2): undefined reference to `__asan_report_load4_noabort'
>    (.text+0x25f8): undefined reference to `__asan_report_load4_noabort'
>    (.text+0x264e): undefined reference to `__asan_report_load4_noabort'
>    (.text+0x26a4): undefined reference to `__asan_report_load4_noabort'
>    arch/s390/purgatory/purgatory:(.text+0x26fa): more undefined references to `__asan_report_load4_noabort' follow
>    arch/s390/purgatory/purgatory: In function `__sha256_final':
>>> sha256.c:(.text+0x4062): undefined reference to `__asan_report_load8_noabort'
>>> sha256.c:(.text+0x4120): undefined reference to `__asan_report_load4_noabort'
>>> sha256.c:(.text+0x416e): undefined reference to `__asan_report_store4_noabort'
>    arch/s390/purgatory/purgatory: In function `_GLOBAL__sub_D_65535_0_sha256_update':
>    sha256.c:(.text+0x4444): undefined reference to `__asan_unregister_globals'
>    arch/s390/purgatory/purgatory: In function `_GLOBAL__sub_I_65535_1_sha256_update':
>    sha256.c:(.text+0x4454): undefined reference to `__asan_register_globals'
> 
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
> 
