Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1338F4315F
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069886; cv=none; b=SxOe/u95Nx1ViuVEL44JRR96oG3uqUkGBWBPQ5blnHt3vd1e1FzlN+3067YM3LN3PG28R57Kg356vtT8vRULhWuEQKgAyDtaY9PGnvVpXLJKzJKJ1fdUI6dckodpJ5AxJbDXvDAWxeGS5LayxF1qN3+Z6Eomc0cOqX1ycHwzolk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069886; c=relaxed/simple;
	bh=ZOWTAg/kB6de76iePVMuO8PiXdBxdivbjv5Z6lu0buU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=sO/MD0YJ7reu7nfW4pJccSCCninAaw/WLTOpqyVNkcjJsb2oKMbZPZnlan7IMsExPsGF8Zy+DT5HjK0pB4ZIdeYCaswi48NLV6Cw0yobKgceFHr7qDf+PRwEhJ456aFJPKMkM35jJfZqmjXfidIN9cL7tpblZsSKWAb0pqFKFV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nbdU/AGk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nbdU/AGk"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3Z2H505252
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JPXoca
	To+QVgVOW8T/6CdUM28RAivvKCMGqiptQsJ9o=; b=nbdU/AGkKF5Yydu2WC0mam
	53lKu0ZW+Q3Cn8Ys4tCWQouU8KUTpPmDGLg8IrUO28gxbq6WacFbPnxe9PP3lh/f
	gclZNZNDmwoYYQFQGcJCAEzu1I+/r/GlR5A8FqgHB3R1M6WsXinRv1XWZe2H6oLH
	X/lb5yZTcxS5T4vmbmTJDz1bvokBjPdxJlKtAEXXL7eQMraOGQi1WyUR96EKmDDj
	fHLdgC/LMRh9SrR9RmTsD4y8rvdBk6sTjXpnOg2C1KgBeyzuHJYdcED4hNM6TtrV
	Q84OWoDZiwmjcOqJ7inrBjFtLGfaUmpa7npF3tmJfpNkNWuCjyrnf9mQJMWh5VjQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4seav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:18:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IGBKXj015172
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:18:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngbx81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:18:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IGHxGw45089184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 16:17:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89A1720043;
	Tue, 18 Aug 2026 16:17:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6217620040;
	Tue, 18 Aug 2026 16:17:59 +0000 (GMT)
Received: from [9.87.152.137] (unknown [9.87.152.137])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 16:17:59 +0000 (GMT)
Message-ID: <831b37cc-46fd-4e29-aac5-7db175872b9a@linux.ibm.com>
Date: Tue, 18 Aug 2026 17:17:59 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] kexec-tools/s390: add --reuseinitrd support
To: Joseph Cathcart <josephc@linux.ibm.com>
References: <20260818153925.6203-1-josephc@linux.ibm.com>
Content-Language: en-US
Cc: linux-s390@vger.kernel.org
From: Joseph Cathcart <josephc@linux.ibm.com>
In-Reply-To: <20260818153925.6203-1-josephc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EX6KtkLPJeu-Bf7vTVyI_VDiozvvNDAN
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a8485bc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=j2Pf85XzIAzbqM7hM6AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDExOCBTYWx0ZWRfX2vaV4fBnz/ju
 rjc8232aPJHTtUdc0s3Pd48w6/wsJxmXpl0RgL/bf+52/4h60RqCQtO/8YY/nkgJMKSeOEKLeuy
 12sO4Y3FgWG56xT+wt3L2HQpL+O+hK0=
