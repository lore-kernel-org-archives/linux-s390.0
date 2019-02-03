Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Sun, 3 Feb 2019 17:25:02 +0800
From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI command
Message-ID: <201902031742.ujudXHUQ%fengguang.wu@intel.com>
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: kbuild-all@01.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com, freude@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, cohuck@redhat.com
List-ID: <linux-s390.vger.kernel.org>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Tony,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.0-rc4 next-20190201]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Tony-Krowiak/zcrypt-handle-AP-Info-notification-from-CHSC-SEI-command/20190202-184856
config: s390-alldefconfig (attached as .config)
compiler: s390x-linux-gnu-gcc (Debian 8.2.0-11) 8.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.2.0 make.cross ARCH=s390 

All errors (new ones prefixed by >>):

   In file included from arch/s390/kvm/kvm-s390.c:46:
>> arch/s390/include/asm/ap.h:371:2: error: #error "no CONFIG_ZCRYPT"
    #error "no CONFIG_ZCRYPT"
     ^~~~~
   In file included from arch/s390/kvm/kvm-s390.c:46:
   arch/s390/include/asm/ap.h:372:13: warning: 'ap_bus_cfg_chg' defined but not used [-Wunused-function]
    static void ap_bus_cfg_chg(void){};
                ^~~~~~~~~~~~~~

vim +371 arch/s390/include/asm/ap.h

   362	
   363	/*
   364	 * Interface to tell the AP bus code that a configuration
   365	 * change has happened. The bus code should at least do
   366	 * an ap bus resource rescan.
   367	 */
   368	#if IS_ENABLED(CONFIG_ZCRYPT)
   369	void ap_bus_cfg_chg(void);
   370	#else
 > 371	#error "no CONFIG_ZCRYPT"
   372	static void ap_bus_cfg_chg(void){};
   373	#endif
   374	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--ZPt4rx8FFjLCG7dd
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ZPt4rx8FFjLCG7dd--
