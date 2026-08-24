Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3377F3002DC;
	Mon, 24 Aug 2026 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787605441; cv=none; b=aVQX5bn1J16RRvfAzRjaIqpogE5NvHzWf7W3M3X2hDeVx2EzqY9FkLA2bLpH9+837FW8T9B8NZFW0bFcIRZGsbGuB5iAZsvlkXuZwvll7iNcDdHlnoKdTzyjpnYsfl9VLeoWrfbOqztvEX7z5ZUW17571xNAGRIlB4Qa3kCrxRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787605441; c=relaxed/simple;
	bh=wIY6maXjQGLouvIrhEgZhGijRHgcgHtSKHhMmOG1SDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+JIf0K10OtEzOhDaG24dEyklKKlkvDU84UDLsmZc9kaq562juYSl2EM0d+HsbZYh6Qoq5KtW9MzBtdDnPL9aVJfqiFdvjjO2e2DxPal8dptaCXL4EvzCtfdeRUF/Q6qAfOzZAla1sS18FnOEP8FOul6mhQUwOnNLLC7/ziytqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GrrQVBnB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GrrQVBnB"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OJVS36984452;
	Mon, 24 Aug 2026 21:03:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6PEpon
	bZsb1GZALTHKRv5kK7IlAzclK00/eNuoDnXcU=; b=GrrQVBnB0+ahEmVmIgEPDA
	ArtPP2O3EZA7orGOSFNq+Pal88Kf7F+b9tz7fq8m9AjPLQ1FPVWCJw0wrCF7od1C
	1Ukc+BvRsczFGksPa63vLYpv7Nt/dfGZT3TlI83l/Nyq7gzAmu/eHZzkf7HZghyV
	dYor4rySbO6lGnEReKdzsxPuEZlFSE7osrffUbd2Ii18jSxSUSSzKq50UciNgcR+
	Q14e33fSyhWFS2H0K7mgvzHUHD2yK9BBm594rO84PCBxb2GG/tvYTPrKKQRK5NXE
	3E3pgw5x041tI0rEC/gI5EoroNhzmus9UEaoM7Pvhiphx2bG0Pt6zXzyR4E179Xw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqm6pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 21:03:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OKuFQS030534;
	Mon, 24 Aug 2026 21:03:53 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3q0qc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 21:03:53 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OL3qL527787992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 21:03:52 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26E945805C;
	Mon, 24 Aug 2026 21:03:52 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEBB058051;
	Mon, 24 Aug 2026 21:03:50 +0000 (GMT)
Received: from [9.61.96.163] (unknown [9.61.96.163])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 21:03:50 +0000 (GMT)
Message-ID: <3bfb12ee-42a5-485a-8d97-a53c02618837@linux.ibm.com>
Date: Mon, 24 Aug 2026 17:03:50 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] s390/vfio-ap: Fix leak of pinned NIB and registered
 NISC in vfio_ap_irq_enable()
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260824135850.503728-1-akrowiak@linux.ibm.com>
 <20260824135850.503728-2-akrowiak@linux.ibm.com>
 <adecc2df-d2c2-48d6-a80a-c84ab9779322@linux.ibm.com>
 <4bc189fa-ade2-46a9-a749-c9c8067f347a@linux.ibm.com>
 <50eab46c-adb2-4ed0-ba4e-cd61f458be25@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <50eab46c-adb2-4ed0-ba4e-cd61f458be25@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qyoxWuzsRwRq4jKJqFnZa12AcVBIdy5i
X-Proofpoint-ORIG-GUID: qyoxWuzsRwRq4jKJqFnZa12AcVBIdy5i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE3OCBTYWx0ZWRfX7nuKHT20tVAK
 xYITPz0gy3pF/9YzkaVDw87Uv5FnbjekdXa+0z+0p2iaE2V4Khc2NKiGwXzuz9Rgwuz3Y9UHtUg
 XQt80Q96kTobDGrgvBlDY3KbLSfuj73NpXeIEDHptpI84Nh0TwBqCXmcYaJ2LvwEm2wWc0sQ8W8
 7sCaoOPC4BcFNA5tZ2dAu81VhmcEEstWuXTftRKHftfDo9bX16wici4DIZm5j0G5tJnF+NVr4oI
 6GChi/86/ENSHCrMOGGHDMKPQr9jJ7I3ZcSX+TLM4f0rCNmxSdFePPGDfuG4H1NsCPVPlO5ljJD
 naPD3KL9UPBnajJJXHB8KF3VW9O7I/aQOPvSBDPpFCByZr+UzVkAilqhwlirH8gC0cENtc3i1FU
 ryoBn0ke0zz+fSWOqNSzdy+5rxadEnqxgJUqK7kvS8uRWOWkigUGKQlE/bQkRHoM0M7G8QS87wT
 51hZw0v2sXsQk7uqhUQ==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8cb1ba cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=I5xbfZNcwhnpA0U6tpEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE3OCBTYWx0ZWRfX4xzIUiU2ovCQ
 MXmODvC2BocK/b0iEZDLpA1ZJPD2BNftnxxYLhiuBXft1OVSmIkX4u7g3NgEo84hDptXYA5nYY8
 b+UKscu0N3d9vi7qLoiP41NgpqB/Xks=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240178



On 8/24/26 3:56 PM, Matthew Rosato wrote:
>>>> -        pr_warn("%s: apqn %04x: response: %02x\n", __func__, q->apqn,
>>>> -            status.response_code);
>>>> -        vfio_ap_irq_disable(q);
>>>> +        pr_warn("%s: PQAP(AQIC) failed with response code %02x for
>>>> apqn %04x\n",
>>>> +            __func__, status.response_code, q->apqn);
>>> LGTM, except Sashiko mentions the pr_warn here that you are updating has
>>> a pre-existing issue.
>>>
>>> Since you're touching it already, do you think it makes sense to switch
>>> to pr_warn_ratelimited with this patch?
>> Since this is a pre-existing problem not introduced with this patch and
>> there is
>> likewise another related problem not introduced by this patch, I am
>> going to
>> post a separated series with fixes to those two related issues.
>>
> Isn't the change in pr_warn wording here also unnecessary/cosmetic?
>
> Why don't you remove the change to pr_warn from this patch and re-word
> it at the same time you convert it to VFIO_AP_DBF_WARN -- that way you
> avoid touching/extending the pre-existing issue with this patch.

Actually, now that I've looked at the entirety of the code, there is no
need to add a VFIO_AP_DBF_WARN here. After the switch statement
we have the following which duplicates the pr_warn but with more
detail:

if(status.response_code!= AP_RESPONSE_NORMAL) { VFIO_AP_DBF_WARN("%s: 
PQAP(AQIC) failed with status=%#02x: " "zone=%#x, ir=%#x, gisc=%#x, 
f=%#x," "gisa=%#x, isc=%#x, apqn=%#04x\n", __func__, 
status.response_code, aqic_gisa.zone, aqic_gisa.ir, aqic_gisa.gisc, 
aqic_gisa.gf, aqic_gisa.gisa, aqic_gisa.isc, q->apqn);

}





