Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8FF3E1D04;
	Tue,  2 Jun 2026 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780400162; cv=none; b=FvFLepZDTJKEDiC4+75rmO0QsbnnjjnEZwtwK7CYrnRGKyEsgpNcXGfrnTioZqvmI3fi39Hb39P53jKyAGXhixT5s6F/OYDaSXqvOZpSiRZzx2L2NYoXGNPqzErXcwfIky45vMPQ3iXXw+SVPqnT0f6Q2vngx7+wzLie1IRA1KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780400162; c=relaxed/simple;
	bh=uOeAs6PNxClhv790oIeghpHjWPmDzY3+LvNh4zeik3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXsifN46spixXARmrTPMM2zSVS/nSjpY1ZfeEYWZltwziK3fCBdhWm/N/lcTQweSAf29OmU072IZioRmBkK7BGY+hLqgqQQRWW6bGqeKVW9+pBgLI4TBoWkRLcBo4nl4VoWy0APolemkxeObZ3KW57GFwv4kw62cXkmDYKnyJbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sHss0WsD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sHss0WsD"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652AGCxJ3167126;
	Tue, 2 Jun 2026 11:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=tOmR1vOesjLPcVrI2tu5zs3qvpROL1
	PDpisyVVSTQY0=; b=sHss0WsDHd4onZqObTCgCyKf+FBgTYOXnI8XxOWtN/M9a+
	HwwRkhCgfBi+EmgeHqnvnnVak8cL7v/fAujhfCLgYKy9qTa9viJPVkiCAgdrmbNG
	biNmbmAPE+UYM3jPZXinDyMUiamremmh5dQt1DOHTaro9znSpUCK6K8jr092HenR
	srmh/4Zkroy7Sop36Z5VsU38yOo4hwwxK3Ez3nIz1szZfLWT1oCBo0usSyi6NcfW
	DqKhDpncKFs1u0iKgrXKdFZUwC2p6LVxnT7PWkCKiGACfaVSMCPfV+uf/kb7Og/3
	W7fSlv/H8k2Qev/gaxfbR3+McgrK6jahfwKp1y/A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpae59ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 11:35:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652BO5hR032368;
	Tue, 2 Jun 2026 11:35:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegjs6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 11:35:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652BZpGB50528606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 11:35:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6C442004B;
	Tue,  2 Jun 2026 11:35:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 374C420043;
	Tue,  2 Jun 2026 11:35:51 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.22.2])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  2 Jun 2026 11:35:51 +0000 (GMT)
Date: Tue, 2 Jun 2026 13:35:49 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 5/7] s390/percpu: Use new percpu code section for
 arch_this_cpu_[and|or]()
Message-ID: <75272029-7493-4f2e-ac81-f2b34ecbb744-agordeev@linux.ibm.com>
References: <20260526055702.1429061-1-hca@linux.ibm.com>
 <20260526055702.1429061-6-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526055702.1429061-6-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a1ec01c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=Uf8H4jbf-KhpXj35GBsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Dymlvks6dFer6TLbyVmOx1kkjDmKUhyE
X-Proofpoint-ORIG-GUID: Dymlvks6dFer6TLbyVmOx1kkjDmKUhyE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDEwNiBTYWx0ZWRfX0Jg3CpF1ouFM
 zhaIiOK7djJ4czNj5CasnkKqQtoRxz10WIwG2iwd6XAEdWSREt4DCtNZET6jEDtiVnIWx18o7zY
 6QkQy3t66waIj4fmh51uGBUqqBC7MzgThgV8lZGmoKMNkAYVz4nu5Uy5QEENBVvS8BZDWuababd
 F1e/claInxrCo28Y8onTmRIj1qT+43bdnX+MXdJ53BfjYdqtfqmYUbrQ7/xrETwn+nizen3KqGA
 q/mWFCulGSg56mPjzdCsAfWDlrMIUMCqAksVoPjvv9zXJN18rzsNyS0GjcM/XChVKdl5XkfP/Nh
 x94vYtsij9X3JqTE0pd6RNXHswTCdOG1OtRsz10UzmLioh4nkGYTX1YkXAOkTrp4bxpV0ktVqBT
 TAuKMOrs8MgJ3TQZVk8gU9kzSXyyJwmw1j87O/d1jhThJWfqlmM8ypNpdzqQDtQwEzMGDF1kXFo
 QG9erNTeZqHuES2Fe1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020106

On Tue, May 26, 2026 at 07:57:00AM +0200, Heiko Carstens wrote:
> Convert arch_this_cpu_[and|or]() to make use of the new percpu code
> section infrastructure.
> 
> There is no user of this_cpu_and() and only one user of this_cpu_or()
> within the kernel. Therefore this conversion has hardly any effect,
> and also removes only preempt_schedule_notrace() function call.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/include/asm/percpu.h | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
