Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A91747AF6D;
	Tue, 28 Apr 2026 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777401092; cv=none; b=MrqGPdHZmn9tsJdjpYywy+R0291HXcHQduPkuO6iKgBE69ts8MkI/rgnzDpELX4sU7gZk1IDybFpJWxaIPBUwab9hPRXE0p12eXltIOMcVHvrZ7iuV5JyR5cvpmVIYi+IBhE9U80tUCj1WQOGsaD1bsEydiHkF6xMCKjtDt/7g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777401092; c=relaxed/simple;
	bh=YqIbouP1QQZZj4irMFN2NaPn8dKRK6jDi3R3gDUUMco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7IIKZc8+nOQ/uTYnpO8yJhje+3r4ZUaE4L8WZS74M6WxhDCMM0yVOUYuJHU9w1Yqb6hH2DB3IDHkFY/TpdmJiWz0fuecd44MoxiCCsGrgnHuI6jnJERsAWRytQDTr9q+pooEJ+Lh89JRoiAWkxVVr+i0N3ouN5SnlOMeZ3g/FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QnBaudCl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QnBaudCl"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SBHIHB935847;
	Tue, 28 Apr 2026 18:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=862JwB
	dU3AS3MnJ2WsujPUgTGILIxct/hGQrfO1H5+A=; b=QnBaudClr0oHW8WwK3wmRe
	9liU9/dpSOThv2rAIwE7zmyc7QJlUuLOCJZi7Odz3jxSxlIPHMWfNUJYk/PrvCFV
	lL7k5YAa8aaCIU8n2M4HqZrSLXqQuUPZLX9YkGWPTvp+mq53wtofr+2NIKITedm+
	fGD+wL3ib1/xCeEYubgHdZ/DkILqIV9fl8l7jutt1DK1OhSpq80Dcv6WsdO2YTjD
	3lZ1XHV8EyivkgBWhM3dmMcgDqGQK4/MaCwO2U//ojWx6+NsYap1GBKOkqbsFb6t
	o/yJUmUukY6b9qyQHV12mJRHRomGv2mHwy6JdnN+HgBKkpQOlAQQ1C52nOWhY07w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9r72e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 18:31:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SINiKG003460;
	Tue, 28 Apr 2026 18:31:24 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds9ehaxn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 18:31:24 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SIVNwO15729210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 18:31:23 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23E5A5805D;
	Tue, 28 Apr 2026 18:31:23 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E86058053;
	Tue, 28 Apr 2026 18:31:21 +0000 (GMT)
Received: from [9.61.116.216] (unknown [9.61.116.216])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 18:31:21 +0000 (GMT)
Message-ID: <1a44c655-eb27-4f4d-8e1c-ff3ee518ce73@linux.ibm.com>
Date: Tue, 28 Apr 2026 14:31:20 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] s390/vfio-ap: Add live guest migration support
To: Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260407205100.331150-1-akrowiak@linux.ibm.com>
 <e8e07556-4618-4203-aaf7-e2e95c6fea71@linux.ibm.com>
 <861c2116-7d3c-4f5e-ad83-0ca314cc6e48@de.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <861c2116-7d3c-4f5e-ad83-0ca314cc6e48@de.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kMMKht6DLD3GdZNfHdooceSw1hQjjtbj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE3NyBTYWx0ZWRfX0BmLEi/batEq
 MSaRBrG1cJ0YUeqxs/q28Ui4JF24lzv9Fqb3jzURRJxpKf9kb/X2Prnul3cHSp/QxFgYnU14RUE
 Zoe85KDNTifAYhV17UT/MFooJIFmrgJZLn2jQzd+TkEv2wCbFq2lQwozPVCXZ9yWxtr+fEGLe86
 U7cEOsxk0g8J0qeZZ5MFFb3DhjtLHJZUYEdKFPkNsFB2L6PdXx2vYzmc//LcplcmZUBeL3GXsBl
 oxU+MmztfGJhy9/LmKIe+fqzf+gX5Qtjv/kHAXb65MyuaDQDMCR/ZrD1lTd0GjlZfepkEWFLyM8
 9ikuhdCok9+W9aB6+70YVfNNTkw4TMSb3qJiwAs5IEhA612TtWrUohMqsvZeSvy/iyV7tG9mQKf
 OCEBBFdz4HN9L9pvBWBQGtMFgNnpyKnv2nnfRjxuyWDQC8lBkUhcUHKjAOSkAIxeGwsiXphdhml
 UkQntIf2SA+38ngjC3Q==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f0fcfd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=l7cB-S0xE_IsS9hsg3oA:9 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: kMMKht6DLD3GdZNfHdooceSw1hQjjtbj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280177



On 4/28/26 9:56 AM, Christian Borntraeger wrote:
> Am 28.04.26 um 15:10 schrieb Anthony Krowiak:
>>
>>
>> On 4/7/26 4:50 PM, Anthony Krowiak wrote:
>>
>> A patch review would be greatly appreciated.
>
> Sorry, everybody seems busy. Can you maybe start with having a look at 
> sashiko
>
> https://sashiko.dev/#/patchset/20260407205100.331150-1-akrowiak%40linux.ibm.com 
>
>
> if any of the review findings are correct?


I'll take a look.

