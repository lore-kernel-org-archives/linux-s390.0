Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466201E49E
	for <linux-s390@vger.kernel.org>; Thu,  7 Mar 2024 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709828061; cv=none; b=p/rRz1CMQI6d3acSaa4elRzENYoH3v7nS/Bj1xquS+qzntFFzW33CrlIgnOFYVT6JF6kLifraZPXWzGl45v+8egUQY237QsYYDzH+4U5LbazqLvpp9dW2PBSnr7YomGIxWN9Un6e8I/iHWf3ECL+BGhKB7qKKDM7OWuB7JF3FnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709828061; c=relaxed/simple;
	bh=/zZU7TiE32bhPXQryUjgEDJmNxvnT2irI4tJC3exl9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pmw9KG/g8PUpl2Z7UTPhLOMRwxlis94/acxJmmvC0F2cDmnL1dOKI9z1Cq8JvsY8PWRoQjhtviXzxG77e7FnSs4+FJ38wo+VSiIhWRch0sC+jvRLpC6Em6EOrcLDgRAaZrhm7kx/MLq7FK1jq5Fqj7e0JZKPKtrXjrm9aB2cXMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H5DUx9Nz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H5DUx9Nz"
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 427FvZPW024748;
	Thu, 7 Mar 2024 16:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=IaMVAJfgY/9saSSlVJiM5pXaETRhhQqn1FGhpRKBL98=;
 b=H5DUx9NzqlEZ+9eAlmMLapS9O4VLHLZSm5P7Dfi76wiHuuaI618pL+dArAS5HAf4OCpe
 yBeAOtE++F9Sk/oR2yODyfFaaBLRajFMvmEZNCMxj4QvEmGSznGJBXnB0v+e+s0q9uMs
 c7n6s9z1zBmxdv4KAimVIMfcVjpdkGks4GqVXrvh9RlmYrQdMyLEZBwTwbbWcUey+WHB
 hgVZ778tvDclMT8hWu009MIy7EexXn5eMgLbpUS3CucRsHlx/SsOvodre3/ho8prMRME
 HnDXF0Y2buUdm/IE1aGNdqDHJhEzUyvGhll0lO3JoCWv2RIbtjgVdDa35p3sgYamH3Di 3A== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqgp28e0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 16:14:05 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 427G1Mcw006073;
	Thu, 7 Mar 2024 16:14:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmeetewga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 16:14:04 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 427GDwxE41681154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Mar 2024 16:14:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9ED42004B;
	Thu,  7 Mar 2024 16:13:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 738AE20043;
	Thu,  7 Mar 2024 16:13:58 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  7 Mar 2024 16:13:58 +0000 (GMT)
Date: Thu, 7 Mar 2024 17:13:56 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, gor@linux.ibm.com,
        kernel test robot <lkp@intel.com>, s-vadapalli@ti.com,
        r-gunasekaran@ti.com, rogerq@kernel.org, oe-kbuild-all@lists.linux.dev,
        linux-s390@vger.kernel.org, iii@linux.ibm.com, agordeev@linux.ibm.com,
        davem@davemloft.net, naresh.kamboju@linaro.org
Subject: Re: [s390:features 97/98] Unsupported relocation type: 21
Message-ID: <20240307161356.33873-D-hca@linux.ibm.com>
References: <202402221404.T2TGs8El-lkp@intel.com>
 <ZdhtYc9THmX4Ddse@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <20240223235939.abycpq35ydgahdz2@treble>
 <Zdxt97Ni3p8ptNyv@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <ZdyKJMEkm6r_ArrZ@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <ZenfbNt966EMJcsY@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZenfbNt966EMJcsY@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oCTpL17n9a2GXR0vvZgD9Np8kVbagBuq
X-Proofpoint-ORIG-GUID: oCTpL17n9a2GXR0vvZgD9Np8kVbagBuq
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 mlxlogscore=733 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403070110

On Thu, Mar 07, 2024 at 04:38:20PM +0100, Sumanth Korikkar wrote:
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

Applied, thanks!
