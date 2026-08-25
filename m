Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2BD3F328A
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651517; cv=none; b=GuCA1t0sjDUuPtjL1lppWl2JufZnhKLS7ldloYS111paBxUk/9rnLJXp1rqAmrzKnq+leJLI9b6UuV+iTX0hSJQah8rY4pXpK4FpmFC4WOGUbgpBPMa9qTLg7/FI4IH+uCO+XgmE3VHi37470qYGNwfW4C5+7u401ukjYzQ0lw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651517; c=relaxed/simple;
	bh=fD82TbaW6cfbCLbvZwNOWHrRQpPNRZVtbP/q6IN7PhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvS6w8lmr7+2+l3LUa4R7iw35Zh5+5O2SLWDBByMLZ7OA447hhwLgnUiqs72ON1DIChraKgUYttyJt8/KrQEV6xgV7V2KmlAswPL+c4Dun0iZ33ClXUzHwJueWWfu2qmckk7JJgpXHM+f+9l6x6yx/ymAclDqNCtttUpvhlSiZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rfSGmnic; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rfSGmnic"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P8Vmtg378223
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 09:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IbOL+H
	afIdwErtib9NN3T0DwdzR+kN4zPi3ZnN+cyuI=; b=rfSGmnicBrmP9PkUr3MjoU
	Y9gFncETuu3ePl1FEuhtXMUvxSyTVITH5bHC+Rr2gi4cfGsqD1ORAq7onEpMJ/kL
	623UUuPxLJymcDSubO5JR/iLvvVTu6Qjfi6H7gIMtsK5Ok9dja+YBsAGpTj0JYRD
	dFmVmwls5kTNLr8/91weMBuD87hkenrfuwyQalgCSqMDH0kpNLXIZjuiJi2ZZZVU
	0zTpvIw87bwVqCxcnXnPIIzGdzPX3vi+yadOvZylpZdQ5/0UEzfMbGFweXvoKyLI
	jQGaQaGyHJHSMVYmZGvUNSxmfbvg4ozDc2hCx+PhKp910BBzqK4pu1+AJqurHS9Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dx742d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 09:51:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67P9fZm3013232
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 09:51:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3juhtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 25 Aug 2026 09:51:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67P9pmh546137618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 09:51:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE76820043;
	Tue, 25 Aug 2026 09:51:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C427920040;
	Tue, 25 Aug 2026 09:51:47 +0000 (GMT)
Received: from [9.224.77.157] (unknown [9.224.77.157])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Aug 2026 09:51:47 +0000 (GMT)
Message-ID: <49bc5f7c-50ff-4341-9ab7-b5a98e662b4a@linux.ibm.com>
Date: Tue, 25 Aug 2026 11:51:47 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/pai: Reduce excessive debug feature size
To: Heiko Carstens <hca@linux.ibm.com>, Jan Polensky <japo@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
References: <20260825094925.1791807-1-hca@linux.ibm.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20260825094925.1791807-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA4MCBTYWx0ZWRfX+4eMqZWbWeUC
 iBjuLgX+f0tiJ8Qmskb2s/BLL4uUV5utH15UxlNWQYzvmi4LOIk2FW6k1S7Ope5BcITrUtIO5wY
 4kUyLTWCoCZWq7vuT51J4HUfsHOEXPE=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8d65ba cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=kDPx03Ww-hrN-jpW9KgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: UG-jJCrBNP4xyEsOXQBSeyUH2TFbclcQ
X-Proofpoint-GUID: UG-jJCrBNP4xyEsOXQBSeyUH2TFbclcQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA4MCBTYWx0ZWRfXy/D0HITds7HA
 R+609TRm+iwnO66avR5ZOnssRiGDpxFpUY0C45mPB32sbr3S1BtYJnXXP80+HrEz0y943q5tj62
 NQwJjedL65IR9IGf9aUgFL5Hm9pKHHOSd7Fsqh+5lKT8RhI03GMjKaCJDC3FOjPu4sI7F9P7BOg
 CLSqq8I7QnLEP6pkl0iw7yAAg5CQy4EOqS9MzDgsvnLyD0NKxFIcMPdwKrl3YelxDq0p8guXX2K
 Q6sM3RqMNxQ4q/Tw8YeWPM+Wt35NXLoAJof8YR2sDrxIpAJxqHVD3MVsSnGuBpo0lrR+1+aWgrK
 AbNahaTlVmI9EYnLt8sAlpEf1B6EoysQNBGOMjMMH1QgiM86s8Jx39i891JQrYgpyih1nvmO6DQ
 BVR4L5gOBXvGM+8UYG/aOQ7VcvBjAXLuVLxbTz/19FDhtTozF1CG1IgOPDt50SdltKYJM+2ycQf
 ieSiF3Yh3RooBIFsBqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250080

On 8/25/26 11:49, Heiko Carstens wrote:
> The pai debug feature is registered with 256 areas, where each area
> contains 32 pages. This sums up to a total of 32MiB. The code does not use
> any debug exceptions, which means that 255 of those areas are never
> used. In addition all existing debug feature calls have a lower level (5)
> than the default level (3).
> 
> This in turn means that without user interaction the debug feature is
> unused.
> 
> Reduce the number of areas to 1, and also reduce the number of pages for
> the remaining area to 1. Since user interaction is required, the user can
> also increase the size of the remaining area, instead of wasting memory by
> default.
> 
> This reduces the total size of the debug feature to 4KiB.
> 
> Fixes: a3f8423622ef ("s390/pai_crypto: Add PAI crypto characteristics table for parameters")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/perf_pai.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
> index cdb8006220ca..ab76ed7ad791 100644
> --- a/arch/s390/kernel/perf_pai.c
> +++ b/arch/s390/kernel/perf_pai.c
> @@ -1221,7 +1221,7 @@ static int __init paipmu_setup(void)
>  static int __init pai_init(void)
>  {
>  	/* Setup s390dbf facility */
> -	paidbg = debug_register("pai", 32, 256, 128);
> +	paidbg = debug_register("pai", 1, 1, 128);
>  	if (!paidbg) {
>  		pr_err("Registration of s390dbf pai failed\n");
>  		return -ENOMEM;

Reviewed-by: Thomas Richter <tmricht@linux.ibm.com>

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
