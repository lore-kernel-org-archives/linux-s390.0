Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C973624D4;
	Tue, 16 Jun 2026 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608012; cv=none; b=pQU8P6Tn6/SQ+iC30cqpJAfIVCZai2np/ZzpT7lN+roZ9tjxjnVi3n3CG5fS1SNWdi5NBzoOCKni8Ee3RapmW1pzlI58xqmqcpvAmsqm3tjrrEo6mVOEtrPwSGVUwB1KCBWRzTbEI7TdEdu0AtcYjqrJ3XWsBNIQOAt7iaEL8DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608012; c=relaxed/simple;
	bh=6UVOu5e9C3oQ8jl11IlPgRgXFfBewjCTq88laiGf0NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OC/Pi6HVLHtr8eYWzq0/+LRFG76ov5uhOhn+RE9/cDbwvNr7LMErp8gPDHBzIFvz+xBtnD5CiasOrLxh9/zxEynrxB4E0k/9z6Iy/3Uxr7ZMSgOC+KH/uZmGsWSnXksNrRsp2QbbjkjjZNV76QEVvPiuoV4rV8CHRzzvENLOTAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jiIfjCWE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jiIfjCWE"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAIC0t1245114;
	Tue, 16 Jun 2026 11:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=6BSdilM6r2d/L2aMX47ZtgTz3VP9BW
	XOz1FnW+lwlAE=; b=jiIfjCWEokia3aw9Zm9Q+NLIvkirgVjPCq0MepfhuuBaNa
	t7YQ1BsALMuFbZS3IcFbpTdcGHL3njH5ZNsVYRnPCeDp1x6RtHdavgTeBUumfHX8
	65nstFCTQs8i3YSCg5cg15cSHzhN4ShEiutou83yv4dW6OABkmTBjdkoWnsmlqyG
	6ghrhreXzrqYQKxY6DEPakQ4UmnhLcTPlX7Qyh5WmDUY5ABzZFgAr1fY6IjJCYK1
	Q8QEU1yQ+n2u6cVfBodjSGNQ7373Zbww9yRKDZzGJob9PP/rtn06oE+I83KwAe0r
	7x7gh3/fS2N+I4x2/0B+748t7eWjjv3NHiQjIeCA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23nn6h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 11:06:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GB4htP025160;
	Tue, 16 Jun 2026 11:06:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4esm7y2rg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 11:06:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GB6ip238732162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 11:06:45 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCFEA20043;
	Tue, 16 Jun 2026 11:06:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BFF320040;
	Tue, 16 Jun 2026 11:06:44 +0000 (GMT)
Received: from osiris (unknown [9.87.157.31])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 16 Jun 2026 11:06:44 +0000 (GMT)
Date: Tue, 16 Jun 2026 13:06:42 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com
Subject: Re: [PATCH v2 1/1] s390/mm: Fix handling of _PAGE_UNUSED pte bit
Message-ID: <20260616110642.19835G94-hca@linux.ibm.com>
References: <20260615091741.76724-1-imbrenda@linux.ibm.com>
 <20260615091741.76724-2-imbrenda@linux.ibm.com>
 <20260615094300.31370D7a-hca@linux.ibm.com>
 <20260615123103.118af04a@p-imbrenda>
 <20260615115000.31370Ef1-hca@linux.ibm.com>
 <20260615140939.417dcb53@thinkpad-T15>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615140939.417dcb53@thinkpad-T15>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a312e49 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=CQ8FOgcp9ve-HgYGo4YA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEwOSBTYWx0ZWRfX7B0s3E15y9D2
 XzQX1fhIO0agM2OFPswrwG6gMV24evi0p5x1untCR0LlqpFxQu2PxZ2JyhsRNh8PPD6V1cKfWu7
 qMJvW4nPDs9gpARKcZDBtajOv2gJp9rn7VFKTTGuCCdHj1msZvRDAWRzP3FMJJTmf8g7Yq0Na3n
 l/F6T7SXUQhdh9Xre4C/qZf/QayEWy1G7U0xjrq9vkKT+KxcsIWzrel9mB1wjLPh7odAHqdjcZ6
 XT1Px+wFi/broFk8WSUtFMlvAin14du8tn4Z02Gi1Epo2ecr1XP8f1Ljpxo7Yc6/iway+UvuD6a
 Dn7Ui3/FKvHihpJbhlSw3Lj43WEZOHX8ub+LDtnO1FAfhmSqIR3fefU3eb7BUSnC1sdm0r5zGSQ
 AylSeQOAoFHQBxZrn5IT+U2Qq719VuvynMNx1VHh78BuLjZrBNO7A4AnGMGxVmTNkAs8jpN+POK
 REjNNKcZGu9SOTQOAHw==
X-Proofpoint-GUID: Yq7gcidqltZheSU_LmaukKEZmfGMyFdi
X-Proofpoint-ORIG-GUID: Yq7gcidqltZheSU_LmaukKEZmfGMyFdi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEwOSBTYWx0ZWRfX4nynyZXCVFBQ
 7j7+vZdRv7xqbswXP6ihsyHLBEiUlSWjIMcPR1i6zZkafTp41MiCoUMegUSxgFUD/M3ssSGiHMz
 gfaV4HC8QGrcoPvnk9f80suN7NFPXz4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160109

On Mon, Jun 15, 2026 at 02:09:39PM +0200, Gerald Schaefer wrote:
> On Mon, 15 Jun 2026 13:50:00 +0200
> Heiko Carstens <hca@linux.ibm.com> wrote:
> > > set_pte() is also used for things that are not ptes, and in those cases
> > > we probably don't want to touch that bit, although technically it is
> > > currently unused for present large pmds and puds.
> > 
> > I can only see huge_pte_clear() for this.
> > 
> > If that's the only user I'd rather add a BUG_ON() there instead of starting to
> > sprinkle the logic around. This _will_ break sooner or later.
> 
> There is also __set_huge_pte_at(), and there it could also be called for
> swap PMDs/PUDs, where bit 56 is used. But they would not be present, and
> ATM we use the same present bit for PTEs and PMDs/PUDs, so it should work.
> 
> Still feels a bit shaky, but in general I agree that it would be better
> to have this logic in a single place, like set_pte().

Yes, let's do that please.

> Also wonder now why we use set_pte() an not set_pmd() / set_pud() for the
> hugetlbfs "fake" PTEs. I think at least in s390 code we could switch to
> the pmd/pud variants, and then be safe against modifications from set_pte().

I guess that would be nice cleanup. Could you provide a patch for
that, please?
