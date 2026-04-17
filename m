Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C36377EBA;
	Fri, 17 Apr 2026 12:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776427339; cv=none; b=hwTuZS8gbYGdZRwgYZTO7WsUOANHzDrTl1u4hrFGpMXnij58xPbgsWJONsJT7UMc5nb9Q84V4WGNILx9ES6dZNsC4NfJjAj9LaRaiP1zQi3u14rSOvWDbfjIHraboJCNhwa6egwxzlGgWFNgQRgz3EkuEbOu/RmaYuj4aI4hV9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776427339; c=relaxed/simple;
	bh=Lm9SeEaLNGcIHS5a+ygYv/hD9J8+HHqHFTvdjl7yLYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n82Vv3FTP/UUBmRrPmj4XrkVTZuUF9cwGjK9LD+Qsnm4+uBBObq2hwJ24AhcHlJgc1ILIzf1l6Nm72Brs96e3QOXcs4qB4xPDZAf9yq4oOOuFxTgCFAYtmFzGhZMcb/8+ljEJeI7QlrHWXCBDFgEGeyP4uEOVLb1WRUa++rsBw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TDJnp3hE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TDJnp3hE"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GKFPja1834698;
	Fri, 17 Apr 2026 12:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=y+ANVA
	viUmCUqOpnan4oSVuj7uYi3EZczATtsQ80Rus=; b=TDJnp3hEevqS5YLdgoikK6
	1XD2aY1tQteI3K/NNAH5Lrff1ewuyFryJeChWVFiSv7zm5NC/EV7s6+fAWOMAVJu
	VD//hYhJwCw/JxrDHZJObsaopNSEXcOQGJUPbxE6cS8kWcx+EmezKwTwWffuiO3r
	/8lbJspsrQCJPT1ifhE81l2o45Q5SXW+E2LDNJCu0TSWw23cBWLFMnXKVL8ePxlh
	kD8sKsBmv8z9Cut3WTylSXueMLEX4oPraaeDUnR5H+Spuxp5Nj1gp7GsX4eAM8r7
	x4P29jmuvk4L6fF2I/yQE+KRomVI9X+UkiFj09ZaLi2JnrP8H+XtLziPT2RLL5tw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89rtcpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 12:02:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63HBUVZR015149;
	Fri, 17 Apr 2026 12:02:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0msy97x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 12:02:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63HC2Bw162325042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 12:02:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEC062004B;
	Fri, 17 Apr 2026 12:02:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 719A22004D;
	Fri, 17 Apr 2026 12:02:11 +0000 (GMT)
Received: from [9.111.53.204] (unknown [9.111.53.204])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Apr 2026 12:02:11 +0000 (GMT)
Message-ID: <a037f996-5c51-484b-9dfa-52bf3bb27513@linux.ibm.com>
Date: Fri, 17 Apr 2026 14:02:11 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] KVM: s390: move some facilities from
 FACILITIES_KVM_CPUMODEL to FACILITIES_KVM
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        KVM <kvm@vger.kernel.org>
Cc: David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>
References: <20260401134254.259873-1-borntraeger@linux.ibm.com>
 <f92b3ea0-76d0-4393-8a82-18de3a7d3e08@linux.ibm.com>
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
In-Reply-To: <f92b3ea0-76d0-4393-8a82-18de3a7d3e08@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDExOSBTYWx0ZWRfX7q3NWpaNnO0G
 b63TyGMa4zru72oNCVlwJ4R9ZT+jDHFOgZm+qZD8UThxC/DxyzQiN0wXcFCbNJaBt34DIrfXrY+
 cwSCyzxtmUMQAcYTJU9xFoLuJbSWiMxkW+2eYCw/SgGKkpi/c5igN3AYX6lLdJt2fALdW6dLmEI
 twAXIeKERrR3zTYgjY1WdUgnFAGWg+mhNXAWQnyq5YBs4et8ShC9EDVQIzVxEt9B7VE5msJS/cC
 k3qUhd1x1SGEJ8fMEpbSBh95HST8m7eu7TDvmNZz4dXihtUDpn6h1a3nnaFU/Ktve+7MQ/nNsV5
 e1SLOmGBU8CV4hQYTEZUxml4FPQ+be+FuI1/zmeTOmlH7EsSAWFhXm8MiLvE0OAVhzweztKanmC
 RxdJTuZ4nnccpZLUCh0JeKp/JYWqZv9GFcdm6YB7hvJoBy4fdzIi74Z/8BAqGJD9ZUE0xfw1xXQ
 +PXik+6SOj5JV4vI3mg==
X-Proofpoint-ORIG-GUID: CLjzjZwSFlrvpDoRCahUQzgsLV2zmUN3
X-Proofpoint-GUID: CLjzjZwSFlrvpDoRCahUQzgsLV2zmUN3
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69e22148 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=tBUaFa3PY-MiWKzbaXMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170119

On 4/17/26 11:00, Christian Borntraeger wrote:
> Am 01.04.26 um 15:42 schrieb Christian Borntraeger:
>> Some facilities have been put into FACILITIES_KVM_CPUMODEL to be on the
>> safe side with older VMMs. Unfortunately this has some unwanted side
>> effects for VMMs without a CPU model (like kvm unit test) and IBC/VAL is
>> not used in that case.
>>
>> Ideally the guest visible STFLE bits, the behaviour when running
>> interpreted (HW supported) and the behaviour when running emulated (kvm
>> or qemu) should be in sync.
>>
>> For LPSWEY this was not the case. STFLE.193 was off, but interpretion
>> did work, emulation did not. As emulation only happened in rare cases
>> (e.g. deliver a machine check) the result was inconsistency for the
>> guest.
>> Move beareh to FACILITIES_KVM to fix the inconsistency.
>>
>> NNPA (facility 165) has no fencing and no KVM emulation. The instruction
>> will work, despite STFLE.165 being off in the guest. Move also to
>> FACILITIES_KVM.
>>
>> Facility 170 (ineffective-nonconstrained-transaction facility) is an
>> anti facility and should be passed along as well as KVM cannot simulate
>> the missing function.
>>
>> KVM also does not implement trapping for guest RDP and there is no
>> additional hypervisor control. Move 194 to FACILITIES_KVM as well.
>>
>> Facilities 196 and 197 (PAI) also do not have a hypervisor control and
>> need to be passed on as well.
>>
>> The PFCR is also not intercepted by KVM and needs to be moved (stfle.201).
>>
>> The other facilities are fine (stfle, emulation, interpretion in sync):
>> Both AP related features (12 and 15) require a userspace added AP via vfio.
>> 156 etoken facility is fenced off for interpretion via ECD_ETOKENF so
>> everything is in sync
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>> Cc: David Hildenbrand <david@kernel.org>
>> Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
>> Cc: Janosch Frank <frankja@linux.ibm.com>
> 
> 
> ping.  Any concerns?

Ah, this fell to the floor because of other things. Sorry

Makes sense to me:
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

