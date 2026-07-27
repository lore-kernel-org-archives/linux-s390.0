Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A084F36F437;
	Mon, 27 Jul 2026 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785144963; cv=none; b=o18w9Q+JkiJsvnnbuC83q9SnDG3qNHHtNZJzT1yGoFvhv/pFl/wD35maCkCwFGGYcEDhdhzFAvHAMxtzZXfKRSyrRsV1N25YNmLjfwoKoaR6RKw8M7uQuNgf9xU/hnJIFBRDhWfU8HYaP+ChJ16lRq6slj9dSKlpT9B8L/n+kkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785144963; c=relaxed/simple;
	bh=qMXqCXO7Vn0MZcv4NCXe0HVhhHb8E+w9zX6+A6WE+co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZN1jC9ZGbh+CWdoreJcJB1GKgPgQAvMZSYSRw7NF3iNP89X949szdEXYVGSK/9vilw8XXZPv3hDhIjTMJYf315IaZIYiasckzqX9mhTmKCJJnVJdyP+zggcd7sxWaP2d4HUdF0nNBowrYlBdY57/5ca6sA2zSzmy8r7iTCFD6Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tYyuut1q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tYyuut1q"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R9Uc4D4154296;
	Mon, 27 Jul 2026 09:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p8JLy/
	m+cFj2sLhJvbC5qgWfebqW+UmhGZjoNDyV7c4=; b=tYyuut1q/eYevtadhMHwC1
	Zeg4FYPZr5I+5ssU7iCIWiUfwwTM6sPVcM6bQ1WKTSHz0Ru5n8A44Jr9B4/5jsmB
	NoO5kkcHC9m8HEeQT0Jpfp3/7qqeaRc0aXCshGjuPmHbLGQm3I8Dd4sijzlL+B85
	cGMLG71UMA5mzvv79Odw95ahSU80r6aWmdHR+uCOsKjVVhGa7c8ANmAhvp1rbFcJ
	YW9aRohCUu7Fv8sDyrl5txlqRfFVwl9dS3d2FlU9JEui5jSRVaFsk1Oidcb2VKL1
	Ro+6YS62bmVYFS7/jZV2Bo/SgIvLtOP/B9ZEhBCS7DU35ASPU1OSc2Syah7IALHg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc78xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:36:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R9QDO3011908;
	Mon, 27 Jul 2026 09:36:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xvgv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:36:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66R9Zv2M41550334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 09:35:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 259E820079;
	Mon, 27 Jul 2026 09:35:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E875420077;
	Mon, 27 Jul 2026 09:35:56 +0000 (GMT)
Received: from [9.111.31.34] (unknown [9.111.31.34])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 09:35:56 +0000 (GMT)
Message-ID: <504bdd81-707a-4015-ab91-1b35730b480a@linux.ibm.com>
Date: Mon, 27 Jul 2026 11:35:56 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] s390: Implement arch_do_panic
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
References: <20260727-arch_do_panic-v1-0-ca1777547c38@linux.ibm.com>
 <20260727-arch_do_panic-v1-2-ca1777547c38@linux.ibm.com>
 <20260727091040.A7F791F000E9@smtp.kernel.org>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <20260727091040.A7F791F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Nw23zAqii5xZh9CH-qRZ4OVc8-a4GVcC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA5MSBTYWx0ZWRfXzYkNwU4WN89b
 YCW4qodKLiUuI6lJ8/wNw5tBpozPgSJDAKznlBM6lFTNjXAFsbK40+5Xl6MMhn68RMnfEcFyJIW
 kUTkipahsod+ovTD+/tC25VFkhuscOtHDqrPtzlusE6TGO/kBe+lqRvFuad/ZCBhqNmoxg26IMf
 q8oOh66LP8Wru4uhFnYrdnhaye6DhZsvizGDrj/Z9B6h5AeTan6Zit6ZvO7s0AyFeUT7S9NpxcN
 Q+Bq1pbDRiTgYSw4F9c3mKDe15x4EBoe5lUpMJr4kiT6zaey4Kd7esgsO3U/BNZv1GEXzmD5iSP
 4URfGGCLl3aEEBcUW2gkG3GXC4DAX/zpJAzN67B7U/wBTVVU6abP8vti+BNbbwWLv2W4XYkTjxe
 47SO2UFuaVu+FgUOw4hybHPq6L7ILkmSL/hJlQ5e/BFOtP1cJfMvk8ztAaf0cvrp0PlFtdnHVkR
 3C8hcJWUesF7i4YbR6w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA5MSBTYWx0ZWRfX92HKhjtCg1HK
 CncxcCjXASGDP68CrhAagup5OrYlmVg3demMtntE6ZeyVJ1bVT9fjPnB/xrKwECzKaL8S9CNP4d
 g9CV6EJnjH9WhxkxAswJ+Gc5p+f2t5E=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a672681 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=GR1TegcZMGn3hSD79ekA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Nw23zAqii5xZh9CH-qRZ4OVc8-a4GVcC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270091

