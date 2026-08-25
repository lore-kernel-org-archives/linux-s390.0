Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665293890EC;
	Tue, 25 Aug 2026 07:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787644243; cv=none; b=H4Zbq94+2RT5nQPddTbsEKxBwc7yfUoc+g2vVguFNEs7vsPvoRn0ep+K3BTsjVRioMkHKdi27TJNCiz+w3h/hFtw/9j5IXqPdFUaiQw9JrBY0uKXB56MPCSZGM40Oqoq68Zvd77qCVXPxGZtX7DOOgsObBWbik7EwSMz/sRhnNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787644243; c=relaxed/simple;
	bh=ifmUMZR/oPkQdshlF8CNyPaunysagZHj1jt9Fyo62Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCzEwgOAobVvgc9Ug+2uzoLLHiApI8P1ezzunMgeAr3N2bfqoOh1r20sy6XW1bRCuf+dHintqfNlqKj4CVc7UNy8xYDQkX2TlvtmuwCQdZj8P57kKsXg4Bmx7k1EOXE/Vb6xdOkF7wQvTdMS6iWYw5vAnjaSlw/wtG/weC7XvWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c58WFFYK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c58WFFYK"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P2WC062619881;
	Tue, 25 Aug 2026 07:50:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=8M1RtMP5dGDh7WaM7pLyX+UNoVUR6v
	tG5dGbHWHRrz0=; b=c58WFFYK9KM178PdMhMSiBOgXiSkNVmR4zI6/FiW0pfetO
	Qn0EICfLuEB2+blm1HU9Q0rPbm51ucxRcJf7jxA2wwkM8IQWZunOAb/yAfmEZUcv
	h1GyFbYOsw7uICwEjp1LAoODpoOFUZJ6DszkQWyy9Vn5QVS6KzuQeYh8DpQwIa8i
	zSeBTC7kM+xGWFv+8TMN0DTzwTrrwgP447/GRHccUcb95nn7vQ0Upy2OuN9OkBV0
	7+FKUcsEFeAdLa1t58R6W+FJYmzMCskn5Im1UDqDPeMYKVxBVD181eYdjsVbuFDY
	62eUePdxhnrlMGeQvkPXIlOTzjSEpy/4UVkUZHlA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726eepc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 07:50:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67P7fJbJ015238;
	Tue, 25 Aug 2026 07:50:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkh2urp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 07:50:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67P7oWCw53215572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 07:50:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6709120040;
	Tue, 25 Aug 2026 07:50:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE67620043;
	Tue, 25 Aug 2026 07:50:31 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.94.220])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 25 Aug 2026 07:50:31 +0000 (GMT)
Date: Tue, 25 Aug 2026 09:50:30 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v7 3/4] mm/kasan: Introduce helpers for lazy MMU mode
 sanitizer
Message-ID: <c4ea355b-9807-4a9d-8f90-246b4e650684-agordeev@linux.ibm.com>
References: <cover.1786956464.git.agordeev@linux.ibm.com>
 <52c9be0cf71a8896a5d76c148c38fb24a2005dd9.1786956464.git.agordeev@linux.ibm.com>
 <CA+fCnZfMkPDVyy0t9W-3d55M2ba9wXoRyzj2EWWYLEW=QO3zWg@mail.gmail.com>
 <20260818120130.1411942A70-agordeev@linux.ibm.com>
 <20260824095635.11040Be5-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824095635.11040Be5-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8d494d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=UUUDspzaHmeMqvLuHH4A:9
 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA2MyBTYWx0ZWRfX1UHCLV5+e1ku
 Bgn8RhOV7C6kM93dO+8ZojEFJxd3UxNobEmy2rwhytC1uQf9w9+9o88eWRIR3m+FXdMYpAxtc/g
 3jIYLqLjXuVFEOeYLLkZkIF9hKjrvls=
X-Proofpoint-GUID: cHEBOSUK2gjUGPKucThiW1yn6xPnJ6ye
X-Proofpoint-ORIG-GUID: QUiBDcHGUMJNuhKLd6qzRIM5vSKsBumz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA2MyBTYWx0ZWRfX5XNKnD3AcB/l
 60zzrpu3M/nJBAHn1S4j77pylmm2Xv3rLRsy8PoSsYbPmmJzM1P1hoRVSaPppyLrV6I3VRxtnvC
 Qyvez7nqN9ADdnyFMj//rnSfACuWt14MrGZ841V5Ao0xKjXk7wwEU4XOp+OfefjP2JHXFLJjwsw
 j8oz3tZ8APPuNMCeNElUo8uy0jUf9Fj0hlDq0Y6VZ9aeFuzGpDyqvuNDkPtBss1V0vx+b0sgItO
 CbrFZts6mH24N6J+a9Rix2nmdPnhPPLF/tF7t+165IpYGijcCQDHB674W9WnKyWASMV+DLFpKCy
 i7+mPGaV9neTj4e7cexQjKXoHQZg7blcC+XqkCU5DfyWUqLkrMin/pPimkZa7tJ8d6GadSXSjVs
 IhvJlzVRSWtqZ+z45I+OmfUL44AOZf/zVA+OO5R60eJ9aXoZn/QpbPVeC6Yo97F/P24fskG1lDD
 NsehB+v/fYx1i/CGJlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250063

On Mon, Aug 24, 2026 at 11:56:35AM +0200, Heiko Carstens wrote:
> On Tue, Aug 18, 2026 at 02:01:30PM +0200, Alexander Gordeev wrote:
> > On Tue, Aug 18, 2026 at 12:11:34AM +0200, Andrey Konovalov wrote:
> > ...
> > > Hi Alexander,
> > > 
> > > Should all this be limited to only s390?
> > 
> > The idea is to allow any architecture to opt-in. Once [1] is accepted
> > this may look redundant, but I still see the benefit in having it.
> 
> What would be the benefit if [1] is accepted?

Just another mechanism for verification, and pretty cheap one.
I would dare to say [1] does not rule out an invalid access completely.
