Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E12410D1E
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 11:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783595719; cv=none; b=CAtlcjvPKY4iWOOpftKnnvbX7+2hDKLnzhmfnc1CiRvbTyaQl8T64D24LkT9nD0Kptf0mefT/HyqPFJ8q7m58reGbi89jl62NOj6OkKfU4G/FwA4INDqWfxOO7kQXWJneRrWY7RAh4DL2HS60W6313ni8UT+LlNhovqsYBiif64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783595719; c=relaxed/simple;
	bh=hMQxGqDMYjVKngpsQDGYdUmnvhAEUJmuhgzHeTWQMzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HpZjZBijl2o62WV2RpcFuTvzs4rmFMfeC2Ahqc7sI0EWMbXIqnKS6vYAw0yn6Y4S+C61v050svsteJB9NMRiNxYJHkpUdFp2ON3MvKHpezJvkBZYajp37FXUL1sIKNEukEVXBhW8bAFbgkzbJyutA+kUY80vdKmjaRZ3tMPLCVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QY+QAjG7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ClypiPMB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QY+QAjG7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ClypiPMB"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669Ax7vs1574485
	for <linux-s390@vger.kernel.org>; Thu, 9 Jul 2026 11:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h+HMbGg4SL+5U70oYYJ2l7pisY/QrLqdUOSZy/EbODI=; b=QY+QAjG7JhI01DOL
	wrAWMBSfa2EsIJlZOBwNOpqR74GzzqMsWGKTL1nRLElce+kxLmPXGSEYyErRT9bs
	jrNUZ5qVhOMFlBS0g8+r8Lj5pkWx0HY2wr4Y4a6rA/soxkxGEv/GhwH6BfRMk7jC
	wxIkHw7CzIPD4C4hy06RY+nKd1hJsp9iQzkVAWdtTEM+7XcTYBvK6npbb6yBBaJ1
	CW4Qj8HEgGXE+RZq1+7fNu0Wd4ijs3A5FZcUaa9zPvqhQLDRRhC6VCASBWFqdB7d
	2iZ0nRAY5gwJd6YOiD4NmrqJffwjsCb4nFAr/D46CSDxbk0OC7RRzM/ZY22CoVf3
	XPhT6g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9urvuavd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 11:15:16 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1a9764f0so23351151cf.1
        for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 04:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783595716; x=1784200516; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h+HMbGg4SL+5U70oYYJ2l7pisY/QrLqdUOSZy/EbODI=;
        b=ClypiPMB6jKo7P5sHj1+Fv/mXETxyK3+/EjkqAnWwmoljqJN7QXJfOu8CAfraZuH3g
         GuHZWt2bIkP4U44wALzkgkjYxWaBQ3fW+Yq5AbO0jjc+qEBexV7WJs8/CmDA7BeTm53A
         rxfFuO9zHrKoCIY4iI+9GnJQGaMoeWyiwzOu6GNJMrqZ8bA7V2QfivjkLOmFR/SVoHy2
         6qZUS0aKJjZDlw8GsTVqQtLrEL3ML4LFs70Oeu1OV7Bkv5tcqv8T/kxWXEsdum2EALmV
         hAiM2NdhGskiXJxHuFYFjT/ROa1oISdR5APSgrrMBfRwTK94dnkpoY525IwBv+86H2Kv
         +ITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783595716; x=1784200516;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h+HMbGg4SL+5U70oYYJ2l7pisY/QrLqdUOSZy/EbODI=;
        b=GnGZQmNRqscwVGZtu8r6AqUQc3uiOPO/u77X1np4VAGD462W4ixM66JlIGyhg3QHGV
         ni1sc7guY537psJK4DaeAms08XTH6TMSh5cYhRIGsQQ4RQWsByfL+6ONsTiKyY1Ixumy
         1WgKi2bW3pune7n91eoGzhfa7MVCTxJczu4enJt7N0s6/7EYovFxloTKbZe4bHhf/JtD
         DTAGf2KqKB4R1EbACn2sQhe8DZOEgU84Aif4cXnW1MLmnmG/DlQPypNZrPOZXQkgfNL5
         PJhJu1PAiQPV3j9KS0CROsmtK7VALfWPzCawjGnk/yD5Pz6ItNPyYL0UeGKGZdAwv7fu
         OXwQ==
X-Forwarded-Encrypted: i=1; AHgh+RpQLN2CLIm8RuUz9kki+YNs4x+7n/n1dZ58BVPcF2Y8a1/MiLUlhCozeNxTkH0l7wtn4CjsNmNVX55b@vger.kernel.org
X-Gm-Message-State: AOJu0YwmpvbB3DCxWCcAP1AtdV6xBC3eeepmMVqQV1RVgpV2WJ0Z4Th2
	fftF2bvb+KW8vdmBOcA0YpIwlNwuaJJK/MKc9Lk6PKOaNpmal1tJrpiug3RHGGad/8ODPPYLIo0
	TpR63ipgY00TvPtwQlLKJT6mN7G6poo+A7lDMSqUZ9R7OV+JaI62YkEFIt2Qa0DvLYgcQpeoz
