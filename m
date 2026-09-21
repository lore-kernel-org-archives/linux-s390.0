Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D978346A5FE
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 09:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982628; cv=none; b=mjVEcgYYKKRlZ1WO9l721+Fx8/LhQNk7CFrhriOaGmIhPJbCTzOKQeLIIyOT0QHTNuIpLc5YWCOsbLJD9G3zHN4pUvH8cQdFTR1QYxQPdOuA4Ii4HUryhuNg9QH1bc75JRqyJvdDzYQt1Sb5MPIPXejSlg15vbJpMbNhAP/TpMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982628; c=relaxed/simple;
	bh=MrmdsfG5/+ZsoYyY+loO7AAw5Gk69+Hu7xgjgZnbpCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QK+XIreVSC3iJumi7c/HnaWWWDvVdUbnMhP6alUHEG5x1Iz5h+aL0Uzzh0EmhdRF09OZTQ9gC5OuTQU6uLK54DfXZw5aMCqBxrZzZNC+IkeXJzXBEJxafnfdOF6iubbtEiXyXKqVZy0VFNvLdFSXOOp26IbTxfcj9z0VNIJdwKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N3uxuVei; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N3uxuVei"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7ZlQ6863477;
	Mon, 21 Sep 2026 09:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZT6vKK
	Mn25kCvIHl8LXUkPPY78J/lI40eZbVnE91Y14=; b=N3uxuVei9yyO4zydQmlP45
	T8/IQU7E8c8N3Y0kUkE1GFhGeJjA3lYSDqCjUtzULt4JZp0IZmkIgPXzyXOxLdoW
	ytQBl1uZFTR5yeelmmSCr9mLz3p3Fq2YPllUrlrt/sq1WiswpFM1/A2HjFZ6bYNH
	sdANmT3NfMyqTjA8vBHLkQ7vY0njXuAR6pLdR0TXlbb2LZ7uQM/you2TrMWu+TS8
	9leXggyCU1HLZ0/DfE4UiKnRidTn/yg0B8FId1jfC1eD2vKQjrQR5utdEbHuC+zm
	mHO3CtD2DtJy18Fes5ku7JqkJluWY+xPaQ4rbreMPVhON7u7+wc4rDCR/n+yi7dQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskduyk70-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 09:23:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7HYE4930602;
	Mon, 21 Sep 2026 09:23:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt6xgceyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 09:23:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L9NdI926083974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 09:23:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23FE82004D;
	Mon, 21 Sep 2026 09:23:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E71B120043;
	Mon, 21 Sep 2026 09:23:38 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.64.11])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 09:23:38 +0000 (GMT)
Message-ID: <b0e1b29b-f4a8-4b22-8894-fd65e83f1c8b@linux.ibm.com>
Date: Mon, 21 Sep 2026 11:23:38 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] kexec-tools/s390: Improve initrd memory reservation
To: Joseph Cathcart <cathcartj08@gmail.com>, kexec@lists.infradead.org,
        linux-s390@vger.kernel.org
Cc: eoin.mcnamara@ibm.com
References: <20260828152256.6892-1-cathcartj08@gmail.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260828152256.6892-1-cathcartj08@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: KSQcg4fSfK6qZ2SBgKKxu03MSzTI2KKE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEzMCBTYWx0ZWRfX3FXJZ+u0rN4E
 d5bWiX6mCJy3GUyIMRxcx93fCk4DEz2l8bREoey+gtJSTUhuxGZ7JGrKI6GQS4RpXkc5U2NGxvM
 voTBiUX/EI4wd1IiUU2zTmxrKOMtO7E=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab0f79e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8
 a=tefWyy4ALFFC40fXQdwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: er6em1wz5FSkmMfn9p6YNGNnPxBXYL5W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEzMCBTYWx0ZWRfX2CgmSZHoJ1/q
 ywncWudlm0fMs4xOvQy2+JEn3+2B7RRnvgOzGAgf6xLV8DAd4FoqxKh2+6BIWoNSZD+XkcHiuaA
 NU60lg2/a0vK1AjCdaESqjfV00b16LUaJHRIplhW/jLrtft6pYDM5Q+KA+OAh78sQj6NfBg/+0S
 CDAIAJDbPy9pNd8dHvDrSK8V6j6ZJDB9QNpJJmKzCoOB+nfI2tc38IrYSf5J7VqXevav0abxcH1
 mBvLt0qRQQUq71n22zLY8U8qA6tBjVWNAkb3aWmCxQ76GGc3/nOno4XJJLSyiehAMA5Vv0HJbk6
 fgHcHLjoJbcwUJa9BppFAvd7cUC6ftdv3QyGhkRMHixooeFCFYJdlyZ5ptzbQ3vCEUlrNH1eWVB
 /dBqtoII1YF4zrHEBim55Sip9+yHyyt9Vdys+SGkI7+/4WDkb3qdj0wDwUpYkGaWMXmQUIQUuoz
 g/2OyKi+MTC2v0F9Mjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1011
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210130

