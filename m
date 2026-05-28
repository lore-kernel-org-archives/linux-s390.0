Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8523ED109;
	Thu, 28 May 2026 14:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978656; cv=none; b=J/vKujPWZeyvKbXyydK7b1BMVn0KYtdc/qPUNWeSabeoMAn5yjaQcAxtyFrq81kuhWSTg+iqkk4KTdualsrax5XtYCjNujrhEZ65Dera8NAJcR3TOQManvQysmsjyUm725OKnHcvWm5wObp5roydKJHfcl0j7PuxysNmoEj/zXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978656; c=relaxed/simple;
	bh=Oj3bsTvaRys66blZVuiEJr6+1+OJRLh+Q9fn7DUnUP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jt2SJRQfNskhBG6gjBOVSq7QsjNp0XlqYZ4QMVfUovQHPy8pOtZQSc4aYtF++YQdQ4v5UpSLamQHgk71Edw/UIINxT2RHLVtKnxG1KqO8lZI6ISn50mt9fzS1BhAJcmyjLcL+V6QZaq2e9aI9CqFxYh2U3qr7kO08wVqtV/W8z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H3AZPpwU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H3AZPpwU"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SCROhn2479650;
	Thu, 28 May 2026 14:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=QsqDsY1NrK7VRWFqbftBylBJ8QP1P2
	YIVQ8OKMQC9Eg=; b=H3AZPpwUvdpBklLeXnVusk9BRo2KXBzTH+2CM64rgXsTg7
	7or7eOWEh6v63juSc5gwlPXjs775JmD2O9vb+QrI+8JMl5UFEivg+slYzd9hrTpt
	CtzjZMTCD2TBI/A9ecxazawomqWZ2vOBuXF0OED6TcHqML9Zr1toEtYrC1iW/vt9
	If2UNPeFzy+NFheMOGX/ua1Ntxsfl+SuxoSQQ9BYgC5PNsj7ItyubWalifS4Vjql
	p+mSjaadHGTbT75Ptqq/mcUzPKN/lTKAvz6UPCDNKPMAcSfvV+9hdMljivKU0TR5
	RL+oLWXx+ksPrPcCVPDacG3WfnKvctg07VLqz/Fg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee886bgty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 14:30:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SEOQfX031571;
	Thu, 28 May 2026 14:30:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb8gx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 14:30:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SEUdmn29557002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 14:30:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE5D62004B;
	Thu, 28 May 2026 14:30:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18D5120049;
	Thu, 28 May 2026 14:30:38 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.54.90])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 28 May 2026 14:30:37 +0000 (GMT)
Date: Thu, 28 May 2026 16:30:36 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "Oscar Salvador (SUSE)" <osalvador@kernel.org>,
        Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_vma_mapped_walk: Use ptep_get_lockless() for
 lockless access
Message-ID: <07baafe4-7d1c-42b0-9103-3e5666770061-agordeev@linux.ibm.com>
References: <20260528075507.1821939-1-agordeev@linux.ibm.com>
 <ahglqif-I4TjFK9X@lucifer>
 <ahhNq0pFKvSKZQbR@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahhNq0pFKvSKZQbR@localhost.localdomain>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Kt87eysoh7DYALPhN2Lv2zuqdzePaw-c
X-Authority-Analysis: v=2.4 cv=Z8Dc2nRA c=1 sm=1 tr=0 ts=6a185192 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=tabJ_l0G7vvt5ToZ1lAA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE0MyBTYWx0ZWRfXwyKYNov82R+3
 ogg5Y/eFgIy2zeyn8OBaGpldKVycXmwhU037w6W7THqhh37mEKaNxEAxNHguMRe4E6PLe1yptak
 b9aePKjEWnQUDymYY40W3+lePCmAMXhjNp0ZKrcQ+yKFRADV6iVsj3/y/PUIAJVVvec5O3KmOk2
 dQMGoiMTg0ZYUvhyXf0zUKuOhBlVXR+kG5ltn0JzwfhbHzzTdASUurEAXSSWhpW6W9gU6uHGNHA
 PeQ/2pbZu89maTojBsnNramkA+b2Jq4YfkRVi8UnILW1UBVYHyhXlByljIDiyUz39/LOImBD7xa
 eO0RL+a+1sgj8Rbo5elCygEwyiR/rIgh6mjY0XXfSZkUdFtPM/JFGZJbqmFT14vHxxhvDFKzWaW
 dEtJEI1icDZq85Q+ICT66PtfXxx9KTRutpAM3ZnviNzESYoyQxP9NDUxHl7mZDZm7sHzsL9DS9k
 YOdAiJ6Kt1NRulFss5g==
X-Proofpoint-ORIG-GUID: eoGu_O8F5vnm42UoxVe2EIZn9XCmxJp0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280143

On Thu, May 28, 2026 at 04:14:03PM +0200, Oscar Salvador (SUSE) wrote:
> On Thu, May 28, 2026 at 12:24:35PM +0100, Lorenzo Stoakes wrote:
> > On Thu, May 28, 2026 at 09:55:07AM +0200, Alexander Gordeev wrote:
> > > Switch from ptep_get() to ptep_get_lockless() accessor for
> > > PTE reads when no lock is taken.
> > 
> > This is an insufficient commit message that's just saying what you're doing,
> > which isn't very useful.
> > 
> > Please explain why you're doing this and what the benefit is please.
> 
> Maybe something like
> 
> "When not holding the lock, there is a chance that the pte gets modified
>  under our feet, so we need to use the lockless API to make sure that
>  the entries remain consistent during the read."

I would gladly use this, if it makes sense for everyone.

@Lorenzo?

> Only arm64 makes use of it though, due to the contpte stuff and being
> unable to do it atomically.

Thanks!

> -- 
> Oscar Salvador
> SUSE Labs
