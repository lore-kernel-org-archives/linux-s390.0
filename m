Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9442222B2
	for <linux-s390@vger.kernel.org>; Thu, 12 Jun 2025 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749719151; cv=none; b=oWnx8XFg5j1NJmVlMNU+LSqmYNRqgsL6bqvSGtAlLeGe5WW22ZcOVmXAYC9MY3wW6utB5zjRl3McsFyRo1eHtI4nCfx6SOpOowGYcNvadAuR0rjVFKw6U3kVsQdKsQJedZc7M9wW0whdu7aia1pKyo7tLXK4wf2SGnHtnRRfiSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749719151; c=relaxed/simple;
	bh=KYnjS+TDUvrkjamcM6m/LkY9QeTWKJW4YgE0bkWCsMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZP4TtOENhXzJFw+pfR9aWsT5DzEcG3owtS3zEGFbgDzFZMWmKJ+jxerpJBMVvfLKkBIbciqNufWxy/thnKBWIB/TP+XnLGZz/92NG3gObQ5njEqjeOHJ1+9fnM/rzZpanWL7CXKzGydwwMVIlTiUyEsfPp+H+1K6tpIggORHjUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nbF0j+A/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nbF0j+A/"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C06voD026302;
	Thu, 12 Jun 2025 09:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=k06bmJ
	I+HRNvL51Xe5qLhxpC0o7ZpQSb9J0ZfcKFeqg=; b=nbF0j+A/QoPmHo0bPPmxfv
	GUmZGTZ/ZTD3EVph80cTZVuPCdcJoLvfZWu5NAzk7HgzFfkU9Lx8OQ442mLrOxWB
	N2BsGDjw2wY7oNmHe5zdC60gmCR/EfMe825AoLaIgpPPTNl1mZDuBoPVLeyRKAuY
	wfvEDwFCHm93/MmwAN9i1GjnIdnYgxKvU75ELIsa5sDfkoPOkM7m10ab84e73WgB
	skNqcIlLdbeKgmX0aiBHWc2xPJ1CzVZ4Km4//WPw6rpDWvx66c4GyqcMzPxPKH0m
	uTL0pYrLH6E3tx9p5H2CPsUix2sJ2HA9VSdlL7wlcs4+GjjrbgOF7KVov933UWlA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474bup9jus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 09:05:39 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55C8lXht011540;
	Thu, 12 Jun 2025 09:05:38 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474bup9jum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 09:05:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55C51Fv8015184;
	Thu, 12 Jun 2025 09:05:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 474yrtm7g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 09:05:37 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55C95WS442926468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 09:05:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2E432004B;
	Thu, 12 Jun 2025 09:05:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7C7720040;
	Thu, 12 Jun 2025 09:05:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Jun 2025 09:05:31 +0000 (GMT)
Date: Thu, 12 Jun 2025 11:05:30 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Marc Hartmayer <mhartmay@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc: Zi Yan <ziy@nvidia.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
Subject: Re: page type is 0, migratetype passed is 2 (nr=256)
Message-ID: <078e6415-d779-4658-aa6b-1fba5fadc0b4@agordeev.local>
References: <87wmalyktd.fsf@linux.ibm.com>
 <1fc8eb08-7e34-4b16-a08f-c81a531ec3fb@lucifer.local>
 <A82049B8-B1B5-4234-BCFA-55779F76EDBB@nvidia.com>
 <20250512171429.GB615800@cmpxchg.org>
 <87zff7r369.fsf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zff7r369.fsf@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=H4Hbw/Yi c=1 sm=1 tr=0 ts=684a9863 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=ufHFDILaAAAA:8 a=IJOsoyzupRI1r897wdwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=ZmIg1sZ3JBWsdXgziEIF:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA2NyBTYWx0ZWRfX+PCzYrnY76ic WrDXdST8l7yKMeDLVWGcaWQwP4MeKfYCPCpI7jwphobdE3IUwAZ2RRxvWSAQEFnxaxN2oy7kmvZ eDByaZbz1ofajoaP+XgpqnOnRRlq/bhX18ZNRkVSBilDVgqvAmz7BzBtXtAE2ZM3GIaW23l/RIb
 kzl8YR7G6KNDq9UafqD+p1bHkW6zCw7uIiHQrHrA+n+l0BLIAYmQ1GKzr0cq6nL4U5h+Iiezdqo VXxj/a9zOEUg/n4zQnRI6nR5EkZMxA2ojaRwP0248HZMSMuP4JzqJN2v9mdrw/mzXT8jkUUJ/E0 NXABlI+B6tKrBb/briftRO7xc2OZcFYRKjup1TEO8JzPWGZhZsprEWD3x3X3dQitrGYyyj5OA3J
 4694Bp2QW8Vcz1OpfWomriviM8EKxvzyslagj5R/U8WWW6IEyJ96EmFm5iW8cAObmdfk7FnX
X-Proofpoint-GUID: iuqbjBUGSbxBsh7SITwlVkjpEAZ1LnqU
X-Proofpoint-ORIG-GUID: yefsgomAk-DfO7n_82n7VTxB9RWp-BiZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_06,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1011 adultscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120067

On Tue, May 20, 2025 at 12:23:42PM +0200, Marc Hartmayer wrote:
> On Mon, May 12, 2025 at 01:14 PM -0400, Johannes Weiner <hannes@cmpxchg.org> wrote:
...
> > The weird thing is that the warning is from expand(), when the broken
> > up chunks are put *back*. Marc, can you confirm that this is the only
> > warning in dmesg, and there aren't any before this one?
> 
> Yep, I’ve just checked, it was the first warning and `panic_on_warn` is
> set to 1.
> 
> I managed to reproduce a similar crash using 6.15.0-rc7 (this time THP
> seems to be involved):
...
> This time, the setup is even simpler:
> 
> 1. Start a 2GB QEMU/KVM guest
> 2. Now run some memory stress test
> 
> I run this test in a loop (with starting/shutting down the VM) and after
> many iterations, the bug occurs.
> 
> […snip…]

Hi Johannes,

Marc is going to be away for some time.
Is there any update here?

Thanks!
