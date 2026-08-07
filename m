Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13554756C4
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 12:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786104902; cv=none; b=plhaLE99R4vK2nhx10/XPZ4n5ru17Oa8O9oTydxJnxmFPMYrDeWWK6lhWoxOa1u5UCL9AKlnRfKaQGAGZ2wUTr8mEpFENNJcC++G2CmNVhAnF9wwzOYJmo0FFKckNeSPKr8dzZ9cVW12cEU5guih+Zywcl7OA3VYWg56SJwswZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786104902; c=relaxed/simple;
	bh=UrdftXdC+EFc1kX/B4HdD7a0nvv1yIr3uO74/chegJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/vEtB/Pv79fJb647x7U/h4DQB3PvWb28rwdmFDG6Wb7MpNF36wUJDqEnpvOoZlRE/1jGU63dj4nEb4h1v+6eQ66HmuOG7KolOJDy7+spcXJxjZje05tl8pEvdtZqTqQbJTRpjPdc5KS8xFQ68Cj/3oPBSGmO96Z50OOb8RtD1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gVF++hOO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gVF++hOO"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770HtjI4060702
	for <linux-s390@vger.kernel.org>; Fri, 7 Aug 2026 12:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LONarR
	N9hDgAhSl5uKZASCeXhfhz/nk4NiX0bMlNtbQ=; b=gVF++hOOQYTL46Yjv54934
	BGHPkaI6o/IDOpiV30FUaQhgVf6kS2FoPDKcQzkA84YQDWbHUznt9hlKVYwaWbrz
	k5p5qdBRHBJGTSgUhzQ3TQUPDUTTV524yYFhehEtV/q7MV7AhnyJVBPLMyHlQHCs
	inmo1SI5RGBXk1Q+YFvjb2BAfNJwFo3CG8TQO23vRr9vrXauJ7sTPmM5iiHrn5p9
	hKTJw3S9PAMHPcJS75qQk3ZV2cvoyTNueR74kOfM8icYF8bnmognYOHLMtnqaTQk
	FvS8oTTgdpeiHvvMa+tPaRTbIemwlJ24WccY+5k7MF44OTmm4h1Ikk75PU43GiVw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy02bnp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 12:14:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677CBFTN006500
	for <linux-s390@vger.kernel.org>; Fri, 7 Aug 2026 12:14:32 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qyq66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 12:14:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677CES4R15663480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 12:14:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68F182004B;
	Fri,  7 Aug 2026 12:14:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15FE820043;
	Fri,  7 Aug 2026 12:14:28 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 12:14:28 +0000 (GMT)
Message-ID: <b2335b78-1a3e-4545-885e-2e2cae5f93ad@linux.ibm.com>
Date: Fri, 7 Aug 2026 14:14:27 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] s390/vfio_ccw: Add __must_hold() attribute to
 vfio_ccw_sch_quiesce()
To: Heiko Carstens <hca@linux.ibm.com>, Janosch Frank
 <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
References: <20260806153849.2622576-1-hca@linux.ibm.com>
 <20260806153849.2622576-2-hca@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260806153849.2622576-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a75cc29 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=UhRHKtATY8iUNcl3ARIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA5MSBTYWx0ZWRfX/JI9JeYI4pK2
 8xZ1DFJvTl02tmBDfTrI7IQLJ3ItexlIE7AoUWxBbnBMxzNw/ID02Ten4yMPxY5GrjkfKBBgvYL
 LuLe6IinE6kPNVSM9IHrRLwM4Xv29PZ+y0kCXT0o+eLlJMvw6R6K+NFwIj2AVQ+TG7Vm6r4klwL
 EILlf0klv+RxvD0pM3qL35mRjX+kDd4zVqgVwEHDP7Yj6CffBV+X9kTVGyfEuO2SVZu8BKcrkD+
 IPLZSoRKt7gOYlWwPnUu5/Wj29+9wDo3x9/4T41QnDW+uHZPjhy7+Jg3dSxqQQFjf292AHEKNn0
 iCB8NceVmTU6y0ey7GM0YzitvZh7gfdm84Y4viiMHYYcztT9vtZ3CLc6UiXvs1zIN+2eqvGTzGM
 H7hta7a95V9nZzymRIebzYEX7Zjr60SJBI/idBKRUYQ8Kcw5qCBGd4Fp2PgSsNnwrHrF4CHMIN4
 vqNVgkzqe4M7gQNv/eA==
X-Proofpoint-ORIG-GUID: kC8LU3aNwvUc1pem2VCz2H9aUumxl8He
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA5MSBTYWx0ZWRfX06ukHLExXVqx
 vfpIrhqGiYK0x3nU6cyKqFvmvKN6UX4g6x7N3ejnMJrfiFYMPmC7ze2nLDFqkSXH6H92mpY93pR
 MRAFFxUwCiaoZojDLbx2OOudbgPwQ+k=
X-Proofpoint-GUID: kC8LU3aNwvUc1pem2VCz2H9aUumxl8He
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070091



Am 06.08.26 um 17:38 schrieb Heiko Carstens:
> Add __must_hold() attribute to vfio_ccw_sch_quiesce() in order to let
> clang's context analysis know that sch->lock must be held on function
> entry. This can also be easily verified when inspecting the function.
> 
> Without this annotation this leads to a valid warning when context
> analysis is enabled:
> 
> drivers/s390/cio/vfio_ccw_drv.c:55:9: warning:
>    expecting spinlock 'sch->lock' to be held at start of each loop [-Wthread-safety-analysis]
>     55 |                 ret = cio_cancel_halt_clear(sch, &iretry);
>        |                       ^
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   drivers/s390/cio/vfio_ccw_drv.c     | 1 +
>   drivers/s390/cio/vfio_ccw_private.h | 3 ++-
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
> index 1a095085bc72..ed9ca77c5b23 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -35,6 +35,7 @@ debug_info_t *vfio_ccw_debug_trace_id;
>    * Helpers
>    */
>   int vfio_ccw_sch_quiesce(struct subchannel *sch)
> +	__must_hold(&sch->lock);
Looks like this ; is wrong     ^

will fixup when applying.

>   {
>   	struct vfio_ccw_parent *parent = dev_get_drvdata(&sch->dev);
>   	struct vfio_ccw_private *private = dev_get_drvdata(&parent->dev);
> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
> index 0501d4bbcdbd..8db29519dbfd 100644
> --- a/drivers/s390/cio/vfio_ccw_private.h
> +++ b/drivers/s390/cio/vfio_ccw_private.h
> @@ -127,7 +127,8 @@ struct vfio_ccw_private {
>   	struct work_struct	crw_work;
>   } __aligned(8);
>   
> -int vfio_ccw_sch_quiesce(struct subchannel *sch);
> +int vfio_ccw_sch_quiesce(struct subchannel *sch)
> +	__must_hold(&sch->lock);
>   void vfio_ccw_sch_io_todo(struct work_struct *work);
>   void vfio_ccw_crw_todo(struct work_struct *work);
>   

