Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6184F477E2A
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629434; cv=none; b=WOkoBNWQGNW9jkjkbRY8J2027S+yIu6EH2zqv5aNpYOkkfrjg9/krbf62zJEvL19yaBpY5y9H3LMYw/Z65o+je/BaDOCOAEeJv3IK8clFrzGpROHj+feQV5cuawwU5xHddqX+uOPJCQ8X0DhxnWJ4X+SIJ8VWjWjk9S7MqSmBpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629434; c=relaxed/simple;
	bh=ShD9mLZbTnNoXw4tdhz7fDb0Aj/5wgWGvG0sv9W9jEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZS8vYdknsIRZCyyl7MgYPAX4vbqwLZoDxMnXj86bVH/J3GdnJtGSbfiwTZWdDB/RVL8l0wRtg0hDVxvHY1WcwZgt0JY7jVC0Pemt/78RBs/tzN1P7lc1uK03ijMliuYkTtBn+UUEwSVEAD06VAI8M6sxUiYA6uDxT5l/JdwfOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Tm/t11Qy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tm/t11Qy"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DCVxBo2293472
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 13:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4oGUOC
	4K9qGT3+NkW96rDlvKFSwfLMu6DxLsYWAwdGk=; b=Tm/t11Qy0kFdAJUcBv9+X/
	noTx5f9ivWmA8K4O8guLX+u1G0jwyQFEpiaRvplYoJiUJoOIvXrU+OmOswdOlK1U
	9PPw+Rlnxb84QUcuKzKn5/lAPUCYlC9HvFCxFYGtFSsBS3ZABfeZ47nCUF/MgXx2
	DyRf8GS7XEuJsxp8kacA/yYNWGOVylOTJsOCzPjEX2Eb7tGpPm5LoJDODXGJrw4g
	vHcclyIYi+lGJQLEsm0eFYZloX7aKtB1lNr712Nty++RevzPlP1HTdStf5JLojqY
	6EigrJhlVcbQGZZTIVP3GTgK7V8Yom+fLwJuYa0Yr+c2XTU2o19oYjtI5vx+gPGQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9r5xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 13:57:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DDuMLs017928
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 13:57:11 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsk37kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 13:57:11 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67DDv9tT656098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 13:57:09 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 819EC58056;
	Thu, 13 Aug 2026 13:57:09 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92C0C5803F;
	Thu, 13 Aug 2026 13:57:08 +0000 (GMT)
Received: from [9.224.77.77] (unknown [9.224.77.77])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 13 Aug 2026 13:57:08 +0000 (GMT)
Message-ID: <7faf2317-1e49-4e99-a816-900cecc02e92@linux.ibm.com>
Date: Thu, 13 Aug 2026 15:57:05 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] s390/ipl: Fix NULL deref in dump_reipl without re-IPL
 parm block
To: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
References: <c00-02.ttjpfvt@ub.hpns> <p02-02.g6f5dd41a34f4.ttjpfvt@ub.hpns>
Content-Language: en-US
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
In-Reply-To: <p02-02.g6f5dd41a34f4.ttjpfvt@ub.hpns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 47myq0YW1C_D1i2w9HrZT7eu_PMn8H7g
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7dcd38 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=p1M8u0mKESfYOS3vc_EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA5NiBTYWx0ZWRfX4rQ3KVk0upfu
 eaoWYs1hcPzPUgel7ftxZ23XXW2FE5v/s5BCDbeBTTmLgIdOPo34Ol9Z/IBZRBPVyGJawHS7+Ox
 nCCQJ4+5SvlRYmcTpExEHMGz5MqZt3DHwNEh7uywnJHR2qhCUVYyto7X4dmp4FE27eOq6lPS5mC
 MM3Lqj0m118J+l3DPqNK0Aa9/konc1eYqoDtKFFATyhbsDjXkA0DOVaoT8lRNwQl+d438koA316
 Zcfj/Sv8QTRFB5ZKB4ZfHX+oY+6UCnbl5WrGU3pieStu6jrhz8gMqg1pOg1GXFLrQi97cQmDn9J
 JC9AE+dmON0W2COeT7GjoSlLUB2lhNQOCo56g0KO19CeuXnKMJPoX8cEoXyMzxT9fJxWJtk8N4k
 9QO4KKqQrvziavzQ6NJw7NWYbbb57zbN0rXa9ImQesxia1vCdAKtjaKoRJkoVLO+LeH9CbOMMZx
 gwGUabdsqnbUJx0pvLQ==
