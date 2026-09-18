Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D838F40F72D;
	Fri, 18 Sep 2026 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729179; cv=none; b=qOl2Y/O8o9LSH34F6A/doj5TN2JP+qoNe8rvHvqcmHuMoKSPfLdN0FutG6AUxFjBFwG5X3iGAXFzcPtBhX6VJ2lx5+GqFdc3NolDtdkZRuxVPylDXx7CO2h2f1AiKHLUQjIlNHrH6xCxJmywZirEpC2pLDXk7WxVgVMCoZX5TCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729179; c=relaxed/simple;
	bh=vXJghl3KuVg5da0+h8PVYuMxaAhPRp2LtVKVy8H6J0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCGiZxPEE/8xG2NKSHpvk5wq4dFYmPm/JoOEg+cEJS6VZT7ogdBZtWD5RtQ/zCtSMTwE6zRq/dl7orWFENKUoS8/kle6kx5fCvdbLO5PcxbRuvwLXQnb53an1Uxt173wkgwpAQNdK3X2eeAaHTUWinjlbC56cGh+e84Csn4CSYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rdc5k3UJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rdc5k3UJ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IA2mmK990986;
	Fri, 18 Sep 2026 10:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=tyclNKZd0pmegIgZMm4HZ9Jsc0OMjR
	iTPkuftcZ9UTI=; b=Rdc5k3UJfFI4O1agD8XWuycd5wdaW9mii3qq9Jj8FM3FQW
	OzVI/BhS8dYixNsIe1hFxbYHilBObPLM8m7GYXrQR29ZPQVKEsiojPSzrpDwHB/Q
	cQd8iUYqrbsncTi0hryI4QOodevy6/BJdpyCi6rFXBJUoVKcLYZCJH/lqwRqQIBJ
	a/qBnVWo8V0olbLVmqhZCGLA+RNHp+Q4wjm38KSV2SGxdsC9/AouF9mtaPp7XGIi
	ySN3ewZnONSGqclO4CdmqfKleys+DErrti3AopyHUxhdzYf90nHsF0S0A2Kt3Une
	9drQddkOv3u4uVEIGB8T9JETBHMrYOLNPpiVS7VA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcvf0sx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 10:59:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I9o4oU466604;
	Fri, 18 Sep 2026 10:59:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5xa6vqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 10:59:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IAxOOl51839440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 10:59:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40D0F2004B;
	Fri, 18 Sep 2026 10:59:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D190B20040;
	Fri, 18 Sep 2026 10:59:23 +0000 (GMT)
Received: from osiris (unknown [9.111.38.246])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 18 Sep 2026 10:59:23 +0000 (GMT)
Date: Fri, 18 Sep 2026 12:59:22 +0200
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
Subject: Re: [PATCH v2 00/12] s390: More this_cpu_*() changes
Message-ID: <20260918105922.20386E38-hca@linux.ibm.com>
References: <20260918084842.2333237-1-hca@linux.ibm.com>
 <aq0S_fKqcZ5WoLUU@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aq0S_fKqcZ5WoLUU@J2N7QTR9R3>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE0NyBTYWx0ZWRfX7B5OxZ3x9grj
 0reL+0oZaWIzANSqO3AxCEqTbB8NtmxFPe/eA61DHulbQwdH3iGPG3YKddDx6H2PHxvzL2AX5Ki
 JpAqEXF45Z05uRNzKyncj/8WGCzKyrY=
X-Proofpoint-ORIG-GUID: OVHJ8lGc11HoTIm5nWy3oZqy2o6LaFMJ
X-Proofpoint-GUID: OVHJ8lGc11HoTIm5nWy3oZqy2o6LaFMJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE0NyBTYWx0ZWRfX4/JkX9fA36Kq
 KKhuGdUP2A3pS9uItHxu196AzTaeYxyfdcmKks30f9GGFKTjhBbVHs9VbVR8SrkXh2+DhBFXntA
 9z5YxBstrTR2XIjeP6dXb8X2oJokqjEyYDbieNyyd6BQs+eM9Vu4ANeiSmZA8nxPZ1KFNJ5cfFZ
 VxCuOpyJmgxaQPwNSWU/XILTLeQqs/TlY0IR6JlWbGnWxKoSlqyQ3pI9wV7d24U+LHiZjY2j2t4
 C2gcEit52S1ycq3LFKKPn7P93v2a26A1uGnntJNVQj1/FhG+uPNz6pbCLlhsMUpP4YNGsX/ehI+
 J+BH6Xlc0jJ5Z4Mbl2RBeHdnXn/kLXtDzqcYdINkGznNTt3Lk+KqLtHHjSrpwXKU1x8IST4s/UZ
 JfugLiS2ifks5yEHpl9LiP2O+AkONBzeIy78/PzXGTmnQVa0Fqwpor1LIjwtKiOgOEG06RKHB6m
 jAU+QVgsGCrG4zWrtGQ==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aad1990 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=6EpOferOdSSFD47BJMEA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180147

On Fri, Sep 18, 2026 at 11:31:25AM +0100, Mark Rutland wrote:
> > v2:
> > - Yet another brown paper bug: Re-add CPU migration check to last
> >   patch. Unconditionally recalculating and updating the percpu variable
> >   address and percpu offset register can corrupt previous context
> >   register state in several cases (not only the single case reported by
> >   Sashiko).
> 
> Do all of those case boil down to:
> 
> * During exception entry from context A to context B, a nested exception
>   is taken from context B to context C before percpu_entry() is called,
>   and the nested exception handler updates B's live regs using A's
>   percpu register indices.
> 
> * During exception return from context B to context A, a nested
>   exception is taken from context B to context C after percpu_entry() is
                                                         ^^^^^^^^^^^^
That should have been percpu_exit(), I guess.

>   called, and the nested exception handler updates B's live regs using
>   A's percpu register indices.
> 
> ... or was there another case that you spotted (e.g. some case where
> percpu_{entry,exit}() aren't called)?

Yes, all scenarios boil down to exactly the above.

> On arm64, I think we avoid those two cases by virtue of not taking
> nested (architectural) exceptions during those windows, and by not
> applying fixups for SDEI events (SW NMIs that can be taken during those
> windows).
> 
> If there's another case to consider, it'd be handy to know.

I'm not aware of more cases.
