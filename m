Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3791F1AB6F1
	for <linux-s390@vger.kernel.org>; Thu, 12 Jun 2025 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749718214; cv=none; b=Feyz4DmovoKnrszYKLN3xRrWyp3C6eW3ZT49AQOAoBHoWVxMfRDzIILBIRpcQLM+UwzMjttxh4ZwF/wHoe6K8seGaOg6b6UXwcCoaizcHAaozmvTyPxj7whbwd7GgoXDTwUw2XSXe9CAmOj20A57buhjHKRrCL/Te/c6+D5u9Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749718214; c=relaxed/simple;
	bh=MF3tYMCdJVSSMyGvB0uKRJTs443ETa7PyXcEk59fFzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnFIK3ZcLYU3Mmxw1QW4rb1Sye8NQe5GbdIVDMCSc9JJ7kEKcox4Icn4OSwSYbS34LjzeCrHNlsOEZF15lbIkkn/EfRERqgJ/9HVEj/dLUI+dFfBgFhO2xNNFXVPB6ZexaqvJWBndtZt3wNjEKpVogPFTnEg1zulrD0gHWHftxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FS6XVUgI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FS6XVUgI"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C1Rhxs029153;
	Thu, 12 Jun 2025 08:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=MF3tYMCdJVSSMyGvB0uKRJTs443ETa
	7PyXcEk59fFzw=; b=FS6XVUgI/C+ydkk6IIgajN/ndKT6zwUOQtkQLKeOShmWc9
	ucrUraCWo+5T54b1WS2AugBZGqqpgMiYAFt+B616IpZKQ/xIi/hcZiu5RJdK5Lk3
	fH3Ar9dm5jtz+MWOMxCSeVz5TGxI4be2OFGOYFWVNL3NpLacymKuN7x3j3AOYrxG
	ZiBrPw2DGQdPsdC6xBLi9hb+j2S8y5tJNS/JdaB1s8Ts9vnZjQhSbyLirQndwMtK
	IjB+r6n4twCPBlC2SpEI7wfs50djbQ1BqIGj5FXwv5CGh394vh9E+Jt/utitk9In
	kDt3sUeamnJq6cLPd1AC9z/b+pDE1fzSS1kK4DTg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474cxjhqjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 08:50:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55C6G2Kh015006;
	Thu, 12 Jun 2025 08:50:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750rpbwy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 08:50:09 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55C8o5VW49611142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 08:50:05 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E17620040;
	Thu, 12 Jun 2025 08:50:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA8542004E;
	Thu, 12 Jun 2025 08:50:04 +0000 (GMT)
Received: from osiris (unknown [9.87.144.171])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Jun 2025 08:50:04 +0000 (GMT)
Date: Thu, 12 Jun 2025 10:50:03 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v3 0/2] s390: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 uapi headers
Message-ID: <20250612085003.10868Ccf-hca@linux.ibm.com>
References: <20250611140046.137739-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611140046.137739-1-thuth@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 15yuknHq3_GfRcY5oIpK1-t0-1aoLL1x
X-Proofpoint-GUID: 15yuknHq3_GfRcY5oIpK1-t0-1aoLL1x
X-Authority-Analysis: v=2.4 cv=fZWty1QF c=1 sm=1 tr=0 ts=684a94c2 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=0WAQRePTKVgAQOHMOhAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA2NyBTYWx0ZWRfXyNHoc+wUloFf 2iowkXOihQ0AQQGBxMs2HGd/1kjeA1S1+feExWpGuBgymtYPwpgKirFt3ymQ60y7Afm0W+pJ5Bd cNGsjrGkzQ1f/YhJ5dazJ5BUEF/EHJ0N6sQr+Q1ceqiOPKbGX+lpSc7RmT1jCfWGzRK9Eo1hDwq
 Bb1vHrAZZpWq8/J04NyrXefNYzcJgjCYQrDh+8huJokZBwtsp4vtBIZTvPnrvfkxb25MJgN0J3F tKKl1WwN7y1DwJeii30gYZemfV3CGQjwgqtZIP9g5vuY0PACF1xpQC9ejQ/drY3S/7XEoWX4zEp hmVjhVS1QxT/rb3omUiyM4ToZVDA5QiDxi3vayPn9SEyl8xTiWF8OiYTR/97Mfu+Hgm/rFPRPxV
 d9cCbbTbVXTtD/YGHrmJ+nS7GdYL+PvN8epqsCL27i7U1kLDzEDAivD5O5SLRQTGejVfaEX8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_06,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=570
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120067

On Wed, Jun 11, 2025 at 04:00:44PM +0200, Thomas Huth wrote:
> The kernel Makefiles define the __ASSEMBLY__ macro to provide
> a way to use headers in both, assembler and C source code.
> However, all the supported versions of the GCC and Clang compilers
> also define the macro __ASSEMBLER__ automatically already when compiling
> assembly code, so some kernel headers are using __ASSEMBLER__ instead.
...
> So I assume the s390 patches should go via the s390 tree.

Yes, guess Alexander will pick them up.

Acked-by: Heiko Carstens <hca@linux.ibm.com>
