Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A46C33B6F6
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 11:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783595589; cv=none; b=koykjW1k6xLpEbM9G0DS63NfRdqWvrTpp7eF++itjUXTGErEAdZbwpAeFVdPJ6ZOhYkCfXTFSk0/yoBCfeFJy+xVaTRBja9yAn5IYkslmlceaiVtbrCMd4t77G3zVm1sGc+/2mtySTiZwd52x+U8urfnQ1MG7PW75ySMMNC5YVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783595589; c=relaxed/simple;
	bh=HqXh4BfYQkZLyAofgdtRXqw9mAcQUWbFiU48fKsf49U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cWIetEIDO4OUutGWCt03NVUB++OBuNSlgaxCYDBz+SqDPzQ4U9W05xCRKfqTa2GB6UFn5qQJGddWSYwmt5ZihulVNhD5xR0HmGuGo/4pzYmkq5VM5e+SQpTOLYxFRCjDUzL5ScJKiQ/2zeHcyJu7lOW5PCNQzHBeFDaTtafQhYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jqvWJK8P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iG0CDJi3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jqvWJK8P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iG0CDJi3"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669AxFQw1434813
	for <linux-s390@vger.kernel.org>; Thu, 9 Jul 2026 11:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Tx1kSZXz579iItxHsi1/8Nt3maK8vpLohSpfVXF4Ysw=; b=jqvWJK8PLEi8s+Po
	PkAhOcF1EZ0TGn8umnL5kgryJ/tFquXm2xFzKz63mEvAAckXJG2v/bBhmyd/J+vv
	w606gHPQkOOhu8auM9bbQnd68PLYN5DhMVRn/TQO3SYM9ZXEOEAB8F2FTaHvyyzL
	/gj6GXZOaZ7Kqn5MccKMlGU9Y/8NaD7WUS1XOInbClq4x0wSv71WFJfHopsmfL88
	joRiOO1NBxKuiVXV4p/tSPunQ9pAf4nwUwhwVoGhXqa2d3YUXy3NiFuuL84Sr5z0
	sFBM3VIfsHX5R32LvKrkWCid7sj7it6qPECFAQp6EaOHyXV68SwSVXRcZbVTi1ag
	vIF6OQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9wwftuks-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 11:13:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e52306621so85524785a.1
        for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 04:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783595583; x=1784200383; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tx1kSZXz579iItxHsi1/8Nt3maK8vpLohSpfVXF4Ysw=;
        b=iG0CDJi3fEdX0+CvpLHa3ZPfVRJBQiHYA56w/vMcyBgF2+hpy32q3CU1HZq6nPC6xy
         UmjDZFf4CwiqV+QRBUVkridGTJW9uiQzqQdFVGemCQ+fVOre4X736H4qF6HV/I/Mg0mm
         4mQQgA3UOxLee/+tn5H8iVMGP5DDnyDMYlMIM9yoA1vaqRiHEh4xDXOiyTrPenIWL3Xv
         eEl3zNhexfGNgmBPVd+rnFNzwmYjP+AaruVL6dHO/2bvZ+hVBZIQCV8e7So3Wmx1wRIW
         WODuJ0vTVTLLQ2w4X1BNziAAkXp95D3RtzBpcq8BLOHS2Nfw+jtRug1n/63Y//6MSIFB
         fkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783595583; x=1784200383;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tx1kSZXz579iItxHsi1/8Nt3maK8vpLohSpfVXF4Ysw=;
        b=bcN6Avx1fow2w/C3jTY2AOmlBzOUUmmHsZ4/aTJvCKcaRGHVtFTId2YQwR1aROAXWp
         3c/VcGDP1/EisilI36lsBKBtlIKp95wSJsHkEF0oQeE1VYyZFpnyZjo9qEDgV4APlj9i
         trOq9KqeoMcNTTUrv4tHrRohEAGQ8kYxS8rRjgdy/dXCKGhYxrKrnkCFXiH4mFAuCzGn
         l2uuWBKEgwcLqjiruyq3v20oeyTXOJXBEonpuT/Cu4ilhj/ykZLPw+MBakDU2tcUHAIj
         j4Ch92ewpqt5vTKX0zUbn+4iW3ddPkDoMuDnenxoE4KIIpMODzno/OYNA8QrSYQ92K3Y
         ecTA==
X-Forwarded-Encrypted: i=1; AHgh+RpjlC7RVTCwRI/by3nhYzaDTzFcuCB6qaQ0iPh7BbKrVPBAaUkg/+Ww4Fm5WPXEU+JFwmy5MsEJuyss@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg//nsSYDiAQIo34qEOC85hb/RmJSJx0s1zQ7qtsa/4Ka+191d
	6B2iaf8MxSem3sibRwUc/fXE5WmrHcGGNtSloqTR5Ae1wTnqHxccXwEdAhudnE8YhYD50X/kXew
	8LGAcNvyNhQpIQFun5+llvmtvL9IXG4GatYZFrhfhTB9tuPnmn9/xPJHxVF1PgEMw
