Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DD74E01E3;
	Fri, 18 Sep 2026 11:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729338; cv=none; b=oGDm3WQhRYsUsW5Hpw/ruSvTn5pfAzuBl28eQ8FLzq8leC+tMN8su2SbSnegDTAfj6WCrehZ2bBLNOaADOvn/6d1sNW7Go6QubhYFD8ZbvLA2MYzOZkCpgIR1177MdQdJHk+JvYzi7f2fIPFA/MuQlFgbYafUDURWPmUGAFja/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729338; c=relaxed/simple;
	bh=6ewiep7ZzxjOZNesecxqH876ysSp9V8BLH626ueoy/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFkRaQYkBCDcPG8GZmGff+svxy9Jsyc26Yy3Q7HQ30xtiOcxaUd7az6PCcHIClAy5CdO5AziipHaBXp62n94RJ/9jAJKXPHArFPoUjHX4jmKzaQrru5NiV281jZKihU5XWksRw4l3DSyfTI4+pizNFXHm/Xxb1SKYkCmEYe+2rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W3703Dcw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W3703Dcw"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IA1T2w946092;
	Fri, 18 Sep 2026 11:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=suvHqJsTNyiojY+d/RJfUZwEOKQLY/
	yu5Qg0Rh4D8Pw=; b=W3703Dcw7MmZ/x4D2lGCydGqIRycDmVrYllNfuWmBplovS
	f40JJ/6WgEWcMyHN+bq+Yqmz0t2JIL8teRxrxSZtVfn/D5bvyg61JGGQ0qTxs2Jy
	Iw9VIUh015DS2o5lWmD4DfTonkS651k91Tz9sEed4/ZZOuBhOAyFb1V/Cm/XXeO1
	udi1AlLlIUTK3EtjaAuMuavNPAVWUyZwf4n+OVVpW51ZsRdLqLM5zTHXJkESyG/r
	KkTEuF3OZYAgWhjfYRV2loq6CdVshsNkuDV7igcetAMBPFyoAIc+6Y9laqhM9tGE
	H626VJKtD+rdeNG13ckfeY8Af4lWojhRrZUXtsww==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx847n8e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 11:02:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I9o5ft507516;
	Fri, 18 Sep 2026 11:02:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gra3yx2dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 11:02:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IB25Lb48497014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 11:02:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BD8420043;
	Fri, 18 Sep 2026 11:02:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D89C20040;
	Fri, 18 Sep 2026 11:02:04 +0000 (GMT)
Received: from osiris (unknown [9.111.38.246])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 18 Sep 2026 11:02:04 +0000 (GMT)
Date: Fri, 18 Sep 2026 13:02:03 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Mete Durlu <meted@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 12/12] s390/percpu: Rework to simplify percpu_entry()
 and percpu_exit()
Message-ID: <20260918110203.20386F2b-hca@linux.ibm.com>
References: <20260918084842.2333237-1-hca@linux.ibm.com>
 <20260918084842.2333237-13-hca@linux.ibm.com>
 <aq0VFSS_81QTKjcj@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aq0VFSS_81QTKjcj@J2N7QTR9R3>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE1NCBTYWx0ZWRfX8vN9k6tLa5tC
 qKN96gJU8XJCk6sOO3PyK5BOVkqOzaoLnPCDRRTNx3lFwRqOBwuTa2A/XvimcIj/pjP+cBKiazZ
 sxv7PHqvAUy/0oWy28nfCdz3iaK/Zu9xnye/q4yQHffhmlARcpwcrqo3yXmrZXDjCVe+d5yNkVh
 JCfeXoaaN1QKVqlVEcHqZUtf6TGpWH60gAi94BrZW+us8ZLU/s5+J0Fvv90GVD3SM2OWaikld8K
 91WmC8M2yPxhP/4BsJWoB/BAuctw07qOe2DI0mPNPbpIto1tC3RKKMwTZGPJyDpZAyHrhMGrveI
 2yo9jS5eJMwHravIyaxYJS/XXk8a7cwdDWubmfQYukyXr2kLN4AxFRKcZXfxS2gtEuFdfMfCJif
 w3XGsypLH5Gl1/aojhEordfa/P61yTKmh4ZIlwVMEF81ZiZ3fSYZ0htuRKQ2sOSxR2TE4Wap+ZP
 dACnnGImHgZHQOWnvuw==
X-Proofpoint-ORIG-GUID: YPTu6fwYnFyVPJY1As4Q9gTDvpW9foUx
X-Proofpoint-GUID: YPTu6fwYnFyVPJY1As4Q9gTDvpW9foUx
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE1NCBTYWx0ZWRfXwrT3tUHhEWw+
 TWrzPVaOTZB79Rn3G+wxXP1yAJOL1qs4yMcAlks5+zSs4xjfSrj5xlgeEWdwpX34KvGqitK6ymv
 HWh3ptCBrJbxBRpHGfJqnMBZRwnfreI=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aad1a31 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=xIGoFdqxBrF3HhsM5RMA:9
 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180154

On Fri, Sep 18, 2026 at 11:40:21AM +0100, Mark Rutland wrote:
> On Fri, Sep 18, 2026 at 10:48:42AM +0200, Heiko Carstens wrote:
> > +#define __PCPU_AGRK(regptr, regpcp, regoff)					\
> > +	"	agrk	" regptr "," regpcp "," regoff "\n"
> > +
> > +#define __PCPU_BEGIN(lcreg, lcoff, regpcp, regoff, regptr)			\
> > +	__PCPU_MVIY_REGS(lcreg, regpcp, regoff)					\
> > +	__PCPU_LG(regoff, lcoff)						\
> > +	__PCPU_AGRK(regptr, regpcp, regoff)
> 
> Since percpu_exit() relies on regptr being regoff + 1, maybe it's worth
> having a check here to verify that? Perhaps in __PCPU_MVIY_REGS() with
> the uniqueness check.
> 
> Hopefully that never goes wrong, but catching a violation at build time
> might save some future pain.

Yes, that makes sense. Especially considering that there was already a
previous bug which could have been caught at build time.

Thanks a lot for taking a look!
