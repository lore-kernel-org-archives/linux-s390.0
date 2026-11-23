Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795439097;
	b=aKs1NogaqeI18ul1xqlcRlSrmkbM2VOyiZ2Tib+HgEBBIYOVpDrllgsg9yB+i5MGUnbC
	 m6TfROQA4/LDb80wuF2jaDyzRshcq6cK+270qI2FaepHG02VV32ARZuhO0V4SeMb2Vfnd
	 LNv4f542SMTglhtFPNPpGTDSrHTkJzRz8Lgy8mWKeAZfHVyY/N9eHZ/l6WQjHq8M2Ned/
	 shj351/ysxHV7oaXGtvYed1dpS+Z/GJo7AsNCtwXldQq9BVjd91CSdYHzZDU37NRDq3sS
	 9iHd70tU6jvW0ErXUDsvY2bPDMrqpg4H50aXhPQabXhpMvIvEVtORzv7gNrmpW1/L7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795439097;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=SPkTlABN6jBq06tO6VLN1KLxuU8g7ywcEEezla+CEbU=;
	b=4ab/4ddTwd7FFm55sKra+fxwYb/eexEB6OOORJPm9fblJTmbncD206ICIEnREyYgnkgX
	 kK4OCGeLceQINY0fifajxvrlf3D2WxWrCYyr9HJMWWuHeECkPy19kACuqWTWkCOF6YSEb
	 Nc+kZn1ROaBaQ1upDE08CGEUlBcknbYot0io3I5FBz/yvj/8Io9FGQFvA4CIg8ZN5qs8q
	 /kaN7RoIpelVXSvGK/jhgRe8+CfV1tPlbQSlQL+ueosjAd2mb4b45wX9qHlzzgRuKq21F
	 8/2KuPVhIS4myzQTULpiTluS1bwhEwYV2iSMZ+bkg7pZnuH+jmxCxNi8fXSMGULOwgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VXsRvltQ;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE74606A31E;
	Mon, 23 Nov 2026 13:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CE74606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VXsRvltQ
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANCYoLR3575074;
	Mon, 23 Nov 2026 13:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SPkTlA
	BN6jBq06tO6VLN1KLxuU8g7ywcEEezla+CEbU=; b=VXsRvltQMwjk6rv6HZFCE8
	RXdk7t25ZWN2XitKdsZbix2SmQkffkJwX/1HTx3sFC0T+oclBVn0YdK80IAg8MCS
	AjMFlvCjvdaBl8ZKJVuzf9ylHqCqxbsLZpWYBbxmV3jQ2eXwvDnRJN9ZGrCcC39h
	eleWhMFJLZs7XFUzcMQ7uVs4Hdua2BJA99auQsWxfSUxvN2OAolKyEUAZazQEHeS
	ugK6+tDvn65hQLIsR783uOi7nlYRO/Be2qsizj5rI2GRLX56TY/KYHuQyMLGVmOC
	3OIdeKTqklWUU0XZ/8NILTSHJNnF7SfotQEPWa8Veb+iewjmk50qWul7AchgERLg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gv2y9q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 13:04:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANCJN6J741919;
	Mon, 23 Nov 2026 13:04:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3qufppe5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 13:04:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AND4DRx42533368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 13:04:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD2D62004B;
	Mon, 23 Nov 2026 13:04:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B62420040;
	Mon, 23 Nov 2026 13:04:13 +0000 (GMT)
