Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F262D3225;
	Fri, 24 Jul 2026 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886431; cv=none; b=l/Vkmnr1S6I3aNhOWdZcCRJc2OGXr64xp/SidxbHUubHONvvhYB+z+yRUzBV3pe44qzJ8ww6c9WtS7L/aAKzEYwwA4Zlr7H63dzv5fxLYTfbWLIYYZRyqt7+xQp9NyXkPKYDRxK0Lbgo7nEkqPSPY4JwQTSutZnGiuwMgGc1vtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886431; c=relaxed/simple;
	bh=c3DmkfQyv9Sgt4Vs1yvkHV7nPcS1vz4IEy4iQ5P5efM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKtcr1RAJoGw89DTHTFW6OnUD0vVYfVzr8YtnplV2UoFmO8BnMElAJ9Bj+yW+mAWeXyUNM9KWOLGOyUW3TzuZR2lvOA8lV5cZTsfDAdSLhSJC0QzDH9CrL7QP3g2OfZJzgO5HEArrO6xy/AuXzd2I/MTob3+DQBbME6dkd6Vy2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pCuq3dgA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pCuq3dgA"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O5Bpof797597;
	Fri, 24 Jul 2026 09:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=pKE5MDozAVwSHOXBgPxCf7ZEXlB1wl
	1HegXgHJ8Mq54=; b=pCuq3dgAC8gaq1dJg/zgqqN4sOTJ90CxlmNJ3y6zX4JrCb
	grzjb+fs7db3zNnqd6MbwXRmN3HkJ1SeeGj4wA4VwHUW/x9rx46irx7HOcHchLeZ
	AYVMRpY9ERSPmM9rnW6uN425H+JhnPncfHScwCKD/6TvhxwvdPQZOkY60QIfGw3Z
	sG8I4+AlYoX+RhdPYDgZwa5WlnAcpPFOB9sjAnAgLWXYJE5fyOdjcaVSmtz+erS0
	dP7xWAfgtwKkA6RKzGnRJKRneXW0avlEfgLyGLtIk+Y7zCC1xM4hFVvz6g7jBxcA
	7QR+yrs6VdfcbEGzyhlTkjN41LbYZLCUXE3qPMjA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gkbtv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 09:47:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O9Z2QW016260;
	Fri, 24 Jul 2026 09:47:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyr2d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 09:47:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66O9kuao16843152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 09:46:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63A192018A;
	Fri, 24 Jul 2026 09:21:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 077FE2014B;
	Fri, 24 Jul 2026 09:21:11 +0000 (GMT)
Received: from osiris (unknown [9.111.14.151])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Jul 2026 09:21:10 +0000 (GMT)
Date: Fri, 24 Jul 2026 11:21:09 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] s390/mm: Fix handling of secure storage access
 exceptions in vmalloc area
Message-ID: <20260724092109.22621Cbf-hca@linux.ibm.com>
References: <20260717092415.3039699-1-hca@linux.ibm.com>
 <20260717092415.3039699-3-hca@linux.ibm.com>
 <c10b144d-22fc-45f3-b684-2adf88dbbceb-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c10b144d-22fc-45f3-b684-2adf88dbbceb-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA4OCBTYWx0ZWRfX33rK1x0q2qri
 oG/4UHGk2WEXMPRrXjP6bTSfwwwhNoHTe4PsF4CCv6N9hn1R3O0eSuiixD/3l9I5JgNhSseZP95
 tX5/gXc6kwWRmtIZ3HTBfp8ssxw563CtvcV+nPFrM2KwS5Pj+NEaMhtJ44dY5hFJ+TlHbRpPBit
 ZpVmZT9sl+KcV8UBv/78TuhZuhQnk5nYvLvVguOLcAKQSo2jBS4DZiH67/ryQRkzi1KBHkyMFYh
 z+RZGuuiJT3Nm8rT2gUX+w1TjcKAwzgeOSrwzR5Mtk8G8v3Ne1JJbNZfmuCIh9aGnwDxCxcl8GT
 u3CMnmELlf1WUHvXABnkpZUcKBE20h6e3ncmRP4iQ6Y+KQ+NIPJj7H2uBrzbvlUJia8Zk+GhY/F
 a54KpJIclorPRQg3+PmeJ+umqDwQ/aJDvLkCi5i434hzvg7SFcAV4AxMKk0SmxLM5tRHH8RvErP
 BU+8O2B2xYO57wRcLlQ==
X-Proofpoint-GUID: owDUVBU__0nXamB7YcuXSBe67t5ubo52
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a633495 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=M4Z5KA4VDbPiLzJinsMA:9
 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA4OCBTYWx0ZWRfX/n+CpR2IZW4D
 PnIJ5KNdzOvQmwU6WGG0t/fCYQUYsSlObLJ2cJn1RS8iqk1BuIkcoko4GbweH21emqs9HaSKPTN
 YY17x4vSlUKw9HaWt5KM8K8e2vFq/a0=
X-Proofpoint-ORIG-GUID: owDUVBU__0nXamB7YcuXSBe67t5ubo52
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240088

On Fri, Jul 24, 2026 at 10:40:16AM +0200, Alexander Gordeev wrote:
> On Fri, Jul 17, 2026 at 11:24:13AM +0200, Heiko Carstens wrote:
> > Secure storage access exceptions in vmalloc area need to be handled
> > separately since folio_try_get() or virt_to_phys() do not work on such
>                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> virt_to_phys() is not called here directly while folio_try_get() does
> not accept the addr parameter. Did you mean just virt_to_folio() or do
> you imply something outside of the context of this patch? 

> >  	if (is_kernel_fault(regs)) {
> > +		if (is_vmalloc_addr((void *)addr))
> > +			return handle_fault_error_nolock(regs, 0);
> >  		folio = virt_to_folio((void *)addr);
> >  		if (unlikely(!folio_try_get(folio)))

I don't remember anymore. Probably a left-over from something else I
tried. Could simply be changed to "...virt_to_folio() does not work
on..." while applying.
