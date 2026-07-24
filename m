Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F2B4908A1;
	Fri, 24 Jul 2026 02:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784859011; cv=none; b=VRUs8yiSDptVN3NtLALtD9vbj6oELxpinrH6N9ZqUa/SJDRCw90+Q6bOKON1LdFJOL/BdtaTox+4HVm+Rz5pVKUn/LQhSg+honVmbtaZjZlatR/M7FegFb4jIZm3yk2Q4+MnT5AuhDOPVqBJwrINGR8gSjBsycMoUkty86QiDMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784859011; c=relaxed/simple;
	bh=KEo/Rtqy5PkN74Y2cNKBvRw23x2VMAX0jV0hFSDl1+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p53Tt+nsyd1owfMicmGDJIXkGC8dzo61RBgCRano2HjDmArO58R4wRDbmQcg2DxFtevqDvzJG6PhUApVK0EdQIr4fA01jnN3rOfhfAt6FARwfz/BLKANuKyswtPXSndg2maa8k2ebpEbUM4SGbneMkW6bGsLoBilScstBoS1R2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jFXisWCd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jFXisWCd"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NLfjFN4190685;
	Fri, 24 Jul 2026 02:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5Yn02y
	4qjrYulOZaRraRLXguBn89QGkWlVFq52axzhc=; b=jFXisWCdPTazgUuYTNrpc1
	atkMpdRF6dN7Eunmzfujmvp53u9N7mIu8DRWOS6Gg2cNbXerbumsI/xQOQecjZi+
	hHfgN8BLQt+N0wSMjrhcoggcMKkvIXLQL0H/yI9Es1gZFqTQHUjNxZNlZRPKsHLm
	0G7PVx5KHt81CmnD2xAVsNVCOPWVPXGCCH4mHYs0rS1M+AlKGasCEXMtqbXqyfK4
	fxFAkun/dBjRJx2gpOyM2hrb24OFVBasgs2VL22/GdLTVFGJNcPj9vG2I47NOYs8
	cr+GK+Rb9ZQIirx1GbWmQR8CXEQZoFM4IRNpoAQpXX5cVvoq8Ps2pkMqZ8USqXkw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahhw7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 02:10:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O24kU5025511;
	Fri, 24 Jul 2026 02:10:07 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gps8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 02:10:07 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66O2A5ve25428496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 02:10:05 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 989A158050;
	Fri, 24 Jul 2026 02:10:05 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8CDB58045;
	Fri, 24 Jul 2026 02:10:04 +0000 (GMT)
Received: from [9.61.177.4] (unknown [9.61.177.4])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 02:10:04 +0000 (GMT)
Message-ID: <2a0d04b3-55f7-41ae-8224-0ba21120918b@linux.ibm.com>
Date: Thu, 23 Jul 2026 22:10:04 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] KVM s390x PCI fixes
To: Farhan Ali <alifm@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@linux.ibm.com
References: <20260723221409.5874-1-alifm@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260723221409.5874-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YYcmyiEcsj2IbMx-IKRW2bzgOYFFHoY9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDAxMyBTYWx0ZWRfX8wpRp3+Kzfdo
 cGdG1F0uAaz0U4jXZpnawEkt6h4PV1g+Z+nKewSS4QFjYRPkLI5DJUEuycsW8KFKtAs2rw9e7X4
 rjoRcX05YAiNco2dClc7LFsPVLqgGZqYTZep0Jg+7yuiooyNqF12IKMrlry/1mE7ybkGi358zbd
 3vDcpbBz8MP9CK8S3Wcik3VvvkuH7g1aF7ffyiEefVDgmkXyktTgpHEpf5/hwTPAtYYhN8RfckJ
 6Dyf+ItI2tuDgQK6I8Ti8RKOUMhVJQFcjXaURrtmZCj5ff/ZkW7IgU5v1ACphioKUOovzklaUpL
 SbFsYybCcHPv3HoHEcmB/s3Yq9OoCFc2Hl+WGNA0EEb2yYO3ZeFmNOJJXCSXZFFZeRADvORQOCh
 l6KONHfCz0xHRibBt6YVf5kBZ1Zp9v2IppbaXmC/zMkuFIEzT6xm6U/y3clrL2KsDqC2ZfDtfGu
 icW8HoRvsKpRdGHpcig==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDAxMyBTYWx0ZWRfXzemR4nfgsdWB
 BxtapDfRT8LgFe1HFZ2nhPdmGhflU431SFWz3LfRg/wyYOLvfLyACEQW+m90Q7UFiPa/RY2XKGw
 HJmYhdjluMQYVq9ndGPSQU4El8EBdGA=
X-Proofpoint-GUID: YYcmyiEcsj2IbMx-IKRW2bzgOYFFHoY9
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a62c980 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=hRmaf8ABpUde_-1rv-wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240013

On 7/23/26 6:14 PM, Farhan Ali wrote:
> Hi,
> 
> This series attempts to fix some the pre-existing issues[1] found by 
> sashiko.
> 
> [1] https://lore.kernel.org/all/20260624063447.85DF51F000E9@smtp.kernel.org/
> 
> Thanks
> Farhan
> 

Thanks for tackling these, Farhan.

Besides reviewing the code I've run a variety of tests on these last few
versions and things look good -- so if you'd like feel free to include:

Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ChangeLog
> ---------
> v5: https://lore.kernel.org/all/20260723183440.3271-1-alifm@linux.ibm.com/
> v5 -> v6
>    - Fix the AIBV calculation (patch 6).
> 
> v4: https://lore.kernel.org/all/20260722170621.1686-1-alifm@linux.ibm.com/
> v4 -> v5
>    - Fix off by one error (patch 6).
>    - Add check for current->mm in account_mem() (patch 2).
>    - Fix commit message as suggested by Matt (patch 3, 4, 5).
> 
> v3: https://lore.kernel.org/all/20260720175819.1723-1-alifm@linux.ibm.com/
> v3 -> v4
>    - Add validation checks for AISB/AIBV spanning more than a page.
>    - Reject multiple ioctl call for the same device, if adapter interrupt
>    forwarding is already enabled for the device.
>    - Rebase on 7.2-rc4.
> 
> v2: https://lore.kernel.org/all/20260716175241.1039-1-alifm@linux.ibm.com/
> v2 -> v3
>    - Remove overwriting guest FIB since we don't use it for
>    re-issue (patch 4).
> 
> v1: https://lore.kernel.org/all/20260713172600.1284-1-alifm@linux.ibm.com/
> v1 -> v2
>    - Drop fix handling AISB/AIBV spanning multiple pages.
>    - Fix memory accounting functions for the case when interrupt forwarding
>    is enabled by one process but disabled by a different process (patch 1).
> 
> 
> Farhan Ali (6):
>   KVM: s390: pci: Reject adapter interrupt forwarding if already enabled
>   KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
>   KVM: s390: pci: Fix missing error codes and memory unaccounting
>   KVM: s390: pci: Fix NULL dereference on AIBV allocation failure
>   KVM: s390: pci: Fix resource leak on IRQ registration failure
>   KVM: s390: pci: Validate AIBV and AISB before pinning guest pages
> 
>  arch/s390/kvm/pci.c | 107 +++++++++++++++++++++++++++++++++++---------
>  arch/s390/kvm/pci.h |   2 +
>  2 files changed, 88 insertions(+), 21 deletions(-)
> 

