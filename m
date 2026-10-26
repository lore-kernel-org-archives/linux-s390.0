Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793023739;
	b=LvI8+YFgmsgL3eOa180zZOv9Pd2yEWll8HSOCXStdoxoIVEPylEhly0DOjqrOs7TPu71
	 vwrwll5FtInHgjbDhOmmMMcI5+QQ/7WKC9mfFGTqsU2SCrgA2dDcRbNC8pO0rnQmkQkxa
	 kv51zJov2j1RvA4S5D8pyxX3EO/cmw8jVmQ6uzVrA1dTkvFKvfAxuS6ti7lEPV42CIGKA
	 TFKIWm4orHPnHEt1ad52bHTGscI2EOXE1jHAeywa7CU7ksyl9iztACAzJVk8NbOquKuVD
	 A0TY/zRGHPhEd/P3XOM9+i5x8rRWqDMEC1aTe984cua8cSOfATPj8P8YRxR2vesSofQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793023739;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=3+mGpR/2FcDneFgY44HK0X4qXpztWCSnCE/KMlqe350=;
	b=frFPyRvWfo9tfuyqoZ7CfWen27ElbJ2PuiJRJ5dkrSabo6ujX3JPrrgVZos195Pjnb29
	 PtzUFo6AIJ1eljKdrClo/fvYJRcUFMbBcIlwN3MVqZnNnTLtX6SMzurJKCqH68ymAWygY
	 a2K0s2J9YUzOWpMpZwUPJIzYJNr4Sjuib+JsD2u9d1B2SzzEOgbQBvD239V60MgjLn/0L
	 HB7miw3OY14Cdfzb8a2d/cW99+ZvD6Z1ECsXjo5ENYzYBbxOobIYk5wwRJaV2ZXgrrknz
	 XyHlZC4mi9EsRxZDrE8kiVX8MdLMTsFRNY16T8UIXPp9iFNNwVXZDXGX+h7v5gUXiVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="Qg/aaj7m";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12561606A31A;
	Mon, 26 Oct 2026 14:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12561606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Qg/aaj7m
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QBEHRj3357275;
	Mon, 26 Oct 2026 14:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3+mGpR
	/2FcDneFgY44HK0X4qXpztWCSnCE/KMlqe350=; b=Qg/aaj7mqQbaMqj5BSK2C1
	d291cgfJezV987SektdL6Sj+jW/TzLuc4ZYpqYczdxzRo1UXe9QR/C/i7Nfa7TJi
	38s/uzrHaloXVDl7vCcdJ81qPFv1M2/IThufy7j5regMWxOD9O8f+jAZQ87LfGvB
	YJVKlTYR17qi2FJFqiIJSPmdbwiPdyJo5yO49XZXMenRdBLwAv4ubKBz28G3vrz/
	yWSYlLE2Kr1oFia5cNBDnjtmimAaU1dinBM0tfgJNwg3jnLrc4Km85fwIi6PFFRW
	qsZQyFiHkGH/H0HWgBF3oO84nDBxdSXzBUlR13uAT+c1Sc6HfcDOufZGQKeFUPlg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmav9yqu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 14:08:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QB5JWV2503050;
	Mon, 26 Oct 2026 14:08:43 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hh9py606e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 14:08:43 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69QE8fvD51249534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Oct 2026 14:08:41 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FC5A58052;
	Mon, 26 Oct 2026 14:08:41 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D90335805D;
	Mon, 26 Oct 2026 14:08:39 +0000 (GMT)
Received: from [9.61.99.193] (unknown [9.61.99.193])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Oct 2026 14:08:39 +0000 (GMT)
Message-ID: <fefd4df9-4777-450c-9078-718f8ea55308@linux.ibm.com>
Date: Mon, 26 Oct 2026 10:08:39 -0400
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 03/15] s390/vfio-ap: Functions to initialize/release
 vfio device migration data
