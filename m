Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB853AEB37;
	Wed, 23 Sep 2026 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790175827; cv=none; b=bn8htU6MdXnq8DysWATFzZgmjecWCYRrXedalfUx7ljhsDwWWjSluxLqtknz2jHR6dtuvG/9JZzSg6OgZxZ41VNB7j/sA6t0ezkKmAyY3YAw5ZGhkpPED5CdMm0vcP3FAOXrXI6cp7GNYHwuLrkWOd+/q5IYPunKFR/9dyMkrWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790175827; c=relaxed/simple;
	bh=4QxNgoKgUvMsk+Befxsu8qC72Xhn4iUR/4UcvoYqTOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXymKMNssePHYDf15BEzv1l5uIOJfbqV+xqoLu+lJCqeK7ish0soj/C3nNFJdw09oK4ubAOoei1TRNlz91PalopAkJTWzU826cSZIyVgwyPqalNKj+kY9qyPmdqpVLpL6zCmlungbyyp2zwDh5lmbQfGemiD/mOfDYAYihTt34w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=legRpnlw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="legRpnlw"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8ZSiX1729315;
	Wed, 23 Sep 2026 15:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=EPMS68PrdsNZ7gxMuinRUE0IfYfyKM
	gfUfdMr4QVRdc=; b=legRpnlwwBNFRcTq/CZDs8TTt1LOY8ZALejjsTBirCrBap
	jsyVl+trUUzyqVEB8KlhRVZmzG1I9+gP7nHuVWjM7R38Czjhon0nCDw2et2wkPXW
	hjYJzJnznMlSScMmXY9HnBJbCUROYJK1c21U5FJZm1ne/wVNJLnotz3Z4Npvqp87
	kRq142raq84vNlGDsYHQpARJXMYTDRjX44oNW6q2F7XWJqlEmHr0eMMNNEaENOF7
	irM1oYV34LCGw2+Um971AUwXp3oJa6ajeQD9JopIFo3hLq26TSOECXvFjoHc8G0z
	sFo15txgDgNzY3CzU1L/ayXY65X1bDZHjUP+a7gg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqkf58-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 15:03:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68NCLOTW008015;
	Wed, 23 Sep 2026 15:03:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qhh5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 15:03:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NF3H9Q45678974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 15:03:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 969D42004B;
	Wed, 23 Sep 2026 15:03:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20BE020043;
	Wed, 23 Sep 2026 15:03:17 +0000 (GMT)
Received: from osiris (unknown [9.111.16.152])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 23 Sep 2026 15:03:17 +0000 (GMT)
Date: Wed, 23 Sep 2026 17:03:15 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Tal Zussman <tz2294@columbia.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Dave Young <ruirui.yang@linux.dev>, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH] vmcore: convert mmap_vmcore_fault() to use folios
Message-ID: <20260923150315.9636E6a-hca@linux.ibm.com>
References: <20260915-vmcore-fault-folio-v1-1-a0cb6278670f@columbia.edu>
 <arOa28u0tRZ-jGYi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arOa28u0tRZ-jGYi@kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab3ea3a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=tmzvjasgP5eedGtlEQQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1OCBTYWx0ZWRfX/qSUEZ3ICfbP
 7iWCMIwXU5aJvSlo+TUNfSx/zcug0TQTOx7H1zGwf4+35SfwQDbGypwj+EfDXa4pjvxwrTHwywa
 aLMiZ7JeoxTII636kNUW8fw+7rL19TZEJiSnOOGrfENYkcyI/cPBlxDXnAtLX2Rw4ZZf2k1qH5+
 Nii0arC9pVTp49hFkzP+rzL2Alm6JEZYQORsRHW2r/jdPMXwzMtrafxX9acwKjRe8Kisgi5gcfs
 DMD84THhbs/RpPrGeO+mYOFjQS4F+85CpurAM8dvfIu1SFqHiL7t8In/BWSkl40s74TEb9ZGgMl
 bGoEKzESMgf11BkvY8/CJUMQMnd85vJoGzVtEOKqPGJyUWHAdfiPtGyKBYmcV8HMBNi2UFoGjoY
 Q1qnt2CVX+ph5r7n1aE2/ArbJMhaCbQ9RPkN99SJ+E15r8o56d4ZImMCY5Lf86yJUel/07ZOBKm
 32lc7ubpUXFyIkLCh+A==
X-Proofpoint-ORIG-GUID: 4vjiCbd2QrgeY-ClIPHd8SPJDf4qfF44
X-Proofpoint-GUID: 4vjiCbd2QrgeY-ClIPHd8SPJDf4qfF44
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1OCBTYWx0ZWRfXzOYLA2lYxR2S
 pq1L4QWw/Hp6whvGa3TuUfsA494gdgXC6XF4Se6Ux5rEwrn+jSscBHwUT1a3BVjBeu+bApkvb5M
 DnE8RqZcdeWnaTvcqjmfo/TcDeKKetA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230058

On Wed, Sep 23, 2026 at 12:24:43PM +0300, Mike Rapoport wrote:
> (cc s390 folks)
> 
> On Tue, Sep 15, 2026 at 07:42:15PM -0400, Tal Zussman wrote:
> > Use a folio for the page cache page the s390 fault handler reads the
> 
> I tiny bit of context why is this only relevant for s390 would have been
> nice :)

It is the ifdef CONFIG_S390 just two lines above the context diff of
the patch; but I was wondering the same and had to apply the patch and
look at the result. :)

In any case:

Acked-by: Heiko Carstens <hca@linux.ibm.com>
