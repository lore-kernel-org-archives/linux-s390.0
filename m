Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B6AD29B
	for <linux-s390@vger.kernel.org>; Fri, 23 Feb 2024 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708683615; cv=none; b=rbThhfmgeAEtL/aeJ0Z2GDWb27P0b36opsmObOFfYYCEIOCtWqmc0RjVrCKd7TOZmXqUv/9ReL8EaGRa7XBOnJ/dDk7sk2kMACpkxfNS/1c8inENaOHH9rZP6QlZcxCM5FRWsMPQqfwT+q+I4B/GKFS1fot54e+t8+abaJSN/68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708683615; c=relaxed/simple;
	bh=PClgToOJp81/D0mWBOvjeQJNlCS3lXxceh3Fk7pWJ7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VnDrlENSrcE+6S6f/U4T/t2gEpx4xn0vgngReeeTiEVEfqz4Fw+HkCNuVuettfjk7BlSby4eZHPdTp23xVW+KpMclrdzpDbMFr7aOqtbRhfUfoegLSGTbHo5pIlBjwDVFHyinD2OTqE36AndPh6cNCVU8d31dVBq65LCUnRJp0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BtkFm5D8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BtkFm5D8"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NACQ4U026854;
	Fri, 23 Feb 2024 10:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=vig6GEwdge8llZPYqmgOR6fuLibsnWWIDPTnxOFEMH0=;
 b=BtkFm5D8XRycXC6CmhYWkRJp+WxAxVL36HHqe6nsr35xOAqho3RyWS5Wp9hYSD8/ixWJ
 d4ZeyzuCqM47nY08C7YMHc4Cc7ao5ND01zBs+mot/kmsvI4jDdS5zfcBvbnrWNYGo7Hf
 U1o9UI+2N+PU9Wfr8dO7E/GrXYCmoepes4UkHtV9aQC0UJrKTzEqr8C4EPtFIp3aLSci
 Ob4cwWVWhbcfYZZ2CsDJYSdAPvGiKPTOqr44Qjmi20Z4GbpbsgN3Dc+Zqbzey2v0UdaQ
 d8WXT7/1/+jXlPkExhh9KDXs6kJnQQPeNw4oJe3lHa+BXkeKJQP2CpjYwR+F0HmWoFP2 Pw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wesdcg540-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 10:20:04 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41N9ieuT031135;
	Fri, 23 Feb 2024 10:20:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9bmc8e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 10:20:03 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NAJvLw43713132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 10:20:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA05F20163;
	Fri, 23 Feb 2024 10:19:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CE4B2015F;
	Fri, 23 Feb 2024 10:19:57 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.171.84.185])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 23 Feb 2024 10:19:57 +0000 (GMT)
Date: Fri, 23 Feb 2024 11:19:55 +0100
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: kernel test robot <lkp@intel.com>, s-vadapalli@ti.com,
        r-gunasekaran@ti.com, rogerq@kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, oe-kbuild-all@lists.linux.dev,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        iii@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        davem@davemloft.net, naresh.kamboju@linaro.org
Subject: Re: [s390:features 97/98] Unsupported relocation type: 21
Message-ID: <ZdhxS3o1NzdJYzMQ@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <202402221404.T2TGs8El-lkp@intel.com>
 <ZdhtYc9THmX4Ddse@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdhtYc9THmX4Ddse@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xqpXlZGXE90bhzeefEaa6FmLWEjL2e4B
X-Proofpoint-ORIG-GUID: xqpXlZGXE90bhzeefEaa6FmLWEjL2e4B
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=908
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402230072

On Fri, Feb 23, 2024 at 11:03:13AM +0100, Sumanth Korikkar wrote:
> On Thu, Feb 22, 2024 at 02:42:01PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
> > head:   4a5993287467d2d0401503256dc9d2690c7f2020
> > commit: 778666df60f0d96f215e33e27448de47a2207fb3 [97/98] s390: compile relocatable kernel without -fPIE
> > config: s390-randconfig-002-20231016 (https://download.01.org/0day-ci/archive/20240222/202402221404.T2TGs8El-lkp@intel.com/config)
> > compiler: s390-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240222/202402221404.T2TGs8El-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202402221404.T2TGs8El-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> Unsupported relocation type: 21
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> >
> 
> In the random config generated by lkp test robot
> 
>  CONFIG_TI_CPSW=m
>  CONFIG_TI_DAVINCI_EMAC=y
> 
> In drivers/net/ethernet/ti/Makefile:
>  11 obj-$(CONFIG_TI_DAVINCI_EMAC) += ti_davinci_emac.o
>  12 ti_davinci_emac-y := davinci_emac.o davinci_cpdma.o
>  ...
>  16 obj-$(CONFIG_TI_CPSW) += ti_cpsw.o
>  17 ti_cpsw-y := cpsw.o davinci_cpdma.o cpsw_ale.o cpsw_priv.o cpsw_sl.o cpsw_ethtool.o
> 
> Here davinci_cpdma.o is used in both   obj-$(CONFIG_TI_DAVINCI_EMAC) and
> obj-$(CONFIG_TI_CPSW), one built as inbuilt and one built as module
> correspondingly (randconfig)
> 
> This leads to conflict in Kbuild and results in linking  davinci_cpdma.o
> in vmlinux.
> * However, davinci_cpdma.o is built with -DMODULE -fPIC.
> * vmlinux is built with -fno-PIE.
> 
> This leads to R_390_GOTENT and R_390_GOTDBL entries in vmlinux, which is
> not expected when building kernel with -fno-PIE.

typo: R_390_GOTPCDBL

Thank you,
Sumanth
