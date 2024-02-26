Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7C42206B
	for <linux-s390@vger.kernel.org>; Mon, 26 Feb 2024 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944907; cv=none; b=d9jjhzCzdPrIAwE+CYBsqbV59sjWntw7uCNWGse11ZpffWNLCZ0igbJ0plKt0VwuRMl9CUKs34ZBy6EMzhrBPTU1Eby2DAuMeTJV8v2mppxomTZvU75CVVuVsnvFy2ah63nKAUJAoJK4NbVK7ERZGW7b4Vsj842cwsJgY+QJfYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944907; c=relaxed/simple;
	bh=8rRzKisEKupWC8GD43hPvylPwFt87S4H82aDqq+xsac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azgCySMuplxoHetUO/mLKprA/mYsSRLHw+LtlPF2LO1ABDnw9LP0IBXDDMG/RctkNaF3N+bWsgx4FSCn5ErcKUx7lOxOOb+4m60sTjjoRSpPdtzc4Y/U5MlMl+x+O5GqfEndkHtBS0qyj5/rqt9iYj/Utt4YqE4cPQ7/U90/to8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oSALd/38; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oSALd/38"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41Q9mcJ8020011;
	Mon, 26 Feb 2024 10:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=d3e/MSjox+N4pUcWMUfARPb1hohcvRfSL1tbZXP+lTk=;
 b=oSALd/38/4TBPYPaKKUjIPkulsyMpTpm3h4w5w89p+zaJbzI0fOxPeztz9+ZekKod27i
 71kImSJgS/Et61DnhRtWdBpx3A0+1Npy6Xpwmw+2ZU1KlNHI7qwmMEofCec51+R9rnfa
 LGpNBLbJzAUP5gK840iLHGnVayJjbp9idC0tLe1izbcssndFO3vLzd3TibKxd++JHwsE
 nUiSN93sjg9rux5KZtBjtCrvn8OOywH4UN64K7Eo80ILCWetSUCAKdn8OYyiIpSQK6pt
 x6bzhsBq2NpMlWJaa0/qck2ujzgpanBD3UYvH7l4TUiQM9UXRbe2WNfb5Pr6aidpVFe8 NQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wgnw8mq87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 10:54:57 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41Q88Qu5021786;
	Mon, 26 Feb 2024 10:54:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfu5yrp1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 10:54:55 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41QAsoc754395352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 10:54:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 082CE2004E;
	Mon, 26 Feb 2024 10:54:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57A2B2004D;
	Mon, 26 Feb 2024 10:54:49 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.171.21.235])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 26 Feb 2024 10:54:49 +0000 (GMT)
Date: Mon, 26 Feb 2024 11:54:47 +0100
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: kernel test robot <lkp@intel.com>, s-vadapalli@ti.com,
        r-gunasekaran@ti.com, rogerq@kernel.org, oe-kbuild-all@lists.linux.dev,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        iii@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        naresh.kamboju@linaro.org
Subject: Re: [s390:features 97/98] Unsupported relocation type: 21
Message-ID: <Zdxt97Ni3p8ptNyv@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <202402221404.T2TGs8El-lkp@intel.com>
 <ZdhtYc9THmX4Ddse@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <20240223235939.abycpq35ydgahdz2@treble>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223235939.abycpq35ydgahdz2@treble>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: azVaMXiblxtDq5yedN1owPAOxdATarfo
X-Proofpoint-GUID: azVaMXiblxtDq5yedN1owPAOxdATarfo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_07,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=876 adultscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402260082

Hi Josh,

On Fri, Feb 23, 2024 at 03:59:39PM -0800, Josh Poimboeuf wrote:
> On Fri, Feb 23, 2024 at 11:03:13AM +0100, Sumanth Korikkar wrote:
> > In the random config generated by lkp test robot
> > 
> >  CONFIG_TI_CPSW=m
> >  CONFIG_TI_DAVINCI_EMAC=y
> > 
> > In drivers/net/ethernet/ti/Makefile:
> >  11 obj-$(CONFIG_TI_DAVINCI_EMAC) += ti_davinci_emac.o
> >  12 ti_davinci_emac-y := davinci_emac.o davinci_cpdma.o
> >  ...
> >  16 obj-$(CONFIG_TI_CPSW) += ti_cpsw.o
> >  17 ti_cpsw-y := cpsw.o davinci_cpdma.o cpsw_ale.o cpsw_priv.o cpsw_sl.o cpsw_ethtool.o
> > 
> > Here davinci_cpdma.o is used in both   obj-$(CONFIG_TI_DAVINCI_EMAC) and
> > obj-$(CONFIG_TI_CPSW), one built as inbuilt and one built as module
> > correspondingly (randconfig)
> > 
> > This leads to conflict in Kbuild and results in linking  davinci_cpdma.o
> > in vmlinux.
> > * However, davinci_cpdma.o is built with -DMODULE -fPIC.
> > * vmlinux is built with -fno-PIE.
> > 
> > This leads to R_390_GOTENT and R_390_GOTDBL entries in vmlinux, which is
> > not expected when building kernel with -fno-PIE.
> 
> Nice.
> 
> I suppose the current s390 memory model wouldn't support removing
> -fPIC for modules?

