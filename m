Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EE3410D1E
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 11:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783595845; cv=none; b=o2bk80p4Xzuxk6HjxopyvCg6ytF/udDVyyCUjERLm0+stsbyvKEV6UQoAWNsiXmUjjBcPVhsH7eaLOoBjJIsDnO9ZUGFpp2SKKuIixDdm3ktJyG1mklGBFkNKopYSFZuxsU2QfXU1EbtssaRvf3Yqkcug3PXdFcRGhsW+qvJoUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783595845; c=relaxed/simple;
	bh=nrb0ag4EBTliR8HEhFNdNbVVIK/JUBRD2JKlM2G1ar0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUAcz6eXza/na8ItjxTmj1haE4k89Zii3wH+H1Qljt7mmwcM5bI+MDntu8SpeBzGBcF74nrWQ0SPIpkjE3Yt45ivJZik9ayVlhzHfNwmWKGKlc/qOqtzdaL1DTQd/8S0Wx2jH2v6dXGP1lwX02vpvr6NeFWST8xNSib5TBTpL1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L5+SzP63; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gtO1PuCP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L5+SzP63";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gtO1PuCP"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669Ax4sV1614855
	for <linux-s390@vger.kernel.org>; Thu, 9 Jul 2026 11:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6mSNoqY3wyokI6LMIu3gKte85FSyTicRshSy0RusydY=; b=L5+SzP63bgPAWhp4
	W0cUVg2l9n9I+4k0Akz43rpejx4oS0/IbbWAmLMXE7C9F37E36sY/GsXk3zuJt0e
	7WRl8xWn74pDgWLAKB7VqpUweKGfDHpjZadrDE/thxVaWuDjHJ729famrINqKMDx
	0upb87A5cv2e3e9cOgTo/VDABpH4Tf/6q96s0WSa2IFCTqdWIxx3GVEJhdklhdir
	gMzNGoVv54cFMR8lTrj5sNzMMQDcUrBjV8bPTBpznG6YMJOrkgy1v18t2RPVEfx/
	2v3dDdCotvg9oshrPidheW6ip0HZ0YECDQHkCxRsQPUi1HLjdw3FRE6oVFrVR41W
	qvGWIw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa418hsy3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 11:17:22 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51a8c689b5fso13527871cf.0
        for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 04:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783595841; x=1784200641; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6mSNoqY3wyokI6LMIu3gKte85FSyTicRshSy0RusydY=;
        b=gtO1PuCPVSA3pcxofYSwzSptyCP8fplhGA0gMAQmi2dxDkJtaOaut5/NCmYMcZ66yp
         ANnNK9rb7kxDIPXzoyfVDt947Ta0of89XonsQf2ieDZ9TcHUuSK7ZKUfimsVYxjXJTJO
         kU43zaFkytMyc1foFpfmHGxGayaY8QZw1+eaUTZKTy4oMk9XSsJBa32zlN6H29CVuyNA
         rSSfYeAf1jGHIDl5pyypQVfyjMATyRCcOiIdur5rcViEEVLFcOtNuI1/WYo9Ufcvo0Rn
         vPZTO8rXfaXRIYTdSlFwq71J1495hyT9KjxVzsTQBjzpTY1aK9RZGnpINh1izwamCSLB
         k9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783595841; x=1784200641;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6mSNoqY3wyokI6LMIu3gKte85FSyTicRshSy0RusydY=;
        b=eVA0NWlHoGC8XoEB0YmaqPGdqjWMWk+vnVIzcDA150zt/v/B4EIUdIEk188MP9ROJE
         jxw1lgrhAW99yg748wCx6+QPt6a3SDsJB0FFqUF8atpbeBTsH5NMV0BAKtuWmg3mdFv2
         dmyDCah8yoMRHW/Qn949MXtBtND5p9p0Z+XBHAPB61hJmOIpPCuN3pwasEYM58gpEAk3
         ddXXS1THWJIbPvU7WrdynfEMposbqCEz3jqH9ihko6Yt6hAZG6Xxa/DjynbfP1Li8sVo
         W8PTb5oabSfmBSNhbndiRRCUHb1xKspWys+0w52MN7JxvJwLo5chr1EgfkXcszKaw7HH
         udug==
X-Forwarded-Encrypted: i=1; AHgh+RoRV1XcXRaSkjRLr1sHColEQf/j0vBioF4G0rUdd3FzM70u+3cKMrqVbmDLhrcUpeBQSOrE3cp9f8fw@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ3B8mJmeQkqhJIdKa0AEZf2tCQAD8P7zECgkH3/0tvbcXMwFM
	DOPDrUZWy1I3Uz0wyXGsfkD7+VnkZ6MJq0a6/nY89VOuXLdr/vNeMmQhwY6a3uTRtP9NAmYMXMr
	GrEAXrm384noj8YvCs3u0bF4fwXCnGH5pwGoNNaBJkRAfNiv0zXNJTgxGOmm62I4z
