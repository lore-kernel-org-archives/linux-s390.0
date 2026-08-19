Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FA83CF030
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787121622; cv=none; b=Ygaw81hEJMh9EX7Zvnbs1IlYK6lxzCffccktOI3HUqALlWqVVl+XAahjd53bdL/2OuYi3D6ecO4zAdudVlbfeXLr0UCkdMBsfoGvxSWwP1GLzjJGpAWrn5Zl96qARDPSepf3oDqkGndzf1TX3G2RLgYWXedbTSYLyG3OmwZ95aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787121622; c=relaxed/simple;
	bh=dCq+/uRZrVCDWVIMvY0vju0MG/k71EqftQ5Lz3zApxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LxLTL7epuYEaFKfJUunEI736nJLHP4iVNO3+8ZyByB1yp3QGlqwxbeKMxvIRReGa9mbRyHk+lRw+dS+nxMMjd57SLpCSvi16qOL7xE/DGaC1ZOYk6qOk7RY0yu+35U5XFju/RnhSssfunq6o0DzJrHNBMNFZ3TyNA+qmVFr5u8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qqRN5YeI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qqRN5YeI"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67J6W8Kb1544883;
	Wed, 19 Aug 2026 06:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ElLnrx
	MrD97qj1w6Xif33+CqjbN78C2jtqwiibMf9hI=; b=qqRN5YeILB16nm1l5jT8P2
	Ipf3qI9UvMq9ijVElmWCgGpowUrOhc1t/W7Oz3CrlFqz/WbSyaYyCGGPDmezdySS
	9NL60dXyeaajNp4JRec56fjscJ5roJhHnXPuZMV+eNPHWzZ1omQj3bGTuT9NEUkC
	w6JMnUTrh23jI7S2HDIM+toi40OGQH8wwKU2dsJcSmeh6CFv8RUQDp/tBgP7wxzz
	HT6DPv01FX0NdJaz/AXZ40xqtrdfkaa8iYHriBlSkmb9hdJOTa5t9Ptuy9iFimF6
	ISISa5NURQ74RkFDTmcKnEmoDGsGSu+9f1piF5b15t5cBzoYKtSc+A3QP25TqwHA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu21yfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 06:40:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67J6QKZh021081;
	Wed, 19 Aug 2026 06:40:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh7fub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 06:40:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67J6eERo46924032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 06:40:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FE622004F;
	Wed, 19 Aug 2026 06:40:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD55320043;
	Wed, 19 Aug 2026 06:40:13 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.142.99])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 06:40:13 +0000 (GMT)
Message-ID: <6f66956a-9793-4f96-b973-6e5875e5e433@linux.ibm.com>
Date: Wed, 19 Aug 2026 08:40:13 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] s390/iomem: register initrd as an iomem resource when
 retain_initrd is set
To: Joseph Cathcart <josephc@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: eoin.mcnamara@ibm.com, Christian Brauner <brauner@kernel.org>,
        Alexander Graf <graf@amazon.com>
References: <20260818175755.3520-1-josephc@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260818175755.3520-1-josephc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a854fd0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=IgPgkZ6YDnl7FKdPT60A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kQz7EmkfbkFfOfQpKzuJuO9-lWTQu4G2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA0NyBTYWx0ZWRfXxNLTOB2537HY
 5oKatYynI6KY5s46I0LICuuPWn+XB2u1nqwUjCwpmiQ7lyqAQ6cMio1iif+mAH9kTalZh+9qVbW
 YNZYo5kKuIBH5d2dbG6cGpzf3ejFt7MaZ7x1664rG4rooO6tZKS/tfgMArD2oEtBuvBDAui+rcW
 +DHJvllrfKHBGbJakVE58jsTZs9jvl9Sn0eI1xoX43wdwa1N+E/r3dUS/ZJx/lA+DjYrO4yafE7
 151+pvqmZBSRBXjz+iaQaoxyFjXeRDPjyXFx1ZL87tWl2SamPENUF5WzrWqjDDcbOjUMCf0rd5A
 /lnqurYl9fWsXb8c2AJuCmeynDsNdLiOTtrzoAzgIM4YkgqSctrl4Xuqc569kArlSYSM7+h/d+R
 QjekpwQAmCFfebczFaYog5+F6YRoElaD95xmt7W6bD97C6BK+Rx3xzKl91wUBF3ETj38SecFUb6
 WUXmwJ7Tsc2pBN+5aFw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA0NyBTYWx0ZWRfX5vMePySGUbfS
 Ud8C/5M+wHXRgMxroXKqW6m494nu8ENVtrxsc2gHEPMNT3u0ks0R3w9KJs2G4o2hpCMcla4UjZb
 YdxYk9gCpF0xw1oSKnRHyoY/XD5MrI4=
