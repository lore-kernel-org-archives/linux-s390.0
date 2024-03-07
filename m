Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5175812F37A
	for <linux-s390@vger.kernel.org>; Thu,  7 Mar 2024 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709826769; cv=none; b=mFvZp1c/B5K172kYTFHQsB/trI/MGy8y+WL7pejulxg+ob5bpUetgDwx7TOxHxZU3qGRgCJyozxXsO0jGTGkpHz8PXVm+hQr6AivMnrdXGNsj/LyjYMoAucplrHrOOS48nPwyUqbJYG12Jgd9RVSgFn7hlzBDatVxORORKmAdNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709826769; c=relaxed/simple;
	bh=Y68jNn/EP5ZMnApVDrSItbb/aPFVYvThDuuIDqYz2Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p+212+MNUacH9EiATJ9rL3AfynaPi6rHhLWZ0IXkZEjYe5FehVSJGg0hXTM0TnOvHNuTqiHgfDkyrZaDTN0+3mi1OjBYvQtUgFddvzyNPCgiGKqylcv1erMHY8J1Nn0ieFXlvvQLi8JPJxBiOH+po+NgvhXd/n/2eeEh6/m3B2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qYYTsXrO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qYYTsXrO"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 427FSt5t006257;
	Thu, 7 Mar 2024 15:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=xbfKqMSDNm9lScy29WARLRR7/Mxmn4Yd8lWC9o9E324=;
 b=qYYTsXrOhd0bijSo083uFhdrDaHBiIu1MgdSTL5KXlYYzjJtHg9ZfPiAP0/DQzGrfFbU
 XQZbd/ioCS9XtvJl+llptNHScAJ6v6HZWqmDvO3U4+wPSVXo0XQ+h1Lkf94NJLGpKsSj
 d5ZJY17K9SdklsqZTUImQDr3kJ7h/O0e0q0tp3PaSXfXC0mdmTX46J05ki6jNjI+zAa5
 F/iLZUcO1lrDeJeaZeT43pPHUxmfGqf+JGFg1cAVc0XqgBxIi0crUj/xiC1BOFS8kV/I
 UxNBrlPzD5IT0Du5Bir1Ouho5sGXOZu/qm7eB6/pOx4H6K1A0CrKW1T0m8Kelj2ZxwkE 0g== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqg8vrx4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 15:52:28 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 427FKCdb031530;
	Thu, 7 Mar 2024 15:52:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmgnke65c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 15:52:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 427FqLlr37421522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Mar 2024 15:52:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 478A72004B;
	Thu,  7 Mar 2024 15:52:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F248820040;
	Thu,  7 Mar 2024 15:52:20 +0000 (GMT)
Received: from localhost (unknown [9.152.212.42])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  7 Mar 2024 15:52:20 +0000 (GMT)
Date: Thu, 7 Mar 2024 16:52:19 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        kernel test robot <lkp@intel.com>, s-vadapalli@ti.com,
        r-gunasekaran@ti.com, rogerq@kernel.org, oe-kbuild-all@lists.linux.dev,
        linux-s390@vger.kernel.org, iii@linux.ibm.com, agordeev@linux.ibm.com,
        davem@davemloft.net, naresh.kamboju@linaro.org
Subject: Re: [s390:features 97/98] Unsupported relocation type: 21
Message-ID: <your-ad-here.call-01709826739-ext-7829@work.hours>
References: <202402221404.T2TGs8El-lkp@intel.com>
 <ZdhtYc9THmX4Ddse@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <20240223235939.abycpq35ydgahdz2@treble>
 <Zdxt97Ni3p8ptNyv@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <ZdyKJMEkm6r_ArrZ@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <ZenfbNt966EMJcsY@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZenfbNt966EMJcsY@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uuInPfpuHRmH-oVWgdTNCR97L_HNB0pU
X-Proofpoint-ORIG-GUID: uuInPfpuHRmH-oVWgdTNCR97L_HNB0pU
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2403070087

