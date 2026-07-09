Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16BE40E8E9
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783595763; cv=none; b=mNmmVW82rS9opuOvRE1h/yzqYy6gtfhj/GZdreOSvzC1LhCq3mNJb5qe412xo3j5tKrI2fNFQ51KhUo1TzF196mCh/w1Wrnnuc/AfwqQGEarJ4yAZ2xkWzXsz/zklIj8nUzbI2qT/gXIgE/6fEqLrhFQliLwGYlTU62tXsOd4LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783595763; c=relaxed/simple;
	bh=2OZyqeCMlAjx4K2K+b/k9iOm6BK8Cqfe058LfZSp27I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KQEOTOVXPRxu4qkgqavJ3sX3O+TBh4sGeaEigJIDt2x7+d98R3ugQTAAShsZb16dfC/BK/icInKNPaTeQRhAqvGR0DB9GagmihFBvfnpUl53RO9yd8hmNlfdRL2k2oZbSHoHJ+l2Sy4XBHHtic37tIbDxSAQQRcLaaLjWLCa4P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ULLpdAqj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kMSp+MCX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ULLpdAqj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kMSp+MCX"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669Ax8qg1434579
	for <linux-s390@vger.kernel.org>; Thu, 9 Jul 2026 11:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y/QNMVWz2zbU62zSNYrI+1kG+0GMg+VxTcjcEiOFHtg=; b=ULLpdAqjhcPbhl+a
	9wkFVF2/lY0nTNUibaezE3oRQ6lteQ4HDVcOfqHDE7vtflCsPuubuaBt22suHv5C
	J/GboNexxusvk46SeLD4YSCgJibhGpTyBp7Ew2CmZmE5Kc85FL5xmUGbwX2SNRRm
	AUKTk+C5LBwuGwFJB3/1RH6SX3HPCEtPeI30OoMKGubID5ux/F8g5HbF1COPW79s
	OzhxWi76MMCFcorNKYBBg01ItlLF46P4rAQRFOMzzGhz1/Bz8zCwIh87EUtM9Vze
	DADpxILacbIASbBx5FZNfW6HGEmYrVnOynweeKBYk1Yd0I8v8nqfQQ/58XsDZx94
	8Wm00w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9wwftv1r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 11:15:59 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e538afe65so111465885a.3
        for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 04:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783595759; x=1784200559; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y/QNMVWz2zbU62zSNYrI+1kG+0GMg+VxTcjcEiOFHtg=;
        b=kMSp+MCXIXJE0DIs7pFLHYpvXnsnX3iIWZtDgN0i1fJWjnjBoz1NYPDmjbbQCCRNEK
         vscp+wRWlJNCjh/XanhPMyB6cllBsqrXbJaR+3Yim34KJ+QqVhYiq4XnmxXbcn3+kzYX
         htjTdXGkRRCxkvb6URsJhgktwib3kHT7eKtJttgS7TcTyMyPpdBJUvP2lYCZTsqMbzT6
         53EbRfFizqInCSE9LMw26TK3JlfoQcPT/Fcg6Pw9vXT5ycRhoHqWKtMQJQ6LJMNItBsU
         p5s3qJHEUsH+n8X9iO9VfJurTdzfT3D39Xrh9IZvupN59Nvf5nehBIKJmRnYljAv7uS5
         Bxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783595759; x=1784200559;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y/QNMVWz2zbU62zSNYrI+1kG+0GMg+VxTcjcEiOFHtg=;
        b=DxPeQezZnQ85LzLuZ3trE9RWzAnEWj1ykzcSPdM3SDbDoj0sLrROO27gXJILfSJW+f
         VQVCYncinL4aU6uWraUP8mnu4DULKK/oK6A2MqVBLMprV1Y1h2diQRDbf0o82iW2JiWW
         IYsN4sxXx5fzbJhJFPE8ZRI2K7H9YlsSckaq+JAWyZyzCPdo3pJ9TDnF2Zqmn6iONWOP
         F7YHN6LMNC1ltHE2CdenopP+WqJOcAEExQPwwEunRVLUgK5lK3DfwK3+xZx8DGs+KkuU
         OdSKVytGCdWuddGNlk5QWleaJAyl9YPXGyITbXIw2qxyAgKGjv13gHkOW++9OwKiKN1s
         YJwg==
X-Forwarded-Encrypted: i=1; AHgh+RrmaDKxuSD7jCDc5yFx/93XTcqKb8sjlM0Cciy8mdngslqAdAPjv6JT28F4WIifaD49huhBoyZLh7a5@vger.kernel.org
X-Gm-Message-State: AOJu0YwJqkCpAnybRR40YuV5I/8e+geKr7p4XsqNBdInQj50q1JbPC3B
	MKQ6ZmzSgocV0e8tLr0GcvEgJrbl1jKED3+i/YkUS4Q1lh51GBFvFMN5tybKUfdHuZnb9QWjxVc
	EOEuwa1UuHHB3f6k36IAElQMZ4mVK+KP5cWQPhJh4s+HhmxX8MEdp0+znOFVHyqYlKen39mVI