On 8/28/26 17:22, Joseph Cathcart wrote:
> Improve memory reservation for initrd. Remove unnecessary initrd
> range from memory_ranges[]. Initrd currently falls between
> "System RAM" ranges, and is therefore already reserved.


What if this changes in the future? Isn't the current approach better then?


> Refactor so that arch_reuse_initrd() is responsible for populating
> retained_initrd_base and retained_initrd_size, rather than
> get_memory_ranges_s390().
>
> Add die() case for when user uses --reuseinitrd while booting a
> crash kernel.
>
> Signed-off-by: Joseph Cathcart <cathcartj08@gmail.com>
> ---
>   kexec/arch/s390/kexec-image.c |  8 ++++++--
>   kexec/arch/s390/kexec-s390.c  | 19 ++++++++++---------
>   kexec/arch/s390/kexec-s390.h  |  2 +-
>   3 files changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/kexec/arch/s390/kexec-image.c b/kexec/arch/s390/kexec-image.c
> index 1a59a32..a9e5442 100644
> --- a/kexec/arch/s390/kexec-image.c
> +++ b/kexec/arch/s390/kexec-image.c
> @@ -79,7 +79,8 @@ int image_s390_load_file(int argc, char **argv, struct kexec_info *info)
>   	}
>   
>   	if (reuse_initrd)
> -		die("--reuseinitrd not supported with --kexec-file-syscall. Please use --kexec-syscall\n");
> +		die("--reuseinitrd not supported with --kexec-file-syscall. "
> +			"Please use --kexec-syscall\n");


Not sure what the kexec-tools rules there are (I see some exceptions in e.g.
fs2dt.c), but in the kernel string literals must not be split for ease of
grepping.


>   
>   	if (ramdisk) {
>   		info->initrd_fd = open(ramdisk, O_RDONLY);
> @@ -143,6 +144,9 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
>   	if (ramdisk && reuse_initrd)
>   		die("Can't specify --ramdisk or --initrd with --reuseinitrd\n");
>   
> +	if (reuse_initrd && (info->kexec_flags & KEXEC_ON_CRASH))
> +		die("Can't specify --reuseinitrd while booting a crash kernel\n");
> +

I agree that trying to reuse initrd for a crash kernel makes little sense on
popular distros, but in theory one can create a universal initrd. So is 
there a
technical reason to prohibit this?

>   	if (info->kexec_flags & KEXEC_ON_CRASH) {
>   		if (parse_iomem_single("Crash kernel\n", &crash_base,
>   				       &crash_end))
> @@ -173,7 +177,7 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
>   				  ramdisk_origin, ramdisk_len);
>   	} else if (reuse_initrd) {
>   		ramdisk_origin = retained_initrd_base;
> -		ramdisk_len = retained_initrd_size;
> +		ramdisk_len = (off_t)retained_initrd_size;

I guess this is to placate -Wsign-conversion?
It would be good to have this mentioned in the commit message.

>   	}
>   	if (info->kexec_flags & KEXEC_ON_CRASH) {
>   		if (load_crashdump_segments(info, crash_base, crash_end))
> diff --git a/kexec/arch/s390/kexec-s390.c b/kexec/arch/s390/kexec-s390.c
> index 4e77fc4..fd0d87e 100644
> --- a/kexec/arch/s390/kexec-s390.c
> +++ b/kexec/arch/s390/kexec-s390.c
> @@ -26,10 +26,17 @@
>   
>   static struct memory_range memory_range[MAX_MEMORY_RANGES];
>   unsigned long long retained_initrd_base, retained_initrd_size;
> -unsigned int reuse_initrd = 0;
> +unsigned char reuse_initrd;
>   
>   void arch_reuse_initrd(void)
>   {
> +	uint64_t start, end;
> +
> +	if (parse_iomem_single("initrd\n", &start, &end))
> +		die("Couldn't find initrd entry in /proc/iomem\n");
> +
> +	retained_initrd_base = (unsigned long long)start;
> +	retained_initrd_size = (unsigned long long)end - retained_initrd_base + 1;
>   	reuse_initrd = 1;
>   }


What is the benefit of moving this here? I see that there is no 
consensus among
the other architectures.

[...]

