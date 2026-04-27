Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC68301717;
	Mon, 27 Apr 2026 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294236; cv=none; b=LES0VOrhMBfK16vGjjJjNgnt7YyAOvn9FyZnCbQEOwVeFOZjp3SJAADw+003ZrVD1IEC28PwKGtP/m8JlX5c7VUGYXQ9H7Qm8mTo0NdJCD6aEzLPZyBuIOwPV5rNaVUUzLTm0CQHfIlgtVzwkNvF5cZ9whDzxlGdX8yUhQzwE0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294236; c=relaxed/simple;
	bh=BbOKLHT4XowbWrKB/OCd7ydCzFiGZK491CAr//69O1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlxUPG9K+Idy6zm81usWlky1m7wNBXH8mymPUfIgJXsSDTDXjPyMwyGmK9wA5leFV8a1bMW0MKeW62znw+XMz0aBBORcXySiqFjxgwBwunuttp9yKziLNSGswetMlGATzBfn4+KqMV9xqzwtgTMYd7zg9kfBX/cdx+QtXtZ+rwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qyWmjglI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qyWmjglI"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QNVGNv3017137;
	Mon, 27 Apr 2026 12:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:sender:subject:to; s=pp1; bh=59SWzXZ+Hgl7z01y0cWjI0l
	IytClP7KTtmTjxB2ZfWc=; b=qyWmjglI/BZIqzvrlqPgHOhAPGj8+YY8fgPnI2M
	q/QGvwqp9Ii9NkPO3TagZcuxfZPJV7tQ3NCp8UYC+NAdIM8hD/viBe8YRQOc/gTl
	Ja8zQyiopDPLIcO49+UVYVsRyF9xdyokB9yiIcNknrP6b3khdlSvZFOhPXAoHhtf
	MYrvWAK23cmCcQjyRxwgLpDcwM4eTa0bqycFO90rKOQXv5VDit2WPEbtzc33fey4
	yVc4DO0Tr7pJTd//aWvcPHngHUxnhx6aPxnGE0n9bWt2y51Bqj9HzaCE52ZZJg4+
	TJANHoAqWmQmqB6Q2n0bJMjMoVGm8chKQ2r3jFh+9ROwMTg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9r0d7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 12:50:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63RCckbV022954;
	Mon, 27 Apr 2026 12:50:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xq5a2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 12:50:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63RCoRkM45220210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 12:50:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E6C820043;
	Mon, 27 Apr 2026 12:50:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75AAD20040;
	Mon, 27 Apr 2026 12:50:27 +0000 (GMT)
Received: from vela (unknown [9.111.3.200])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 27 Apr 2026 12:50:27 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.99.1)
	(envelope-from <brueckner@linux.ibm.com>)
	id 1wHLPu-000000006j6-3nt2;
	Mon, 27 Apr 2026 14:50:26 +0200
Date: Mon, 27 Apr 2026 14:50:26 +0200
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: Christoph Schlameuss <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, David Hildenbrand <david@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] KVM: s390: vsie: Refactor handle_stfle
Message-ID: <ae9bkscHB51fUA5w@linux.ibm.com>
References: <20260226-vsie-alter-stfle-fac-v2-0-914974cb922c@linux.ibm.com>
 <20260226-vsie-alter-stfle-fac-v2-3-914974cb922c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226-vsie-alter-stfle-fac-v2-3-914974cb922c@linux.ibm.com>
Sender: Hendrik Brueckner <brueckner@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 26baCeDkPpPZW9x3RqVZoyHWSfrQsr4F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEzMSBTYWx0ZWRfX+QI5a/O4+IRF
 IOJrdwqG8GxTKCtTQp7POcv9IFmAwG0/Brxbuix9aBzs05luHYrGiWm/CkV1ml5T3n4cMI35Epq
 mtNr6+/RmTM08Ez9VETL61LICfPpnXer4mQGsW8hEZa+mvx6f4huH3u/7ZjQm2wv6xziLNrVz/n
 fIHYciecwWPUR8dpqZjZv2oL+hUo5g9EGCILSpVutQl98BjN1MZWtZ2fenP3g+kDwb3U9CLG3Xr
 IFiDv6FRWkTIEqBFM7fRU3+yK3EjBXmzML38p9eedSCJxR4LxjnFPdZp3q8vTjCyb7wtawZtxIf
 ulaFw3l25KR5RJ6tOyLs0XzzGwnv6D1pUf0uvePsiNiiX7kgm38txH0E8X66qa+slne7X0Oy6eG
 Tsw/soJb3ZWs2WB1tJMD8zXMSSH9fDHVN3ezRCfnzD8ZxFmFkgyUrmc8xxDVdZ7s1bms0A107LX
 JRR/nnCizC8f/xMqIZw==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69ef5b98 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=jI7lt5Zo0p4w2OnscCsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 26baCeDkPpPZW9x3RqVZoyHWSfrQsr4F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270131

On Thu, Feb 26, 2026 at 01:49:06PM +0100, Christoph Schlameuss wrote:
> From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> 
> Use switch case in anticipation of handling format-1 and format-2
> facility list designations in the future.
> As the alternate STFLE facilities are not enabled, only case 0 is
> possible.
> No functional change intended.
> 
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Co-developed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
