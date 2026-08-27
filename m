Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B6722FDE6
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837773; cv=none; b=V9gNm1KKuGQSbIIOjEDBmIDLZXu2atZNv/WLb2796pPx0L3juY9aHb5UXeRGH2KFYL9x1Yz5NFPU1HKLd2d/ToIvMMp0LAlqQ6NJX3dloz5D9q+rc6K86boI6/JsQLMvRaXjCL+kXFLoGOMB/k2MCAmD3W84Pof5aSfe/fKgbtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837773; c=relaxed/simple;
	bh=DVoHmg/xB3QkPusl7RpeDgWjqN5/Ee+ljPKenLRiHzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peRKGBkhsRSXiwncG1Ql4cmsdkAqPdJB7jIFWAZvDQT74LonWXtWhgDUhkA93+Hr/2DBwYr3PRBiJlye4cgiQrHEEqrqldBiq141HzTApWXc62cQXPl/qpxBTHZb3QThwEHyg6ptFY7gWv5d6+hGB1RCE5/lt0vh84z8j02Hgmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VWM501mK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VWM501mK"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RCVobt3056778
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 13:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=I1qvt1IIW1k0jqc6h4mpEl4if4X7Ng
	TIyOy/t5YTok4=; b=VWM501mKtQLGu0z0uhAhAMkUrdDs1uxfAAYjTP5lbz9Z4H
	q/RCmOzAPGx3+gYEcU3l3aVRwQl31YkgpYyFG8891wQVMmJeJr/MX0+yqBjJrg0+
	l1yN0Wo92jCniQEXnRt9dH0C8obVpPBR1zPf+4+sjAZkVXECwAsQCPTgmQUeGtbY
	ZZd0/odYN24ez7P3+5PHTTbdEhk2Hz2EePVyN/wrvlDS5nNjmklOV40q9La2Ig94
	Nl1xymR0xjJlQ5dZpmMURpw0lUIsaJNHUM+LkmtYhAdhnqbiGnwZw72UfYa2PRRK
	v0Svt8mMFfJXR98m3NA4LbLFslric6S5/JHrBiiA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxna99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 13:36:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RDQFad027432
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 13:36:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsyg23h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 27 Aug 2026 13:36:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RDa3H316646564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 13:36:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 431112004B;
	Thu, 27 Aug 2026 13:36:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1597B20049;
	Thu, 27 Aug 2026 13:36:03 +0000 (GMT)
Received: from osiris (unknown [9.111.16.137])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 27 Aug 2026 13:36:03 +0000 (GMT)
Date: Thu, 27 Aug 2026 15:36:01 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/3] s390/boot: Avoid IPL parameter append past command
 line
Message-ID: <20260827133601.25110Bb5-hca@linux.ibm.com>
References: <c00-03.ttkffvj@ub.hpns>
 <p02-03.g5fb840964ae7.ttkffvj@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p02-03.g5fb840964ae7.ttkffvj@ub.hpns>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfX9MFDuI+UBk5q
 t4vH11lRcWYLEIP99PtHKwmu1f4bF1nyZMcoB0VNZThOcDltK52jusm6NY0pSt2hjlC9GsY+UOg
 wgs93IZUqRR1Jug4R5rzX3PO9JUuZoU=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a903d48 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=_8Na6-hfPcbgmeiWKu4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 1vvlSm27SyRuJFzbapEdexGQ0dNejIO4
X-Proofpoint-GUID: 1vvlSm27SyRuJFzbapEdexGQ0dNejIO4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDExMyBTYWx0ZWRfX1pQFOyTSqfO8
 ONyqlVYOD+2oA83TpukJHzDZR3BWd8B2V7qZyefqElDLBnBR159F1rs++8N7LKUncgXj+XMvdxH
 Z8wq4p8uBk8sz33bIKSIwIPIPXxibG5TVBK1XeGmFNTUwVvLwYr1l2+Y0+eCrm+/knSXrPfA30S
 h/vG/VHM6TIlCmqGKYAvXfLZkQ/clG28Drmky33VYngP6xGDh/i7xi+SLaXpHKaOoAfgH5+1cTz
 GILyScD6/uhSGipITd6vGQb1XWR1xX8QXwIBc7HDHGJndHL11f+T4u5vBCl5rA4h8VQBgbqI6GU
 LfG3NKjzd3/woP+p1vGpr2dkpguL3cdhvRazi5Rvq4BI8H4Y+YjEJXxR0sCXkxx/6pVAPlQAtpo
 bzz0k5eYrrYfmBlrFshwHCmnqXjZ9DTo0ZmMIIIyFPYQAqXH6LD2dBWx0eET5RMqx3zipwXN1mi
 HGSIdIvdtjI9KFSA3Yw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270113

On Thu, Aug 27, 2026 at 02:01:30PM +0200, Vasily Gorbik wrote:
>  static void append_ipl_block_parm(void)
>  {
> -	char *parm, *delim;
> +	char *delim;
>  	size_t len, rc = 0;

Reverse x-mas tree?

>  	switch (ipl_block.pb0_hdr.pbt) {
>  	case IPL_PBT_CCW:
>  		rc = ipl_block_get_ascii_vmparm(
> -			parm, COMMAND_LINE_SIZE - len - 1, &ipl_block);
> +			command_line_buf, sizeof(command_line_buf), &ipl_block);
...
>  		rc = ipl_block_get_ascii_scpdata(
> -			parm, COMMAND_LINE_SIZE - len - 1, &ipl_block);
> +			command_line_buf, sizeof(command_line_buf), &ipl_block);

Both could be long single line statements. :)

>  	if (rc) {
> -		if (*parm == '=')
> -			memmove(early_command_line, parm + 1, rc);
> -		else
> +		if (command_line_buf[0] == '=') {
> +			memmove(early_command_line, command_line_buf + 1, rc);

Would it be possible to use something different than "rc" as name for
the variable? It is actually a length. Maybe something like "append",
or "extra"? That would make the code easier to read.

> +		} else if (len < COMMAND_LINE_SIZE - 2) {
>  			*delim = ' '; /* replace '\0' with space */
> +			sized_strscpy(delim + 1, command_line_buf,
> +				       COMMAND_LINE_SIZE - len - 1);

One line?

Anyway, feel free to ignore the style comments. Code looks good.

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