On 7/27/26 11:10 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] arch_do_panic() is bypassed when panic_timeout != 0
> - [Low] Unused declaration of s390_do_panic()
> --
> 
> --- Patch [2]: [PATCH 2/3] s390: Implement arch_do_panic ---
> commit 640e72aef0a165dacc87c9e5913aa8f9442aa6e9
> Author: Mete Durlu <meted@linux.ibm.com>
> 
> s390: Implement arch_do_panic
> 
> This commit implements the arch_do_panic() hook for s390 to handle
> architecture-specific panic actions instead of relying on the panic_notifier
> chain. This change allows user-specified panic_timeout values to be evaluated
> in common code before executing the s390 specific actions.
> 
>> diff --git a/arch/s390/include/asm/ipl.h b/arch/s390/include/asm/ipl.h
>> index b0d00032479d6..38924c4a5d1d7 100644
>> --- a/arch/s390/include/asm/ipl.h
>> +++ b/arch/s390/include/asm/ipl.h
>> @@ -166,5 +166,6 @@ enum diag308_rc {
>>   extern int diag308(unsigned long subcode, void *addr);
>>   extern void store_status(void (*fn)(void *), void *data);
>>   extern void lgr_info_log(void);
>> +void s390_do_panic(void);
> 
> [Severity: Low]
> Is this declaration necessary?
> 
> It looks like s390_do_panic() is declared here but never implemented or used,
> as the actual implementation provided in arch/s390/kernel/ipl.c is named
> arch_do_panic().

This is leftover code. I'll remove it in the next version.

> [ ... ]
> 
>> diff --git a/kernel/panic.c b/kernel/panic.c
>> index 1eb0cdc159d94..de0bda946cabb 100644
>> --- a/kernel/panic.c
>> +++ b/kernel/panic.c
>> @@ -755,9 +755,6 @@ void vpanic(const char *fmt, va_list args)
>>   		pr_emerg("Press Stop-A (L1-A) from sun keyboard or send break\n"
>>   			 "twice on console to return to the boot prom\n");
>>   	}
>> -#endif
>> -#if defined(CONFIG_S390)
>> -	disabled_wait();
>>   #endif
>>   	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
> 
> [Severity: High]
> Does this change unintentionally bypass the s390 panic actions when
> panic_timeout != 0?
> 
> Looking at vpanic() in kernel/panic.c, if a panic timeout is set, the system
> will restart before reaching arch_do_panic():
> 
>      if (panic_timeout != 0) {
>          ...
>          emergency_restart();
>      }
>      pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
> 
>      arch_do_panic();
> 
> Since emergency_restart() does not return, will the user-configured on_panic
> actions be lost in this scenario?

Yes, this is the intended behavior with this change. I'll document it in
the commit message in next version.

