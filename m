Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A393349B19;
	Tue, 16 Jun 2026 11:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781609944; cv=none; b=ZSbwO0bDnlBYRKxoQf1JBIGY2rAiZnDkMr4qsGxB2pyKi6xzloj+KSlfgwc5+mqg8xLRD0KFNBDZYA4HzGKlYHJVPsvankKMqPn8LQP4gO3WEq9os9WMdOOC8TYs6XHg3WWWtO8dFrnnB7pABLFe10GboVSfg8DxPjAM8CFe6vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781609944; c=relaxed/simple;
	bh=kibHn209etHEdQw+XiDdq6meRmKaK4KxA4ZmrW9+Eq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MurhiW/dfMdNUq7mXz+fm7rg9X6eZyR7WLOLWyws6dTdVqHZMOauZoQsVoY2Qb9LgAwcPAm11tby8RBx3Rw0oeBxbgJs6VE5OyZWqUX+ibiekhPPIjWIIWImiD5qE5kwl5m5DCgr1cW7yk4EpV/Sd/0RG6U8c2Cdxoz+BvJHIaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rDUO3Psl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rDUO3Psl"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAIV1u1156302;
	Tue, 16 Jun 2026 11:38:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=C3im/s
	5+IRxoAYnb6GsxB/vrjG1MT0WZJ5WG06cH3lc=; b=rDUO3Psl2I12ul1B655Ozu
	WeDF1o/Q3iJ5N0F14/0KxDnTB6gwEJkLWheXXVr5FHdbrKy0TiHBE5BtqlUgW5c/
	YiqrR0ZTboCquzQ1GPAY8j6sxQDLJAMt8gTYqX2MEC3YnXl9sPr8JGY30UGi24wH
	CAP+bFdVZrKhqf2FHtyAOOgLEKBEgfcOsy0cDp+9Tpt5Key3VqIZ+61MybjjJfrn
	vdD2XVklOR8eVdVVmjAZr17MHy4eeKdaU9xY8rel8/Ry4XoQOmAXB7EvGNiehw1H
	puOohWq/N+29zq5Ld9cL8zGPkfjnnKDhB9iGLa7uw+KvrDSXnVcMOXYrRvzTyE3g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1eg4u1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 11:38:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GBJcOC017579;
	Tue, 16 Jun 2026 11:38:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eskrgaw10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 11:38:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GBcskw32440758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 11:38:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6CF42004B;
	Tue, 16 Jun 2026 11:38:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6381A20040;
	Tue, 16 Jun 2026 11:38:54 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.224.92.222])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 16 Jun 2026 11:38:54 +0000 (GMT)
Date: Tue, 16 Jun 2026 13:38:51 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: William Bezenah <wbezenah@linux.ibm.com>, vneethv@linux.ibm.com,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org,
        farman@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        mjrosato@linux.ibm.com, virtualization@lists.linux.dev,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH v1] s390/virtio_ccw: Also suppress -EINVAL on device
 detach
Message-ID: <20260616133851.30c8f309.pasic@linux.ibm.com>
In-Reply-To: <2e543ef5-1aa8-4ddc-a68a-103c7bdfe58d@linux.ibm.com>
References: <20260612155407.199218-1-wbezenah@linux.ibm.com>
	<20260615002309.052e0614.pasic@linux.ibm.com>
	<875x3jn94r.fsf@redhat.com>
	<4d7fc371-4357-496f-9774-1f7a7c1a3091@linux.ibm.com>
	<20260615234246.0ec5d947.pasic@linux.ibm.com>
	<2e543ef5-1aa8-4ddc-a68a-103c7bdfe58d@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDExNSBTYWx0ZWRfXzmLPRw+8fm7b
 PftOMOYN2lBjrYKVy2ewutttD9t/scZ/c3H8OlHsZqo8ALV9zS/KNhNwcihPnJwbPh5W5Wle41V
 umxVYiYI78CxqnFnoRCiXIiJcZo3Qwk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDExNSBTYWx0ZWRfXzBIHmCJXJgai
 BIXRjyg/R3H9tHmC4UbSD2kri+LwvdqmQs70t8Ci2ToNSvOQkVnbMYzGoUolgX1RdU9TXyoXeOT
 b0SQ4OxLNeW4605GCnPgjc3T8rirJNfT15y+aVEjJqDQ1w+LPSWMmDgzngKCLcA1ovX4ciSUbIk
 qTWZ+3yK8cXK3weQ1o7mLReqmMCmhOFsVbnedaBM6tvzqUwkCgSBB9mJNq0PFOaryS910Pyq4uT
 3fFXUrIjXCMZ+fzh/++LqsOyK3I5xwUES9kJM8dPRwE3mBc9etAw9eVp1V7+AKIy2Sv5xz27trW
 2RBzaJE1i7+oAQnExWCeWmZCEZk9kP6qjHEfLNmlGg3yUCSZjkLWkwFThkJlTbiQgskckBUV1TW
 wWasDZzzKzKVFGb/kfSliI64g2kJEqqpMaYE1k/mDLi9x7P1qAH8fZQJlBvuou7bCNuSewLwHJG
 SawPDhECJbTRn08ba/g==
X-Proofpoint-GUID: eOURV6RVULlFqMq8SZSrwepCj8xxt8fo
X-Authority-Analysis: v=2.4 cv=NuDhtcdJ c=1 sm=1 tr=0 ts=6a3135d3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=gLCP7kfCjpCqMkl7GTQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: eOURV6RVULlFqMq8SZSrwepCj8xxt8fo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160115

On Tue, 16 Jun 2026 09:58:38 +0200
Peter Oberparleiter <oberpar@linux.ibm.com> wrote:

> >> So the commit didn't introduce -EINVAL as a new return value, rather,
> >> it changed the subchannel lifecycle such that existing paths now
> >> propagate -EINVAL rather than -ENODEV during the device detach
> >> scenario.  
> > 
> > I'm not convinced returning -EINVAL in the given situation is the
> > right thing to do. Peter, would you mind to chime in?  
> 
> I tend to agree that an attempt to start I/O for a subchannel that has
> DNV 0 should result in ENODEV rather than EINVAL, though the latter is
> still valid when a driver tries to start I/O on a subchannel that is not
> enabled for I/O.
> 

That would be a "programming error". I think it would be nice to document
that ccw_device_start() can return -EINVAL as well, and that the semantic
of EINVAL is basically execution of the function was not attempted,
because of a programming error. Or if we think that the list is not
exhaustive even after adding -EINVAL, we should state that as well in
some way one can program against.


> We'll make sure to design the fix for 8c58a229688c in away that ENODEV
> will be returned when DNV is 0. Assuming that this is the only situation
> where virtio-ccw's ccw_io_helper() receives -EINVAL from
> ccw_device_start__timeout_key() during detach, the subject patch should
> no longer be necessary.

I fully agree! With the semantic of -EINVAL pinned down to programming
error, logging the condition seems to be the right thing to do. So we
should keep the old handing IMHO. 

Regards,
Halill
