Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE7F3FB7E3
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783595896; cv=none; b=WWvoBo3wXrm/khbO7XJxhTOJGeBKldsMBAWZN8Sh6zwawmoNI9EDVhmuj2tY8JCJibseut2IRd2IyQPve3exG61XPI4p8qleg15tu8EANCny71ORwS+OGmZqQ6eNcyJgM3561yE8qVSdgei/CZevrobh0cqYugd2NMps4qN7rcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783595896; c=relaxed/simple;
	bh=JIbY68pv3tLScCT8hJ5wD/twH9VZZ6GeM09XMVAWRO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/7CHcy/BH9nKioTlZIz3gb4q//THWrcyrlQ85bTFDAKxPVqL7OYVyUT1pmM0JBuDHMgUo9mf7nMZmn0y90+0aKLTjy4WnkSOOIV1AwioRMcJX8DcRLycYa47g8yI5tJzrTJ0Uks9ZYrPr6ySTOydctCiiIMS03Eyxl7+WP7uaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fyY0pNu1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MK4YT8VD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fyY0pNu1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MK4YT8VD"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669Ax6eW1521393
	for <linux-s390@vger.kernel.org>; Thu, 9 Jul 2026 11:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vihb0TqYNakYFNkvFgdqTcLu+5oolASwgMBC4TOzm2s=; b=fyY0pNu1SYakkEnc
	jiua1Bz59Z/HxTO6ZZj7/6VoWVtUtY1ICmo9H1Pd2QjrZWC8gJfOm9T5qkA9XEc9
	zZ/LvhTR9YL1D4FRKeeUPeBJzIH2ig7MkQc5n0wn0ncq5EOUUpyCj9xucWrHafNA
	Mhaf5VX3wvgWTqgyvze8xNYS1i224SoOljNif2MkoC4501PXlkZEU2tlj13tOCVF
	k1OcXw5rO9V9U6F4nqjFTDFlr4SsHrosvOnlojjBDdlvWI+//0MRkxof7+sUSdLM
	DMKQPcPOu2w9XU1PRa+80kn2vAWE27oY8QNhmoRslamfrHh0e5dTRzAtOzXXQfwX
	yQEHaQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9sqwbw6d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 11:18:13 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51a87ef9713so8501651cf.1
        for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 04:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783595888; x=1784200688; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vihb0TqYNakYFNkvFgdqTcLu+5oolASwgMBC4TOzm2s=;
        b=MK4YT8VDvRArg85T1zuTh5lSKIWav5mgM9lgl/Wqi6XOe/Rg8a1Zvw9gtOhLclBP4o
         pYi/nFuZXbtOOurKlLICGKkHkM4r743+P7rx4PS6NN5xPyJT0RsAvIJ0G9mhceTCXXbJ
         TcUro0L6NlU/HEB84Xas/wzMRrFfMwg00IIGuAZo3sEPmd+7NgSmRH6lWYqGcdTNJ6aQ
         UgnRd/bcJ9tXEy0jZY+ieknG+OZumgTnq9FOrZUo23eCq7Yg7goLntaWz2aswEvEsznZ
         fLOTkypvDdzTU0WJq4q/V1gkEgRJXkHlQxBvF4l0IlZbc6U3kUV0e1T82wCUynLqcAT4
         1BXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783595888; x=1784200688;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vihb0TqYNakYFNkvFgdqTcLu+5oolASwgMBC4TOzm2s=;
        b=DSJX2ipDQXef0QGSmdDl2KNLcMapGFyjhGuoKiJbNbMdneOsfgWtvGbpWZPk7NZJ3H
         5MLuO5I0XUMB5sRPMnydRSYhd1BlWjmGU2rJluNWn5fv+/OLNO+4I0jk1IzVeszRw0FC
         60FcRsJghv0qD9vGJqj6XV8lM1y4Ts/CKVHX3mZa1KTe07e/861t9Gtioq7QOBDTvxKJ
         LXMZ7aptCoT3sua7v8UHKKvPJ0kKfbFtZ7WNWprwSCAKb54ypJjBZcYcH0xkt/IQGnFs
         nfVNDHg8f3/KezEAH6JPRGhh9oX/NHmCmue4XXuPDqqd4TH97Xa52syvsjX771okxHCe
         SEyQ==
X-Forwarded-Encrypted: i=1; AHgh+RquPGiE3+wZJIsq9I0IxTb1q9FxDfFm5RBraA1VNCy2ukG/oZzmbS0w1cE3IB2V+LA/E/Wcx9wiHzHQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzYWjY0So/rQuMgHT95uA/g3UiJfD365hmX8wChSAGBzsaC6E8Y
	b+kwvzexYZH6GtxcXbpT9G1eUFcG8uldLiJMdo9Qq62AZ8MlnO0PPpE5azk5nl/W9ZLa3zUrNCe
	L54tW55piQi/mCzkMBCa3kgg44VwA7LwwcVgUDIIe03EefWd3/WennpboIKldG9D/
