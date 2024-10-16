Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AB9134A8;
	Wed, 16 Oct 2024 09:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069590; cv=none; b=V5oV2mcmpVYzDfVWHhQdO5QNfVmAtvetbGWY724rOEuU6mxPJQgxxO3EfiEFX4zOzf8ZQpci4+zgosPECmiX2xbciedG1etQ8IwZKvNgaxDT21kFE/ihKIMr13HuA4w4Lu+NWs8WdDjKk8AqbpSo4Vp9XIYvZ1iqQkUHJNVoXNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069590; c=relaxed/simple;
	bh=u3hZhXCKokVw4XNtUv+yV7L4ef24D88dELzsCm5JZ3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHllbe/X1ikYvgRkh066mf9RFmTvUgZHD1LVuguedpI04X7ggfLfLbrYsXBZkrNql3JfLwEweP4xaFOf72YvVTcuDA8+54kjKPQ2L0e+3pQLDQnIen43yFSZ2iQ28bb1ju+4jRJc8LMXjDMVBiqyM3ehwFiw5TrdLb0yT8g2iFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hzl6zlbh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hzl6zlbh"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G8t9gw031430;
	Wed, 16 Oct 2024 09:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LYUajw
	5H/Yn9/VR9NpmgamCBftzg66jeHRzXOKGbtdQ=; b=Hzl6zlbhMZH4xvTO04uRjx
	4zahnixJysmJqL5ZWchQxjszYf1z5CS4hWywRmUNS9HGHah1JWCJZTo1wwHZ7NPV
	F4wfnbgETpSPxflQPhQrjPVf3Mn+/EhtwVzIPqTPp12cM0SLisPCRfIEqxtK/ahE
	/Pg25LVpxeCGVNuwX4exBxQ1pl39HuthLjcWFzbJPiUdjza1T3OCjJ1fiSP/rnku
	jUIsei/RDkcClUuwoNlPBWkg2rq3UGkn1amFR09M4ZgBN9y9dXU8KBiq6LLnchdU
	TgOLarQP3HyunCGl7YVryfjc8HbbK9VKImNveXWOonvnjcRzbkmIaEX6op/FKL6w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42aad2g284-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 09:06:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49G7GajF006789;
	Wed, 16 Oct 2024 09:06:26 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284xk8a2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 09:06:26 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49G96PY060621238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 09:06:25 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6575658059;
	Wed, 16 Oct 2024 09:06:25 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81AC258055;
	Wed, 16 Oct 2024 09:06:23 +0000 (GMT)
Received: from [9.155.199.163] (unknown [9.155.199.163])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Oct 2024 09:06:23 +0000 (GMT)
Message-ID: <cdb1e714-a70f-4bb0-b7b7-c420c9322176@linux.ibm.com>
Date: Wed, 16 Oct 2024 11:06:22 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] s390/uvdevice: Add List Secrets Ext IOCTL
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20241015112859.3069210-1-seiden@linux.ibm.com>
 <20241015112859.3069210-6-seiden@linux.ibm.com>
 <20241015120109.7641-K-hca@linux.ibm.com>
Content-Language: en-US
From: Steffen Eiden <seiden@linux.ibm.com>
In-Reply-To: <20241015120109.7641-K-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Wtbyx_WJ2TT6zuPdJBUI9d-XOnRQ6J5h
X-Proofpoint-ORIG-GUID: Wtbyx_WJ2TT6zuPdJBUI9d-XOnRQ6J5h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxlogscore=777
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160059



On 10/15/24 2:01 PM, Heiko Carstens wrote:
> On Tue, Oct 15, 2024 at 01:28:58PM +0200, Steffen Eiden wrote:
>> Add an extended List Secrets IOCTL. In contrast to the first list IOCTL
>> this accepts an index as the first two bytes of the provided page as an
>> input. This index is then taken as the index offset for the list UVC to
>> receive later entries for the list. While at it fix some kernel doc
>> issues with the list function.
>>
>> Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
>> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
>> ---
>>   arch/s390/include/uapi/asm/uvdevice.h |  4 ++
>>   drivers/s390/char/uvdevice.c          | 96 +++++++++++++++++++--------
>>   2 files changed, 72 insertions(+), 28 deletions(-)
> 
> ...
> 
>> +/**
>> + * The actual list(_ext) IOCTL.
>> + * If list_ext is true, the first two bytes of the user buffer set the starting
>> + * index of the list-UVC.
>> + */
>> +static int list_secrets(struct uvio_ioctl_cb *uv_ioctl, bool list_ext)
> 
> This is not kernel-doc style :)
Thanks, this should not be kernel doc anyways (nor part of an API). Removing the additional star.

> 
>> +	free_pages((unsigned long)secrets, 0);
>> +	return ret;
> 
> free_page() instead of free_pages()?

