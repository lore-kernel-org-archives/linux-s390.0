Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467C41EA65;
	Thu, 12 Jun 2025 12:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749730580; cv=none; b=jLe6s9CVUWEpwvwgKwg7KKq/hZRhn9cY4Wb2NJnO4ybHtRp3f608szOIp64FJ+ZZeJ56QOhAUXlouH48zIyENc+pPBbWC7S7Xo5Vbdadu+ZEZGtV9K97eEXDh7kEAC/1U4bH5J8qwaM0Li5YePiY2P860Oie36CzYUEh7NWpN28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749730580; c=relaxed/simple;
	bh=QYKln1FWkJkewV6m9D9iVAYsU7JrXPL0itElPg1yRp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d00DC/PH06VHmK1VHmElc9aXw1YXMzTGjtdKWqSiBRVjI9TnGnOqBW1pw2FvBX0os1JqBJqa0vj5Q8qUv9n5P2igjgFTHEhaGaWyCY7nJVFWc0bjEtp+stAiYqhVw7Xw95i4L8jOVId8sqE7f4gIfYvxkMafes+w147t5tvTuVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZRCoBG68; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZRCoBG68"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C8QlUb000795;
	Thu, 12 Jun 2025 12:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=oWUl518ENhE+I//VZIwKOVmltiU0OD
	OamU9HtHFT4ko=; b=ZRCoBG689NVVhqLKP7vze5DKf2BAnmXTflsjNIThBvGPlI
	uIEJjP7Oxdueu/uF/ilUISry/+blVmZrdj1lI4jwmIajuM02kQ5aDHC/waEHNGXE
	ZgjTahqs6XRKDwMwJjxn8qbmWyZetP6waqHk6dZiPSsact1WHPo/WMIeNovJYUhF
	lMl6tMhY4UP5duvOTtZ82rXt3LhhcnVlad71gbpqMG5o8t7tIK2j/YypwZQ7mEY4
	8DMYXv1nYzmb6NVT530Uhx5rx1q5hjKlfdSEC58ezgD4lFfQUP+UxuejtKCvbLxX
	soIZ/o8ePAlbVKhv19rd4cllToF/i83nwTy1RSwg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4769wyy8wq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 12:15:54 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55CCFCUT001664;
	Thu, 12 Jun 2025 12:15:53 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4769wyy8wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 12:15:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55CB5COG028110;
	Thu, 12 Jun 2025 12:15:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47518mmhw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 12:15:51 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55CCFmwq52822512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 12:15:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0788E20043;
	Thu, 12 Jun 2025 12:15:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBD7120040;
	Thu, 12 Jun 2025 12:15:46 +0000 (GMT)
Received: from osiris (unknown [9.87.144.171])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Jun 2025 12:15:46 +0000 (GMT)
Date: Thu, 12 Jun 2025 14:15:45 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Hao Ge <hao.ge@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Matt Turner <mattst88@gmail.com>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Kent Overstreet <kent.overstreet@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-s390@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
Subject: Re: [PATCH 2/5] alpha: Modify the definition logic of WEAK_PER_CPU
Message-ID: <20250612121545.10868G00-hca@linux.ibm.com>
References: <cover.1749715979.git.gehao@kylinos.cn>
 <4d78498def57e0df4c768ad9eb672cac68fb51dc.1749715979.git.gehao@kylinos.cn>
 <20250612112215.10868Da1-hca@linux.ibm.com>
 <496a782f-25f8-44c5-88dd-d2c56a585898@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <496a782f-25f8-44c5-88dd-d2c56a585898@linux.dev>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5ECCCBaGq-b_DYDsiRkDmnLOEbpQwJim
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA5MCBTYWx0ZWRfXxUECaCqM6x6t s7fRYZxCkwb+mfNdorKCrdr9h/2Kd4a8ptgDxMXlhfwJhlnf4o9fYI3szL9PEzFn1EKlYFBHcqP G30vWpgQIxhLvtBJNMBfpj8TIO0lqXNbcNzgvYYuEG1/3AmcfyzoBAijj/vGkQ1kRg7QhstqhO3
 Q5o1etjsLGxmuaOTnSNxQn9GuOMbSKlYl5TeA9wrog8RdFr6+WfMn6kbHJHJG50gAH/1a0Fg1nE nbdiY39ZoeTcdD++XEWZcVQfurnvkixl3gxvBRhWHQGjfCDaRtCvXNbTExpYbE7OxmhYD03Tmag 1frXCKZ0FWX1VSlu+1XRb/XqvAmxiPVe+qrQQdKPtT08EDcHLOj3G8FOW8FFdgG9gbP5wq9DLDH
 9kZfXuXfr1QTd7E+0m1yGiG7bLJNpRC+ec+YSs6AaHnYevnOAAgMqw6xtkL5+BZ43RjyNkv5
X-Authority-Analysis: v=2.4 cv=YKGfyQGx c=1 sm=1 tr=0 ts=684ac4fa cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=PvjgP0zBWn8W4tAsNlkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: uWhc6G93y2Cxo5Tu8uuCIUnZGVE0d5xZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_08,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxlogscore=621
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120090

On Thu, Jun 12, 2025 at 08:06:25PM +0800, Hao Ge wrote:
> > Furthermore this removes ARCH_NEEDS_WEAK_PER_CPU and defines
> > MODULE_NEEDS_WEAK_PER_CPU while the common code conversion happens
> > only with patch 4. Or in other words: if patches are split like this
> > things break.
> > 
> > Same is true for patch 3. Just merging patches 2-4 would be the
> > easiest solution to this problem.
> 
> I think this should be CC'd to the stable branch.

Why should this go to stable? This is just a minor optimization.

> I'm wondering if these need to be integrated into a single patch.
> 
> I'm not sure. What do you think?

stable or not: this series must be bisectable, which is currently not the case.
