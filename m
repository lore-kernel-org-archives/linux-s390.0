Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8102E7BD3;
	Tue, 18 Aug 2026 20:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787085702; cv=none; b=ebP/d/hAqCO2+IIQOgyjb1kWoJbjWcE/viOhz52Phh6Gj5S0uo3qJU3cWIy6NXBv1hvc4lyZ1HUkP80t4EztCopt8zrR3lPxQaWvKWqdmtOa5FyiJP3rD9DxYY3iVGBsqNCufSFBi8nZW71GFXTxKEjiE9f4vvADv5lvr1fLT3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787085702; c=relaxed/simple;
	bh=X/eml3cAEVmJzlja6uzONpHbZ8wluoj85ZOlk8hrXPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3ZtAM+gKVavCLWpDO/cO8NyA5NiEyj9kM8yQ8r+8T9dUWXO5PGO5iS90WQkyhJCKNJlH7aSWl7cAeU6lrU+k4tneJoloGLHyyz4V6pg3XfZIqELOk5ZV8eAigRGvrOWAiNO1yigL3SJIqCecjui7sa/1oag51uxjk3fJFqDoNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A4PrJ02J; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A4PrJ02J"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IJVxB61260656;
	Tue, 18 Aug 2026 20:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TnEDvU
	TZl1aI7NzW8y/+1ps9Qg1f8Fq2A5e778QWcF4=; b=A4PrJ02JC0RgToEXeGs7ME
	W7LD1zHyOBMUPNI0MS8mOTDEqAComvyNyzHuDXPztcPBRaHHtvflYN/nt6oQEEzF
	IQ/0j1Pb3kEwAgXLT514GTitFqXJU3C65nWgh3DhwPRJj4LSIGlvRedSowKkiw2d
	+ajrrzOYScEGdsoOOlOQAkIWFwrJk47nF8zhnGUjO49NhTd0FKm1FlSOplk49QmL
	tzWyV6MSM4ACUn4O4b91uZGBtFeLVUoJPvNRwAgwaDo8jJbw3yOf2QBwNogNZlAV
	KMBXKndk8qqwFj+ry8VIRvwJ0/QXxclb5BeDVc+6JdnF2vGi7gxZ18hWDFW9jLpg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4tut4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 20:41:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IKfKZX001335;
	Tue, 18 Aug 2026 20:41:33 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ek5csa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 20:41:33 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IKfWQ652232658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 20:41:32 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C10158051;
	Tue, 18 Aug 2026 20:41:32 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32CF25805E;
	Tue, 18 Aug 2026 20:41:31 +0000 (GMT)
Received: from [9.61.131.241] (unknown [9.61.131.241])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 20:41:31 +0000 (GMT)
Message-ID: <4680572d-1332-47b7-82a8-d0f96caa3f8e@linux.ibm.com>
Date: Tue, 18 Aug 2026 16:41:30 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] s390/vfio-ap: fix KVM GISC and page leak when
 queue removed from host config
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260818193349.1877940-1-akrowiak@linux.ibm.com>
 <20260818193349.1877940-2-akrowiak@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260818193349.1877940-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: u85W8vdoVRHnoB6pDhpaEYLvjxPONZGb
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a84c37e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ksE9VoHb2XX14hlrD9IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE1MCBTYWx0ZWRfX5iah1t1lRmPJ
 Xdczoe8JzM+xcbs6NcvV0A1kvJ0f/WlJEOamGMsECT9QsFcvW1J0mus6iSdqKQ+BDlKfROghS22
 3tNNLsq2nvLlejqzJqL0by9OX+PGcbA=
X-Proofpoint-ORIG-GUID: u85W8vdoVRHnoB6pDhpaEYLvjxPONZGb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE1MCBTYWx0ZWRfX3ccnP85r5z6z
 h/ZNpHe+B9JfAKW8rWHiKvYWKCp500zj0f5x3IS4aenqqBZc9Adx4EAR6iPQThZvVZL/t+xp5Pl
 7m6ELMqWYPON4Pfup2SiEdM75w8YKBb1fmdG2QV11pd4Ax8UJm8s1LiWYeSdP6AleNUssGRxhoX
 iU7spLQbkUfPfciZG2kcLyLpo+KhAt61m8s09S6jyxg/FFuGJygTZp6h2CMCyfOqKa/VXAoNFWB
 CYjsAoZ2y2dZOSHLqZ9+MDo9oiDOxzezZbXSSO5Sima9quzKa5rfpL///ThRYIDkHR+RjN/jFiQ
 o7YPmZnAO91ovK7I9R79y3RE8IBj7Y61aPdZDCDyjUU0Tw2RKnhj+eBvLcL5sJkOwpXg0Csaei+
 MOUutaTYq48kMLBuWW2Mj07XA78zsGSwg1NEYUj1syNIdvCPTRK9Qoqd8H/qIcT3Q2qOE48XOpd
 4UDf3bBEwfYSRMlQ2ng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180150

On 8/18/26 3:33 PM, Anthony Krowiak wrote:
> Three related problems exist in the handling of KVM interrupt and page
> resources when a queue is removed from the host's AP configuration
> while assigned to a mediated device (mdev).
> 

...

> 
> Fixes: b9bd10c43456d ("s390/vfio-ap: do not reset queue removed from host config")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Changes LGTM, my review stands.

Thanks,
Matt
