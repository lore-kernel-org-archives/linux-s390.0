Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4380416879;
	Fri, 24 Jul 2026 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784908467; cv=none; b=F8bhTPSBo5mJnryj+kZUphls8YgRJ7x8Y0ux+Ulr4qDqXdlWq2cSKH3q+Uefn+DDr75+5yS4CPMoSegJBKMbuqltyxI5Zd6Xe2Osf8JRMZeWh0Y04WdPUH74plvGJW5RaCaqK9Jw0QqqDFWBo4h2cjncsU35pbZLY+wm9qngVbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784908467; c=relaxed/simple;
	bh=8GbH9gZ2i5q7Mlwi6OB2cb0g80TyMgwFfs217iBheLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFgIxue5ExeAc2TOuTv9lL1GdmuT9M1Rtgx1N+J16EQxWshTk/Dhy+Q+KCpsk4qrU5athm15ZJEKxWDITPEnr2PgOEL4bSLvIfkqc6adnbryyuj5I63LHQBiHc3EJikZXlRBrJeB2hKFsiyLSu+kgnvMQxlg3z+XMOyW++ANPas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k6inKvha; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k6inKvha"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODfcN41973556;
	Fri, 24 Jul 2026 15:54:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LVrLNa
	iuS1OZ32mIlJn81Tcf8P/MvxiGEsgu1RZk5Iw=; b=k6inKvhaf4jaoODMc4zkLr
	gBIoWrJh0ZR+oZm6JKvIC/3igAPUSSE6JsJjop95GnNrD5S143zp/fatJRcUqIwL
	Y9SVJPUIIlBAe0LNFp81aZ78KKS9tBkhy6weYxes9TxOt8t1fU1orVbctVTrArv2
	DoDoS23l2j1WBtNF3dzS6cH7FyIDo6PnEXaHRmHB5wHEamnvsoQNR/0djAjgluwj
	qlRQQ+9nxgEAaQPS5sIo71GcH7CNZnZtvJu/igDftytoa63ojMl/IDrHBYD/RZkm
	2XABWbgdmRywxHHm3kO/YffGaRGs5NgIXB0boQIqqOIAw6uh8WBBCi5Z2tRJFGxQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8h50r6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 15:54:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OFnf0r007596;
	Fri, 24 Jul 2026 15:54:23 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6whnh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 15:54:23 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OFsM5Q24642070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 15:54:22 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F25A58052;
	Fri, 24 Jul 2026 15:54:22 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D000C58045;
	Fri, 24 Jul 2026 15:54:21 +0000 (GMT)
Received: from [9.61.177.4] (unknown [9.61.177.4])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 15:54:21 +0000 (GMT)
Message-ID: <8e4c0105-e2f4-4ff8-9b8a-ca4db31a4a66@linux.ibm.com>
Date: Fri, 24 Jul 2026 11:54:21 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] s390/vfio_ccw: limit the number of channel program
 segments
To: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org
References: <20260723174751.1180334-1-farman@linux.ibm.com>
 <20260723174751.1180334-3-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260723174751.1180334-3-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE0MSBTYWx0ZWRfX0a1oh1LdjQSq
 HgElVqn2gbpsYsmUydQWi1x5J4wgalrkCnEQLiJ9oq0yXfMaK7aeg3trVB9ZCVddfjSc4G1iR/9
 Q24HKX6cqENT+sg+qD5FMvlIlZBMPbY=
X-Proofpoint-ORIG-GUID: glPJYKF3HP2VtdE6fxBO0_Qq1eyYlDOp
X-Proofpoint-GUID: glPJYKF3HP2VtdE6fxBO0_Qq1eyYlDOp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE0MSBTYWx0ZWRfX1WwZFj2CrP2N
 4wdsEBu1OVbcidCOQFOJX7NqCOWHTB0Q8G6BScHWeLc5FQt5qOgVncCxs2WA68fc2h8L2lnnybq
 CoSdO7aFurHyH6Bezu/SXY/8j27/ULDPbEENrmGKkcsIJppx7F6O8OhnYBPJ+T6EMSSr1acB/M1
 fjpOfJKFnDAyz1hPlR4OpTYJeUCggKeqFnkEl9R3pjOMYOLOXMAfA4FNh8RfOU+Bqf9cBpI4IHS
 ndl1VvObjA64/i0HRdxsyIFVgSizySo7vLd3eXNN9Q4ot+BjZyugf/D/IuaAE+dytzDNBTwAkR4
 bkoUy4tgeu34+XF1YbLiBrgS7hCj/LUfuckdgaR/wyKGRzXvMiLtrXjmgZZINXiSXjezUAa8kVS
 stoLCwoSq3euk5c2Z1VoRD551I4NmkipUy4c8wv3qnDNLyRzQF0UA7vLydaWoRobz0qQAhuY62W
 GEXT9+RHYSdcjvGiwzw==
X-Authority-Analysis: v=2.4 cv=du3rzVg4 c=1 sm=1 tr=0 ts=6a638ab0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=Wa7acx2emfWfxFq0UwoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240141

On 7/23/26 1:47 PM, Eric Farman wrote:
> The processing of channel programs, and the CCWs within them, is done
> recursively. As such, there is an arbitrary (but not architectural)
> limit to the number of CCWs that can exist in a single channel program.
> 
> The vfio-ccw logic breaks these channel programs into segments whenever
> it encounters a Transfer-In-Channel (TIC) CCW, and the combined number
> of segments count towards the global limit. Impose an equivalent limit
> to the number of segments until such logic can be made non-recursive.
> 

At a future point if/when this is made non-recursive, we should at that
time keep limits with sane defaults in-place but at also consider making
it kernel-configurable (like the vfio dma limit).

...

>   * struct channel_program - manage information for channel program
>   * @ccwchain_list: list head of ccwchains
> @@ -38,6 +43,7 @@ struct channel_program {
>  	union orb orb;
>  	bool initialized;
>  	struct ccw1 *guest_cp;
> +	int ccwchain_count;

Nit: Unsigned?

Regardless:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

>  };
>  
>  int cp_init(struct channel_program *cp, union orb *orb);

