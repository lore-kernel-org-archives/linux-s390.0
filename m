Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599894766B4
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786105791; cv=none; b=YK5xTUPfWmXAkBfNJuTVFhC2CUXSifAaxEvhkmeZXc6NosyY4Li1bPKQqnLZWiFYPl06Lnxwo8HXd5tzCPzV2WzZl2MpkNdgj7OeIK3cFsVm2rwzswjI7cx7sGVn2F3yPDjois7Y8v1K9I5BD5/DQFRZxbLi99LjtbfPzUUy/pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786105791; c=relaxed/simple;
	bh=Qq6n4K12Bf1IlFlxCD0Dtn32cPYanAfn8haxDfatgKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDRaL1AyqaZJIy5YqaJNXJO4aBe0LIy18GJtkwjshFVMEEl+V3xRK46MqbW/dr/g9D6+45hwVojJjXifD8joplb31JOr06ZRDzobXG7zxyW3ODrvufrcZKci2ub7SSahDw/uY38P8NHZeFqyvBXD9KeXymG3txwDOS4DfNLdDT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aEiQsaXO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aEiQsaXO"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770Ik5C4063064
	for <linux-s390@vger.kernel.org>; Fri, 7 Aug 2026 12:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=syL+i+5Uo+8ZScloWbbOCohR3ki3Yg
	+rAgNZ7tWSb64=; b=aEiQsaXOg+2bOCDNSITSTrGmUbjlTadrnEikV1/VgdkZE/
	mCMuDMQPOx+v00VW+H8iz2qA/ZLQIHmj8Xbx9GD8EfoCyIIhiVdYSoTE/0GDKYbK
	Pl46hF8NSGXCKrxYslXMw0DhjXuDyMW48/KTui3+dh5vL+uOxuRovGbmYFjpRP9b
	YNjo3Zyi/sZZCDTYj9c7raZESg7hoseUdN6w5oWpE534uLg9BHTeXY8T1kYMMyA2
	QnMy6tRGbPlIkczQLHVsBQMhBQ2brWmMH7yjMIy7OmYyeXvnjp9/LFUVJJQ0mWjN
	rhjro588zT54BKXDt/vYgqWHj7VA4hGkQFpf2GUA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy02bqq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 12:29:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677CQNla015150
	for <linux-s390@vger.kernel.org>; Fri, 7 Aug 2026 12:29:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhqjee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 12:29:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677CTdBn34013650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 12:29:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA30E2004D;
	Fri,  7 Aug 2026 12:29:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 588DF20049;
	Fri,  7 Aug 2026 12:29:39 +0000 (GMT)
Received: from osiris (unknown [9.87.138.170])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Aug 2026 12:29:39 +0000 (GMT)
Date: Fri, 7 Aug 2026 14:29:38 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/3] s390/vfio_ccw: Add __must_hold() attribute to
 vfio_ccw_sch_quiesce()
Message-ID: <20260807122938.17243E4a-hca@linux.ibm.com>
References: <20260806153849.2622576-1-hca@linux.ibm.com>
 <20260806153849.2622576-2-hca@linux.ibm.com>
 <b2335b78-1a3e-4545-885e-2e2cae5f93ad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2335b78-1a3e-4545-885e-2e2cae5f93ad@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a75cfb8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=54WZ2u8Ir7aW3_30joAA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA5NSBTYWx0ZWRfX6YZ/Stsj7tYx
 D9lFVuhUmx1UAHSC6o5jmFQxuywUvJNq246mM7L7XovjhErmOU6vUuAi5W69SELqdjRZnCTJcC1
 N57AhPZBlD5dP5TYOASWT0Zuq4UDvzUr3JVe0SE0/IdMq/BFvaPyIeraDoxPUy1PUiL2tnXOxyO
 TvXczw632V5TPjeFIpLUhG0nlZDOeucHfNZerabYR7PspRQ6/xTxNnSATUT80GgxvF/FtgNtCnZ
 /tB8QGVF5UOmTKG7XcvR14vFQIAvEvZMVDjnKo2MOSeSGCu/YkArdb+qpDv0v5ttJFqwJHh9Jc0
 wxGu68SpiGLTj1GfSmRWm/0DQg7gdofNtpqcUF53h32M0TUDFzWJmObuWA9pEz7Eq64I8A4SVMy
 fXN+7WhWk78Pp9mMEEYKsCITu+O7o9JmTWByOq5VurR3p9GqqKRJYx/+sQx6/+A8b5m30ZofTBT
 eQ9sAvHKG7m6B1b7XHg==
X-Proofpoint-ORIG-GUID: pmAuKZ7_AqCDJ8Gc4C9f9cnZ7CVXikxC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA5NSBTYWx0ZWRfX4mlMUdzE7y/G
 ESalRohfKeKfSuWkVMpUSjT807RlqVdWFvWI4Bc5LBdSrY89Yj1+Yf1xjFExSvoMZ1UF32uXVtC
 Hxj7h0kRi+bDw8xFVu4aOkqU+TwSQDA=
X-Proofpoint-GUID: pmAuKZ7_AqCDJ8Gc4C9f9cnZ7CVXikxC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070095

On Fri, Aug 07, 2026 at 02:14:27PM +0200, Christian Borntraeger wrote:
> >   int vfio_ccw_sch_quiesce(struct subchannel *sch)
> > +	__must_hold(&sch->lock);
> Looks like this ; is wrong     ^
> 
> will fixup when applying.

Right. Thanks!