X-Proofpoint-ORIG-GUID: EX6KtkLPJeu-Bf7vTVyI_VDiozvvNDAN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDExOCBTYWx0ZWRfX7VMU1ob/Cg7E
 PGqNQgsei9OO+4sM4euR1WA9M5tA5eD0z1gVjWoB8FlvM4APyCkgH2g8BweX7JndRxmHKtHG4tS
 s38pPe56G+pufrbeoT+9QgyeA3594WTtg/ik+jVA3Bo582DbJQ9q/x0evxerpsqhDVxApx8Oz4p
 bSb7NZGYcZ8uMk9d26SEjeO/9/9Dhx99X7qLCr3wU2irFAhsQNcDcTRjnj7ixYVpaxFP2SXeQ3j
 51qB4st/53jtFmu8nVRWv1N828vvAhWQ3NVjcPkFtGbNyvt6ugAQzPeVsieKr4/EqsHKMtYNFke
 Dbm076iEyORV7vxuWxmfNFI7aLSkSwpZMGsXxlAXBFlfeB4xjGqDYbX3PVpV0u9DEQezErmGj2j
 3JXPnokk6Zqz4vWAFAXvUwY8u4+6BUZ7dLv8wDjvp3Ud6JehGZPn2BYwxXDtkM4cWbLfrTYqpV8
 TTq2VKx5hP4hIb++Pig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180118