X-Gm-Gg: AfdE7cl4u+kGnaS2EbbfDGv88nV/jgL3AC97K95hvW/QzUdB7kVbL30eg45Kli4OpJa
	FL55opCz1LFkVX9l3mjjKdy438pfy6go3OP6WLvMxyv80dIHhsIFQDDyM4Fx21o4D5LgfTFHkeH
	EVSxsSb2Rn7yR0bAYc8YNV3/gcXJTcCYN9Hs3v3EXWdgiBzmJOMcuCBW2PCyO6vOSJMheKVP8M7
	FE23FRoSPYjOWTUQ00cbu7hbFucUj0f7dh1iHOiSlKY4W/NM9XIpZppc/Jzv+z4DK6GC7zRN6jF
	HRJZI70XOFVYR0eHArwkfjW3aGzvD8hDcxupyFh5j+81UoMPOo1kMzI6lm9/Ke/gkfVFcSxI0Mw
	OCLKOBy8FfjNW0sukZXkMaVrEf+MPF7df/IROeoK06dJstyfbIcFRl9rXaXzU7g==
X-Received: by 2002:a05:622a:c86:b0:51c:7b11:41b2 with SMTP id d75a77b69052e-51c8b51c97cmr72541771cf.78.1783595841167;
        Thu, 09 Jul 2026 04:17:21 -0700 (PDT)
X-Received: by 2002:a05:622a:c86:b0:51c:7b11:41b2 with SMTP id d75a77b69052e-51c8b51c97cmr72541381cf.78.1783595840774;
        Thu, 09 Jul 2026 04:17:20 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6cccfdsm54034235e9.1.2026.07.09.04.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:17:20 -0700 (PDT)
Message-ID: <8d15c107-30b1-48df-9e69-a7e8520f4e36@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:17:17 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 07/18] s390/syscall: Use
 enter_from_user_mode_randomize_stack()
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, Thomas Gleixner <tglx@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Sven Schnelle
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller
 <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
        Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
        Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
        linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20260707181957.433213175@kernel.org>
 <20260707190254.030598804@kernel.org>
 <499eca86-8def-4044-8b69-8f290528e10f@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <499eca86-8def-4044-8b69-8f290528e10f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UI3t2ify c=1 sm=1 tr=0 ts=6a4f8342 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfXzNlx0LbT3M9+
 lOZ842JzFd0jDsosycIwEJLIfW8x2l6Pr+hMerhTOqfmxcwpJV+j9pxmv83h3hzlkozuCeJFqn5
 xGt6HLatANOKTg7ksygTLFemuauy++BShypYcnnVqd6zlUTJO8s0b/YhCK47mc5UAZbZCcDWMM4
 PrljKNh66ADTQZdeLWxKPEG+iYrX89v4e+pbq3hdqdQjC1xnclzfCDOrLHxSMlCGgkuXpneqwTc
 V/rd8EAraIK6EQY87fBvvIBQquCwUzb9DxLJsJ+6J0QJ1D3flX0wuoyVpvLfqqe7GvqPae0cYpI
 5SuARySrmPGi4Z3tkP3ncXDRW2vDEOrpnR/PCYVehM/uCkv2MBMgTwjJilnOs5txko+mKcHzf+Q
 TCXTftXpPday/4n2lTbbXQHyh81JPhPKHkBsEVPUEbeu2gHH3Mnk3IvyPMjjcMxQNpm8OPOUDvv
 bhzjDhAhFxT1P/M5/mA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX48IMgl50GX5k
 UJnR4xeRhs5XqzDpB8X5lu+jFEgM8pSQLXvH/mqCwUnrsDBazzsW8Cvvt3rWUdPYnERr5ERkvOn
 BH1EKv6+nvYpXzc5PPs6WVU3LMaVF6A=
X-Proofpoint-GUID: dkI0EJ5-DK6_9nE6hKF6Pttz0zz2_jOk
X-Proofpoint-ORIG-GUID: dkI0EJ5-DK6_9nE6hKF6Pttz0zz2_jOk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090108

On 9/7/26 04:46, Jinjie Ruan wrote:
> 
> 
> On 7/8/2026 3:06 AM, Thomas Gleixner wrote:
>> enter_from_user_mode_randomize_stack() replaces enter_from_user_mode() and
>> the subsequent invocation of add_random_kstack_offset_irqsoff().
>>
>> As a bonus this avoids the overhead of get/put_cpu_var() in
>> add_random_kstack_offset().
>>
>> No functional change.
>>
>> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
>> Cc: Sven Schnelle <svens@linux.ibm.com>
>> Cc: linux-s390@vger.kernel.org
>> ---
>>   arch/s390/kernel/syscall.c |    4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> --- a/arch/s390/kernel/syscall.c
>> +++ b/arch/s390/kernel/syscall.c
>> @@ -97,8 +97,8 @@ void noinstr __do_syscall(struct pt_regs
>>   {
>>   	unsigned long nr;
>>   
>> -	enter_from_user_mode(regs);
>> -	add_random_kstack_offset();
>> +	enter_from_user_mode_randomize_stack(regs);
> 
> The #include <linux/randomize_kstack.h> can be removed.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

