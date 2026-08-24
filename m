Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DAB32ED34;
	Mon, 24 Aug 2026 19:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787601418; cv=none; b=dC+wa1rU/yxmVfVPay6zs2MqG4aYBV/ZTCwiKXVWmutmbiZO0Uif7cbzHd96zqieVtXzvfPJdYtKW01nzQLsSRHaj4aQ37+sBJmFWZ+mFZwMp9KMBigFLTswff0pXWiWnVvPCc81CFBpOJE0qhBDH9N6VIabo26jmbNtmkmo0J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787601418; c=relaxed/simple;
	bh=aHCEQ0XMoejXwVzW6TV0Q7bxJKeXNpAgs4LvFmsTLrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VEOffsJpNSrTLpEXgLMRNosO9zHaV6X6oxzezFydjDwaFdsgN4XinIYrBT+Wum3N0iInwTZq9GaZNRmXqnc/NdJNcBoOxgvgW1COGY1Nhg3rMa6QnZahyt0vVLn0kWWb1B1AQWnOvFOPjbU55Rn2tbDgf4Nzsd+bT+5oFF0kRTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gPhkITO0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gPhkITO0"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OJVWSm2858005;
	Mon, 24 Aug 2026 19:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9bRzMX
	DQ2KHryxh9JVER/KHkaENwp2hQwgBUP3CN0PA=; b=gPhkITO0yoITlqCEIInF+O
	ScjUdmX0HZurzF/5GQpgn2CEzSTvZhwU+nCiUR+sm7pg/D1M0YWDzI0EJOpUxUFc
	C+7XlmzXzytYsHn5cWg2XNBcfsVlnvQTByO1NAW6uNS9o4LuW0TdAPkkeEiMJPeK
	GKaSd6QyNP7tU5zoF5obprJn7nByTgPr/cy2ngfCvP3T4WpizoIaK5YcJ49wFKjs
	dpW3wSsIh0wGegbXhdcuHswlBDOdK8FAgrCKc6dpz4h9+KLvwrldR45+QdH+YONV
	bqgnFeds53H3ODAXbOKjwYErvXCKYi/j+yddnrGriU7muPusVkQokojkeDc7ZCQA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4kuhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 19:56:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OJuIfX017026;
	Mon, 24 Aug 2026 19:56:48 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3q0cxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 19:56:48 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OJuk3Z35521210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 19:56:47 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB40658056;
	Mon, 24 Aug 2026 19:56:46 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D186358052;
	Mon, 24 Aug 2026 19:56:45 +0000 (GMT)
Received: from [9.61.21.147] (unknown [9.61.21.147])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 19:56:45 +0000 (GMT)
Message-ID: <50eab46c-adb2-4ed0-ba4e-cd61f458be25@linux.ibm.com>
Date: Mon, 24 Aug 2026 15:56:45 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] s390/vfio-ap: Fix leak of pinned NIB and registered
 NISC in vfio_ap_irq_enable()
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
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
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <4bc189fa-ade2-46a9-a749-c9c8067f347a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LYzQOk97v3aBe7OKPUcgTKr4CoIuOdXF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE2NSBTYWx0ZWRfX+tnMNZ++biV9
 ZCB4d0euz9VxDHpmWrgebYVskmg16JN1oTMFXRHHsBEQ88Y7uVUWrGA/dOoufeIew2ZE+HdL1ne
 Oe1PBp7zdG4K+UDbY8KO0IHYe6153FE=
X-Proofpoint-GUID: LYzQOk97v3aBe7OKPUcgTKr4CoIuOdXF
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8ca201 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=fC8ONtpf1JqEIMraeR0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE2NSBTYWx0ZWRfX7z7pqN8NTJxy
 w70Hz8Qqt+AMn8DixynYuGuiFRiDeDGx+I1uv6FbDdPRFcdbV3M0rb6GOOnRHPq48lasGic0RiR
 Z/t2VSD0dl5jN23tLcYxokklQPv3KlYfwbTY18JjvSuNEgXPFyoAUVgepkzmfav/+4TvEzrgwMy
 5m6R2GycPyY7w2fsG40aq0KP0wK02SIGZntOKD2PfBIMXmrvzSzy4e8hCI9RoxIH4p8cqPwO8O+
 oe9Mfx4H+ckNEzjrrPNSZSI+D1O7EQWY1Yv6zKcL08OB1Vsjyv7FQl3uPvc5ABvTjvh8bL1h84P
 lMeYjkCJaBDtgxJFHessMoTzdU1TAD0vj/gy3o4z/93WCur8orny0wQng8VTgZ/Cy1aSgk/9teO
 JANopSU+IJG23jPhup/I3U2MPbVDoEdcwQShmzGuKcpJ63DOZZFXHxFXU098Ir0jYcM811WkGzb
 bgsdMZNehEPvLVJ3Gdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240165


>>> -        pr_warn("%s: apqn %04x: response: %02x\n", __func__, q->apqn,
>>> -            status.response_code);
>>> -        vfio_ap_irq_disable(q);
>>> +        pr_warn("%s: PQAP(AQIC) failed with response code %02x for
>>> apqn %04x\n",
>>> +            __func__, status.response_code, q->apqn);
>> LGTM, except Sashiko mentions the pr_warn here that you are updating has
>> a pre-existing issue.
>>
>> Since you're touching it already, do you think it makes sense to switch
>> to pr_warn_ratelimited with this patch?
> 
> Since this is a pre-existing problem not introduced with this patch and
> there is
> likewise another related problem not introduced by this patch, I am
> going to
> post a separated series with fixes to those two related issues.
> 
Isn't the change in pr_warn wording here also unnecessary/cosmetic?

Why don't you remove the change to pr_warn from this patch and re-word
it at the same time you convert it to VFIO_AP_DBF_WARN -- that way you
avoid touching/extending the pre-existing issue with this patch.