Answer from our toolchain team - Andreas Krebbel: It should be ideally
feasible to build modules without -fPIC on s390.

> 
> Otherwise each driver could get its own copy of the object file:
> 
> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
> index d8590304f3df..ef6591b6a4c9 100644
> --- a/drivers/net/ethernet/ti/Makefile
> +++ b/drivers/net/ethernet/ti/Makefile
> @@ -9,14 +9,14 @@ obj-$(CONFIG_TI_CPSW_SWITCHDEV) += cpsw-common.o
>  
>  obj-$(CONFIG_TLAN) += tlan.o
>  obj-$(CONFIG_TI_DAVINCI_EMAC) += ti_davinci_emac.o
> -ti_davinci_emac-y := davinci_emac.o davinci_cpdma.o
> +ti_davinci_emac-y := davinci_emac.o emac_cpdma.o
>  obj-$(CONFIG_TI_DAVINCI_MDIO) += davinci_mdio.o
>  obj-$(CONFIG_TI_CPSW_PHY_SEL) += cpsw-phy-sel.o
>  obj-$(CONFIG_TI_CPTS) += cpts.o
>  obj-$(CONFIG_TI_CPSW) += ti_cpsw.o
> -ti_cpsw-y := cpsw.o davinci_cpdma.o cpsw_ale.o cpsw_priv.o cpsw_sl.o cpsw_ethtool.o
> +ti_cpsw-y := cpsw.o cpsw_cpdma.o cpsw_ale.o cpsw_priv.o cpsw_sl.o cpsw_ethtool.o
>  obj-$(CONFIG_TI_CPSW_SWITCHDEV) += ti_cpsw_new.o
> -ti_cpsw_new-y := cpsw_switchdev.o cpsw_new.o davinci_cpdma.o cpsw_ale.o cpsw_sl.o cpsw_priv.o cpsw_ethtool.o
> +ti_cpsw_new-y := cpsw_switchdev.o cpsw_new.o cpsw_new_cpdma.o cpsw_ale.o cpsw_sl.o cpsw_priv.o cpsw_ethtool.o
>  
>  obj-$(CONFIG_TI_KEYSTONE_NETCP) += keystone_netcp.o
>  keystone_netcp-y := netcp_core.o cpsw_ale.o
> diff --git a/drivers/net/ethernet/ti/cpsw_cpdma.c b/drivers/net/ethernet/ti/cpsw_cpdma.c
> new file mode 100644
> index 000000000000..017156225e7f
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/cpsw_cpdma.c
> @@ -0,0 +1 @@
> +#include "davinci_cpdma.c"
> diff --git a/drivers/net/ethernet/ti/cpsw_new_cpdma.c b/drivers/net/ethernet/ti/cpsw_new_cpdma.c
> new file mode 100644
> index 000000000000..017156225e7f
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/cpsw_new_cpdma.c
> @@ -0,0 +1 @@
> +#include "davinci_cpdma.c"
> diff --git a/drivers/net/ethernet/ti/emac_cpdma.c b/drivers/net/ethernet/ti/emac_cpdma.c
> new file mode 100644
> index 000000000000..017156225e7f
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/emac_cpdma.c
> @@ -0,0 +1 @@
> +#include "davinci_cpdma.c"
> 

Tried compiling it,

When I enabled both CONFIG_TI_CPSW_SWITCHDEV and CONFIG_TI_DAVINCI_EMAC
to y, it could lead to the following:

  LD      vmlinux.o
ld: drivers/net/ethernet/ti/cpsw_new_cpdma.o: in function `cpdma_ctlr_create':
linux/drivers/net/ethernet/ti/davinci_cpdma.c:511:
multiple definition of `cpdma_ctlr_create';
drivers/net/ethernet/ti/emac_cpdma.o:linux/drivers/net/ethernet/ti/davinci_cpdma.c:511:
first defined here

Thanks,
Sumanth
