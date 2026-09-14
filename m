Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93087319601;
	Mon, 14 Sep 2026 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397645; cv=none; b=Wz4F31FPhn5MwM/Pfc/QOo2QPRyVEKZ5bzz91Vq9phFY5k7uH1wv7NB5KWK32Z2fF+qMOw5mjdK6pu9wYoUpLH/7/En616DahWWdoZKmJbCsvCQqTaR0DzKod4Xg5g9egrJo9R8NR+Z5WplumEcW7A+QfsCQBieQk34kcOI617o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397645; c=relaxed/simple;
	bh=kFCKHi621AjGDm8LrVk88DLI3HyRyRbY9isaABoxJyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GrTaxNg761kPoyq8g2wwW2hEBgVqn/yNazwigBECs7AlZFZiJXdHSAh8h/G97+Nuig+HpVJ4XucsNL8fX9J1S1trMui0rgrujygE/3ogZq9IQXqQzTR+V+RdGGjzbTUTT0fcRYplGpR90amdPlZf8wPV/tsz469hgFjXyojwxk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D52SCTij; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D52SCTij"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EEVlKj2160411;
	Mon, 14 Sep 2026 14:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=luBa94
	VbONhRx+7hsYfj2YPwmf9vpuN0WMLt38Sa+/M=; b=D52SCTij1xq5E+Tk568lfj
	QU8sxzSJk+/5NUGqDpsb1b2pSrm+1pIQtlJvp1n4KZp2CBURcLi03Mh9SCYcOKr0
	biJH5+kZeuq9NEaBH8bhp6BCzJ4r/d2vsOKQgvv/6MASZOuV+veMpDejEluUHlA+
	e4ad3oICoQ1grpxxdIz9pPH4va86q12ByyRxAh4HHdlhbiCe8fZU5gu6EHQH8h/b
	Z6yrHxUu2LW+uHQ0qfNLmdvXt7WMtJ+030UBNgUrJChAcPvHRtpT0aUOwSZuTISA
	EOYWbOWexYCxOiJmnKoYqt/kGfFtw7Dad1s0UDSj/wXHfChlONc8KAR3NDMAPeRg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5hj8g7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 14:53:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED54d72386810;
	Mon, 14 Sep 2026 14:53:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnk9j6dyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 14:53:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68EErspJ45154566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 14:53:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A98772004D;
	Mon, 14 Sep 2026 14:53:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EA6D20043;
	Mon, 14 Sep 2026 14:53:54 +0000 (GMT)
Received: from [9.111.205.105] (unknown [9.111.205.105])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Sep 2026 14:53:54 +0000 (GMT)
Message-ID: <fe8ff552-a33f-44a5-991c-22415862c136@linux.ibm.com>
Date: Mon, 14 Sep 2026 16:53:54 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 18/24] x86/uaccess: Add unsafe_copy_from_user()
 implementation
To: sashiko-reviews@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-trace-kernel@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20260821195259.2688377-1-jremus@linux.ibm.com>
 <20260821195259.2688377-19-jremus@linux.ibm.com>
 <20260821201107.7F0CB1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260821201107.7F0CB1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIwOCBTYWx0ZWRfX8pJhEG3rjc1Y
 lYnbic5+ymQS+46Dl0S/obOUT6gEdrsOze+ah5EgxdNifl4hkvBE8aNgnWH153+G6dky/8jleRV
 Vhv/UU7Kv21Yn8th6yyO7IncPsFOiPmHUXWVDkGLdxX2235T3vBmNVeDAILmlJ6LIKHQFLvmhzN
 g1rns0nt/yCpltnrpJw9/KBUvTPi7P+EGWh+55mwOl/Z7EqTz+wh0KeuiX32gutZ06E/mVmlpa5
 j9XTkK/PWYXIBnEmKWQ781IQFg+aID9v/k1SewyrH27FC0rQB+117h0gl7AtPOlY0zrtfKpNAZK
 BlbXeaBBYN31sqGjmxjh8/JYzuJuqWWwOlN5ubZdUwpe10F+fJ6EeYARiAVm1j2xQGNPC+k18qL
 7ZGfMScDDWhMikxSk/YY07LbpHkgRC6l3zM0MCQRIuL/byFomJ45Obh59aXctXNBqJ5FRjD804Y
 nIgsZL/uzfRcG4IUIhg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIwOCBTYWx0ZWRfXyis3z2GqfFuM
 9IlidRCHryfo+9EoLyjMb3ZzTeRoieIFGtcF7peSbBorDm/7f+6Dtr4kv036c7JdlYQ/ZDk/n9M
 zzjnXrq0kmkX1/bpKTYchx/CSAfMBH4=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aa80a87 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=njC-hnyFwTIKUP6h0CMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XggWwxfULuItcQhR-pRffxO0bPQTtQ8Y
