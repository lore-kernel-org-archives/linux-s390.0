Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2599D35B643;
	Mon, 23 Feb 2026 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847121; cv=none; b=G21kaSzFUHGrT85nFEs3VZHUsYda6fJTTAf0dNPEcYHimaWmGnI77lamIPRqW680fUaOOqIjO8OBJyPofjPkafVo/Ck2qb+wsvROdNMeNjRInWWdoxZ4peSA1U9oQBA7aP/9qD/DpA9xkTL6AtiW2STwo4hqsIMs2B2X2z/R30s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847121; c=relaxed/simple;
	bh=sz2X2ovkOkNyNxTVSqZ9D5RuN4/x6nw7CTW8k28O2Go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bFnSjuOjVIOVtdOraGZhYQWolUTq/bXCLAt804c4HtUemi/dfrV3uVrOBTGHTccqZA69UtPWt+JUhXGipUkeoF/8Xo7xWLeI1nuJuIY6EUNQ3pjPUo861Umi837+3kCp60VH8qyI1/X8b+MOg/Elk8VuiuRyIe/3fwqd6xjiPX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kIWYAjTu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kIWYAjTu"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MNOTrq2839902;
	Mon, 23 Feb 2026 11:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ogDCAk
	iKXSzUTq+jSctmvqmgehpHdHEidi3Jrqe5V3c=; b=kIWYAjTuWXa1MRhlFVxaDf
	heTLq9ynWO46XUK/uR1tibEqhk0CzOq+0HHmkAteiJMoeijx16xZDXxK1VRl6gXs
	2YLi+8olj4pzthZG6+DdlqKX9xt2/nr4SLG3qvThWlqt9KK6YKPe8Or3YEMDtDkA
	m1B+eWIf7FRdQz4pvLf9MrwAlvtbjEF2Z4o9ZtrimNEBj6EakCab9bTIbhns46WQ
	lzfCcTHOdNLfCcS8FRHwNQIMw+Obcuo4V1Kfg82I65h2+hY/grgGLpcyX4+DLoBb
	8GjZLIqU5g1MFY0R6CHPWEQCRY36xpakIhYwKqOf5Eg88uYo1NR3J1DQASlgL45w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4brpdnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 11:44:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61N9w6gF015764;
	Mon, 23 Feb 2026 11:44:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfq1scp59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 11:44:58 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61NBit9A55574850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 11:44:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A96D2004B;
	Mon, 23 Feb 2026 11:44:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E047C20043;
	Mon, 23 Feb 2026 11:44:53 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.140.60])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Feb 2026 11:44:53 +0000 (GMT)
Message-ID: <9a939e13-d462-48e8-bc4e-19157b353b4c@linux.ibm.com>
Date: Mon, 23 Feb 2026 12:44:53 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/3] bpf,s390: introduce emit_store_stack_imm64()
 for trampoline
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, bpf@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260223084022.653186-1-dongml2@chinatelecom.cn>
 <20260223084022.653186-2-dongml2@chinatelecom.cn>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260223084022.653186-2-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Py6Zu0sNF6bQULOx9WAjiYDMa1y0Lffj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA5OSBTYWx0ZWRfX0fi5FM+jXi/f
 TKmTH3dxWlWqeTN62tCiyNGJLrASS+pxoEmrop1xZSRsEiZ82OJ84hMciB4pg4gO+TnxIRy9hgc
 ObaU/8PvvXxfXERSrEO2zttf++vZeismNiHs80Yr9CHK82FZ+36xT21qsZvQcThyswkSgScahmN
 TDNANpbUcyTVwp+EUpHxLQ+OwY2en7y5pzrzHlFiz5y+VbLKLLcFRnJFLG5MAOeEGBmcAdK031n
 NNE+FnmOA/ba2pZ+zIl6IMVexcOfG9TlkvGmsY0s8Io+chnbotxpqsssNNa6TVpP3JTWkJ0Q17c
 AjDs29E6HaND7WbDP5Cvb5jFSJ/oBEb9K0UXA0nHlCtI7OHH1eirNe7/Aa2FeNc6Vw2XBz7tvKZ
 WEXvBny0jtvVhnw5UjNwQa7Ldj89daNuJGqkferh1fPJUw3w245wxOmnZTZZ0E9UWrbPctqu9Qf
 ihONCU9jK5Wj66cnSCw==
X-Authority-Analysis: v=2.4 cv=eNceTXp1 c=1 sm=1 tr=0 ts=699c3dbc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=COVfD8POcFL2HCZS6VIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ffivgXBCrRasPRQq13UCAN7EmSI1-tlT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602230099


On 2/23/26 09:40, Menglong Dong wrote:
> Introduce a helper to store 64-bit immediate on the trampoline stack with
> a help of a register.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>   arch/s390/net/bpf_jit_comp.c | 27 +++++++++++----------------
>   1 file changed, 11 insertions(+), 16 deletions(-)

[...]

> @@ -2743,18 +2747,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   	 * arg_cnt = m->nr_args;
>   	 */
>   
> -	if (flags & BPF_TRAMP_F_IP_ARG) {
> -		/* %r0 = func_addr */
> -		load_imm64(jit, REG_0, (u64)func_addr);
> -		/* stg %r0,ip_off(%r15) */
> -		EMIT6_DISP_LH(0xe3000000, 0x0024, REG_0, REG_0, REG_15,
> -			      tjit->ip_off);
> -	}
> -	/* lghi %r0,nr_bpf_args */
> -	EMIT4_IMM(0xa7090000, REG_0, nr_bpf_args);

LGHI is more space-efficient than load_imm64(), can we keep it open-coded?

With this changed:

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