On Thu, Mar 07, 2024 at 04:38:20PM +0100, Sumanth Korikkar wrote:
> On Mon, Feb 26, 2024 at 01:55:02PM +0100, Sumanth Korikkar wrote:
> > On Mon, Feb 26, 2024 at 11:54:50AM +0100, Sumanth Korikkar wrote:
> > > Hi Josh,
> > > 
> > > On Fri, Feb 23, 2024 at 03:59:39PM -0800, Josh Poimboeuf wrote:
> > > > On Fri, Feb 23, 2024 at 11:03:13AM +0100, Sumanth Korikkar wrote:
> > > > > In the random config generated by lkp test robot
> > > > > 
> > > > >  CONFIG_TI_CPSW=m
> > > > >  CONFIG_TI_DAVINCI_EMAC=y
> > > > > 
> > > > > In drivers/net/ethernet/ti/Makefile:
> > > > >  11 obj-$(CONFIG_TI_DAVINCI_EMAC) += ti_davinci_emac.o
> > > > >  12 ti_davinci_emac-y := davinci_emac.o davinci_cpdma.o
> > > > >  ...
> > > > >  16 obj-$(CONFIG_TI_CPSW) += ti_cpsw.o
> > > > >  17 ti_cpsw-y := cpsw.o davinci_cpdma.o cpsw_ale.o cpsw_priv.o cpsw_sl.o cpsw_ethtool.o
> > > > > 
> > > > > Here davinci_cpdma.o is used in both   obj-$(CONFIG_TI_DAVINCI_EMAC) and
> > > > > obj-$(CONFIG_TI_CPSW), one built as inbuilt and one built as module
> > > > > correspondingly (randconfig)
> > > > > 
> > > > > This leads to conflict in Kbuild and results in linking  davinci_cpdma.o
> > > > > in vmlinux.
> > > > > * However, davinci_cpdma.o is built with -DMODULE -fPIC.
> > > > > * vmlinux is built with -fno-PIE.
> > > > > 
> > > > > This leads to R_390_GOTENT and R_390_GOTDBL entries in vmlinux, which is
> > > > > not expected when building kernel with -fno-PIE.
> > > > 
> > > > Nice.
> > > > 
> > > > I suppose the current s390 memory model wouldn't support removing
> > > > -fPIC for modules?
> > > 
> > > Answer from our toolchain team - Andreas Krebbel: It should be ideally
> > > feasible to build modules without -fPIC on s390.
> > 
> > FWIW, I'm looking into this right now. Let's see how things go.
> 
> From d6641b8492ade37709a7099cea0ef71f29d062d0 Mon Sep 17 00:00:00 2001
> From: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Date: Thu, 7 Mar 2024 09:46:11 +0100
> Subject: [PATCH] s390/tools: handle rela R_390_GOTPCDBL/R_390_GOTOFF64
> 
> lkp test robot reported unhandled relocation type: R_390_GOTPCDBL, when
> kernel is built with -fno-PIE. relocs tool reads vmlinux and handles
> absolute relocations.  PC relative relocs doesn't need adjustment.
> 
> Also, the R_390_GOTPCDBL/R_390_GOTOFF64 relocations are present
> currently only when KASAN is enabled.
> 
> The following program can create a R_390_GOTPCDBL/R_390_GOTOFF64 reloc
> (with fPIE/fPIC).
> 
> void funcb(int *b) {
>   *b = *b + 100;
> }
> 
> void gen_gotoff(void)
> {
>   int b = 10;
>   funcb (&b);
> }
> 
> gcc -c sample.c -fPIC -fsanitize=kernel-address --param asan-stack=1
> 
> The above example (built with -fPIC) was linked to one of the
> built-in.a (built with -fno-PIE) and checked for correctness with kaslr
> enabled. Both the relocs turns out relative and can be skipped.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402221404.T2TGs8El-lkp@intel.com/
> Fixes: 55dc65b46023 ("s390: add relocs tool")
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>  arch/s390/tools/relocs.c | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Vasily Gorbik <gor@linux.ibm.com>
