Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BA33CB567;
	Mon, 10 Aug 2026 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786363540; cv=none; b=OV8K6WruNgbWR3ZYmN0XIFPeQvlHAyfGZduVOXp3N3uBOZCkGL3UFIzGypDCCjmUkNL1hm0FqJdGdIFMaRtRY3AFrA9CgwDD/2++Dv2QyTy1sz1FTkJo47Y5OpRpwGuUqYRCCjK8z2jgA8o0lNGqWuHFXH4linsSRjgy/9a2nXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786363540; c=relaxed/simple;
	bh=RIwCP5SiEbHlZVarPVDhzeIjS0x9wO7mdn88f7ztRms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2FVMm0FzZ+I90aGjCSf2YlfXaT4ZEkJzHCCGazWpkK5uZSezAgL8IrwAkxY8GH3hfnyD5y7WKHR/jkADIEhJACqKi4Mohb18Q7ZehyzbV1m8toDf0zbRgrNtMnq+OORLo7RzJmrH9ox0IHG01a5pEynXPwgsCVLtHsIdSvHqkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ami5gf89; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ami5gf89"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A9VeW71169728;
	Mon, 10 Aug 2026 12:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9Uq4jW
	OEFGGkEyaip4XhqdPizQjHGkz6vYgTocKPAGQ=; b=Ami5gf899OOu/vkfDoH3DJ
	gLwmYDc96kiZMcv1QMxhQ+RLKMSIVYVWVdsMnq7hx2Q95oFKIZoji5a4UDeWFq2G
	kc05ISwBPmJ3MvmnBDxZ2abLROUAiXCkBnzHdP4AMpPdgWJrIMTvONUflZImraXN
	7J2rJlQ9hwc7qwebD18650F/5GO9fVt0P4Vw8EHBFVe+XEdIw256R3MH0C61EW4w
	0oj0MAEcb8/ukn5Mp9LbhseOsPtJcAFShXKEbxu2zTpPT/NptU0HirHjaxTEQSpH
	NKDtsTYe8czczWFbvocTWi7qFSARhwVEoeWr5mKPTZznlL+c5ksonrpA4KKLNuCA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2qec9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 12:05:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ABuE7G007628;
	Mon, 10 Aug 2026 12:05:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9gvksx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 12:05:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AC5UEC48693514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 12:05:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C9BD2004B;
	Mon, 10 Aug 2026 12:05:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 184AE20043;
	Mon, 10 Aug 2026 12:05:30 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 12:05:30 +0000 (GMT)
Message-ID: <c16e6836-c816-402d-8457-f763aa343356@linux.ibm.com>
Date: Mon, 10 Aug 2026 14:05:29 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] KVM: s390: vsie: Small VSIE cleanup and improvements
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>
References: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260807-vsie-cleanup-202607-v1-0-b18659b55e3d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a79be8f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=y2UNMCqQMAZ73icnnzUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: dMMK4CDEoD083Edy6G_zaQGgMHEfIIfN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEwMyBTYWx0ZWRfXx5bWTSeKFQmI
 N4IKmes1IoKkRkpQ9oB1VmqBD5dzjOiHwTvIqwXf529dgQkTarYtLeh6QdEZaChBKs0gLRpTAbz
 +fFE+WRa4vBhG9edG0OHSdfc2ceP56n9fe6xDBr6tvmWeo5xE4Pzfq2boynaGUCEQqBKeupauP8
 9y3NaoW1iyO4QvBfmaUFz9Tgx9cwKRLaPlKER+SYLnb12NWNj2/2sKQinAVSqkNkLWSXHfjiPgV
 ln+MzrlR1tnglPTr5+xNy71/jHNubhKo2uO/sUY4X/z9UOmh5MI9kPSg164KkLlyyFuwdowlKtk
 qVNpWiZmio/7d23ptpCQ8IH+pryARFnTXGm04K140ICIqWEMcd/UewtgYUbFh4T3OShw2aGTiob
 zqVXKQ/+i0Toy0HOaiAxQv1GD/jnoRVTt7exAHnCa66IJAtz19alZgy/Po5/buXoNIeOPLU2Lhp
 SSZ6KVOzTMen2v7CEOw==
X-Proofpoint-ORIG-GUID: dMMK4CDEoD083Edy6G_zaQGgMHEfIIfN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEwMyBTYWx0ZWRfXxEpnMbwrOfWA
 V7fsr4trhEokkbJHST8sk7GBBFXFjYazYEb6kEJ8PS4wUt2gzhWUjjDNqCKgNhl873/d2sW29OM
 xMG5KOqmPvWosUxywHF/Bmvmz7Dzh0A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100103


Am 07.08.26 um 11:57 schrieb Christoph Schlameuss:
> Some patches previously sent in series
> "KVM: s390: vsie: Add VSIE SIGP Interpretation (vsie_sigpi) v1"
> 
> Link: https://lore.kernel.org/r/20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com
> 
> now in its own series as proposed by Janosch in
> 
> Link: https://lore.kernel.org/all/77387525-cf7b-4617-a492-d81b6c1cef17@linux.ibm.com/
> 
> As well as some small additions like some of the offsets in struct
> vsie_page do have in page offset or alignment requirements. Adding
> assertions can actually prevent bad code changes as well as provide
> clarity for the requirements.
> 
> And introduction of simple SCB_ALIGNMENT_SHIFT constant.
> 
> ---
> Christoph Schlameuss (6):
>        KVM: s390: Remove double 64bscao feature check
>        KVM: s390: vsie: Remove duplicate assertion
>        KVM: s390: vsie: Convert shift to phys_to_pfn()
>        KVM: s390: vsie: Assert mcck_info offset in vsie_page
>        KVM: s390: vsie: Assert crycb alignment in vsie_page
>        KVM: s390: vsie: Create constant SCB_ALIGNMENT_SHIFT
> 
>   arch/s390/include/asm/kvm_host_types.h |  2 ++
>   arch/s390/kvm/kvm-s390.c               |  3 +--
>   arch/s390/kvm/vsie.c                   | 19 +++++++++----------
>   3 files changed, 12 insertions(+), 12 deletions(-)
> ---
> base-commit: f9a2394a23482bfd330911e9c8295b71724feacd
> change-id: 20260716-vsie-cleanup-202607-8690ba7ac3ea
> 
> Best regards,

I adjusted some commit messages and applied this series. Will schedule for next.
