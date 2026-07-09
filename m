Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6AD413D93
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596051; cv=none; b=htzECORDr5F7GLJF71gN1zFSXo+giWH34JFXHiPE6Fbkib1vHgj6eE8a90D0x/Yj7CaBsbyzdRWaFPs0fw6nGZ7fm+FN9jdN/iff2kmMvhTj9895530Xfph+3QtoqHmXnKKPFLl7ygp+uEfRI+Wy5H6w1bwBfoX+r2WrayTQxGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596051; c=relaxed/simple;
	bh=R+aFi5Oqdv0TDSr7wZR2WAPngeBl4pJ5LsNFoxiZF8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7NsetSPneEZDu2q25KQg5coiHdpcKc65aBXuErjuf7me9LD6JyQQz+JBzrzFjTCbwPRDaJ/xKt0VLWYrhAlBit1JlOnUpkkgqzN4/bBDySritxh17qUdnKLnMYJJpSjjWOzIWrvXt2NVumzC1RAo/+9Dvi5Iiu63W7LogdKAxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iOWfjmK8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IV3ibm3j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iOWfjmK8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IV3ibm3j"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669Ax5801570841
	for <linux-s390@vger.kernel.org>; Thu, 9 Jul 2026 11:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E2VXUkO/1Nfb5542An87XlKwD9GRDm4PLC6Ooi7YQSk=; b=iOWfjmK8f8Y+DVJW
	EcnBVbRqoFetWpR+MvbIm0rNsCYEYiCVdv/jb+r7ZZuAst5pdACVTyVPX1hk4M4R
	UloW32yrnx0br0O0OZPBTsUXsGcPSz6fo0b7Z9SsSAlawkneGV3knPcGuKS4ecbQ
	qUgL7kJ1kZwezKuA1OHch6fG0wR/9IjoD0gaRXopgi656DtKQN7lmNG5nDcMpELo
	+2tydKrnvkk1mYPsPWN5nD/hRUDpTxejd9pRgo55t5XyFzKGEVSWfHJeObs1qXCX
	o+wuU7kKSC/wnWW5kZ8U0x7Pvu4fl9GPrm5rLmSBf6RmcKnNqHf8RgkEBJ09ZjsD
	t7y3cw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9rq34985-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 11:20:48 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c01ff996dso17579771cf.2
        for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 04:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783596048; x=1784200848; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E2VXUkO/1Nfb5542An87XlKwD9GRDm4PLC6Ooi7YQSk=;
        b=IV3ibm3jgasq0s25tfTTsde+mb+cbf0EiYjotNWeOD6lhtkHYfP2NAvgo3fLSIlUov
         awVy4ec6gUG+6lxF88vREvFX/BnAW2XtnXM/E4JYk8LbH2pnNKv6JRm4+/odI7GT6WSw
         o9aCqNbOOPo5mJxVtnMjUCgjDg7UbJ+oDXXQhHorU2xCYBjgAs94FosLKC7YNfz1EuEO
         FWMkNhgguy/XKB6GOEnwwjaWaA5LXbHHvWA4FfdMgXQG+86Zds/kXMxljOv9W//PYxl2
         OBUyoAWmlW2J9N199MquiObfB1jyw8TCul4WpEMjMdIUFrcq3Ym9tBCiae7oUGfKnIgR
         uZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783596048; x=1784200848;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E2VXUkO/1Nfb5542An87XlKwD9GRDm4PLC6Ooi7YQSk=;
        b=N5s/fTJC9A91wI5YEuyBWYS5OqK+2DdQq8t7FV/ANfkVzMp7QA8XH/uKDYZKm5/eqo
         6usiDaeyJMyBbhsFvl68kfOjCOeEaVEvsPefpVoyx229zPxLcr5s3vWjOW5sjBDMRPTr
         OU9vEP7dkNHQKXunQCKI9bNYwz7htW5Wu3O8jWPupXSLiFMF1c7H8ECGhuSdsPbujnVP
         rSCJoI4IREw90jLGu97DzRrgZimNVOXxTVDKQ1LeTJwNTxMvowLk+srp0X1Ucff1+/Ky
         elbHkFRO0fUUlWSazeeCzDoTmocIccCh1yoXS+OyXAbensWYBQeKSsQGrH6M0rkceS8E
         VdcA==
