Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F208E36E46C
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272585; cv=none; b=jwBlAJuwALK6EY0Qa/7kFGHDnBbwFkxLK99NW3TUv1968E8YAyqdcxqHBa9nVZfiXjKGuBM8gKeeAURA+7v8N8QrzOSEimBHUcJ1Vv5c8TI9507UDRDSNyDKU5oPG00C+OtMQzdZDTfuc9c6nPhdOiEbXBBSfcMuW9llYtbym1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272585; c=relaxed/simple;
	bh=DFwy3eOms3uMytGi0Epbfu8xNsnTdGpbvGjBD+o7YY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fce4h3Oxat60jXQau6A2iJI7IrSfs16h5izmtOU18lYHdHTxrm80Gdo52MiZDGwqsZovRxHzNov7y9MlJ1VMJ+UKjecOwWpi4B/n7IOJGrPSqpzTaHEb6z8cb5/69I00Uu8SUNTPIWNZr1V1bZhcy/MFk2rXariB7wBwrX3l5D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MhCn0IFU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MhCn0IFU"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681DVXim3645028
	for <linux-s390@vger.kernel.org>; Tue, 1 Sep 2026 14:23:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=A2J49DPPlmX1UX7Kg9ZM2DWn9xUN38
	XnPJYbX3hsQHw=; b=MhCn0IFUorRXeTXc4ECQVn/v1Z8roc93Ft16fVniDsSMrB
	2ErT5O015pCOs1fD0K1j7ZpQKaRV9yI8uKymRcZPhWfT45Jzr9n5YyD1Nxg/1QSf
	kqOSRP7UX72oGI9Vn2gXP2r3z/yXxdydaCuyTgLSntKzRl3hDVJQKtIqwWC4rLrZ
	C6biHrAAuTrH60ZR3slBs1/tH1L//Zzma9BhYvqtccS7dYWKotnR9iwqt7KnphRk
	Endgto+cOsExwTj1bYiKttMpdJCH4i4ahp71cYQu9ZZ1tZ3BX/i48ggHl+Xq8FfI
	NcQhb0ce46xbJIuUBQRJxpPW+YJ8nJ7SXLTdd0uQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r8asq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 01 Sep 2026 14:23:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 681EBdSJ022151
	for <linux-s390@vger.kernel.org>; Tue, 1 Sep 2026 14:23:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccey3xev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 01 Sep 2026 14:23:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 681EMv7i30605648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 14:22:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B4A22004B;
	Tue,  1 Sep 2026 14:22:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2033E20049;
	Tue,  1 Sep 2026 14:22:57 +0000 (GMT)
Received: from osiris (unknown [9.111.45.16])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  1 Sep 2026 14:22:57 +0000 (GMT)
Date: Tue, 1 Sep 2026 16:22:55 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 0/3 v8] Add CPU hotplug support for PAI PMU
Message-ID: <20260901142255.152550Aa7-hca@linux.ibm.com>
References: <20260901085448.2260658-1-tmricht@linux.ibm.com>
 <20260901142016.14482Fc5-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901142016.14482Fc5-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a96dfc6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=1WMqsBvd7Ljd5YfwIk4A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEyNCBTYWx0ZWRfX5dsKQsxKbhmI
 ypxiC3LSUH7DJ3Dv78nv6LjzfpepVH9sGrVv2nBrkp2Kpu77bQeWou+P177BcohjP4bESZQIXxk
 85n/q2txL0JzUBba9NC1Rl4Ig5mHYRsh85BvpgecU/POlZWbYxk4i4XQ5iXPWNMvQNHDgfL+3Dq
 q8PaqqoYh9IgAqgAHr0l5L6HMvE3HnAdCkbWVvs2wZUQaI95t2VZ/GSji7YeR7BXflItX7nT0E9
 a9LeiEkwpi4WCgZv8tWubRi421qUQny0pqfPM50vw8u+Cvdor2iExV5/15O1YzjwHCOmkKl0wFl
 UKBzgOlZR3es9U4CwlQvbji3xwOzjlJkyxEDGPu6/2ZI59iLzO+5C39+1khxTCOcPyJijG0c+Hm
 uCSZMhSzFRWwc8eiG2Pjbqf+wVrXVsC2lYMGvoVJ8h+ESA1bDb+P+63VowH5Ba8gu/dkeQAFDFm
 zGgO2KBWhxDtkmzSFMQ==
X-Proofpoint-GUID: Sj6-fDgyf0y1eOliAkL6czLPmq7Ivh-0
X-Proofpoint-ORIG-GUID: Sj6-fDgyf0y1eOliAkL6czLPmq7Ivh-0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEyNCBTYWx0ZWRfX71+W3MyQlsxM
 o/qd1iF4ED2Pp0kaPEB6ZqcL/6Y7PZtF+0b3fKoTifjZ1d1IKP1b/RDOq1OIRAHsrVS8c7KJOVf
 Voz/kMpm562jHOlVcd90johdKgqmjpg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010124

On Tue, Sep 01, 2026 at 04:20:18PM +0200, Heiko Carstens wrote:
> On Tue, Sep 01, 2026 at 10:54:45AM +0200, Thomas Richter wrote:
> > Add support for CPU hotplug add and remove for PAI PMU.
> > 
> > Patch 1: Change function argument list
> > Patch 2: Move locking from CPU scope to event scope
> > Patch 3: Add CPU hotplug handler
> > 
> > Thomas Richter (3):
> >   s390/pai: Use PAI PMU index as parameter replacing event
> >   s390/pai: Move locking to event init and delete
> >   s390/pai: Support CPU hotplug for PMU PAI
> > 
> >  arch/s390/include/asm/pai.h |   1 -
> >  arch/s390/kernel/perf_pai.c | 182 +++++++++++++++++++++++++-----------
> >  2 files changed, 128 insertions(+), 55 deletions(-)
> 
> Series applied, thanks!

This was supposed to be a reply to v9.
