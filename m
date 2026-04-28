Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2A743E9C9;
	Tue, 28 Apr 2026 13:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383125; cv=none; b=L/08maGgZMGwIOR131R+0DfI3e20LQNf/0W4g7a9iVPoticp6PdptfRE+2TkqNBHpH3nnaG9Rajve7jVm5AhTEMhDcSbVQkX4iYZ4dsNcdoD/P0WtB7fCJgOciewcio2qXKtXSn2AR2d3yMB59O81Bj8TyPNdU8G/bErAoaWiKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383125; c=relaxed/simple;
	bh=vMPtvx3KxkEEMDJ/yB0h/G66zyh995Cxxnl9JIoswXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9MIDxO3cryrnD3PzMy5wyVmXZid7vHoJJjxHmTy3LkkfWfDz8ocwAeW+Tno0L8BqWXEgD5CZkh98IBIQeSjO0GNStQUkCxdJrtyjjehhsHkcBbQhQ7qg4FsMwhN2iEj/cRoZVVV5zNYVy7ESBvMQh8T9YS1YqoO9xprIOux1eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bABSFR3H; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bABSFR3H"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S6Gpdi3591721;
	Tue, 28 Apr 2026 13:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=zfaO7Bfpyc15pcAXJeY75qrgtUvaxU
	h03KKHQ45OvIc=; b=bABSFR3HAKEs7vXMwkMD1ceJ1PksxLgFmMOJbAn43tKIT0
	czKTzuK4CQyzuuVFO+Rj4klxfnFtKx06g0ZzBzVG4D4pxxEGx4Ed5wFcaPWf+bsS
	QVPYCEdnN98xsq6uZm8dpUTPcJvCbvTH5uo40iUas6FOEwI1x/ocN9lejZjpeQz/
	xyWoDI4JL9c34ShbwWJSgjr/FfPUuFAC8YQrJuCxR/HYfHnFEB+t/ozyRxYaQYKb
	I1I6YuTSVBDiguCTopoEjJsOhpPXZ/BgNlbrfN3i4vYKQtPwFF3YbYbXAswZf+jN
	CvEn9LxlmXaya90wE238olB3uufcw/nOiz8sgwcA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1dvkkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 13:31:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SDO1Rl005360;
	Tue, 28 Apr 2026 13:31:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xk1vew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 13:31:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SDVttE25166552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 13:31:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDDF420043;
	Tue, 28 Apr 2026 13:31:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 590CC20040;
	Tue, 28 Apr 2026 13:31:54 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.2.212])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 28 Apr 2026 13:31:54 +0000 (GMT)
Date: Tue, 28 Apr 2026 15:31:52 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Maninder Singh <maninder1.s@samsung.com>
Cc: hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] s390: remove extra check of task_stack_page()
Message-ID: <d61c9efe-7639-4520-b15a-ae0c19f418b3-agordeev@linux.ibm.com>
References: <CGME20260428105633epcas5p37a93b7abb3d2ce0d1c2fbf6a72634ea7@epcas5p3.samsung.com>
 <20260428105607.1283661-1-maninder1.s@samsung.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428105607.1283661-1-maninder1.s@samsung.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4xXWRQ-HI9A52Z6Kw_9_rzsWeWcdENDh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEyNCBTYWx0ZWRfX2vOgzERpI+8h
 vebEKj8AbVTEuS2lX/rEYKfHlSlDkDXseA74aucPo7wd9lHfAnZ6aT40Pj+5KBVVwtZCkjXrsTw
 je8Glgx2ZOE2DNFtU1l/8yaxQcuWePCkPfUSiTtF92WoY5WCWLNItN/v/evh6/fTB1BCf6mKFN7
 MQQWvjOXO7ZiX9QOtEMTmT+W+lzrO9Pb34JYq3JjUnfrWeLJBcj3FDf0fj0lsOIGt168N9G4Evq
 3yZgymgzEfKjC3ZDgXJPja7dxhDHaQ94CE0Fy4IU2nstD5nvYghvG7BkQCKDlED1KXT00MIq6tu
 fj/zo3JnPTB8xFaIvc4j/+bUeDmb07FW8qm2w0Vu2L1nUYiIAa2Rafz7tRhAmuVxj8fTWVLBmCd
 Tkg5JXonTDdKX3WD9d+RlWrgdz+gX4MOWusUyviLDiak1qN7UIetY7p1ex1455PHk01LKLUhDwY
 Wboih1A+VgYI3oObvXg==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69f0b6cf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=hD80L64hAAAA:8
 a=lkM_ilHB-wc5t3v_04UA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 4xXWRQ-HI9A52Z6Kw_9_rzsWeWcdENDh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280124

On Tue, Apr 28, 2026 at 04:26:07PM +0530, Maninder Singh wrote:
> There is no need to call task_stack_page(),
> because try_get_task_stack() already takes care of that.
> 
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> ---
>  arch/s390/kernel/process.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
> index 0df95dcb2101..dabd569dbba8 100644
> --- a/arch/s390/kernel/process.c
> +++ b/arch/s390/kernel/process.c
> @@ -203,9 +203,6 @@ unsigned long __get_wchan(struct task_struct *p)
>  	struct unwind_state state;
>  	unsigned long ip = 0;
>  
> -	if (!task_stack_page(p))
> -		return 0;
> -
>  	if (!try_get_task_stack(p))
>  		return 0;

Applied, thanks!
