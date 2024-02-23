Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCA229D08
	for <linux-s390@vger.kernel.org>; Fri, 23 Feb 2024 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708682614; cv=none; b=GUhc8LNlHnHmlU0GaBgo0M4233m4JuH5unDGSeu+K8RtuL+lio/7IHfy7Z/fFElbL+jr1AK1VveHsQdb/OwYmNEXjnIZA0doYVhew0Oj2omEOMQBtxoEsT/jtfx6MMzGwXUP2PUsq7cGEMCE9rcsfOzmQGyPA2eT78gskpPkoGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708682614; c=relaxed/simple;
	bh=mLo7+VnYV02ZgzoF7QLmcWeEgudYKYv2gtSFelVGSB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NFaT2SWtfx61W5A3W9h0ntyanbXkCxIwsn7fLbBqzAyDpPvg/K7pkAUxPAo9RBmD9R0L8WJG9M5OFRpAFSEkrzqyJ3pQczApLhqtnfdHESmCREtlC1JBGw0JlIl2Mkv9+D7n7rY/Kp+0jXxQuxV4Se+/f6saGTCAPYMa2cVRgQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XBOFONjR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XBOFONjR"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NA22VP016573;
	Fri, 23 Feb 2024 10:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=niRJAWpgDm64SvML3GR/bYc+uOAH9v4H9hfBmZsEiP8=;
 b=XBOFONjRhTN//tCstzQlvPwdc1IK47bU1b3VDXz42LrgUGPVAXbJnwzhpsDb3+FOwiOV
 paftOp02UTHfxeGeQe1Tq+sRs1+a0Y8Ughv4oy5k4aXv+QBgdLxwD0mNzI2nCs6dVxiQ
 6GkKXuegWDMcGWaIA1M0P7y0eShSSB6b7kyuWIHN0I9WD3P5MuLWvShN+7tJm5j+NJLB
 eSUKxl7AarMGb/F+/y9jKVC38Y5wk1z+leYXIEl9S4sF24rhRcFX0QpFWtFQegUrqfyW
 cpAWr48VkJAdF5Sz1iXQjFNoLg5ZwW6zNEW/d+40bVMrgYBECoL2n8BuUzvVGCJpaWHR mA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wes8k00y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 10:03:22 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41N7bVIp003596;
	Fri, 23 Feb 2024 10:03:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74u4ugu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 10:03:21 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NA3GPX21234346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 10:03:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58C4F20063;
	Fri, 23 Feb 2024 10:03:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 729C72004B;
	Fri, 23 Feb 2024 10:03:15 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.171.84.185])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 23 Feb 2024 10:03:15 +0000 (GMT)
Date: Fri, 23 Feb 2024 11:03:13 +0100
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: kernel test robot <lkp@intel.com>, s-vadapalli@ti.com,
        r-gunasekaran@ti.com, rogerq@kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, oe-kbuild-all@lists.linux.dev,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        iii@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        naresh.kamboju@linaro.org
Subject: Re: [s390:features 97/98] Unsupported relocation type: 21
Message-ID: <ZdhtYc9THmX4Ddse@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <202402221404.T2TGs8El-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402221404.T2TGs8El-lkp@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PGNQ-aaxz9pZfStkwQzfzKj6Fp4xcBxM
X-Proofpoint-ORIG-GUID: PGNQ-aaxz9pZfStkwQzfzKj6Fp4xcBxM
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230070

On Thu, Feb 22, 2024 at 02:42:01PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
> head:   4a5993287467d2d0401503256dc9d2690c7f2020
> commit: 778666df60f0d96f215e33e27448de47a2207fb3 [97/98] s390: compile relocatable kernel without -fPIE
> config: s390-randconfig-002-20231016 (https://download.01.org/0day-ci/archive/20240222/202402221404.T2TGs8El-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240222/202402221404.T2TGs8El-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202402221404.T2TGs8El-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> Unsupported relocation type: 21
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

In the random config generated by lkp test robot

 CONFIG_TI_CPSW=m
 CONFIG_TI_DAVINCI_EMAC=y

In drivers/net/ethernet/ti/Makefile:
 11 obj-$(CONFIG_TI_DAVINCI_EMAC) += ti_davinci_emac.o
 12 ti_davinci_emac-y := davinci_emac.o davinci_cpdma.o
 ...
 16 obj-$(CONFIG_TI_CPSW) += ti_cpsw.o
 17 ti_cpsw-y := cpsw.o davinci_cpdma.o cpsw_ale.o cpsw_priv.o cpsw_sl.o cpsw_ethtool.o

Here davinci_cpdma.o is used in both   obj-$(CONFIG_TI_DAVINCI_EMAC) and
obj-$(CONFIG_TI_CPSW), one built as inbuilt and one built as module
correspondingly (randconfig)

This leads to conflict in Kbuild and results in linking  davinci_cpdma.o
in vmlinux.
* However, davinci_cpdma.o is built with -DMODULE -fPIC.
* vmlinux is built with -fno-PIE.

This leads to R_390_GOTENT and R_390_GOTDBL entries in vmlinux, which is
not expected when building kernel with -fno-PIE.

Debug data:
==========
1.
  CALL    ../scripts/checksyscalls.sh
  AR      drivers/phy/ti/built-in.a
  CC [M]  drivers/phy/ti/phy-gmii-sel.o
../scripts/Makefile.build:243: ../drivers/net/ethernet/ti/Makefile:
davinci_cpdma.o is added to multiple modules: ti_cpsw ti_davinci_emac <<<<<<<<
  CC [M]  drivers/net/ethernet/ti/davinci_cpdma.o
...
  CC [M]  drivers/net/ethernet/ti/cpsw.o
  CC [M]  drivers/net/ethernet/ti/cpsw_ale.o
  CC [M]  drivers/net/ethernet/ti/cpsw_priv.o
  CC [M]  drivers/net/ethernet/ti/cpsw_sl.o
  CC [M]  drivers/net/ethernet/ti/cpsw_ethtool.o
  AR      drivers/phy/built-in.a
  AR      drivers/net/ethernet/ti/built-in.a
  LD [M]  drivers/net/ethernet/ti/ti_cpsw.o
  AR      drivers/net/ethernet/built-in.a
  AR      drivers/net/built-in.a
  AR      drivers/built-in.a
  AR      built-in.a


2.
ti/.davinci_cpdma.o.cmd:savedcmd_drivers/net/ethernet/ti/davinci_cpdma.o
:= This uses -DMODULE -fPIC  <<<<<<

built-in.a:ti/davinci_cpdma.o/ <<<<<


Hence, the error by lkp robot. No fix should be necessary in
s390/tools/relocs.c

I think it should be either fixed in ti driver or in the kbuild.

Thank you,
Sumanth