X-Gm-Gg: AfdE7clA3nb9jQP4HWLV6rh5P+JCMjOhAaXGyLDHGDW+R1QGm7oyu2JzNAVcYpWfO4M
	9+vUBbPVm7mTfs0TwD8Qo1wbZCDAQrOfWEvDCPZYu9viFLMGR5CLb/mSJWgm9aFHv01prc+rfBC
	zYtC1cO1Zf5zfff73od/0YSmeWy8sqbYn81oXiGvSDedGtfOG5iRPiyky30GSOYyPLt459iKAM5
	2MvhRdvZ3mQwGe0/EHj11WClcjMKeN6ps+3PnzMvNkgMIPpNImqE2Oe9KV0c/1ABYeYsuFBEoAf
	VQ5DLwUvljgTLNdd2tiiW7VmjXrXZZLDgfbbymSMYJMG3JBI9XiW9IEnZft6PsGF1jP8wqMQ9fd
	Fm9vYv5RvDZWaEY9hgWoszWuyjKy6+ftTtBo17ATumPfG0oXqbXNeAL8noHRhRA==
X-Received: by 2002:ac8:7d14:0:b0:517:61d5:2f7b with SMTP id d75a77b69052e-51c8b4d596amr63974481cf.56.1783595582885;
        Thu, 09 Jul 2026 04:13:02 -0700 (PDT)
X-Received: by 2002:ac8:7d14:0:b0:517:61d5:2f7b with SMTP id d75a77b69052e-51c8b4d596amr63973951cf.56.1783595582395;
        Thu, 09 Jul 2026 04:13:02 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f213e8sm48543085f8f.34.2026.07.09.04.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:13:01 -0700 (PDT)
Message-ID: <835e2f62-3b66-45d4-a614-dc2198a715ad@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:12:57 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 01/18] powerpc: Move stack randomization after
 syscall_enter_from_user_mode()
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
 <20260707190253.718191130@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190253.718191130@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX9/OSFvSnzvvo
 6BkodCPB6+uccHL5X3ijpDNIs5uG82QvT7itP5zrKRQYdgiWSjW8+gqQAWlVIPc01kJpfB731O8
 6Y/Q5R8Zg6nIKaHIAxgUS/ML7eLl8kTqXmebGCDVaiLEwoIyD+M2kZM72hsfggR+G9KuYLNtpU0
 Pqg9jzmxbanO+csprS9j39ZK2yDrHNguXP1Z18SeCMVcvp4fmdZLBYzOJe/OUnKqA86hDbhpgPL
 jOuDvVXI68gPLdoxn9Ryl6/AtkIjCbsUJpXa8TDiIvdlJ5V2DvEZoCpXWoIAuEDpQeTw1Q98dC+
 2Xf1npMFNhco+T0wYNQUgO9Hrb6Ac7f/mLQiXztI1shdcBxLpTWkbKdeLr1iQR38mc5PiZqJWTg
 2qTAsguD7M9/E4YTtUD+4nrHWhWXvUhUXc/tpQ9kEbz1Tse6ccJ5EqZEzqKeJ28Po4W/i/1DTXp
 skanspEs9qhA+h8K8Vg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX4BkKNit6IDSQ
 k3wK/Ru98aMBwYrSnwXJfD9WMoZLrPKR1Nt2ySWRz5ln5hMpRATTnhNH7gMty++UimSlQmxgw1g
 /oJKstGbx/U7RNESFc/CT9yGUSBO3Qw=
X-Proofpoint-ORIG-GUID: ubTdcszPhaHbs9jJG4qVEgsHH6LJBK-Y
X-Proofpoint-GUID: ubTdcszPhaHbs9jJG4qVEgsHH6LJBK-Y
X-Authority-Analysis: v=2.4 cv=Krh9H2WN c=1 sm=1 tr=0 ts=6a4f823f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=voM4FWlXAAAA:8 a=EUspDBNiAAAA:8
 a=63ny2n9c4_t8xnV3ltYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090108

On 7/7/26 21:05, Thomas Gleixner wrote:
> add_random_kstack_offset() is invoked before syscall_enter_from_user_mode()
> establishes state. That's wrong because add_random_kstack_offset() calls
> into instrumentable code.
> 
> Move it after syscall_enter_from_user_mode() to ensure that state is
> correctly established.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>   arch/powerpc/kernel/syscall.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -19,8 +19,8 @@ notrace long system_call_exception(struc
>   	long ret;
>   	syscall_fn f;
>   
> -	add_random_kstack_offset();
>   	r0 = syscall_enter_from_user_mode(regs, r0);
> +	add_random_kstack_offset();
>   
>   	if (unlikely(r0 >= NR_syscalls)) {
>   		if (unlikely(trap_is_unsupported_scv(regs))) {
> 
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