X-Gm-Gg: AfdE7ckLK7lE5VjLja3Tj7XFpVCeLw8mjr65Pu1aw4o32Dua5LZFG6J28vYqa1zZJ7T
	Crhsd/tYpJy0ZE2ruLhODQtwfctJtk8oPt59ACXjIjb/n6E0fxy3qwwTdw1/XgwyvX/MYhmSN9c
	avDf7njMza5cb+A5re56gR+lViPGzEHnOL/ALvBDOCJTmre8ksvrT6GpxAkgsmklWlkqZqyKGCN
	dYXQGFy3XcO56IIMQe0PFjSaWzqIp1VXqFUtB8j/PER44YqFIOCo3UU276Li7m70IO6ATioZ3P0
	2DmbbhNKnGGGayAmfMC+zgZ5vnheYfDxekW8NKnaZU4bszhTHnZgHmq/JBFOBKGiuw0oHvvOB6P
	7mg46SE7C8S5ZT7R/IPlmUdCpdFmS3EZkWBqvA0jx8RJoSijHe5ZFrrzb2j01Aw==
X-Received: by 2002:ac8:5d06:0:b0:51c:98f:f282 with SMTP id d75a77b69052e-51c9b9c9812mr22453961cf.27.1783595888684;
        Thu, 09 Jul 2026 04:18:08 -0700 (PDT)
X-Received: by 2002:ac8:5d06:0:b0:51c:98f:f282 with SMTP id d75a77b69052e-51c9b9c9812mr22453591cf.27.1783595888214;
        Thu, 09 Jul 2026 04:18:08 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6d53absm53036115e9.6.2026.07.09.04.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:18:07 -0700 (PDT)
Message-ID: <e89995a7-0da5-4581-bce0-5dafc377e9b9@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:18:04 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 08/18] x86/syscall: Use
 [syscall_]enter_from_user_mode_randomize_stack()
Content-Language: en-US
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
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
 <20260707190254.079478122@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190254.079478122@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfXx7sRhKBywTd3
 ulS3ng6o36s30eGh1vpe5jXrGi2FTC2xk+d/0qaSkfi3tUjZwZF5k6bboIwqNspgC3bkX34Tt9T
 msr8MuvtFO+imthmGzocPjIJvQo1AxsJdpE3T0l14uX4EjHiJoYaCiuw3ItxTs+RdLrTqt+SQki
 372INXzICFPECuCyagTTosl+mImPNDfoF0uAc11AA3cteS4ttclF6LkYwnF+EnnBYZD/p77lrSW
 28ezXDLRVr5mIVCA46qivWBPW/D1w6CWwclbjs0RpI8ZYem0RIB9RCIrDbfD6aSvqUiOHbrXZBH
 FRHLJvO3GTEtIVHQ6bROmTaMGzfdWRNm5NY7SHW7w4dXXdky8v4SUNGHiJGddx/soP6gEzgPcPO
 fcN/lW9P8BNwPrwKvOyl1kN1/Q1uWaOWDxRdFm31ywTfrocP1AkclH72ADUNeCtXid9bPfMJnCj
 6Vr6yKvZSG1T5+zzG4Q==
X-Proofpoint-GUID: 5vf_01JWjb5ew67skNCMgM666nuGjl4n
X-Authority-Analysis: v=2.4 cv=fMIJG5ae c=1 sm=1 tr=0 ts=6a4f8375 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wOAZ5We2mjvvK_q5lLMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 5vf_01JWjb5ew67skNCMgM666nuGjl4n
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfXwWSZMosTYmq8
 dcarVLefuyUkLcUofIXlqxm6naO0zi5hlgSgnr8Ev9aIJTRUgj9rctkmH+0Dp6oyacNW1rAIrGv
 /eYhBUgNrYsbHQ7kqj19HtxY4SrrIx0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090108

On 7/7/26 21:06, Thomas Gleixner wrote:
> These functions integrate the stack randomization.
> 
> syscall_enter_from_user_mode_randomize_stack() has the advantage that the
> randomization happens early right after enter_from_user_mode().
> 
> In both cases also the overhead of get/put_cpu_var() in
> add_random_kstack_offset() is avoided.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: x86@kernel.org
> ---
>   arch/x86/entry/syscall_32.c         |   19 +++++--------------
>   arch/x86/entry/syscall_64.c         |    3 +--
>   arch/x86/include/asm/entry-common.h |    1 -
>   3 files changed, 6 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