X-Gm-Gg: AfdE7ck5pPDpBmuCFit8L5eTARJqJBPWJAbb/24qXdsEit2nhL2zc3nPUUx8hpUiWfX
	WR9diPvTu5cidx81ZVn4HueaS4fOMu63DOQ4PKY5jvk3VCdsHwCPk5xhpWsuJboyTRXpKycBu4l
	VrK6WzqctqrDWu+0nGtF6kM9ZE3PQxAyiHtif9pisLSOewpmXTEAlODMK6ABbz+nZBftuvDhWmR
	6++iHx4neYHJs0qM9OA1I6DLMlR+wgi2Z8bZDL3Et5kVa0/ltQv67OBf/HKIY/0TuiM7fkBpB26
	hSdPIxkhnjwofD+P+fiJQngnmGf8T6/SZl4j8uOwUKAAkMxr5dutt643c16Ky+edDnbZTNci86E
	QwtcVr0pjDuzEW6O6yVNEDRAo7EFsBvWSgXCEM1O+kmQTbveKf0fw6fyQZcaC4Q==
X-Received: by 2002:a05:622a:58cd:b0:51a:89db:95a4 with SMTP id d75a77b69052e-51c8b2bdfecmr69627201cf.6.1783595716208;
        Thu, 09 Jul 2026 04:15:16 -0700 (PDT)
X-Received: by 2002:a05:622a:58cd:b0:51a:89db:95a4 with SMTP id d75a77b69052e-51c8b2bdfecmr69626741cf.6.1783595715754;
        Thu, 09 Jul 2026 04:15:15 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d843csm49838232f8f.14.2026.07.09.04.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:15:14 -0700 (PDT)
Message-ID: <954fe87d-9d43-4819-9f5a-eb0e5e5affea@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:15:11 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 03/18] entry: Provide
 [syscall_]enter_from_user_mode_randomize_stack()
Content-Language: en-US
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
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
 <20260707190253.816918647@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190253.816918647@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX3VAqXmZNzrED
 BCgD7jS+SFByi8YslfCXnw/pJxwOAJXZrb9rpZr+taeKqVAwFuya4G2u5yhe8tzPGGlJ5niKf7G
 Q5YxmR5cMNKseWxUBqZlYDp/cuROcDc=
X-Proofpoint-GUID: gHiSTUpFu4iktCRFgtB90YGKbo3ey_NM
X-Proofpoint-ORIG-GUID: gHiSTUpFu4iktCRFgtB90YGKbo3ey_NM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfXz3pEYyROpS9C
 KLKUDeWewMPvO3dI8EgL45jbMquCo9JLx/D/QV7eG95fwFeLahHu0K+U1pEuDjE1hliNXIa7WPz
 cxNnWVkzNBbHxUuXPhqEOBaa+Xk35aJWFdsOd+zRmJchuV4rq0ERoMJ76xzCwnoKeg1PXptIpdr
 jx7AXiMRn4EmS7rkkIUxGuTB4rb5geZFRRGu70JrEhcI5XhBJWnDkom7MXnboAjzHblOGdkTCHI
 wiAM+3CA6KTTXI08Ml1jSzrSUhQ1OwGpYdtSIqkKgAUD0HvU87ATW3roi6nDyHQqZhRWoSi8AQu
 0PYMSpcpliObMpTxUVtD8IWMzs3CEm1JRr5MehxAOOhU2gAP4gWRoGhN2Fd+gWSOc+w+wjxUAR2
 P+BOjz7JPvEPoA7hoaVHZl0I7dGQPPoZU/ZMF9UBNk6ovHAnhhxc73Mas2L2s+nncuHP0V+cBlx
 nmtf7ux/RKXcHC30agQ==
X-Authority-Analysis: v=2.4 cv=H43rBeYi c=1 sm=1 tr=0 ts=6a4f82c4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vLKI4MkW7k7maJ7H7gsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090108

On 7/7/26 21:06, Thomas Gleixner wrote:
> Randomizing the syscall stack can only happen after state is established
> via enter_from_user_mode() or syscall_enter_from_user_mode(). The earlier
> it happens the better.
> 
> Provide two new macros to consolidate that:
> 
>    - enter_from_user_mode_randomize_stack()
> 	enter_from_user_mode();
> 	add_random_kstack_offset_irqsoff();
> 
>    - syscall_enter_from_user_mode_randomize_stack()
> 	enter_from_user_mode_randomize_stack();
> 	syscall_enter_from_user_mode_work();
>      
> to reduce boiler plate code.
> 
> Those are macros and not inline functions as the latter would limit the
> stack randomization scope to the inline function itself.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>   include/linux/entry-common.h |   56 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 56 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