X-Proofpoint-ORIG-GUID: 47myq0YW1C_D1i2w9HrZT7eu_PMn8H7g
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA5NiBTYWx0ZWRfX5h8IgQrJArk5
 RJTZpVAiuzYzJ1boYLae3bYu6PtT2+VX7M2qN2gNZc0GtSTcjJEMsIGN/hMyqoQmZ/u5RMdWE3b
 7bwg95FCsY6zCVc8Aji3qe4kisT9vs0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130096



On 13-Aug-26 13:06, Vasily Gorbik wrote:
> Unlike kdump, which passes the re-IPL parameter block through os_info,
> the stand-alone dump passes it through the IPL parm block address and
> checksum in lowcore.
> 
> Some IPL types, like HMC FTP boot or QEMU direct kernel boot, might not
> provide an IPL parameter block. In this case reipl_type_init() selects
> IPL_TYPE_UNKNOWN and reipl_block_actual remains NULL. Nevertheless,
> dump_reipl_run() unconditionally dereferences it when preparing the
> lowcore fields. This may happen to work by chance when address zero
> contains readable lowcore data. A zero IPL parameter block address is
> then stored in lowcore, causing the stand-alone dumper to enter disabled
> wait after completing the dump.
> 
> Explicitly store a zero IPL parameter block address and checksum when no
> re-IPL parameter block is available. This does not change the behavior:
> the stand-alone dumper completes the dump and halts, while valid re-IPL
> parameter blocks continue to be handled as before.
> 
> Fixes: 099b76513992 ("[S390] Automatic IPL after dump")
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  arch/s390/kernel/ipl.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
> index 7024fc413715..68fdd5616dfe 100644
> --- a/arch/s390/kernel/ipl.c
> +++ b/arch/s390/kernel/ipl.c
> @@ -1929,7 +1929,8 @@ static struct shutdown_action __refdata dump_action = {
>  static void dump_reipl_run(struct shutdown_trigger *trigger)
>  {
>  	struct lowcore *abs_lc;
> -	unsigned int csum;
> +	unsigned long ipib = 0;
> +	unsigned int csum = 0;
>  
>  	/*
>  	 * Set REIPL_CLEAR flag in os_info flags entry indicating
> @@ -1945,9 +1946,12 @@ static void dump_reipl_run(struct shutdown_trigger *trigger)
>  	    reipl_type == IPL_TYPE_UNKNOWN)
>  		os_info_flags |= OS_INFO_FLAG_REIPL_CLEAR;
>  	os_info_entry_add_data(OS_INFO_FLAGS_ENTRY, &os_info_flags, sizeof(os_info_flags));
> -	csum = (__force unsigned int)cksm(reipl_block_actual, reipl_block_actual->hdr.len, 0);
> +	if (reipl_block_actual) {
> +		ipib = __pa(reipl_block_actual);
> +		csum = (__force unsigned int)cksm(reipl_block_actual, reipl_block_actual->hdr.len, 0);
> +	}
>  	abs_lc = get_abs_lowcore();
> -	abs_lc->ipib = __pa(reipl_block_actual);
> +	abs_lc->ipib = ipib;
>  	abs_lc->ipib_checksum = csum;
>  	put_abs_lowcore(abs_lc);
>  	dump_run(trigger);

Reviewed-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
