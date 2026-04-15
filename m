Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D65E33F37A;
	Wed, 15 Apr 2026 11:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776253541; cv=none; b=ra0N0LknOYUhl8IFuPQRLy5yKfeZXZJCxn7qkxawutfP9UhaY0eHYEymhVt/lK40OzqeGl+5Ji4DAp9lAdGs4G1aL1QXpu++9FTZBXsdRgPF9/7deQQYfO3jRI70hA/c2TGkvHmsijnCLKA+kTyaqCmvG1A+StjxtAKY92MVleI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776253541; c=relaxed/simple;
	bh=/hce7AEsE6Dd+EMW5lLCu5KR/ju7tpARdd7z1+JdM1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4JewHbx58V6vtBX8rkcNxP61ZmVbJSnhTtAoRHjvIXw8soNQ/iuUkp11A6kn6XemfsY+TtoEXr8Cikcei0u50CUA92itPbKNlRlEfbDtO6k4T9UIbtrS90BBX3R8WZYwGnZdEfxWNQTCIs//PZqBde4D/fkDXDUxJeIqIxF7YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qy3e3Hc7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qy3e3Hc7"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F50IaM1833223;
	Wed, 15 Apr 2026 11:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZNdLtV
	Z/jemo3cFAAx7t28VzY/k2Mm8Gd9recp0TKNA=; b=qy3e3Hc7VX/BJ1/0mKa9xk
	fh+HbCnfAv93P3gBluy1X6VFofOcmDWGXizc6Z4vn4cRZcH7Fjq7033jUF8FIpyK
	9nnVKOkRFDJy34Ufq9DXilFwNg6EUhs9dCT+xFOel8eGiyRG6BC+MDElhce6LnSo
	sdiS/u00cA9lSH8ta7H4RVtfmJDr3mWnkHdA7qT4aug/yW4fV/APHsugH4KqzViv
	Lx31cq0TYiLk2OHE3sJkuTDn9jIItRwSb+klAl0BiUhNRWw9Kdl7dlBtrduvy4g4
	rRsE36L4Mb8xfNNeo3Mty4XSgLg0J5GBSp9NlhJ7z+0/AgbRSn3YH9QMWJxk30HA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89rfu5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 11:45:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63F8uYMf004569;
	Wed, 15 Apr 2026 11:45:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24kdy44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 11:45:37 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63FBjXiD49217802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 11:45:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C40D92004D;
	Wed, 15 Apr 2026 11:45:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84EF420040;
	Wed, 15 Apr 2026 11:45:33 +0000 (GMT)