X-Gm-Gg: AfdE7cloF+2sDNoq8gCNVzzCY2nKd/tItDNmyHrBfP3gVr76lRIW/PRxGickj3ENbrg
	q6Gx7TrLAVtGRZD3FB4Ucv2hAEVR1cQkLX0gO4CzyWAcuvShhjue/HU0uWVwuBy3XHE3QdawMJ6
	9Y3yNzY6foh6Tr9z4p5ck4JURE+nlDijQBd7c8ROnfok2k+l5ij/RGY/PRed/rvk6rXvCZ2y2R6
	EQumU0oBhbjT50KS5CAFZrrIElvrT47VVlRxzBSvOYioHf+ydm09vLBTPr71DbUlhk2p6bChG/T
	CPrF0ZnxZHqA7jqPaHgn3MnnccKnutGvW/Mhjev79fW9tnHyTksAxhL12L1n4D7O3YRpo17BnHK
	M425AI7mCVuivWDflMJ+BLs9yMLFKCbu2jGoJZvlnmcnL61WVYHtYNEg0j6i1wQ==
X-Received: by 2002:a05:622a:1113:b0:51c:1b3d:fe62 with SMTP id d75a77b69052e-51c8b2dbe87mr68191411cf.28.1783595759074;
        Thu, 09 Jul 2026 04:15:59 -0700 (PDT)
X-Received: by 2002:a05:622a:1113:b0:51c:1b3d:fe62 with SMTP id d75a77b69052e-51c8b2dbe87mr68191231cf.28.1783595758685;
        Thu, 09 Jul 2026 04:15:58 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039b126sm50274140f8f.24.2026.07.09.04.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:15:57 -0700 (PDT)
Message-ID: <cf26fe68-5a8d-4d6e-b9f9-d69faa8a6012@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:15:55 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 04/18] loongarch/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
Content-Language: en-US
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Huacai Chen
 <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>, Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
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
 <20260707190253.865955911@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190253.865955911@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfXyxtm7SbZWuTQ
 hwmgY16USR49U0GUQuYXGdQI9t+IolKMlklTjwA2LtxhaGbxcfBhzg+4KWOtmhNOnA6URfAmeXH
 dwIQECFyE6iGkxDuWw2ZPjFyQqNs2rV9DSafMqM9AG3Gxb9TRogOk79+sYKozzIP6WqGWry1JQO
 5IYxIuD2CfBPeBK6p7Za/C2wE+AmoVuwKkjjQ4Tf4dP6ty5If+smR3woQ44ftzhlLKhlYtrDZ0c
 0NR0Davn0hxQFlXpDlB6PwFGENMuCCQc2knzdugslGSlpzCnGJnmVaSzWOrptctLYpT7TRaJmop
 bFh4BTZJPzfpDcA5hXr6lvLixdx37WyFH56vpHo88JFJwWr+4UnJGfKAiiG7GamrEwaFurTYoam
 9ZkhXl4G5IDlV4IYTYxCFqi7QJRbMqec35Y7u7hVCwoDES7JFZIlDpjAxcPi6VosUS8gDIr1Q9+
 K9q9tp4kvf5hhFZMk8A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX9NDog1nNVPJs
 WbvWM0h2PF1zrdkcsNDoomyNHZ1pFzOygOWQxaNnBaydvaXIeQVLHh07pvE6vGkzh8zx4oVbA+A
 Kp0XosJp+kxjhpQvjYvpj3wmSu0qLpY=
X-Proofpoint-ORIG-GUID: nBzpCOo0ovyCuIC7YZAZ2K37kjZH7OiF
X-Proofpoint-GUID: nBzpCOo0ovyCuIC7YZAZ2K37kjZH7OiF
X-Authority-Analysis: v=2.4 cv=Krh9H2WN c=1 sm=1 tr=0 ts=6a4f82ef cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=DoJJhcVa48uSEvU2-xUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090108

On 7/7/26 21:06, Thomas Gleixner wrote:
> syscall_enter_from_user_mode_randomize_stack() replaces
> syscall_enter_from_user_mode() and the subsequent invocation of
> add_random_kstack_offset().
> 
> The advantage is that it applies the stack randomization right after
> enter_from_user_mode() and thereby avoids the overhead of get/put_cpu_var()
> as that code is invoked with interrupts disabled.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: loongarch@lists.linux.dev
> ---
>   arch/loongarch/kernel/syscall.c |    5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

