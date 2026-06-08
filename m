Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0BE23B638;
	Mon,  8 Jun 2026 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780929414; cv=none; b=oJWzh7cDJhSil48gfwAWzJYETJrs+OuUob0Nrn9hP3bKLm2ji3QIbWkrtqOJgCFqsVds8U4L+KT4+Xpb8dlkNYRTMGGtSnE9sBF2Rqwtq5EdbQy3cjQBtJ5aDD5KnIaBr45MwZLnRIlbEy+FXk2M1aoM7YbFmqV0WGTshx/80Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780929414; c=relaxed/simple;
	bh=CsOSwVJoO+IU+PSkRq2oCO8fb85fXC0x4Xyf7QP74cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMACQvwGkP29glwbA9WhlylpCF3J+fgcKRmVot97/eApZjj6Sbf87tm8twJTKz15Z8uuUg72Xgi7yOgZPljYywPO4m33iz0bPXuoO4qG0dUffAF/4NOPVCW7ShiU3VwMsnRwaH6vroLpS2DQZ7naPzVfNJooH0j8DNsD7k+VZrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RXwwG8MJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RXwwG8MJ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658A4g2K3640226;
	Mon, 8 Jun 2026 14:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=DeTPW0tTRTvjdjFWIe76eFP91hibte
	iSt+HlIVJgQmY=; b=RXwwG8MJ2rXG+Zb7P6/wLfvLz62C/zk8xscAs9f7zkj6cY
	UjsIH2L/h6UmYOhs6v4vwVrFeNyn9UEsr/OgyxEkWsMGtIu3CZizNeYeptZBmyK1
	2fcnsPUqcyEQb3LZ62Pw886EF0dJNFymugynov19PvP0rpi8S4olEt16wkQtH5ov
	wlub7KqzjGwBwFjXjLiP3zBs5jp9CmuH72M2TSOnCyQb3OZlOHnjNEOyeWaUqXME
	j/YdTCjg7YdT1WvDzI8Hyh9phSXgx3Dv6ZEU34j7t93w9gvTVG/Ix4lBv07WvCcK
	xJgOVm7vpnItAWpQfU3sL8WzTfhTDfJGwyrcysVg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ydyrjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 14:36:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658EZMLN004741;
	Mon, 8 Jun 2026 14:36:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjnpvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 14:36:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658EaVRp50594084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 14:36:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C94820043;
	Mon,  8 Jun 2026 14:36:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD74420040;
	Mon,  8 Jun 2026 14:36:30 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Jun 2026 14:36:30 +0000 (GMT)
Date: Mon, 8 Jun 2026 16:36:29 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Jan Polensky <japo@linux.ibm.com>, gor@linux.ibm.com, ojeda@kernel.org,
        peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com,
        aliceryhl@google.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
        lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
        dakr@kernel.org, rostedt@goodmis.org, ardb@kernel.org,
        linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/6] s390: Enable Rust support and add required arch
 glue
Message-ID: <8f3c0ffc-adc3-493f-8347-9e7579f3cf99-agordeev@linux.ibm.com>
References: <20260601174625.2910233-1-japo@linux.ibm.com>
 <20260608142122.34400J00-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608142122.34400J00-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEzNCBTYWx0ZWRfX4Cj+a/gt9Kpg
 fODyLhEu8kzqPkkmsUAON2PSn0SALrY0PdoxRkPfJqJkG2G64Te3GSKqaZRpws1GYLkh7RpwZOt
 KkQIwRTSHpqI7sNDaKYS69u+ymXv+Qn7WgytsnaiqMRubvlpSSaamdB5MOqF+LeB/04m59yqvrz
 KaHKMwIjno0lX9pj/3nb0CVyAh7tf2OFDMWbKkD0FGc0AH8tscaq8mFP0zfH9p+AJTOlqlJ1iQp
 A6NGV5k0Hn4knb/IeMBRdX9YC150lIEubJw3hMAvDtDtYlbEGmIQfVQ0LTuICl3j+FUE+SGQcCc
 diIHS0u6NiciYQQKvX2eePxs3t/KEBXLAmHYc7iw7axpy+nhEoDRsgS0pBY7rFzlbDSXTxqh2XQ
 1gzZHh0F5J6V5Lh7I0vBgLU6rhfLZAjZqx6SeqK1WVPwB4cDvtzJX+IeavHK13Sag8vnsWnHg+H
 B8fkX2rST3/UCq8+ovQ==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a26d374 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=ramI4VpqOhEfsmJ3a8kA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Akk1_jBef2RE7_B_jQqziSrEGSjbj1Ef
X-Proofpoint-ORIG-GUID: s6lfMA4kvQkUBfXVkfiMHa6hz5hjqckk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080134

On Mon, Jun 08, 2026 at 04:21:22PM +0200, Heiko Carstens wrote:
> I guess Alexander will pick this up and route this via s390.

Yes, I applied and scheduled it for -rc7.

Two new files fall under the Rust maintainers scope:

 rust/helpers/helpers.c | 1 +
 rust/helpers/string.c  | 8 ++++++++

Please, let me know if someone is against it.
Otherwise, an ack would be ideal ;)

Thanks!
