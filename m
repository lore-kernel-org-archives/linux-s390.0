Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EA61A317A;
	Wed, 21 May 2025 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747837326; cv=none; b=aumOM+Lei3guk0jF3D1YeCNbQSntQqxb1YybUJg/EARTN+3UkHWromXSl69+DDVaywwqrY8a7gDyI2D5vsSRS8J7D3y5l4Ah7mMTr1gISZPEjk5kUpTZ+dsN2u0t4o++Icfieas1/SHur+e9v9mE0X9hvy4q9PkJgsr2GQeVYFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747837326; c=relaxed/simple;
	bh=DeEkaq/YR/aYXQ8EJo2m5wKNuGyxAH40rEpWj4GBF4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbobBDr9uxaQsum2ZvmoqGKJAKhazx38TSIIXpTZeBRGEzahfvHxhe092tWPi2JZAK/HyUThT1Z2Ke3/ZxnBTexb4Secgjq8bOFy9uZo2iwEfaqSN32Vrta9jkBBvpWTL7Oa9GTKmYNRwn0tSTMqPtXayDyy3MxULnfK3BU9JZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mTsSVMSI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mTsSVMSI"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L8NSB8012153;
	Wed, 21 May 2025 14:21:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=+pbdGlDVQ9Os2VXqbYRLNQcB+/6pA2
	U3W63QKyIuekw=; b=mTsSVMSII5BvDvxamWrcmQPJkQfui6b6maA6SRPeusJUVr
	EL+3/agoe/RKh6BDypzUYHR74hqAA/Qu5PVSeoSTjorxFtYDTudvTLeq1NcY1n8d
	XwjeSLvJtZxxstTFgiyrKYipDWC8WKhN2waaHXJwWgwMdXDYWpODY/EzvGavnwha
	k0tNDXehgaYdibJmlDR18HcktLlYyTBLyeyQc8XhVQeyEO6cflS5X6pc2o/QQy5g
	a/9Vvz8nGBcFcbRbqppaD8MPsVf+V0Y28AtDZLTyk/hxQmMT+C8b+4SfpUpmB9Hp
	1ttGLfqzynvmbd0HPnulaQuiJddrDUieHOV5chLQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rye6mhn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 14:21:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54LDZZUp015480;
	Wed, 21 May 2025 14:21:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46rwnnchb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 14:21:55 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54LELpm218350516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 14:21:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AECE42004B;
	Wed, 21 May 2025 14:21:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3075420040;
	Wed, 21 May 2025 14:21:51 +0000 (GMT)
Received: from osiris (unknown [9.87.128.135])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 21 May 2025 14:21:51 +0000 (GMT)
Date: Wed, 21 May 2025 16:21:49 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/4] mm/memory_hotplug: Add interface for runtime
 (de)configuration of memory
Message-ID: <20250521142149.11483C95-hca@linux.ibm.com>
References: <20241202082732.3959803-1-sumanthk@linux.ibm.com>
 <20241202082732.3959803-2-sumanthk@linux.ibm.com>
 <3151b9a0-3e96-4820-b6af-9f9ec4996ee1@redhat.com>
 <Z08WpCxt4lsIsjcN@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <1b9285ba-4118-4572-9392-42ec6ba6728c@redhat.com>
 <aCx-SJdHd-3Z12af@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <fca5fe72-55a8-456c-a179-56776848091d@redhat.com>
 <aC2sUdhavboOgS83@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <496e6707-bdc9-4ad2-88e2-51236549b5f2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <496e6707-bdc9-4ad2-88e2-51236549b5f2@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEzNyBTYWx0ZWRfX+es2tdgCqTRk DJ+MBFcXGJjGaWxKeOwxOXX3HaifE2jsF6o6EwdTUz637IAAyyIRmyLieBEilYuL54IzOfj0uKG 8HHZ05z1Lql7XFezD4n0z5MK24sCeu3zexFnWdV1fJwa6WuHsVUolLZibcVmeHFKhcknn9qtLkd
 +kaIFrHEc3EIIymkdgsHfPT4OzYAuhh8oZOZ1jUO5628XXKDKI4nh0bsHAz2yEk2qqAjfNgvG+m Cw1MKRlRUONC51E+plTgUo7+a6cbh3VwUCjX0y4oF9p7caNfRkw5uoMW5fWQN2cWjo2R8Wa1m1a +bOe8AKjG39CDxcnSp7JJ+InPS70cPMvcfE6kJ+HgJrpOYlozVzL7EkbH0Gml0uthDWVH5qziRt
 8q6zrAwx7FEjXojfog8xb5rI6LNv5FstR6KVYmRF0dFL6jq/wj8OYGvrRPKXXwchRIxRoaI3
X-Authority-Analysis: v=2.4 cv=esrfzppX c=1 sm=1 tr=0 ts=682de184 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=nzSEty_UkPgyXC6r39YA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: x4PT5vUB9_qT4dlNxpPKkjz48cYLT3z2
X-Proofpoint-GUID: x4PT5vUB9_qT4dlNxpPKkjz48cYLT3z2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 mlxscore=0 mlxlogscore=346
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210137

On Wed, May 21, 2025 at 02:33:42PM +0200, David Hildenbrand wrote:
> On 21.05.25 12:34, Sumanth Korikkar wrote:
> > As you pointed out, how about having something similar to
> > 73954d379efd ("dax: add a sysfs knob to control memmap_on_memory behavior")
> 
> Right. But here, the use case is usually (a) to add a gigantic amount of
> memory using add_memory(), not small blocks like on s390x (b) consume the
> memmap from (slow) special-purpose memory as well.
> 
> Regarding (a), the memmap could be so big that add_memory() might never
> really work (not just because of some temporary low-memory situation).

What is "big"? Worst case for s390 with existing machines would be an
increment size (aka memory block size) of 64GB. So more than 1GB for
memmap plus pages tables, etc would be required.
