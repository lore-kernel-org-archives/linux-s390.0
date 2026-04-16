Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A8DB640;
	Thu, 16 Apr 2026 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776326622; cv=none; b=CugP+SSAeuwaQ7qw+/udKRz6yCfou18Wd9Wbn5r3di9/4BkNvpH8IYuePZST0bCDNKtXE5uwVbbbuP3FeiMmsK8CWuJKVCyDJgIADskaf3TCXHsqSzlwS72Vr97y7qY7wxqfYfSyThj6nmn/aemVyhefcfdHjQVJvvlKfMpKIOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776326622; c=relaxed/simple;
	bh=EBU/4jXEnIxXLaNLjg5FPh6fkdejLRCt3fZBImWfQYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mg5K8Kv4bRPqkzRNTBPvn1JN9VEcn2dVz7az0xK8jBBQQU1ApA2kBMylVEN/Kgr0+TPV7NU2WnLVnjxO2nP5uFFXSoNTmTY64LOH9+t/FC2fMJkCV7Dyd4BLQO9LsaiTvv8BxJI7EiJDwZLUdR+MYzkY83ogh5QanEH//GOdpCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lPRS1XAE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lPRS1XAE"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G7l6Ut2130606;
	Thu, 16 Apr 2026 08:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JuQKzT
	MomhVg7sw7anpFgkOTtQ4X3ZHeOHKPH0kt7sE=; b=lPRS1XAEfAPruuL3/ShM8Z
	vnE93BjYzwUYDuWBSXojV7yUuh2FV3PeEZYVBi4xTWhkZ+FX1nZLlo6MN1DKvNBo
	hESYK/1hbsvW6tWZXD5m+HhG3jYg4TuXOoNRQfmdKuTPeVSOGw3xtrZaWbcLqx2u
	AlM2b6ukMcP71FCSTYh8HWbDWg/nLo8Hg+57HtyiAoI7xdbB17GUwM00F9PAfvcj
	dxcDO4BZh8xTmfBiknoQv0x9rjKNXnan+o7TxCUY9Rpfy1AuZSZ/5F7ZRJwTiIg6
	3mJS9tUJylEDB9HaNdhjMIB4iiA4jnP5QxePOl/0Tr5AHTduCKJbTY9GFRcK5ViQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89nmcqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 08:03:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63G7WNGW004198;
	Thu, 16 Apr 2026 08:03:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24khwbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 08:03:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63G83Z9F31457908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 08:03:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71A042004E;
	Thu, 16 Apr 2026 08:03:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38E3120043;
	Thu, 16 Apr 2026 08:03:35 +0000 (GMT)
Received: from [9.111.91.184] (unknown [9.111.91.184])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Apr 2026 08:03:35 +0000 (GMT)
Message-ID: <624c8a3f-2a09-4257-9b0c-2b64e60e52a1@linux.ibm.com>
Date: Thu, 16 Apr 2026 10:03:35 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests 3/5] lib: s390x: sie: Free guest memory on
 destroy
To: Nico Boehr <nrb@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com
References: <20260415085145.91197-1-frankja@linux.ibm.com>
 <20260415085145.91197-4-frankja@linux.ibm.com>
 <DHTSMVSISIZM.3MS0YLDBLMB09@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <DHTSMVSISIZM.3MS0YLDBLMB09@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5XHZntYeg5JJlzX2bfo-UmeZZXjMzKvw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA3MiBTYWx0ZWRfX2vMNv4/Z4L0z
 ha6kA8WPFSTgXLiuxoXyGMm0LbiB/6/TSJRSv3EsWs6HeWPjlM1cBetI2A6/OeNY3MeY0r/tXWy
 7mSKUnn1nmX+AEAvueAkmlesp5WXgRHp1wGKRzudshtbW6Yfe/O1aPi8Z3pxOal8yqAy1p6kViB
 yrQ84/OHfaSbfbDpmSxrgHNKo6g9gCFF9QW0qEz2GdWMCkpTG0RevOXOpbD5JeqweGCzti/zhhv
 GeZrlWiFa//jXN3u9X0FI6oWlnXjoGNOSYznnuwJf1NtpmxLpoaDNDEoTzaG/TX/+lHYJ/cBbS5
 EePiHhU+icmfd01y4DMGX+0TQCNqxjpvY9KKn6GjZk73Lb2+cvFXDGfsUv2okfaArMynuJ4loTa
 0O7a3HWILuXKh8F3EApqhs/lCAm5sRe8AqdTI/761DI23ephaO84LZ/hx4h+zVojdxsXjT5Ofw8
 UJn4yYZ35sQhMhowE1A==
X-Proofpoint-ORIG-GUID: 5XHZntYeg5JJlzX2bfo-UmeZZXjMzKvw
X-Authority-Analysis: v=2.4 cv=FY4HAp+6 c=1 sm=1 tr=0 ts=69e097dc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=dbLSXGKGoUd-6RR-K84A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160072

On 4/15/26 16:21, Nico Boehr wrote:
> On Wed Apr 15, 2026 at 10:45 AM CEST, Janosch Frank wrote:
>> We never freed the memory that the sie library allocates as the guest
>> ram on destruction of the VM. Most tests reuse the VM or just leak the
>> memory since the standard allocation is one megabyte and tests only
>> use single digit numbers of VMs.
>>
>> It's time to add automatic freeing to the sie library when a VM is
>> destroyed.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>   lib/s390x/sie.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/lib/s390x/sie.c b/lib/s390x/sie.c
>> index a49c45c7..758ead77 100644
>> --- a/lib/s390x/sie.c
>> +++ b/lib/s390x/sie.c
>> @@ -192,4 +192,5 @@ void sie_guest_destroy(struct vm *vm)
>>   	free_page(vm->sblk);
>>   	if (vm->sblk->ecb2 & ECB2_ESCA)
>>   		free_page(vm->sca);
>> +	free_pages((void *)virt_to_pte_phys(get_page_root(), vm->guest_mem));
>>   }
> 
> Is there a particular reason why we have a two-step process of calling
> sie_guest_alloc() for memory allocation
> and then
> sie_guest_create() for initializing the sie_block etc
> 
> but
> sie_guest_destroy()
> cleans up both?
> 

Historical reasons I guess.
There've been a lot of changes to the SIE lib over the years, snippet 
support itself isn't that consistent but it's currently good enough.
s390x/sie.c is the only direct user of the allocation and even that 
usage looks like it could be converted.