X-Proofpoint-GUID: XggWwxfULuItcQhR-pRffxO0bPQTtQ8Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140208

On 8/21/2026 10:11 PM, sashiko-bot@kernel.org wrote:

> This commit adds an x86 implementation of unsafe_copy_from_user() similar to
> the existing unsafe_copy_to_user() macro. It also updates the existing
> unsafe_copy_to_user() macro to use shorter internal variable names.

>> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h

>> -#define unsafe_copy_to_user(_dst,_src,_len,label)			\
>> -do {									\
>> -	char __user *__ucu_dst = (_dst);				\
>> -	const char *__ucu_src = (_src);					\
>> -	size_t __ucu_len = (_len);					\
>> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
>> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
>> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
>> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
>> +#define unsafe_copy_to_user(_dst, _src, _len, label)				\
>> +do {										\
>> +	void __user *__dst = (_dst);						\
>> +	const void *__src = (_src);						\
>> +	size_t __len = (_len);							\
> 
> [Severity: Medium]
> Could this macro change cause dangerous variable shadowing?
> 
> By renaming the internal variables from __ucu_dst to generic names like __dst,
> __src, and __len, if a caller passes arguments with those exact names, the
> macro will expand to something like void __user *__dst = (__dst);. This
> results in self-initialization using uninitialized stack memory, which could
> lead to arbitrary memory reads or writes when used with SMAP disabled.

IIRC Steven advised to disregard Sashiko's concerns and leave Josh's
commit as-is for now.  Any objections?

> 
>> +	unsafe_copy_to_user_loop(__dst, __src, __len, u64, label);		\
>> +	unsafe_copy_to_user_loop(__dst, __src, __len, u32, label);		\
>> +	unsafe_copy_to_user_loop(__dst, __src, __len, u16, label);		\
>> +	unsafe_copy_to_user_loop(__dst, __src, __len, u8,  label);		\
>> +} while (0)
>> +
>> +#define unsafe_copy_from_user_loop(dst, src, len, type, label)			\
>> +	while (len >= sizeof(type)) {						\
>> +		unsafe_get_user(*(type *)(dst), (type __user *)(src), label);	\
>> +		dst += sizeof(type);						\
>> +		src += sizeof(type);						\
>> +		len -= sizeof(type);						\
>> +	}
>> +
>> +#define unsafe_copy_from_user(_dst, _src, _len, label)				\
>> +do {										\
>> +	void *__dst = (_dst);							\
>> +	const void __user *__src = (_src);					\
>> +	size_t __len = (_len);							\
> 
> [Severity: Medium]
> Does this new macro suffer from the same variable shadowing risk?
> 
> Using generic internal names like __dst, __src, and __len might cause
> accidental self-initialization if a caller happens to use the same variable
> names for the arguments. Should we use more uniquely prefixed names here
> similar to the old __ucu_dst?

Likewise.

> 
>> +	unsafe_copy_from_user_loop(__dst, __src, __len, u64, label);		\
>> +	unsafe_copy_from_user_loop(__dst, __src, __len, u32, label);		\
>> +	unsafe_copy_from_user_loop(__dst, __src, __len, u16, label);		\
>> +	unsafe_copy_from_user_loop(__dst, __src, __len, u8,  label);		\
>>  } while (0)
Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

