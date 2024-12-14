Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2635C126C10
	for <linux-s390@vger.kernel.org>; Sat, 14 Dec 2024 09:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734167917; cv=none; b=XpHRQReTIeaZJd+NX+2eJxXrt0q+1FSwHKmZ1FV+7nS6ZCzjjaU1Bovnv8OcYcnRK/kdwdb/jUWozm9bQ/Gj0L3zoE+NIXxwxfAxqpn/qOP6/7/fnH4peQyYk6jFkj7OzPx3Z0S7na8sZlcv9fRmHmk+Gh3zMYxJfVGnitlmjYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734167917; c=relaxed/simple;
	bh=fqllHZZPd0h2bIjPpy43/VddcIqh/5Iq0aqHycfTOmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8O2Ymg3NvKlxhJ4hghkQalJmmlhBCxsiCJhXb0J/zt4HHMmr4tq/4kUv3PDcyuwXo9emGoadqfzffPef8zSOw2aU6bYJdvDpCjxWe8wXd161+tNj0+UKJNh//F5I3fQf0rhKHOvOCwCzy/klnK0yGgVlY547NY6R+db6ccEh1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I/UmBmQl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I/UmBmQl"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BE4TRso018926;
	Sat, 14 Dec 2024 09:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=WcqJw9z8Xi2dAQdId8Agf80AKwGPMv
	w7TFoeRY/+4Ac=; b=I/UmBmQl2elfBnta0fgFP4KIKPmTOS87BDuXUdfvunjUzU
	DBFBiHewXvraVPVJ5BdH69F0phsAI35o3uk4MOYsA8hTzNWlCoy2sWcMDHk4czB8
	GKnSSr9Mo95tanFUfFCSwycT6rCTRd7OCfAViIA35B+EIg77u/zAt09TI906NQ0U
	s6DmSCzPQa1l+MwQTnQsRxoU37BoaXvPU1ukkJmri8nX462n+feqUPUaE+U2FCPJ
	dMsZCYg9VdWV63zsb0/9h7Mfi0FniTZQEN+4nsWlZncS/AEQ3Xg5hMCoun4p6cl2
	oXaa/MTHMgHtbMfq2zKuQ1r8TqTLcQgCFPpZ1Dzg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43h2gb17v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 14 Dec 2024 09:18:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BE7mNOJ032734;
	Sat, 14 Dec 2024 09:18:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0pt2mtc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 14 Dec 2024 09:18:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BE9IIK434996732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Dec 2024 09:18:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E91A20043;
	Sat, 14 Dec 2024 09:18:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6128420040;
	Sat, 14 Dec 2024 09:18:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 14 Dec 2024 09:18:18 +0000 (GMT)
Date: Sat, 14 Dec 2024 10:18:14 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dafna Hirschfeld <dafna.hirschfeld@intel.com>, linux-mm@kvack.org,
        muchun.song@linux.dev, linux-s390@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: change ENOSPC to ENOMEM in
 alloc_hugetlb_folio
Message-ID: <Z11NVjR88-mxoDM9@tuxmaker.boeblingen.de.ibm.com>
References: <20241201010341.1382431-1-dafna.hirschfeld@intel.com>
 <20241130185121.02da011be898052454116c4b@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130185121.02da011be898052454116c4b@linux-foundation.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LXEOui7LmHJ84tox0LpDxDn1svrhYRcq
X-Proofpoint-GUID: LXEOui7LmHJ84tox0LpDxDn1svrhYRcq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=651 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412140074

On Sat, Nov 30, 2024 at 06:51:21PM -0800, Andrew Morton wrote:

Hi Andrew,
...
> > -	return ERR_PTR(-ENOSPC);
> > +	return ERR_PTR(-ENOMEM);
...
> err, yes.  ENOSPC is for disk drives!  I'll slap a cc:stable on this
> fix for a decade old bug.

This fix invalidates the comment in hugetlb_no_page():

	/*
	 * Returning error will result in faulting task being
	 * sent SIGBUS.  The hugetlb fault mutex prevents two
	   ...
	 */

The problem is an attempt to write to a MAP_NORESERVE huge page (as per [1])
causes an infinite page fault cycle instead of SIGBUS, at least on s390:

	q = mmap(NULL, hpage_size,
		PROT_READ | PROT_WRITE, MAP_SHARED | MAP_NORESERVE, fd2, 0);
	...
	test_write(q);

1. https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/noresv-preserve-resv-page.c

Thanks!