X-Proofpoint-ORIG-GUID: kQz7EmkfbkFfOfQpKzuJuO9-lWTQu4G2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190047



On 8/18/26 19:57, Joseph Cathcart wrote:
> Currently, /proc/iomem contains no reference to initrd memory, even
> when initrd is retained and still held in RAM. This makes the memory
> ranges invisible from userspace, and unusable to programs such as
> kexec. (A sysfs bin file is created for initrd, but this doesn't
> help programs which need the explicit memory ranges)
> 
> Add initrd to standard_resources[] unconditionally. Add initrd as a
> child of iomem_resources only if retain_initrd is specified.
> 
> strstr() could match substrings like "retain_initrd=0" or
> "no_retain_initrd", but this is how PPC chose to check for
> "retain_initrd" param too. (arch/powerpc/kexec/ranges.c)
> 
> Signed-off-by: Joseph Cathcart <josephc@linux.ibm.com>
> ---
>   arch/s390/kernel/setup.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)

Checkpatch complains:

$ b4 shazam 
'https://lore.kernel.org/all/20260818175755.3520-1-josephc@linux.ibm.com/'

$ git format-patch -1 --stdout | ./scripts/checkpatch.pl -
ERROR: trailing whitespace
#58: FILE: arch/s390/kernel/setup.c:513:
+^I$

> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index b60284328fe3..373e54ed7519 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -481,15 +481,22 @@ static struct resource bss_resource = {
>   	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
>   };
>   
> +static struct resource initrd_resource = {
> +	.name = "initrd",
> +	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> +};
> +
>   static struct resource __initdata *standard_resources[] = {
>   	&code_resource,
>   	&data_resource,
>   	&bss_resource,
> +	&initrd_resource,
>   };
>   
>   static void __init setup_resources(void)
>   {
>   	struct resource *res, *std_res, *sub_res;
> +	bool retain_initrd = false;
>   	phys_addr_t start, end;
>   	int j;
>   	u64 i;
> @@ -501,6 +508,19 @@ static void __init setup_resources(void)
>   	bss_resource.start = __pa_symbol(__bss_start);
>   	bss_resource.end = __pa_symbol(__bss_stop) - 1;
>   
> +	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD)) {
> +		unsigned long initrd_addr, initrd_size;
> +	
> +		if (strstr(boot_command_line, "retain_initrd"))
> +			retain_initrd = true;
> +		if (retain_initrd && get_physmem_reserved(RR_INITRD, &initrd_addr, &initrd_size)) {
> +			initrd_resource.start = initrd_addr;
> +			initrd_resource.end = initrd_resource.start + initrd_size - 1;
> +		} else {
> +			retain_initrd = false;
> +		}
> +	}
> +
>   	for_each_mem_range(i, &start, &end) {
>   		res = memblock_alloc_or_panic(sizeof(*res), 8);
>   		res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
> @@ -517,6 +537,8 @@ static void __init setup_resources(void)
>   
>   		for (j = 0; j < ARRAY_SIZE(standard_resources); j++) {
>   			std_res = standard_resources[j];
> +			if (std_res == &initrd_resource && !retain_initrd)
> +				continue;
>   			if (std_res->start < res->start ||
>   			    std_res->start > res->end)
>   				continue;

Cc: Christian and Alexander.

I wonder if it would make sense to move initrd resource creation to
do_populate_rootfs(), right after /sys/firmware/initrd creation,
enabling this feature on all architectures?