To: kernel test robot <lkp@intel.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, jjherne@linux.ibm.com,
        borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20261023174349.3545941-4-akrowiak@linux.ibm.com>
 <202610241421.XoTPxllD-lkp@intel.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <202610241421.XoTPxllD-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=P8SvFSAu c=1 sm=1 tr=0 ts=6adf5eec cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=anyJmfQTAAAA:8
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=i3X5FwGiAAAA:8
 a=QyXUC8HyAAAA:8 a=GX393M_rzUjNoeBSXGMA:9 a=QEXdDO2ut3YA:10
 a=mmqRlSCDY2ywfjPLJ4af:22
X-Proofpoint-GUID: -5bIaNUMOoDmAkLjAiBf99pFTxTmbYko
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1NCBTYWx0ZWRfX0q7Lf+DA0KS7
 o92Oa2f7gw94b2cNVVG1uweteovYfJBviUkQDeGEJed3OLxOTE6/a8idnwNi9aro3664pyr9ktW
 Ob/6WIL2h/eV5YxOWc5fWDag+EqhA4I=
X-Proofpoint-ORIG-GUID: -5bIaNUMOoDmAkLjAiBf99pFTxTmbYko
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1NCBTYWx0ZWRfX4eVOuz7xwFlw
 dJAly447spu7ECGoCdz4Z8sdoYT7XX5yNAYq3tzP/JxvqcnXsSDD7cnKdzqjL+GoEOYO4fjIz5V
 q8BhhxgH9b0lg9JMjpXrSeDG+/AUG+tg/1YJI1g/2Swz6XVhRxRfRlZx04xQxyPWUh6pL/+ZfDd
 /teRbSYWbcnBigcaGhDMXLdxomz9dualO97pXhaJeqd1mqYHQ2zqKQ/pE3Ed8XOFirUrULghcAJ
 qiI+7msSmtqEgKPHtrTSr66uR9TQrHiljl0bp43PTRC8GGZAJk7zFIKS4s0x9tazphL1hxtq7Wh
 stVGFnNpfsMrrXtEE+zo3wVg3V9xg2oniCY/P9vws/Y9Y3g4fSMreywzDXcipOkcGbTeZ4vevjh
 jI2tDkYKSOvWnSdBTV2quh421OBLUHhmTKgG3eConQ+AdAggytlw/0aKlU+fDJl3Q+GESiAXUBq
 tLM/5y2kxE+GLA22n6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1011 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260054



On 10/24/26 3:11 AM, kernel test robot wrote:
> Hi Anthony,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on kvms390/next]
> [also build test WARNING on s390/features mst-vhost/linux-next linus/master v7.3 next-20261022]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Anthony-Krowiak/s390-vfio-ap-Provide-function-to-get-the-number-of-queues-assigned-to-mdev/20261023-134335
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git next
> patch link:    https://lore.kernel.org/r/20261023174349.3545941-4-akrowiak%40linux.ibm.com
> patch subject: [PATCH v10 03/15] s390/vfio-ap: Functions to initialize/release vfio device migration data
> config: s390-defconfig (https://download.01.org/0day-ci/archive/20261024/202610241421.XoTPxllD-lkp@intel.com/config)
> compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261024/202610241421.XoTPxllD-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202610241421.XoTPxllD-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>     Warning: drivers/s390/crypto/vfio_ap_migration.c:208 function parameter 'matrix_mdev' not described in 'vfio_ap_release_migration_data'
>>> Warning: drivers/s390/crypto/vfio_ap_migration.c:208 Excess function parameter 'mdev' description in 'vfio_ap_release_migration_data' (did you mean one of: 'matrix_mdev')
>     Warning: drivers/s390/crypto/vfio_ap_migration.c:208 function parameter 'matrix_mdev' not described in 'vfio_ap_release_migration_data'
>>> Warning: drivers/s390/crypto/vfio_ap_migration.c:208 Excess function parameter 'mdev' description in 'vfio_ap_release_migration_data' (did you mean one of: 'matrix_mdev')

Yes, it should be matrix_mdev .. to be fixed.

> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

