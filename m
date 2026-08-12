Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB72140DB4C
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786527792; cv=none; b=GnSXKPFXM0I3DbC6BLYUpl390Yj4sJsthCazzeMPNs7lFqIpjjMVkW4j69tnus1BiGDZVvZNR8+3NMIyZ3oxWo4hshOWwGqo0Ckfiym6G0JN8+nwd0VHa4zqri+Wb9olNrlbJ2Z69OXz9wKqEU59nB2RO0sB4snmuouIjRTNcpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786527792; c=relaxed/simple;
	bh=YBZv3HsD6nZdkvpRZoqBrPYmga5XAosw5Ssi3DwYcow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lb+5GwHNrn7ErDWRXTfN821x3hGEmBxm6QP7a8cN4iMCYFWY9uKGQmGYivVwsJEkxujwTnvKA8m2OewUdMUOwDPpz7Dg6nHvNjSTUtRD5JETraGKtNnsHNpZ4weZ74nUoBSZ0EdxhiOCD+vFapLXm11yxjFTw9vgEv/bnsBJXBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cFdjdg+V; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cFdjdg+V"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C62hxV2631855
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 09:43:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=cdBlUH9XnqPQUp7L55csSWgxv3B1Np
	1DphRzlk+HHT0=; b=cFdjdg+V46NACik3xJTrut/UrIo8R8sJ3REMK1ixznuYa8
	d1HSjje8gwXNEF2psY34pq7NRuoLzhDrt4tvLCqYW2V44H4/j+f9VbxqLmbO8Pjo
	uPbrZK4e527iF1vInS+AxGS7kqqn/nr5r3a+o1yDXNoQVd4WXD5rjbsUo/dm679D
	sjYCI1U6Me8R1jHlI+BRB6U0JPT1ljRbcVeNS+JIU72dHdByCbotNl0UOVtIsWcJ
	EThfC4QpRfrdExyY8Gw4gEYhFS0CRA6ODj/ScL81lAU7PGN6rye+Bb2NsP+JB1Jz
	UkCRqPu4ogNi9aqmlpqCPvIOEt/PtemXCWQXFdeg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9hrgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 09:43:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C9fglJ032043
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 09:43:08 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gd9r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 09:43:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67C9h58w29163928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 09:43:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3113E2004B;
	Wed, 12 Aug 2026 09:43:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB53F20043;
	Wed, 12 Aug 2026 09:43:04 +0000 (GMT)
Received: from localhost (unknown [9.111.41.232])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 12 Aug 2026 09:43:04 +0000 (GMT)
Date: Wed, 12 Aug 2026 11:43:03 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, sumanthk@linux.ibm.com, japo@linux.ibm.com,
        agordeev@linux.ibm.com, iii@linux.ibm.com, hca@linux.ibm.com,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH v3] s390/cpum_cf: Handle CPU hotplug via prepare/dead
 callbacks
Message-ID: <ttjnhnr@ub.hpns>
References: <20260811133901.3765063-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260811133901.3765063-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UYh3Uu6SwIX-j79Au0YhA95LA7vVY5dJ
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7c402d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=i6DpusERV0AH6cNGrsoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA3NiBTYWx0ZWRfXwqxIY5PrLO20
 32FBMx3x69Bng1xu9Jy/yTV3HzjPdwq2ZF2QGFPkNzDJr1ttkwawZsV0ncR7DD/m48IQ9IXStUM
 kuugf8EvevtFciHtKlqYgC7hKub8LiGlDLaEpphDEM2eHAfBG1H47g3BLPqf0I4vZ9X+qcD4ACg
 mVwe8D73wUgtet54EppG57pO57EY7g2zMMPyzX3PBUCioqtf7Ycr2qwv5SGMcvOlMfl6ZEYGlZb
 DO/gHKZRzOG6DuFt2LdiYIdeuF1iikxYKLkLotiG565rK5cs4HZ5Gta5ADm9oYZIJMk5Elkovii
 YRJX+Xlr4ieC2KEZSop9H2v5+VDKtfy+ioUoHwLEBQ+5JoDdbCwI/4iGftOOeCgOL3QC8EXVSuC
 pJcSxLJ5XjX2ebAy48u9FITrOL7BO2JyxqRQ30NUnECrJeqcYSeYD4JVlbEdAd4HBUWONtfUVlv
 fwQYeg99FQd747VyMYQ==
X-Proofpoint-ORIG-GUID: UYh3Uu6SwIX-j79Au0YhA95LA7vVY5dJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA3NiBTYWx0ZWRfXwOq+hphTLreC
 FDhIxkNtwZIuZ93fjmTBxbsfnXPSoykmJYh487BNWrJJF6Y8zNNR+gBR+YE7X+7czt8BrWLYG3J
 H0hZ+2mG3TR4C84Ye7ePNucyjuNWDaA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120076

On Tue, Aug 11, 2026 at 03:39:01PM +0200, Thomas Richter wrote:
> The command 'perf stat -e cycles -- <command>' crashes the kernel
> when CPUs are hotplug added during that run.
...
> ---
>  arch/s390/kernel/perf_cpum_cf.c | 215 +++++++++++++++++++++-----------
>  1 file changed, 142 insertions(+), 73 deletions(-)

Applied, thank you!
