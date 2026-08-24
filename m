Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A50246781;
	Mon, 24 Aug 2026 20:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787604997; cv=none; b=gyOGfq23Q4016L23COKdUDqxHbJz3PjHxpEES9EADfymx8trrYL9ZxqzV4nlV1EcgAEZKBCZLfkDpUa1KvqKGnTOcPdbjXQcBCrKBJcDh6ONAx+zzPG7c+W9c1Xto+xeVoRlrNFT3vb3Y36jJB0Z3nM6nZ53uAwjk72/qM7CkSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787604997; c=relaxed/simple;
	bh=oxGvpJXn0j7pVZtTYsp8ePNna712eA722kU7qOjKLpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JmMzE/v1bmd3xjoJb1cNx88UlcG0QATIrgnyaFXpqHYlJ3ty7MhFg4nhb0blmIzgXbwzvlN5nQVyVVxzD0FSFDud2Q1iGHHthUV8R20DfhsER5qnjh0pLNPxHGuhpMf4D6+YQ4WksAu1L7+aDrdOiZONOvnlsqrNEjTzi2tLscA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PuobLqnM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PuobLqnM"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OJVlqZ2744507;
	Mon, 24 Aug 2026 20:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oxGvpJ
	Xn0j7pVZtTYsp8ePNna712eA722kU7qOjKLpI=; b=PuobLqnMAY75jYM54aVm8J
	5bgDJXFn37e7yXQ3lYaSfE4EQO8iw05s841e4dZqvn79/TJnF0iRqmF+2I8iia95
	h5NvhXm2dCt19jbnIsASkjcFf0RQExrZXBq6y4OKsSB3zamqni94DbDQ4NG2t9OL
	0DGFCbZvluDXkN3NWHRHNezGKB7aDJ9HLecfjFN9ZAFQndu3pgDdrjztSxIN7jaE
	f9MK7G8MwyUZMJbmf6dEYJf74nbKedcMhEq9ioLGCVro7DOzBR1IVeSojx4XQgtO
	Mb02XBcfJ8d4UQJALMKk8407ttYCg4quIt4HUh6xUwOBjiOrLGTkxQIYaPSwzU8w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hmbs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 20:56:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OKuIwt011820;
	Mon, 24 Aug 2026 20:56:28 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag8ab4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 20:56:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OKuRsx9503368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 20:56:27 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B50B5805E;
	Mon, 24 Aug 2026 20:56:27 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4AEB58051;
	Mon, 24 Aug 2026 20:56:25 +0000 (GMT)
Received: from [9.61.96.163] (unknown [9.61.96.163])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 20:56:25 +0000 (GMT)
Message-ID: <1ed56cec-00d8-4805-96e1-bdcdecc3be1d@linux.ibm.com>
Date: Mon, 24 Aug 2026 16:56:25 -0400
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE3MyBTYWx0ZWRfXwQYXEudCLZhH
 maNSFNpDHwRM9T7vigSB2MMXP4uIlBQL6HA3cxO4YZPJucvUrPr9w82hhm+jsQJ++UC2+z8RBbU
 qwvpOQXRkY1TAGuzZq/Ed3Q+j/EPKZQ=
X-Proofpoint-GUID: VCI0cuZEie5NwuuY8hy-ug_nd0t_Us9d
X-Proofpoint-ORIG-GUID: VCI0cuZEie5NwuuY8hy-ug_nd0t_Us9d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE3MyBTYWx0ZWRfX2Wb7EXoflSb/
 bSiUJduVVKAen77BavimZAN48Jt4ud3DmwkMyuzhSoxHvDcdM5fVjF8RTh78tEAW8UjTbXfFz4l
 VmWRFwr9Ab5aQt6TIjQaqZZtTjTEj/c8puXgUDaOb4Dwb/wE5+oCjX9n8E3XSh92JiH7Nc5t14L
 20m2TIC4MEH0sUBfbMP0yjiHmjPbPDjVLhChpSR0CfpCqJ6rsAywpRZFxO3DVfMOS9Qw0JwCh9W
 iQmuYyiC7W3vOTiXigckYn6uYqk2zq5zDioWeJzUXHJlXE/zEPIbVqIwsQ+oLj4VYhZg8tfzFCm
 LNfsnyGAWG5IdvAr2yBFgZ8rgfdnH+pFF3M2TueVlK/ym8Fa1oFa7I2QkvnJS50nAfI7CcPIJ7g
 yewxj7XQ4iuZPqz85ZdVSYx2Q///CLxkypYT/WHlf1whhXkG3F3NHeYwR27wvF8YUFFgr1BkL1G
 YO5jQ4YCBy/FCMe162g==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8caffd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=I5xbfZNcwhnpA0U6tpEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240173



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

Sure, will do.


