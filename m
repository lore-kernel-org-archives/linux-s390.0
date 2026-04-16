Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DC333D6FC;
	Thu, 16 Apr 2026 05:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776318702; cv=none; b=pZe8Mfiy6VCEEQZ/BDLSi/do8DGeizGryWfQ2HNb+6PENg84a197QRuxkqmLuN8tQbnewYHontJtcWImTp4cPXEzY6H8e27lMjOxP8Di689Hj5LSifDy4oe6s2B/dPYUSumIypbD6FU1tRHIJO6CBylLr2OWSqfmrPqsZJ9kw44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776318702; c=relaxed/simple;
	bh=D6MNqmfa+ryzkLE4j+bQy1XSqtXdyOPXVN4Ne49PevY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iigXHAEdLsHYopX2ShcwvnluIaCQXlmx7DoOTMA9Lm/awQ5N03wd9LH6rFlXI/tc6YI83izjgKb7GmYSsyKQxfXZ4KblLQnIillvr/hCBCS9eZduM8CwMXbreDXbAxWouzb8NWKCPXZverddOx4kaZrMAGe+9KptOK1ot2uELRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sXHr8Edz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sXHr8Edz"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FH5aTh1834640;
	Thu, 16 Apr 2026 05:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=U8ZRn9J58C2tx9KmJMMxW40X0fA9L1
	IY5FebFkKSNqs=; b=sXHr8EdzAdYtC7Dy/MQGRJ6gCJmuB9HC5SfiA6Jov2hRn4
	BpUtV4s4rnevLNx2lfedSMiq/7cxZ/lATxTtjcKi0cG2DzWtGXklAHTapxDm2+ec
	wtd+Bm81Fu7phUj73Ll2w5PC2FCCBEhA6LDmJVdBKp8cAGxZqvpnxkSmdYIFN3BF
	D5UnWHaJX3NcKQ6jqwjcSP/zCK9/Tc8lBFZib4Fk+2AiZrnIDnEseBOrgcx//0pk
	6Y3zQysqvD7cTBfs44kRIC9gnzrVx/joAbxDYc1YYfWn4j0dMIraNr6y8UM72k35
	qSOeT5TharBdevNzLxWs9ue3b69gmtZ6x/c9YdDg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89rkv3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 05:51:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63G2fCnP003299;
	Thu, 16 Apr 2026 05:51:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4djbh935bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 05:51:30 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63G5pRqs8585520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 05:51:27 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34B3920040;
	Thu, 16 Apr 2026 05:51:27 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79A1F20043;
	Thu, 16 Apr 2026 05:51:26 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.42.253])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 16 Apr 2026 05:51:26 +0000 (GMT)
Date: Thu, 16 Apr 2026 07:51:24 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] s390/mm: Batch PTE updates in lazy MMU mode
Message-ID: <140b7365-e3c9-4bbe-ae10-15332ab97b62-agordeev@linux.ibm.com>
References: <cover.1776264097.git.agordeev@linux.ibm.com>
 <924c91e711e8b16470eb2af7e31d0b6ffcf2940c.1776264097.git.agordeev@linux.ibm.com>
 <20260416054045.10407A20-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416054045.10407A20-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA1MiBTYWx0ZWRfX5pIGN9vk30we
 dEdDpjHcN3OtZZhU9RR6MeNf2QNxxFkV0hzShlf5P32vZ/72MVdRnUOWgAxVNPplaFNcT7/QSIj
 SY48LJKBDrMU+HVnn0iunlzFd4dEWGN9mvCyZfloITf19pxIuel2ViUn1UuCcCuKrtdT0Ha01Vg
 /OuqiETY1NC9qBcwMWOAXzx2f7kI6n2ofhS825l2tlzwjHweZCOHZAcj8zNOnh3yMq3k754+rfg
 FflZ67AzX/ZpvN/HkPVVwt8ZvutgINT6fmLfnla0yRzg3kweZL/aDR8lAttzHHfb5XAV7DWrPnb
 9CmmK+3kTHDLOIEXy2AXfgmT9z2CV1ml7G2+4rl7ojVbARA4EdhLNc0oOYLSQiRRCT3dgfIntaZ
 J+ZHcjZVXsUbhx9dTS3Y9MUckE/QT1hYqjEIRXjIjJFs0m3hBFva0/ZvNhwnXzDL0zVo2QTos/G
 7c5UeehORU3RaYMGSgg==
X-Proofpoint-ORIG-GUID: UEg3ZGRPSaxBIgycQGOzLqPcS2ClwgUn
X-Proofpoint-GUID: UEg3ZGRPSaxBIgycQGOzLqPcS2ClwgUn
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69e078e3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=glRYRA6g95Ob0rDooU8A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160052

On Thu, Apr 16, 2026 at 07:40:45AM +0200, Heiko Carstens wrote:
> > +#if !defined(CONFIG_IPTE_BATCH) || defined(__DECOMPRESSOR)
> > +static inline
> > +bool ipte_batch_ptep_test_and_clear_young(struct vm_area_struct *vma,
> > +					  unsigned long addr, pte_t *ptep,
> > +					  int *res)
> > +{
> > +	return false;
> > +}
> 
> Why does this depend on __DECOMPRESSOR? Which code in the decompressor
> would generate a call to the ipte_batch functions?

Any call to ptep_get() or set_pte().
