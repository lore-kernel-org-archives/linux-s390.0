Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE41A3BAD92;
	Tue, 10 Mar 2026 13:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773147963; cv=none; b=YjMh83Sr5oT7hlPVmX1FxaRHajorpGaneYzWrCWaFfwEMcL8shuhunMyjyxllEwNOBSF/gaf1xwIbpB3OahU5Pyj3bUIYP9iRZE346K/96C+NA8LpEWJSEwnmQvzR7qAUYK1s1M5KTKZhDz1riKtZF4cuZP0q7nkswhPswZurZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773147963; c=relaxed/simple;
	bh=Q70wPJHkxhNxMnxPUjwXORM/54hpNZtyyZoRSvtD2XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JImR8Ru36nIHHigiLFnbhHxgpz1/kTGrth+A5ivQFalA//PhJy1o9FOHcNWLnK9M6yp6S2IE2V1zr6nvyeoqahEga4iUEocPheO0MXS3pNVCUSTp1X8lI6Cqbv4mytWM56wUMCsZlzXqVKah0IlmEqY3PgAIWFtH4bGeQ9nohlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nWeXwdgG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nWeXwdgG"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A7FN481027783;
	Tue, 10 Mar 2026 13:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:sender:subject:to; s=pp1; bh=YzxURxAn+aP1foMUIRRSzMl
	t63Y7SSS6GSwZB1tY89E=; b=nWeXwdgGw2Mr6WSxXIRgOOS1xlMtwYJEWpdx3F9
	jjpVI9ZMBdkMNyhJLSze4iwuYu9NkgRA7FI3bYeb7lrPy/JeRh26brV1cy95FeKr
	xkHtBekdouTr1bYsYxZZhy/Y2H+Jmszt+mQd00hZeJjDg1j/2pIVKNMN5g0gXdyH
	wZjQ3x0BpmM8fe+W43cxmz1B9bYwkTQ7yP6iL3bUfB40a4JfNvLi7sRwiI598lDm
	wssfcBBWo/kQ3374Cv9L8IYNNTqXWxPA6AXEBPiY+1sSPWaxYve1p86s2gHvuFWR
	HH4zR1c/vJveB+7ZGw0x4xxjxQbHmm44GoL6XtMU1ss+dfQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcunakka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 13:05:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62ACJbOm025041;
	Tue, 10 Mar 2026 13:05:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs0jk0yu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 13:05:46 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62AD5hru43909608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 13:05:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE99A2004B;
	Tue, 10 Mar 2026 13:05:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD1A320043;
	Tue, 10 Mar 2026 13:05:42 +0000 (GMT)
Received: from vela (unknown [9.52.206.38])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 13:05:42 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.99.1)
	(envelope-from <brueckner@linux.ibm.com>)
	id 1vzwmM-00000000KKL-2ScP;
	Tue, 10 Mar 2026 14:05:42 +0100
Date: Tue, 10 Mar 2026 14:05:42 +0100
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Thomas Huth <thuth@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] KVM: s390: log machine checks more aggressively
Message-ID: <abAXJhjxah6NQZQl@linux.ibm.com>
References: <20260309115904.7280-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309115904.7280-1-borntraeger@linux.ibm.com>
Sender: Hendrik Brueckner <brueckner@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hff_WyBihgypk4W5al3-WPgiHarDf9v5
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69b0172b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=08poYBf3Jgh6VJZOBr0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDExNCBTYWx0ZWRfX3sE9FVsUWP6c
 Mz86ZnkCgYhQ3KNx+9o9XLW2VWTpyUg9x5q3UWqGMQIKTgLaPkxO3hT0tox0wmklNCkRcWe4AT9
 kyEDlBBZD5ZnCq7rxhSgAO1q5XsQ2/2M/ga6wEI4/NWGi6SzKYHJxCukT3aaWj9hTojP4XSWC+f
 5u1yVMK0kHEPzuw+g+GYaNEtYnn4doceFPx3+ls/gzozbBNhXhSTguD3qKURNsmb0nVuunP/dCM
 hCtNECNm4R4oCooR8j0KFw5n+sOiLhgsdiVFZt4YenTaTbSAH9O6I7+VuZNQtcQSqFxzAcermqp
 RBThrBLIr1mb9HPs8SkqZqu7O1G31fbeCn2yRqGQ6g2OADRCLaXdXAyyOWBaI/ZCcyp2opaYsBb
 QIh3dm8Wzorv6z5OpLJi/3ByJpi1wlikmQbNVXG8tCkxadRSyGL693vpq3i9ZHkOLdLOxn8RJz9
 0eyJgSBRyAJGUyjBsiw==
X-Proofpoint-ORIG-GUID: hff_WyBihgypk4W5al3-WPgiHarDf9v5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100114

On Mon, Mar 09, 2026 at 12:59:04PM +0100, Christian Borntraeger wrote:
> KVM will reinject machine checks that happen during guest activity.
> From a host perspective this machine check is no longer visible
> and even for the guest, the guest might decide to only kill a
> userspace program or even ignore the machine check.
> As this can be a disruptive event nevertheless, we should log this
> not only in the VM debug event (that gets lost after guest shutdown)
> but also on the global KVM event as well as syslog.
> Consolidate the logging and log with loglevel 2 and higher.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Acked-by: Hendrik Brueckner <brueckner@linux.ibm.com>
