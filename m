From: kbuild test robot <lkp@intel.com>
Date: Wed, 10 Oct 2018 07:06:17 +0000
Subject: [s390:features 32/77] arch/s390/boot/mem_detect.c:77:12: error: 'EFAULT' undeclared
Message-Id: <201810101515.F6Y4TvTH%fengguang.wu@intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--IJpNTDwzlM2Ie8A6"
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
head:   c72251ad879056d096d39db21c08cb52e481eb2d
commit: 6966d604e2ec4ecf5691aea953538f63597a250d [32/77] s390/mem_detect: move tprot loop to early boot phase
config: s390-allnoconfig (attached as .config)
compiler: s390x-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 6966d604e2ec4ecf5691aea953538f63597a250d
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=s390 

Note: the s390/features HEAD c72251ad879056d096d39db21c08cb52e481eb2d builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   arch/s390/boot/mem_detect.c: In function 'tprot':
>> arch/s390/boot/mem_detect.c:77:12: error: 'EFAULT' undeclared (first use in this function)
     int rc = -EFAULT;
               ^~~~~~
   arch/s390/boot/mem_detect.c:77:12: note: each undeclared identifier is reported only once for each function it appears in

vim +/EFAULT +77 arch/s390/boot/mem_detect.c

    73	
    74	static int tprot(unsigned long addr)
    75	{
    76		unsigned long pgm_addr;
  > 77		int rc = -EFAULT;
    78		psw_t old = S390_lowcore.program_new_psw;
    79	
    80		S390_lowcore.program_new_psw.mask = __extract_psw();
    81		asm volatile(
    82			"	larl	%[pgm_addr],1f\n"
    83			"	stg	%[pgm_addr],%[psw_pgm_addr]\n"
    84			"	tprot	0(%[addr]),0\n"
    85			"	ipm	%[rc]\n"
    86			"	srl	%[rc],28\n"
    87			"1:\n"
    88			: [pgm_addr] "=&d"(pgm_addr),
    89			  [psw_pgm_addr] "=Q"(S390_lowcore.program_new_psw.addr),
    90			  [rc] "+&d"(rc)
    91			: [addr] "a"(addr)
    92			: "cc", "memory");
    93		S390_lowcore.program_new_psw = old;
    94		return rc;
    95	}
    96	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--IJpNTDwzlM2Ie8A6
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--IJpNTDwzlM2Ie8A6--