Received: from [9.111.39.166] (unknown [9.111.39.166])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 13:04:13 +0000 (GMT)
Message-ID: <01631f5a-9140-4dcb-a91b-5c431b384be6@linux.ibm.com>
Date: Mon, 23 Nov 2026 14:04:12 +0100
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
Subject: Re: [PATCH v3 23/23] s390: Report AEF features to sysfs
To: Steffen Eiden <seiden@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oupton@kernel.org>, Fuad Tabba <fuad.tabba@linux.dev>,
        Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas
 <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas Grapentin <gra@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-23-75e95980fb10@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20261106-sysreg-v3-23-75e95980fb10@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b0439d2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=z66wZ0Kh3ARbYNmR0dMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1MiBTYWx0ZWRfXymFP4SkiqWsW
 Pm2Mk/7WqEVjnM/E7zfbHPsw5SWu3rWN+iPeRj+HMRNO97rYLLKj1QTNIIPxNENaydMKV+zhkWc
 NXGWkxB5YqhjbYwX6J1LG22xVJ8Rol0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1MiBTYWx0ZWRfXxCZs1gpJ5z8E
 7uuwSFEKlOEpyOES02W/YAKXC/Xh2Z4H/OyeNTwJDNU+wjRGhh/CiE/MDINMtGN6hemv1ZwN3i3
 28i0NxURvD4nj49iExiC0/KR+YMtowxZTcfFaOXlw86UADzgruhkODUoGEvjsSWvijeTcQQTtEd
 ypwJ7Lm3tZ0/wTxkqLy40Z8M4xQJvRKPZl/cb/DdrAOhKM/Np9A+EHaRI/xAPIbWR+mfaqfkD2s
 sfzmQ2zo/WT7WkCQjRd7VDr8LVhTKRTH+rc4c3LzHpgDKXoAKllQiS6aSQ2mK3SZUr3/BpzK+AD
 jFi/H3uCZ+hDku2cT7va9UvHVD+G9f2MKijY4xepfYt2+NvwP7L1KYCmtY6yCNCevR0xGqypyF3
 WIr38QZUif08vgCAPscmstXg/6qowMKtnD4QRCoav/QxjkEhVSJPwp1w18vK9zWmncDtGAAZaM7
 AD7zcq65VjtINwg9+8A==
X-Proofpoint-ORIG-GUID: qllvn7jbl9j9C9bDrZh1OcCUIR-5vXzu
X-Proofpoint-GUID: qllvn7jbl9j9C9bDrZh1OcCUIR-5vXzu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230052

On 11/6/26 5:07 PM, Steffen Eiden wrote:
> Display various information about the Arm execution Facility (AEF) to
> userspace. The files are located in /sys/firmware/aef/. Show if the
> feature is available and usable for the host, which formats are
> available, and how many arm vCPUS per guest are supported by the
> machine. Additionally, provide the raw binary output of QAAF fc1 (Query
> Model Capabilities) in the file qmc and fc2 (Initial
> System-Registers-Save Area) in the file save_area.
> 
> Co-developed-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>   Documentation/ABI/testing/sysfs-firmware-aef |  70 +++++++++++++++++
>   arch/s390/kernel/aef.c                       | 113 +++++++++++++++++++++++++++
>   2 files changed, 183 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-firmware-aef b/Documentation/ABI/testing/sysfs-firmware-aef
> new file mode 100644
> index 000000000000..6ccd8491a017
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-firmware-aef

[...]

> +
> +What:		/sys/firmware/aef/query/sae_avail
> +KernelVersion:	7.5
> +Contact:	linux-s390@vger.kernel.org
> +Description:	Read-only, decimal boolean. Reports 1 if the machine
> +		provides the SAE instruction.
> +
> +What:		/sys/firmware/aef/query/ptff_avail
> +KernelVersion:	7.5
> +Contact:	linux-s390@vger.kernel.org
> +Description:	Read-only, decimal boolean. Reports 1 if the PTFF
> +		instruction supports the QAGTO and QAGPT subfunctions.
> +
> +What:		/sys/firmware/aef/query/edat2_avail
> +KernelVersion:	7.5
> +Contact:	linux-s390@vger.kernel.org
> +Description:	Read-only, decimal boolean. Reports 1 if the EDAT-2
> +		facility is available.

I don't think we need any of the three files above.
sae should be reported as a feature in /proc/cpuinfo, same as sief2.

edat2 is facility 78 in the same file.

PTFF-QAF is unprivileged.

Also, if aef is the requirement for the directory to exist, why would 
saef not be enabled?

