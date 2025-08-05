Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3577B1F30AD
	for <linux-s390@vger.kernel.org>; Tue,  5 Aug 2025 12:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754395368; cv=none; b=PVzIaO94xK5nzyGSeL43OdAkRV34n9BiVKQN0e0noIXM3IQK0ZioO7wccigay7h/cSbNcuEI7WEr/HFTyWTWICWehtpEXsSqJaHfC+RNDxYmbdeFjADAYlQ5d+4O4uPhD+sn7K37kjLA2Ab2cj8dTVGH1BB9oAoErdFitp+XN1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754395368; c=relaxed/simple;
	bh=44EEDgk2IoBfl6am7HJGIRsw9eO1uutFIoNPcp67cgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdmhzCBuo5IWyzm08pYZ7pRDJ4WY1uKd+c2CYUZDScf6r+/ELyH5n45aIRNQ9/22LoB8HueSpf/63oE358GeG93+3w9MaN2oMb3PFXbgM7X8Kg8b2qX6umAuUZpNYi5ENDJ834H+pOkMV3gCLLm8w5efYlPPMuH8i77FX/lnUO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V4JO1yix; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V4JO1yix"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5754ugMO001974;
	Tue, 5 Aug 2025 12:02:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=4Gq1hragezVRPpyFaG97IjZ+pamyoA
	qvxruf8TzYNDw=; b=V4JO1yixO1ntQxKmzarPKt0NrIhbVckf2vo2mpgig3+73x
	X5/caCi7HMUjhM0kkBShepLXJc1PevjbYupDy1o0YqMTgcpbQZ+dZ1DWfKmCPS54
	JWYguNDpXtDqOFHOw0TA0ENUVfH6cs1xrrRR+veESreXCvmheYGw1Y67FM2P3lS2
	OtswnWxrpi9oB+/3ps1vs+9EXCqpY7u2sxRfW1VYRZmJ7AbmBbEZ4Mh36mlQkxBX
	Jl+k+elMNd45ZEhKV1Nkhh65iR92XcGxSRUZgaoUy+lh7fVa600ru8KbKaFauWTE
	htTdRDRPzSlinujjue3aDsn11ZmivoNnPN0w0Ajw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bbbq1rac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 12:02:35 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 575BpMtX014043;
	Tue, 5 Aug 2025 12:02:35 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bbbq1ra8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 12:02:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5757vA7a001893;
	Tue, 5 Aug 2025 12:02:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 489wd02cde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 12:02:34 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 575C2UMF52429262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 12:02:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FA452004B;
	Tue,  5 Aug 2025 12:02:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D23420040;
	Tue,  5 Aug 2025 12:02:30 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  5 Aug 2025 12:02:30 +0000 (GMT)
Date: Tue, 5 Aug 2025 14:02:28 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Marc Hartmayer <mhartmay@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-mm <linux-mm@kvack.org>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: page type is 0, migratetype passed is 2 (nr=256)
Message-ID: <0f120fc0-860f-46ac-b9be-762f8bd42284-agordeev@linux.ibm.com>
References: <87wmalyktd.fsf@linux.ibm.com>
 <1fc8eb08-7e34-4b16-a08f-c81a531ec3fb@lucifer.local>
 <A82049B8-B1B5-4234-BCFA-55779F76EDBB@nvidia.com>
 <20250512171429.GB615800@cmpxchg.org>
 <87zff7r369.fsf@linux.ibm.com>
 <078e6415-d779-4658-aa6b-1fba5fadc0b4@agordeev.local>
 <CA+mpNMkvSBs6juBUOFEGLL-9SWbhsUBGAFAY2anrHaQ4OEfYmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+mpNMkvSBs6juBUOFEGLL-9SWbhsUBGAFAY2anrHaQ4OEfYmg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: El4sce7GAzX0H0ryWJfMu14Yw56xOaBw
X-Authority-Analysis: v=2.4 cv=M65NKzws c=1 sm=1 tr=0 ts=6891f2db cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=itihl33mmSw6o8Duwr4A:9
 a=CjuIK1q_8ugA:10 a=Qzt0FRFQUfIA:10
X-Proofpoint-ORIG-GUID: lPT6r1O5ZmnZ5-t7rOfSZRPYkZD4KfN8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA4NiBTYWx0ZWRfXzdf+BfaILxT8
 VqWHWPhMnSxFkMBCjzxwtbIletltxUTwyhExEjg53hxL02+ntt6xhpGCsCeh6GVDfKhJahalkhp
 vAL8FZG4Y24gogmY2i9+v9sm9GEh0cBqI3Er9wb4hoLZRx2E63AclhEK/A9jGHsHHtB6ub4BU3u
 nVdp9WN6Y1ny1HebGnEybcO4MkwHFQt4yFMJNAgAMPWN6Gnbw0+K2ukeeQlya84L3P2v8X7kJVT
 75DeHfR5uWk6A/bgrOhreq86cuVWvBL4pDL8A1GSCzxTHlYFL+sjwiIAnpYvhfxYLDSefcavuWU
 UtSuhZwRbBnzm2Zh5y2yR1NrrTV/uohbp5PmhziZwbB9cdVDR3DwEzWGHFu65asZ+HseLn+8dwC
 bTpngMj+HlGfOYxjHf34DQ/Z8ICq0oGsC+h0sNt81eKgMh8zOqdzvxFURGOY+RmltaERVyUU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=497 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050086

On Sat, Jun 14, 2025 at 10:24:32AM +0200, Johannes Weiner wrote:

Hi Johannes,

> Hello Alexander,
> 
> Apologies for the lack of updates. I am out myself until the 23rd. I'll dig
> into it when I get back if nobody beats me to it.

Is there any update here?

> Thanks,
> Johannes

Thanks!