Received: from [9.111.60.89] (unknown [9.111.60.89])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 11:45:33 +0000 (GMT)
Message-ID: <b284ea20-f663-4d3c-87bc-22c6fc147134@linux.ibm.com>
Date: Wed, 15 Apr 2026 13:45:33 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] KVM: s390: Fix lpsw/e breaking event handling
To: Heiko Carstens <hca@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com
References: <20260323153637.3683-1-frankja@linux.ibm.com>
 <20260323153637.3683-2-frankja@linux.ibm.com>
 <20260415105925.10321B18-hca@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 xsFNBFubpD4BEADX0uhkRhkj2AVn7kI4IuPY3A8xKat0ihuPDXbynUC77mNox7yvK3X5QBO6
 qLqYr+qrG3buymJJRD9xkp4mqgasHdB5WR9MhXWKH08EvtvAMkEJLnqxgbqf8td3pCQ2cEpv
 15mH49iKSmlTcJ+PvJpGZcq/jE42u9/0YFHhozm8GfQdb9SOI/wBSsOqcXcLTUeAvbdqSBZe
 zuMRBivJQQI1esD9HuADmxdE7c4AeMlap9MvxvUtWk4ZJ/1Z3swMVCGzZb2Xg/9jZpLsyQzb
 lDbbTlEeyBACeED7DYLZI3d0SFKeJZ1SUyMmSOcr9zeSh4S4h4w8xgDDGmeDVygBQZa1HaoL
 Esb8Y4avOYIgYDhgkCh0nol7XQ5i/yKLtnNThubAcxNyryw1xSstnKlxPRoxtqTsxMAiSekk
 0m3WJwvwd1s878HrQNK0orWd8BzzlSswzjNfQYLF466JOjHPWFOok9pzRs+ucrs6MUwDJj0S
 cITWU9Rxb04XyigY4XmZ8dywaxwi2ZVTEg+MD+sPmRrTw+5F+sU83cUstuymF3w1GmyofgsU
 Z+/ldjToHnq21MNa1wx0lCEipCCyE/8K9B9bg9pUwy5lfx7yORP3JuAUfCYb8DVSHWBPHKNj
 HTOLb2g2UT65AjZEQE95U2AY9iYm5usMqaWD39pAHfhC09/7NQARAQABzSVKYW5vc2NoIEZy
 YW5rIDxmcmFua2phQGxpbnV4LmlibS5jb20+wsF3BBMBCAAhBQJbm6Q+AhsjBQsJCAcCBhUI
 CQoLAgQWAgMBAh4BAheAAAoJEONU5rjiOLn4p9gQALjkdj5euJVI2nNT3/IAxAhQSmRhPEt0
 AmnCYnuTcHRWPujNr5kqgtyER9+EMQ0ZkX44JU2q7OWxTdSNSAN/5Z7qmOR9JySvDOf4d3mS
 bMB5zxL9d8SbnSs1uW96H9ZBTlTQnmLfsiM9TetAjSrR8nUmjGhe2YUhJLR1v1LguME+YseT
 eXnLzIzqqpu311/eYiiIGcmaOjPCE+vFjcXL5oLnGUE73qSYiujwhfPCCUK0850o1fUAYq5p
 CNBCoKT4OddZR+0itKc/cT6NwEDwdokeg0+rAhxb4Rv5oFO70lziBplEjOxu3dqgIKbHbjza
 EXTb+mr7VI9O4tTdqrwJo2q9zLqqOfDBi7NDvZFLzaCewhbdEpDYVu6/WxprAY94hY3F4trT
 rQMHJKQENtF6ZTQc9fcT5I3gAmP+OEvDE5hcTALpWm6Z6SzxO7gEYCnF+qGXqp8sJVrweMub
 UscyLqHoqdZC2UG4LQ1OJ97nzDpIRe0g6oJ9ZIYHKmfw5jjwH6rASTld5MFWajWdNsqK15k/
 RZnHAGICKVIBOBsq26m4EsBlfCdt3b/6emuBjUXR1pyjHMz2awWzCq6/6OWs5eANZ0sdosNq
 dq2v0ULYTazJz2rlCXV89qRa7ukkNwdBSZNEwsD4eEMicj1LSrqWDZMAALw50L4jxaMD7lPL
 jJbazsFNBFubpD4BEADAcUTRqXF/aY53OSH7IwIK9lFKxIm0IoFkOEh7LMfp7FGzaP7ANrZd
 cIzhZi38xyOkcaFY+npGEWvko7rlIAn0JpBO4x3hfhmhBD/WSY8LQIFQNNjEm3vzrMo7b9Jb
 JAqQxfbURY3Dql3GUzeWTG9uaJ00u+EEPlY8zcVShDltIl5PLih20e8xgTnNzx5c110lQSu0
 iZv2lAE6DM+2bJQTsMSYiwKlwTuv9LI9Chnoo6+tsN55NqyMxYqJgElk3VzlTXSr3+rtSCwf
 tq2cinETbzxc1XuhIX6pu/aCGnNfuEkM34b7G1D6CPzDMqokNFbyoO6DQ1+fW6c5gctXg/lZ
 602iEl4C4rgcr3+EpfoPUWzKeM8JXv5Kpq4YDxhvbitr8Dm8gr38+UKFZKlWLlwhQ56r/zAU
 v6LIsm11GmFs2/cmgD1bqBTNHHcTWwWtRTLgmnqJbVisMJuYJt4KNPqphTWsPY8SEtbufIlY
 HXOJ2lqUzOReTrie2u0qcSvGAbSfec9apTFl2Xko/ddqPcZMpKhBiXmY8tJzSPk3+G4tqur4
 6TYAm5ouitJsgAR61Cu7s+PNuq/pTLDhK+6/Njmc94NGBcRA4qTuysEGE79vYWP2oIAU4Fv6
 gqaWHZ4MEI2XTqH8wiwzPdCQPYsSE0fXWiYu7ObeErT6iLSTZGx4rQARAQABwsFfBBgBCAAJ
 BQJbm6Q+AhsMAAoJEONU5rjiOLn4DDEP/RuyckW65SZcPG4cMfNgWxZF8rVjeVl/9PBfy01K
 8R0hajU40bWtXSMiby7j0/dMjz99jN6L+AJHJvrLz4qYRzn2Ys843W+RfXj62Zde4YNBE5SL
 jJweRCbMWKaJLj6499fctxTyeb9+AMLQS4yRSwHuAZLmAb5AyCW1gBcTWZb8ON5BmWnRqeGm
 IgC1EvCnHy++aBnHTn0m+zV89BhTLTUal35tcjUFwluBY39R2ux/HNlBO1GY3Z+WYXhBvq7q
 katThLjaQSmnOrMhzqYmdShP1leFTVbzXUUIYv/GbynO/YrL2gaQpaP1bEUEi8lUAfXJbEWG
 dnHFkciryi092E8/9j89DJg4mmZqOau7TtUxjRMlBcIliXkzSLUk+QvD4LK1kWievJse4mte
 FBdkWHfP4BH/+8DxapRcG1UAheSnSRQ5LiO50annOB7oXF+vgKIaie2TBfZxQNGAs3RQ+bga
 DchCqFm5adiSP5+OT4NjkKUeGpBe/aRyQSle/RropTgCi85pje/juYEn2P9UAgkfBJrOHvQ9
 Z+2Sva8FRd61NJLkCJ4LFumRn9wQlX2icFbi8UDV3do0hXJRRYTWCxrHscMhkrFWLhYiPF4i
 phX7UNdOWBQ90qpHyAxHmDazdo27gEjfvsgYMdveKknEOTEb5phwxWgg7BcIDoJf9UMC
