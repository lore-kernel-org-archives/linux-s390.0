Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E55419FB2;
	Wed, 23 Sep 2026 22:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202061; cv=none; b=iFhkHG/foNlkP5UE4SPByz57AI1dDLgEsNz/WyILXW5Bd4+kLAGbjESAyNBkXUJD6ODCWJcnX0ZJU45VagA5cOp8jvwPK9Icti1REDK/llWmU1P3Ze7n4UQzJGd2yOF3tnw0W0ZFMwnRpp4m7xh0k0p4pNAxWY//+Q/94v2dc6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202061; c=relaxed/simple;
	bh=a1YKOuifPB71A34XprteMDk+HCreJgv/jv1DDEnj+r4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rHSAIjjkTQne87whNbVv92gNrGczi9CbW2Qsh2GCaJAYBY0Pr1hzZORieKvOqrZTggqpqpiRzEIBLcmNrfqvV2t1W+lO4SVV5FCISXU2i19kZ5tEJkBLLMKXbIv3GNLt3KeAvnldWmPWN+t5N0OXqXJW3Iuhq8Ucj47sc38AePo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Drv93rqh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Drv93rqh"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NK5e5K4191666;
	Wed, 23 Sep 2026 22:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GcFyNI
	k5gzOxCTCHf8n1WUNIQS9YIHrjRFRTK0VJUzA=; b=Drv93rqhPc6YSKXztBC5ZD
	pjmxxg6WuFHT/IBMKPU2C061ejkQnpMe1R1Erw2b9Xsd+Y2oUkHdlzyqL/5dBKCx
	1hRL9ACdKCsKNePpZ52/DqJmZdp1kVg0sBUUvW3V44/jO7Umv+76ADb/UDDQbVnu
	DOrgwq6oKyajGspF/9qOv7NV70vVOxXUQ2VZfxFKZNERk5F7LA7TMo7TVXyn8pqd
	uydjb6wzm4U1Zvl7b+6JiJw8VBbJ0srWD+bKN+4f7biQitaGNAvwZ1tzlqdui05i
	yS17ylDPOuWmHcMyGoXQu54DuuYphO/Taeewm2BLc8vCOLkpp4D9/YDMJTY/11OA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1nb80-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 22:20:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68NJmJcU903428;
	Wed, 23 Sep 2026 22:20:55 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qk21r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 22:20:55 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NMKsNV57541086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 22:20:54 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B8775805D;
	Wed, 23 Sep 2026 22:20:54 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 156EF58052;
	Wed, 23 Sep 2026 22:20:53 +0000 (GMT)
Received: from [9.61.7.131] (unknown [9.61.7.131])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 22:20:52 +0000 (GMT)
Message-ID: <502d511c-0cea-4245-a8ee-06e8d05a141b@linux.ibm.com>
Date: Wed, 23 Sep 2026 18:20:52 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] s390/pci: Reuse FMB buffer and preserve state in
 device re-enablement
To: Omar Elghoul <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, schnelle@linux.ibm.com,
        alifm@linux.ibm.com, farman@linux.ibm.com, gbayer@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org
References: <20260922195141.94548-1-oelghoul@linux.ibm.com>
 <20260922195141.94548-3-oelghoul@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260922195141.94548-3-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GifT-Wu2KdCL6L5P1dK2us5HXNA5tme1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA4OCBTYWx0ZWRfXytvcyBGFmPnw
 Drc8yZWFawCooX7BANYZwf+moJruTVqJdjaMEjI3q7E0+t/Uf3lQgNJTzyq7gQUvM/8/0GAFFAC
 1IM3g9RUMgQ93KZWI2519Pz+oDbCeZyeOXeTAAGDgcUsMs6X/bcZSYNVYFWGe3yBqhuMiHtvi8Z
 gJ3oxtCZNdCWxVweL1YR7mUUToj66JWGvQ3mD7s49uYzjkzhGKR1w0DcCqaXEYTzQTKs9CCUnZZ
 dOLptpqmJE8xXOBosOCAHkr121kUMOupt2cfasgwvTfnOTasH9vaS1uiitdTkPLIR+JmBpsyXfo
 iVblK7m0h0jQe0R3gtZGAcVgET/b0Cq1KX4IlrNCxD0eZA3+4ozl8MHgfpUyzd1laE5ZDPw0Af+
 7TSLtDWL7qMXRMa5qTU9FA/igja+w8YUB+PXi0lJQM1poz5tVUFDLQTz/PJn8skXPl9B646vtIa
 0rtRKug1ri/SsiBG1Ag==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab450c8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Bcyp42XLdVgv1jISZPMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA4OCBTYWx0ZWRfXx0A2BjQWGwY6
 A/yd7U4B4P+RalLUiYUibbSQOLvxcdukwwQTtq9BP8OT0sXcX2GH2SwB9imnTIrorBCr2FsK8jh
 ich+25Z1EfiMhzMTXFhh0IRXYHU9kSg=
X-Proofpoint-GUID: GifT-Wu2KdCL6L5P1dK2us5HXNA5tme1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230088

On 9/22/26 3:51 PM, Omar Elghoul wrote:
> Introduce the function zpci_fmb_reenable_device() that checks the state
> of function measurement and ensures it is enabled. Reset the counters to
> zero, disable, and re-enable the FMB if it was already enabled. Call
> this function from zpci_reenable_device().
> 
> Don't free the FMB buffer during disabling and reuse it when re-enabling
> measurement. Instead, free the buffer upon device teardown, allowing the
> same buffer to be reused in the enable path and add the bit fmb_enabled
> to struct zpci_dev. Audit the only consumer of zdev->fmb and update it
> to reflect the change in semantics.
> 
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>

[...]

> +int zpci_fmb_reenable_device(struct zpci_dev *zdev)
> +{
> +	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
> +	struct zpci_fib fib = {0};
> +	u8 cc, status;
> +
> +	lockdep_assert_held(&zdev->fmb_lock);
> +
> +	if (!zdev->fmb_enabled)
> +		return zpci_fmb_enable_device(zdev);

[...]

> +	if (zdev->fmb_enabled)
> +		zpci_fmb_reenable_device(zdev);
>  
Besides Gerd's comments, I was looking at this patch in isolation and
this combination made me wonder why you were adding what appears to be
dead code (of course, patch 4 adds another caller that doesn't check
zdev->fmb_enabled before calling)

Maybe you could add a bit to the commit message besides 'Call
> this function from zpci_reenable_device().' to indicate that this
function is also being setup for future re-use where we might be going
disabled->enabled rather than enabled->disabled->enabled.
