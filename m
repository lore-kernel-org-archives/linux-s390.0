Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEA934107F;
	Thu, 23 Jul 2026 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784824720; cv=none; b=pbS6F+aVH9b+JE0dXl+OTSygRz5ZfmKPQM0drR84awIdGPJc27fQsrSP1ihk/mCfl5vNUZpyIFQrRrlvvBkDdxUosRa5cVFrGGW1L5AccbfzJzzvo51ULKtqumXB9TFfSgmGk8ZvfFNik+DhOd7Rmxc9wWrsE1GDu7KZS3bWI3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784824720; c=relaxed/simple;
	bh=8QFfivOq3dFgFtl1JZbFBFdSPNvH+WRBg82oFKzDfHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c4clnNS8H8mCVxTtmF7P3+afVZCrgigHbfe1VRHy1O0HuEVIWAxjA73ZN9JLtf2/2rkUy0rQfaXp7YlpKbR8tVPaO+5RibK4fvfdi3BvymYr5Ydn4f4dYAKHB3KfYhQf9CyVV8ja1Wyv1k5moPpMnPGlAiWRx1iaitgcIjXv79U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eAmyerQ2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eAmyerQ2"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDBih93094728;
	Thu, 23 Jul 2026 16:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=94TQvF
	Fvj8zVmSSSoqgjcJLHCeffNFWX7lxB9/2yAwQ=; b=eAmyerQ2H6KpE5iZv4II1Q
	CGMu//IhlkkL/Cclat3LMxryIcLjpC6A6Az5I839966jyGnkMey58/e9JlrJn/F8
	kU1hlBMziCfmQORfHnhkX7gglUaVTmJq4l0x7GSD1rSGvde65YDm4FGODJ7F1heE
	kb4RLqQ5qQ6Zj3kCEin0lKCiFOItzTMJen9QCZ49aSF8dALrwXjgZ+M0XT2ON8cP
	2mwd1TB5RwKpgZFkPPGfxd8uXymZLzrxLOW6z6mD08yhxXRmWP8q8NSyklXEpsHH
	7lqQFF0HVM+5Dtn96C+q0gCAcwIgOELVGT3IZk53Vy7UtaxQ9AOOOWJ9UslBot4A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahfyr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 16:38:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NGYbru017258;
	Thu, 23 Jul 2026 16:38:37 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqd7pv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 16:38:37 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NGcakn64946438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 16:38:36 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04DD058054;
	Thu, 23 Jul 2026 16:38:36 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 340345805A;
	Thu, 23 Jul 2026 16:38:35 +0000 (GMT)
Received: from [9.61.254.118] (unknown [9.61.254.118])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 16:38:35 +0000 (GMT)
Message-ID: <df4102bc-c834-4782-ab33-c275fa5614fc@linux.ibm.com>
Date: Thu, 23 Jul 2026 09:38:34 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] KVM s390x PCI fixes
To: Matthew Rosato <mjrosato@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: farman@linux.ibm.com
References: <20260722170621.1686-1-alifm@linux.ibm.com>
 <6cefe506-b36c-472a-8ab7-ca2483dcc0a9@linux.ibm.com>
 <695f10af-317b-4de0-a66a-4257d40d8cc9@linux.ibm.com>
 <a5dee982-6958-4328-89bd-b7d69df730f7@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <a5dee982-6958-4328-89bd-b7d69df730f7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: veaRIRkB8pmfZSpJli7R-k9p_fy4Uka6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE1OSBTYWx0ZWRfX2qbezqleAG7y
 hUPQao+AQ4o7GASET0JEupGCmyr3yFO3zTT0pzprQxWaNW5qOi92eLCeFd4GSPEUD2yioZNdLl1
 panmFQOLM+emQPdbHcQvZVZWzaLHkIggYGmHAOj+px2ctHMCXVJpmuGcoGpisULYWYg/VJ/jQ2t
 /ulLH8cHVs/yUFfYXkIk2tApklZpkdq0pk++09WiwsN14XegcNYuKkQqVqVTfaUWFrZxvP8oGsH
 jWFO/PKdYSMD+4biFsFMrE5je+QMRV4Hf02nuJpsC4rMLn4K2t6nOl4UMHMr12WQ4vPv71Uay0S
 8HO1XdkY4Zbega3J5FYkzhZiIEF4NdL17oXH+1Hvvc0OFB0T/b8dNa7wJwN9uXlNE2LUeBS4THy
 T7xKdg0y4azAjT2U6SfuG4wwUhwRbGq3WhkPPX9Lck+Vepb0/xTtN0B/KLUu/kqMYzkMJH79Qke
 gsXfVO9BnSw9j1I254w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE1OSBTYWx0ZWRfXx8ZyAgt+jaM6
 7aZhRbFdGF2qOibWnmgSSWNNOJmrRTt3EkkZ2/zAg+4g9eTb7+BoNk9P5l7o/dUo+hFoooefFtM
 9vx9kRjePTYTFSujbinCVmUXIC4pxjg=
X-Proofpoint-GUID: veaRIRkB8pmfZSpJli7R-k9p_fy4Uka6
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a62438e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=x10Zz5tqN_DblOGAQIUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230159


On 7/23/2026 8:35 AM, Matthew Rosato wrote:
> On 7/23/26 9:00 AM, Matthew Rosato wrote:
>>> I would take this series and do small fixups where necessary. Just tell
>>> me if the change for patch 6 is fine. Or provide a v5.
>>>
>> I am reviewing and testing this today, please give me a few more hours.
>>
> Farhan, could you do a v5 with comments addressed?
>
> I am willing to also tag patch 2 if you either make the change I asked
> for there (or explain to me why it's not necessary).

Yes I can spin a v5, I think we have enough reviews to warrant a v5. 
Thanks all for reviewing.

Thanks

Farhan

>
> I've also done a variety of testing, so I'd be happy to also give my
> Tested-by to the series.  But would be good to do this on a v5.
>
>>> I suggest to add cc stable to all patches.
>> Agree