In-Reply-To: <20260415105925.10321B18-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEwNCBTYWx0ZWRfX+blWt3t4EB5W
 kBnDkbpij0dcUA0mn6p5dzM4SA4FXbfdLVAdXkLqLYbZHmin7fvEOiZyBw+UYW0ucov4pKpfwa/
 zD1RIRO3Kdg7UPdJmQq6Xm7z0vsaU4T2p/jrRIOmRjhCWRDJjQqdsecqNVcV2aEyrzNKh7Immq4
 +8QocnRx0pCuLag/7jpymS6WiB36EfIm/g8LdNiqsj0bxwlRYxBserGEwbTPXicUZ6hLPppWaVw
 mZUeq6D7FVuWgREZ2cleVTqZRXZ9aHQKph8vtt90C1Xjl98U5IhNb/5/KbRb1UT5hBO1Y9I4NQz
 pqurUsZFU2faJM3D8f0zzpFLDvSx8ctakNk/96sXaxsd1TH1OOocv4C673jmTbILn/jzFqprX9l
 2Av6+TiTmWz/wnqySrMEoffyiMqXIRgZavzLue/0ty2SiX97MiR7x2y0N9WuFPo9sXKtK/w+F82
 zBvE17i7vQ/GNE+XOXQ==
X-Proofpoint-ORIG-GUID: Mn0wBowuQ5PqQKvgoKWfnniW6Ct7kXn-
X-Proofpoint-GUID: Mn0wBowuQ5PqQKvgoKWfnniW6Ct7kXn-
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69df7a63 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=4Rwbd3wxp51vNf_aTKoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150104

On 4/15/26 12:59, Heiko Carstens wrote:
> On Mon, Mar 23, 2026 at 03:35:22PM +0000, Janosch Frank wrote:
>> LPSW and LPSWE need to set the gbea on completion but currently don't.
>> Time to fix this up.
>>
>> LPSWEY was designed to not set the bear.
>>
>> Fixes: 48a3e950f4cee ("KVM: s390: Add support for machine checks.")
>> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>   arch/s390/kvm/priv.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
>> index a3250ad83a8e..cc0553da14cb 100644
>> --- a/arch/s390/kvm/priv.c
>> +++ b/arch/s390/kvm/priv.c
>> @@ -714,12 +714,13 @@ int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
>>   {
>>   	psw_t *gpsw = &vcpu->arch.sie_block->gpsw;
>>   	psw32_t new_psw;
>> -	u64 addr;
>> +	u64 addr, iaddr;
>>   	int rc;
>>   	u8 ar;
>>   
>>   	vcpu->stat.instruction_lpsw++;
>>   
>> +	iaddr = gpsw->addr - kvm_s390_get_ilen(vcpu);
>>   	if (gpsw->mask & PSW_MASK_PSTATE)
>>   		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
>>   
>> @@ -737,18 +738,20 @@ int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
>>   	gpsw->addr = new_psw.addr & ~PSW32_ADDR_AMODE;
>>   	if (!is_valid_psw(gpsw))
>>   		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
>> +	vcpu->arch.sie_block->gbea = iaddr;
>>   	return 0;
> 
> This doesn't look correct to me: even if there is an early specification
> exception the PSW is still replaced, and hence the breaking event address
> needs to be updated. Read: the gbea assignment should be moved before
> the is_valid_psw() check.

Right, LPSW(E) completes even when we get the early specs and bear is 
set when completing LPSW(E).

We might also be missing setting ilc to 0 on early specs.
I need to look into that.
