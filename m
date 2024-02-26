Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753A41C696;
	Mon, 26 Feb 2024 08:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935518; cv=none; b=pKWCMYZZNIQ9if4GGLOO2msKIamrqTLZhjvZ68JiIdav31v940gu5+M3r106TByJ+tuK6JMFhmJshTueRMi+gBD93TIr5IXyJbqMLwAYcNRXLiIWXgXjqPs9vEcCv8VuUOKkQcwoE8sndAqmfYEagG4g3nwXirn39IaO0KAbprg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935518; c=relaxed/simple;
	bh=TkeJLWSaleQ1V9sa6H8/Bn1o4lbURzv3H5YvCtOMVIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pKR+IxboRU9O3tfOm+d/2nHCNUb7Q+LqNMXitqr0PHRmiryd3SMcDqwiN6bwxJY8F5QHYAApPqvhe6MB2aawowKJo1lRU+aqOB9QcZyloAQHd2k9pYknScnNmBdSk800ntDVgxBHGGyRJrBStvmIAFqzfw6V2s4iL2q3q3/0hNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hScEjs0S; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hScEjs0S"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41Q7WvUw028547;
	Mon, 26 Feb 2024 08:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=262juMYYDaM9xYgeMFXljlcA/IggMHsKofu/AnWxIGc=;
 b=hScEjs0SKUQZfw9tU8m5J7SWN55JfMZq8yxP0QId0AV4VbyXDVqI6AwBqmESN+cU9/Cu
 a+pr13u+E55XNchfOYnOQKP1TSrZ5j88X4UcEUPIGQWm6h2oCH0mQO9/yfhUh28yHb/b
 uc5Cumg/k8YHR9poMzz+uVKV7I39cFtxnVKYro1WUkNVOW6LTkv4nR0304oWwSCrRJ1l
 rxnweVRKN9N1C3BM+XpaN4bssxsy6cx6Nv5pHj+sB3x4z2EbGmWUQ+rs9AofQwyEbaen
 fQzc5PjGaioKo/HV+sHGc1jL07sx4iVNR2JQiV/wKiz4Ic5Fuwjv/9V37xSEvl3FcZAn JA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wgpbkru4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 08:18:30 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41Q659DO008178;
	Mon, 26 Feb 2024 08:18:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfv9kykgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 08:18:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41Q8INfi39977504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 08:18:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79CCD2004E;
	Mon, 26 Feb 2024 08:18:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23F962004B;
	Mon, 26 Feb 2024 08:18:23 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.171.21.235])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 26 Feb 2024 08:18:23 +0000 (GMT)
Date: Mon, 26 Feb 2024 09:18:21 +0100
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: kernel test robot <lkp@intel.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, oe-kbuild-all@lists.linux.dev,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        agordeev@linux.ibm.com
Subject: Re: [s390:features 97/102] arch/s390/boot/startup.c:180:5: sparse:
 sparse: symbol 'vmlinux_relocs_64_start' was not declared. Should it be
 static?
Message-ID: <ZdxJTdGRt9kzPudk@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <202402260305.0Kp1dQiZ-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402260305.0Kp1dQiZ-lkp@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yvlxzqFiDWkoleV2HubV2v_OBHiiYFSM
X-Proofpoint-ORIG-GUID: yvlxzqFiDWkoleV2HubV2v_OBHiiYFSM
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_05,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402260061

On Mon, Feb 26, 2024 at 03:15:26AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
> head:   a795e5d2347def129734a7f247ac70339d50d8c2
> commit: 778666df60f0d96f215e33e27448de47a2207fb3 [97/102] s390: compile relocatable kernel without -fPIE
> config: s390-randconfig-r122-20240225 (https://download.01.org/0day-ci/archive/20240226/202402260305.0Kp1dQiZ-lkp@intel.com/config)
> compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project edd4aee4dd9b5b98b2576a6f783e4086173d902a)
> reproduce: (https://download.01.org/0day-ci/archive/20240226/202402260305.0Kp1dQiZ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202402260305.0Kp1dQiZ-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> arch/s390/boot/startup.c:180:5: sparse: sparse: symbol 'vmlinux_relocs_64_start' was not declared. Should it be static?
> >> arch/s390/boot/startup.c:181:5: sparse: sparse: symbol 'vmlinux_relocs_64_end' was not declared. Should it be static?
> 
> vim +/vmlinux_relocs_64_start +180 arch/s390/boot/startup.c
> 
>    175	
>    176	static void kaslr_adjust_got(unsigned long offset) {}
>    177	static void rescue_relocs(void) {}
>    178	static void free_relocs(void) {}
>    179	#else
>  > 180	int *vmlinux_relocs_64_start;
>  > 181	int *vmlinux_relocs_64_end;
>    182	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

This is already fixed by Alexander Gordeev in our branch and should be
available soon.

Thanks,
Sumanth