On 8/18/26 4:39 PM, Joseph Cathcart wrote:
> Currently, the --reuseinitrd param is not supported on s390. This
> prevents testing kexec in environments such as virtme-ng, which by
> default does not store the initrd on disk.
>
> When --reuseinitrd is specified, add retained initrd memory range to
> memory_range[] and fill new kernel parmarea directly with retained
> initrd base and size, rather than memory range of a new ramdisk.
>
> Add die() cases for trying to use --reuseinitrd flag in addition to
> --ramdisk or --initrd, and for using --kexec-file-syscall instead of
> --kexec-syscall while trying to use --reuseinitrd.
>
> Signed-off-by: Joseph Cathcart <josephc@linux.ibm.com>
> ---
>
> Depends on: https://lore.kernel.org/linux-s390/20260818153559.5700-1-josephc@linux.ibm.com/T/#u
>
>   kexec/arch/s390/Makefile      |  2 ++
>   kexec/arch/s390/kexec-image.c | 11 ++++++++++-
>   kexec/arch/s390/kexec-s390.c  | 17 +++++++++++++++--
>   kexec/arch/s390/kexec-s390.h  |  2 ++
>   4 files changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/kexec/arch/s390/Makefile b/kexec/arch/s390/Makefile
> index fab3e68..17f9dc8 100644
> --- a/kexec/arch/s390/Makefile
> +++ b/kexec/arch/s390/Makefile
> @@ -6,6 +6,8 @@ s390_KEXEC_SRCS += kexec/arch/s390/kexec-image.c
>   s390_KEXEC_SRCS += kexec/arch/s390/kexec-elf-rel-s390.c
>   s390_KEXEC_SRCS += kexec/arch/s390/crashdump-s390.c
>   
> +s390_ARCH_REUSE_INITRD =
> +
>   dist += kexec/arch/s390/Makefile $(s390_KEXEC_SRCS)			\
>   	kexec/arch/s390/kexec-s390.h					\
>   	kexec/arch/s390/include/arch/options.h
> diff --git a/kexec/arch/s390/kexec-image.c b/kexec/arch/s390/kexec-image.c
> index 69aaf96..1a59a32 100644
> --- a/kexec/arch/s390/kexec-image.c
> +++ b/kexec/arch/s390/kexec-image.c
> @@ -78,6 +78,9 @@ int image_s390_load_file(int argc, char **argv, struct kexec_info *info)
>   		}
>   	}
>   
> +	if (reuse_initrd)
> +		die("--reuseinitrd not supported with --kexec-file-syscall. Please use --kexec-syscall\n");
> +
>   	if (ramdisk) {
>   		info->initrd_fd = open(ramdisk, O_RDONLY);
>   		if (info->initrd_fd == -1) {
> @@ -104,7 +107,7 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
>   	char *rd_buffer;
>   	const char *ramdisk;
>   	off_t ramdisk_len;
> -	unsigned int ramdisk_origin;
> +	unsigned long long ramdisk_origin;
>   	int opt, ret = -1;
>   
>   	if (info->file_mode)
> @@ -137,6 +140,9 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
>   		}
>   	}
>   
> +	if (ramdisk && reuse_initrd)
> +		die("Can't specify --ramdisk or --initrd with --reuseinitrd\n");
> +
>   	if (info->kexec_flags & KEXEC_ON_CRASH) {
>   		if (parse_iomem_single("Crash kernel\n", &crash_base,
>   				       &crash_end))
> @@ -165,6 +171,9 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
>   		ramdisk_origin = _ALIGN_UP(ramdisk_origin, 0x100000);
>   		add_segment_check(info, rd_buffer, ramdisk_len,
>   				  ramdisk_origin, ramdisk_len);
> +	} else if (reuse_initrd) {
> +		ramdisk_origin = retained_initrd_base;
> +		ramdisk_len = retained_initrd_size;
>   	}
>   	if (info->kexec_flags & KEXEC_ON_CRASH) {
>   		if (load_crashdump_segments(info, crash_base, crash_end))
> diff --git a/kexec/arch/s390/kexec-s390.c b/kexec/arch/s390/kexec-s390.c
> index 86c9fb8..4e77fc4 100644
> --- a/kexec/arch/s390/kexec-s390.c
> +++ b/kexec/arch/s390/kexec-s390.c
> @@ -25,6 +25,13 @@
>   #include <arch/options.h>
>   
>   static struct memory_range memory_range[MAX_MEMORY_RANGES];
> +unsigned long long retained_initrd_base, retained_initrd_size;
> +unsigned int reuse_initrd = 0;
> +
> +void arch_reuse_initrd(void)
> +{
> +	reuse_initrd = 1;
> +}
>   
>   /*
>    * Read string from file
> @@ -151,6 +158,7 @@ int get_memory_ranges_s390(struct memory_range memory_range[], int *ranges,
>   {
>   	char crash_kernel[] = "Crash kernel\n";
>   	char sys_ram[] = "System RAM\n";
> +	char kernel_initrd[] = "initrd\n";
>   	const char *iomem = proc_iomem();
>   	FILE *fp;
>   	char line[80];
> @@ -174,11 +182,16 @@ int get_memory_ranges_s390(struct memory_range memory_range[], int *ranges,
>   		sscanf(line,"%llx-%llx : %n", &start, &end, &cons);
>   		str = line+cons;
>   		if ((memcmp(str, sys_ram, strlen(sys_ram)) == 0) ||
> -		    ((memcmp(str, crash_kernel, strlen(crash_kernel)) == 0) &&
> -		     with_crashk)) {
> +			((memcmp(str, kernel_initrd, strlen(kernel_initrd)) == 0) && reuse_initrd) ||
> +			((memcmp(str, crash_kernel, strlen(crash_kernel)) == 0) && with_crashk)) {
>   			memory_range[current_range].start = start;
>   			memory_range[current_range].end = end;
>   			memory_range[current_range].type = RANGE_RAM;
> +			if (memcmp(str, kernel_initrd, strlen(kernel_initrd)) == 0) {
> +				retained_initrd_base = start;
> +				retained_initrd_size = end - start + 1;
> +			}
> +
>   			current_range++;
>   		}
>   		else {
> diff --git a/kexec/arch/s390/kexec-s390.h b/kexec/arch/s390/kexec-s390.h
> index 6a99518..a990739 100644
> --- a/kexec/arch/s390/kexec-s390.h
> +++ b/kexec/arch/s390/kexec-s390.h
> @@ -34,5 +34,7 @@ extern int load_crashdump_segments(struct kexec_info *info,
>   extern int get_memory_ranges_s390(struct memory_range range[], int *ranges,
>   				  int with_crashk);
>   extern int command_line_add(struct kexec_info *info, const char *str);
> +extern unsigned long long retained_initrd_base, retained_initrd_size;
> +extern unsigned int reuse_initrd;
>   
>   #endif /* KEXEC_S390_H */
