Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879DF23BF;
	Mon, 15 Jul 2024 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721037991; cv=none; b=vB5azNsfTVqKeYH1z6x+z8Y01tY7kL4NG9r4gKZ3k95c6jtPDUWmhUO866HWel6h9yXGUDbwF+M9jHhMjsctGjHuFyEJUZjtYHgyVPKdweynabKVeZVwqzL3V9u2b82UvAq16H0QG6ICSnfQ4w4dIu8OIpYZTNeAKraZLb049wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721037991; c=relaxed/simple;
	bh=6K5SbV3udFSz28nS9nUxd9RGHDx8eKjPW/0+TZMeGjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4dlHB0xkknhfnJYCOwQgyQssIlKLF3u84jGK1BZ5iJrZ9PDS4/QMu5Vrf2kBuoyCxht4M+W843YytjXc3TxbYpwUdgPQeUyW8xkPs1WHsJaxBtR36BSl0wCsu0s0aKIlYQeTUtyxwHCqg8nqaZawp1gHU2qZIt0wUMS4ijl/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DqksaoAw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DqksaoAw"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46F8ReWX016639;
	Mon, 15 Jul 2024 10:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=taO/oRZRjXPCGjersHndsBJ0Srw
	wSFCbNZXcZLUK9pQ=; b=DqksaoAwUZ18/Gywda3GQyu1w8BzTxTcG3E31mPtPbZ
	v1IaBQq5ykFXX9/KPjTm9k2di2J3dgYzf7cs8lSQNVA+U/75cbxUk8rx9TJ80AYY
	TGpqjtibK4aK7gEY4Tbv501Kct+F/Rz857uSuexvTT8pYOiUBoAGIx5Fa4TJ1ew9
	2L1RIH6rDltVvonQ6x1JEB8t33LAvK4X56rrCZ9h5x15t3llrrsOWQ2jvzG30pSz
	FzaEIvoFT/ZeNOJze4Kx0B07rBZWb+J9hF2JjauqepUUU7jDsiwdwI8U5ENi7OZH
	tAxGd1Hz4pzEu+xsyYaqTi06JDr6w7C16btdSPv0jnA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40cxyr8eqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 10:06:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46F710k2028721;
	Mon, 15 Jul 2024 10:06:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40c6m2wxch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 10:06:20 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46FA6HZL28639780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 10:06:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34A122006C;
	Mon, 15 Jul 2024 10:06:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 814E620074;
	Mon, 15 Jul 2024 10:06:16 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.68.13])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 15 Jul 2024 10:06:16 +0000 (GMT)
Date: Mon, 15 Jul 2024 12:06:14 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
        linux-s390@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        linux-debuggers@vger.kernel.org
Subject: Re: Incorrect vmcoreinfo KERNELOFFSET after "s390/boot: Rework
 deployment of the kernel image"
Message-ID: <ZpT0loUJ4KdabiCF@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <ZnS8dycxhtXBZVky@telecaster.dhcp.thefacebook.com>
 <Zn1uTZdlYNaRFUqK@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <20240709212141.31160508@meshulam.tesarici.cz>
 <Zo5L9xZtIs4dCf0E@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <ZpBrDvUpn4SzaqND@telecaster>
 <ZpEyucQA1rctAts6@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <ZpE7AsR-nD2tNuTn@telecaster>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpE7AsR-nD2tNuTn@telecaster>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: szJ0jmdYemPWCqIjfZgD4o7D5tyatRLh
X-Proofpoint-ORIG-GUID: szJ0jmdYemPWCqIjfZgD4o7D5tyatRLh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_06,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 mlxlogscore=388 phishscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407150078

On Fri, Jul 12, 2024 at 07:17:38AM -0700, Omar Sandoval wrote:

Hi Omar,

> On Fri, Jul 12, 2024 at 03:42:17PM +0200, Alexander Gordeev wrote:
> > On Thu, Jul 11, 2024 at 04:30:22PM -0700, Omar Sandoval wrote:
> > Hi Omar,
> > ...
> > > I'd be really grateful if KERNELOFFSET was always the difference between
> > > addresses in the kernel image and in memory like it is on other
> > > architectures, or even if there was another, s390x-specific field in
> > > vmcoreinfo for that.
> > 
> > Do you mean another s390x-specific field that would be the same
> > as KERNELOFFSET on other architectures?
> 
> Yeah. I'd still prefer if KERNELOFFSET itself was updated, but if that's
> really not an option, another field could be a workaround.

We have different approaches in how to get it done, which are
being investigated.

> Thanks,
> Omar

Thanks!
