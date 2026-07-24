Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410CE344DAC;
	Fri, 24 Jul 2026 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784885820; cv=none; b=uNyfGkpruoOAXmgKKjGp2qT6FhytlWI56CflZ6iVfWO87j2VB0jbcCS3rT7Rv7D1jw7wsiYFK+oExxRztDFnlwjRmI6p6KjoG8Dzz+m3vFtdaE9L/ugB4yKNRXaFfRT5txk2EhK6PHat/oLxBzLy8aal/oDOEpa/2YV9uzFeUtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784885820; c=relaxed/simple;
	bh=E9Lu4cmzWK3gSIokzYYPtAZoXYvl7WdSSVRsgdSNLA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IzH9L5ttCeLRgF6gIu8UtaOw44v2hRdoHCyTAixct8KfL6XQH88tS2Kbo29DpWjPdMMFRHyHaOB8x/KpF8aj0OlrgatYS2Ou5VW3x2uc2UQdEPy6ig/GSoci9HZnMXmodKayiPI+GegVfe4hlrE9W4paL4Eg8xJSkxtTGKVxyLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QckL6fVn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QckL6fVn"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O5Bf6W919608;
	Fri, 24 Jul 2026 09:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nyV5w+
	pZ5RzM1CbuGElNExlXXZZMATzOUMrhWVoaoEE=; b=QckL6fVnvr0h+JwCrR0ZmU
	lXFZe5NYVPqsvCgRcMI2oVhP0X3M1p1c6uaVB5GNjt6zd9AEZ3SdDI9gqE4jYvpQ
	J2fh8Mk/ijDjpoml0FUs44f39aXO5r4xVboJCvuvCBWZchC+2D68OCcrv4sLXsEe
	Qiu/Vs7iiOyscrUAmIakTRo4xGM+n+G8YCw9NRPNM+Q/CeBfRLDaNNkvaf5lN4Tb
	9oRsoENKAZlVsRUqlPwoVb89No040YyvP9PmrviKV8CkMIpk2gV39t+9Owupvm6x
	oG0b7+po4lgaqu9vwpiseKmCZwvkXwQePxoTi1i5qXbKuWT+QHhRP9+YaJYerxsw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg791c1ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 09:36:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O9YbHr017813;
	Fri, 24 Jul 2026 09:36:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk8a94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 09:36:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66O9aqNb48890296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 09:36:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 824F82004F;
	Fri, 24 Jul 2026 09:36:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 616242004E;
	Fri, 24 Jul 2026 09:36:52 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 09:36:52 +0000 (GMT)
Message-ID: <d2953b94-0d4a-48ab-94b3-5be6ef762c2c@linux.ibm.com>
Date: Fri, 24 Jul 2026 11:36:41 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] KVM s390x PCI fixes
To: Farhan Ali <alifm@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc: mjrosato@linux.ibm.com
References: <20260723221409.5874-1-alifm@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260723221409.5874-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Uii0WdI6UWT1BmBBnaD2wksTdLguluwy
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a633239 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=0R6eTVlKerFncTElSHAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA4MyBTYWx0ZWRfX9STIXUJY5J2K
 zW6tHCjfJtpB0gmtIIRKGoNY3Rt/WEhciNdYNWBweKI8zOJvpvuE2/jxdvY3Qb24FnfB5NqdKte
 0dA4HHszipb1uBhPF+j85tVm3kLsvpU=
X-Proofpoint-GUID: Uii0WdI6UWT1BmBBnaD2wksTdLguluwy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA4MyBTYWx0ZWRfX7Vhxf9tomBzc
 pnQr99DSNQfeSaq0/LORsPiXn5JdWGlcindGMOHSpj5l0pU3t+uFUidK/ZxZ7S7e1qbvMCa1bpC
 75rK1VNscBxEu6upJjyt4o7jVWNLbCfEKVu6XGDNyrla3VFKbg8hCoiqgJVJZZBlRyaSpNUkYYB
 Mv9gVsb1u7f2FLmWcdHPiAXvGOHslJD1DkMDMtu62S3Gp9VJpvToKGrtKeFTBw2HrECMckehHX2
 o3pNHziQtZ1ArMzJF03jpWi7uLYR2rzJT15Gd01c1mis35YLkxGf5xONJXoSHUsAe0CJ5TC8VK9
 tfyEYlUD2x3RDNbuWYdPFA3AAPYUVI4AS2nRCUF3pHtiskxSX504enSPuDm12eQRNhBUbqVbZIL
 rD1WQ4kd4qnGujWf/npzxN8TB0hmWBCC7ri7vI1INbO16PpDkUiMYr6CUX7YkED+EYOYO2gnvwV
 YUIHBRuI72aHgoe0R9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240083


Am 24.07.26 um 00:14 schrieb Farhan Ali:
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
> ChangeLog
> ---------
> v5: https://lore.kernel.org/all/20260723183440.3271-1-alifm@linux.ibm.com/
> v5 -> v6
>     - Fix the AIBV calculation (patch 6).
> 
> v4: https://lore.kernel.org/all/20260722170621.1686-1-alifm@linux.ibm.com/
> v4 -> v5
>     - Fix off by one error (patch 6).
>     - Add check for current->mm in account_mem() (patch 2).
>     - Fix commit message as suggested by Matt (patch 3, 4, 5).
> 
> v3: https://lore.kernel.org/all/20260720175819.1723-1-alifm@linux.ibm.com/
> v3 -> v4
>     - Add validation checks for AISB/AIBV spanning more than a page.
>     - Reject multiple ioctl call for the same device, if adapter interrupt
>     forwarding is already enabled for the device.
>     - Rebase on 7.2-rc4.
> 
> v2: https://lore.kernel.org/all/20260716175241.1039-1-alifm@linux.ibm.com/
> v2 -> v3
>     - Remove overwriting guest FIB since we don't use it for
>     re-issue (patch 4).
> 
> v1: https://lore.kernel.org/all/20260713172600.1284-1-alifm@linux.ibm.com/
> v1 -> v2
>     - Drop fix handling AISB/AIBV spanning multiple pages.
>     - Fix memory accounting functions for the case when interrupt forwarding
>     is enabled by one process but disabled by a different process (patch 1).
> 
> 
> Farhan Ali (6):
>    KVM: s390: pci: Reject adapter interrupt forwarding if already enabled
>    KVM: s390: pci: Fix memory accounting for pinned/unpinned pages
>    KVM: s390: pci: Fix missing error codes and memory unaccounting
>    KVM: s390: pci: Fix NULL dereference on AIBV allocation failure
>    KVM: s390: pci: Fix resource leak on IRQ registration failure
>    KVM: s390: pci: Validate AIBV and AISB before pinning guest pages
> 
>   arch/s390/kvm/pci.c | 107 +++++++++++++++++++++++++++++++++++---------
>   arch/s390/kvm/pci.h |   2 +
>   2 files changed, 88 insertions(+), 21 deletions(-)
> 

thanks, all applied and queued for kvm/master.
https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git/log/




