Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD472E7F2C;
	Fri, 24 Jul 2026 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784914712; cv=none; b=Kd09hI+104Eu3a+bP2HW5fbdpuycnj2RlW8Q73inM9tdbWo/uwWMF/z1Ci1HCPLsRvyZXhfhMQQ5Zn/4N+XYaSYlcg/hc/LATD0TddRpKLBYHiTLevgXTsDkQUpcq9KKCHGH2jOMAp1spiu+i/y+8grHB8kC36OG/7/elWQb0ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784914712; c=relaxed/simple;
	bh=9aZ9Z4z9OKfhG011FWx1iCYWZ1CqiDTm3Q1lo+Ece3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmN38vZ85VLiC5Ch2/jY88Xxtu4kZHeweLJ0fBYFZeyLvqhTUvjpa6IELEiJxi6gVNwpRF/G2qFYrg1ESJXo9qXiChleJDn1m1rk/8YZKutPCW47+ZGiPGVcLayNTXSbcDLz9wN/3u7EU72fJcndxJFfmknPRJ1BSYHnGrVbU7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OmiiStuY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OmiiStuY"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OHBrJe556129;
	Fri, 24 Jul 2026 17:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9aUh0s
	9krB9JSmr7g6EM+bm9SIxLn8keheRNhv1VNUo=; b=OmiiStuYKIUKRnlo0igE6o
	i3Mler+UylKzwMZHhzQ6i0DbXBpL75GBhcieE02/BGUzlkVguHw0+9BPxtyfZHq1
	uGXlWhUXQnuR6LLQkMD7K1Jlnhf5fYOxrbK/sOv2tRAXhQjWnYKbhb1xUdVWZDQ4
	G14Tu85nHevmlbYnCvQHm6lwhVQ9vs9nkQelwI/mls8IE2Tb2J2P+U1o+BTsNL1q
	9HSowBX2tHjiVT1VDSuVai8IBTY2tz4CcXA2jmxO8AN+qUZgtndwF1q/d5UqPU60
	LULPAwGCw9zt5cmF31yjKsxlqncIjjd2KBSIv9QnIoXjA9k6OUQo23LpOCL/kebg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8gs95p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 17:38:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OHYapr007816;
	Fri, 24 Jul 2026 17:38:27 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqj4a2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 17:38:27 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OHcQC632113318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 17:38:27 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABE9958052;
	Fri, 24 Jul 2026 17:38:26 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C708B58045;
	Fri, 24 Jul 2026 17:38:25 +0000 (GMT)
Received: from [9.61.177.4] (unknown [9.61.177.4])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 17:38:25 +0000 (GMT)
Message-ID: <e526c23f-be32-4cd3-8bb3-e5a2e7af1be1@linux.ibm.com>
Date: Fri, 24 Jul 2026 13:38:25 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] s390/vfio_ccw: calculate idal length based on idaw
 type
To: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        sashiko-bot <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20260723174751.1180334-1-farman@linux.ibm.com>
 <20260723174751.1180334-6-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260723174751.1180334-6-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE1NSBTYWx0ZWRfX/hD8pmofwX9n
 H6h3sp/bp3e3vo/AUC52lCSPrXIILUOqdrv34myUQcPR7EBOL/P2HL5KGpb9KxFPsEbctiyvTW6
 OPU4IU9NqOyKUWcUBKuHGh2qhf6fhhY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE1NSBTYWx0ZWRfXzRpbkaRhIktg
 h/ECVCttuzBVswR9M1cOGJcBbvh25pavDULn3eDGFMbQ6NzvYcgPLNj472FIZgglCW5bAHAqhrF
 8qGPGANZufW2n6WXplsoer/fVCKQ2d5fa1biNuRGcUWpv4Z14lJVxZ99ybGs2g9fDivDtc+jS+U
 komam6wRTMvYYFamKIccTtUdn6jBS1mss07kvCE3XFvx1iMV+Ykxvm6Pac8j/gHjaHj8bOOhAQt
 W3J6V6f6+oLE+Q7SpV8HCxjPYeOcrfGVR2IkdGkYA10m5OlBqrSSAOcAtfe2fxHOO8WG7moQKDg
 Kmy0TdejRFq3sE05buOnf0pno9ArDOlC/b6AK87MdHTxkjvaC7Ni9inkl9TCVaLCIm5BnnbX5Ya
 6hS935DjwrGYoH3G7qn/6tNwK5H1e5dWEhuw6SVk7BGQm66T6QfoVnWVOuCIZZSDb6ZTtgVpjB+
 nk3eZGLDiWP14QDTIKA==
X-Authority-Analysis: v=2.4 cv=Q9LiJY2a c=1 sm=1 tr=0 ts=6a63a314 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=QCTVnt_YNtsi5-26WvkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: okv1Z-iBP2fpmF9MXVHk2fD7r1DXTegx
X-Proofpoint-GUID: okv1Z-iBP2fpmF9MXVHk2fD7r1DXTegx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240155

On 7/23/26 1:47 PM, Eric Farman wrote:
> Sashiko pointed out that get_guest_idal() unconditionally calculates
> the length of the IDAL presuming everything is a Format-2 IDAW.
> 
> The output of vfio-ccw is always Format-2, but the input can be either
> Format-1 (31-bit addresses) or Format-2 (64-bit addresses). As a result,
> the size of the guest IDAL may be incorrect and should be trimmed down.
> 
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/r/20260720203400.7328E1F000E9@smtp.kernel.org/
> Fixes: 1b676fe3d9d3 ("vfio/ccw: handle a guest Format-1 IDAL")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 06b6bc6142a0..b4a041d35bba 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -233,6 +233,7 @@ static void convert_ccw0_to_ccw1(struct ccw1 *source, unsigned long len)
>  }
>  
>  #define idal_is_2k(_cp) (!(_cp)->orb.cmd.c64 || (_cp)->orb.cmd.i2k)
> +#define get_idaw_size(_cp) ((_cp)->orb.cmd.c64 ? sizeof(u64) : sizeof(u32))
>  
>  /*
>   * Helpers to operate ccwchain.
> @@ -534,7 +535,7 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw, struct channel_program *cp, int
>  	dma64_t *idaws;
>  	dma32_t *idaws_f1;
>  	u64 first_idaw;
> -	int idal_len = idaw_nr * sizeof(*idaws);
> +	int idal_len = idaw_nr * get_idaw_size(cp);
>  	int idaw_size = idal_is_2k(cp) ? PAGE_SIZE / 2 : PAGE_SIZE;
>  	int idaw_mask = ~(idaw_size - 1);
>  	int i, ret;
> @@ -602,7 +603,7 @@ static int ccw_count_idaws(struct ccw1 *ccw,
>  	struct vfio_device *vdev =
>  		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
>  	u64 iova;
> -	int size = cp->orb.cmd.c64 ? sizeof(u64) : sizeof(u32);
> +	int size = get_idaw_size(cp);
>  	int ret;
>  	int bytes = 1;
>  