X-Forwarded-Encrypted: i=1; AHgh+Rqy9kR/gKB620dj4PxN4F5i1u4sehYt6RgR1+eXhMQKcG48NCgnDddZf+1LZ5/kWTTwXoA6GFJDk/ck@vger.kernel.org
X-Gm-Message-State: AOJu0YwFKkQ5fXiVhJ4xilrXgG8YkvalLg65NVQUrcDh4GVHvzZVpZNF
	BmDYt84WDNqQGWdYT+4PjhIz1NiI2T44KInHlksEadIlB1d2Y53/lX3KDvUH5DacOPZgtLYYDuE
	kyybtlaOqN0Pmi0EUMZGSNuix/Foj9Q0g3VaTbjz7xEgz30UGOSN2p7Poi+Nartsa
X-Gm-Gg: AfdE7cltcBG6cC1OhZdHks/GEl7D3QIl4wuwCFcB6L1bRsIvxpDCrK4Zu5XuVekP7sb
	pPG7THyvt6h8FqwwkteUnJRTlubcT1t1U2UMmljhjSZZOVYnJI7QRAltnK9bWwwI2RAaXBaeQyL
	IwgOYEDt+JADbLoNt+ExrUX6usqTW1dzVAjzYgUL23+Zl2F6TEIOF4TTQJnGti3rVbNPFW55d+i
	G5yzlmQlNUTPzooTCJM4NOTl54gxsf6Mt+1d4PL7TsUaCgjCHKb7OWTchHvhQdPSv3sDxCF5o8V
	WzhDmgVHn/UqEKP3UXFE6w1QN0WNGpdJpWzkvbqlFa6buw2OLuozjzBWr3Qj6LFp3vOEMDkGkrJ
	eGJwA+a2wIizUSZnIUYh/qjtpkw5/qArgogYni2cR26xtN5+r1qz6EORs8BnF7Q==
X-Received: by 2002:a05:622a:251:b0:50b:4491:a2cf with SMTP id d75a77b69052e-51c8b30365emr71754671cf.27.1783596047560;
        Thu, 09 Jul 2026 04:20:47 -0700 (PDT)
X-Received: by 2002:a05:622a:251:b0:50b:4491:a2cf with SMTP id d75a77b69052e-51c8b30365emr71754181cf.27.1783596047072;
        Thu, 09 Jul 2026 04:20:47 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69acd1d32c6sm1861799a12.31.2026.07.09.04.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:20:46 -0700 (PDT)
Message-ID: <73b82749-2df3-4c12-bc2a-ff7628dc8292@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:20:43 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 10/18] entry: Use syscall number instead of rereading it
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
 <20260707190254.181086755@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190254.181086755@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: g6cXfgyB3kr0oVlUwGWcrED4_i_mzhCm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX51oEahLdH4Cr
 JHWagpcQOltM3RxgKi/PdKz2/hS+sGjvZoK/CD7e3WK608Cc5eikwqWw6PDgj+f2X8frfoD4zwF
 tbm6sLHiud6CstKoveCuXXyDXlUO1Ebm+WsNpDFfNYyk4wxUAoNlNxK+a04/rusp9rNtBXsmLw3
 +PxmzjIT8wD+Q6CSQv7kdikET6t/FdhNJWdsSFVbPzLK3jz8U5KS8yA0PZQmjjAk+p4r158oJnj
 jyBxhfqOXHYp59btLGHv9tlHZCq/c641/0qbDSbnbf4s7SwhYqQO0K1loG4MQ1t7gRp0o4kxl2v
 fwZOSy9RPehQXR5MwHFqB7U2au+zR6geI98N/mwobpxZe6yH7kmGZVGrUIoR7lfeyMEL8XkQxMc
 qS9q0S5RNiPqEb43tzeNQef3eC5YQyZNOfESLRsOWL5DH+cpz8s3yyBT/F1uOIlULT/mrpcjtv8
 8F4CCyrHH09eQ6WhIcg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX1Jb7JP+OY4gW
 pBLAbu8oaqI0Voq62y0Lst5CoFfrEsq2UfSBl9AFAzTeH9cMImcwkCEQ3OZlqf+DPNKj98G1sKf
 HI6RJo/I5E4hgwwIVSMmZfvdqM+MS9Y=
X-Authority-Analysis: v=2.4 cv=PYPPQChd c=1 sm=1 tr=0 ts=6a4f8410 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=uucGcSui7XbmpEV0VHgA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: g6cXfgyB3kr0oVlUwGWcrED4_i_mzhCm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090108

On 7/7/26 21:06, Thomas Gleixner wrote:
> rseq_syscall_enter_work() is invoked before the syscall number can be
> modified. So there is no point in rereading it from pt_regs.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>   include/linux/entry-common.h |    9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)


