Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CB9314B72;
	Tue,  7 Jul 2026 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436088; cv=none; b=GpNr/yHOWfD9ov1R25fNmCseIGl6jq2ehVF5umbsCRZrwmo/lBSZ6m4Z7Kiyp6ShEZhmhN3/JYP0dRMh5mbs7Aps+3PwbDZClRwzcMEqNsaQf3Xx3lQYE1wUEQepOaxyhE43Um2O8KFOT5aCxfmN5q2iTS7hpl3So+o17NDZVuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436088; c=relaxed/simple;
	bh=5WmCBzRJdD3Gbvi8/pqS1Ypmi0AKZwX90Hdz3iuM+Tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rCZgbgNo2RrabpqNNjX33ZS54gU3M2ThdnQUTkFu5tw0R7nvA0IPlZsuVKCYFIvF2Rdor9dBZcpZtv9dL2fldNtLLRr0/4vN6jnntityiqwO7dkJtpbojV4xR08dYLGKQd9jpRlTPFFdn3yUE2qxFpgtQYeB5A+FNc1to25vbwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cp2LLMGM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cp2LLMGM"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667CIEO63536540;
	Tue, 7 Jul 2026 14:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PKIX+B
	TJajPf0fKhWpzRmTsFV1faQ4qf0HMLQrQICCc=; b=cp2LLMGMVKLAbZPrAQeAq5
	4NlJiknEemeAw/SGLWJ/uK/lLnwwhFnDidvejFXBzUSLeWVg7t4D/SU7UuOcAOn8
	4IZ8K0GTQqwynX1fY2TScyLHDMibiEn/+mCaE6wTn1LhiiPNCebtVBS9ofzyc3TX
	Jf68A1N/trqACT2mG4RiyIF1Roxyqh5kjPezSI5jHcT6hV5JukT7Pxcl4V6gBoP4
	TM/azMev4bfYZ+HdYr8A66iKnMO4zC/QW9LxR50K3HV+QcgDy2rk1edcN3+EzWpI
	paKj3RT369N9qxDwUWtjQVUWuhKX0sz7DY9i6VPVIxvRQopn+4aQQqaHDv6rDipg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4qsgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 14:54:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667Encvw006504;
	Tue, 7 Jul 2026 14:54:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgk3ahy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 14:54:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 667EsYGZ61342032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 14:54:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B59A20043;
	Tue,  7 Jul 2026 14:54:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E081920040;
	Tue,  7 Jul 2026 14:54:33 +0000 (GMT)
Received: from [9.111.139.68] (unknown [9.111.139.68])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 14:54:33 +0000 (GMT)
Message-ID: <ee148a32-a792-470e-861f-b4da6203cb31@linux.ibm.com>
Date: Tue, 7 Jul 2026 16:54:33 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] net/iucv: Descend into net/iucv when AFIUCV is
 enabled
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        David Miller
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260625061303.36326-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260625061303.36326-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: FQa4XBSPQ38JcjQjDXW6oWjB-tPC02b8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE0NSBTYWx0ZWRfX3EKUCYtNSKld
 rJj44U19flZXNE5elztKdt5GFmQGh48CYr3bs8YchaS41VEHWhwTTwzVYNNSfeq2UrEWp/sd7ZN
 IiRlidXQ+dXVtAhGZYKxuosQk6MzWTxZG/Mvu6CLHMOKO/QI58zv/wj6FIP+9QYYJuPyFVxxdv1
 6/4+bjCSNtd5O/TinIg3yXPP1cEX7cY7c97ImhhlqO7MgxW11V28QtWLEsJMc6ekGESh86wtjTq
 vkc8Z09wcEpSkXt1r1Fhj916+Za3HLtoqTDQnMl4CxlWY+x7oIeZasB8T65+YTSq9WXz34A33hA
 GPmjOF4gVXdYjY9PkioiHDTRkAZxLO5C1Ka69nhl083IWO+ASu566j3nn78+txfA2cLU6mmfCp9
 9Cd5Ag9BmnI4BWsVJlajgem+6y/WHYJ+I3v8iLCn+JTp87l5X3qzfBt7cDuTv7TCONNmszMv03k
 VEFA/P149lGZ5jg8lSw==
X-Proofpoint-ORIG-GUID: Zw5nodsd-SCp-lQF4qPQMCuKSnk6XxQj
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4d1330 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=Svb84iCddaksufn_uqMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE0NSBTYWx0ZWRfX+2LSk60DRF/+
 3coNeZ+IgaOghboUG5brDk6uJuaLn3TS/KC8CG7EEEkrjbK5EBKpZiNf/F2cnkVjD1k0ZRXQQ0t
 tQSc7Alg8l9rnP9ySWyCJgPbFUoSzZ8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070145



On 25.06.26 08:13, Pengpeng Hou wrote:
> AFIUCV can be enabled by the QETH_L3/HiperSockets path even when IUCV
> itself is not enabled.  However, the top-level net Makefile only descends
> into net/iucv/ under CONFIG_IUCV.
> 
> That creates a Kconfig/Kbuild carrier mismatch: CONFIG_AFIUCV=m can be

the same is true for CONFIG_AFIUCV=y; please mention both cases.
(Maybe also mention explicitely that CONFIG_IUCV=n is required to trigger the issue)

> selected, but af_iucv.o is never considered because the containing
> directory is skipped.
> 
> This RFC uses an always-descend model for net/iucv/.  The subdirectory
> Makefile already gates iucv.o and af_iucv.o on their own Kconfig symbols,
> so entering the directory does not force either provider object on.
> 
> This is intentionally RFC because s390 maintainers should confirm whether
> the QETH_L3-only AF_IUCV configuration is intended to build af_iucv.o
> without the base IUCV object.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  net/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/Makefile b/net/Makefile
> --- a/net/Makefile
> +++ b/net/Makefile
> @@ -45,7 +45,7 @@
>  obj-$(CONFIG_MAC80211)		+= mac80211/
>  obj-$(CONFIG_TIPC)		+= tipc/
>  obj-$(CONFIG_NETLABEL)		+= netlabel/
> -obj-$(CONFIG_IUCV)		+= iucv/
> +obj-y				+= iucv/
>  obj-$(CONFIG_SMC)		+= smc/
>  obj-$(CONFIG_RFKILL)		+= rfkill/
>  obj-$(CONFIG_NET_9P)		+= 9p/


For the records: I do not see a usecase where somebody would
create  configuration with AF_IUCV=y/m and IUCV=n; i.e. where
somebody would support AF_IUCV over HiperSockets, but not via
z/VM. But technically, it is possible and who knows.

So please re-send as a regular problem patch to net and add my
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>

Thanks you.



