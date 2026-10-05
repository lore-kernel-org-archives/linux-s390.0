Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDF42F8EA3;
	Mon,  5 Oct 2026 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791189495; cv=none; b=eQEhv1Zz2N3PnPE/CjBI5gpCG4CImXps3pUT0l604nrnqChzVHgSTX//I5gqQj2fRsz4qltF2PR98KR+TJvs3tcQe4IJLPQApOGhkz5QPSX+BSP/mhIMs5CPpMb5c16bcbRSJNXHnKW2FaU1IXH6XTN7mWe6k+ctvlpCSFQJDBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791189495; c=relaxed/simple;
	bh=ANU2vUZctkABGQ0e7iIJn56261rI45+xmcN31Vqcmpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZoRN6xPByEPa4Igj1j9NydobpMuDgmooobzFCcLYEP5H07jL/rUIMr9C7OUy+B/YPmaDGuDZIX7xey8N3CWhVKhJ6BLTAYgSC9byujh6nNlyRc4bMXKtz6jnG4WTbgvd9K7b9vfVCJowU6w/rRaG5ECH4+FgdyL1p1V4d/g5M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y2j1xUae; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y2j1xUae"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69515M7x1475338;
	Mon, 5 Oct 2026 08:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=A9rJPw8ubc0/1JeHLq0SX1aG++6Cnd
	FlC37Ozl/ZImM=; b=Y2j1xUaewS3GE7gBW+sqmVRukmq9OXTlnnNV6t0gGOsr6h
	iOv7x5retOfVmW/bfIRZU2KHTK35wkQPcGITm6gzO1aHwzszwyBI5sxbA4p0N2jv
	j+IUYNkNGJDvhiZheV0ZO0rjn6Uje30ycI7+GEqpBIM8o3O8iNw46MuJuJbJnmsQ
	9vQJZlfzRkZJFsO67r1bfQPnEHDrYQA/Gk58yBsScE9Gt5UjfuElCUrNdZhMvpw7
	djsxyF17KthuyNY0kwoQl4sTQm9IQdKc28my+6HZoKVZxIZ461IpVXM4WqqHEfHs
	vQeo57SmKtkYbPrfqNDqzkkijHrT2Ykc/5vBYF/A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scr97h2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 08:38:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6956U9702165200;
	Mon, 5 Oct 2026 08:38:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1pmtc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 08:38:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6958c9eZ51315128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 08:38:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD10F2005A;
	Mon,  5 Oct 2026 08:38:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 926D92004B;
	Mon,  5 Oct 2026 08:38:08 +0000 (GMT)
Received: from osiris (unknown [9.111.60.83])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  5 Oct 2026 08:38:08 +0000 (GMT)
Date: Mon, 5 Oct 2026 10:38:07 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Shirong Zhao <shxzhaosr@163.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/3270: return -ENOTTY for unknown ioctls in
 fs3270_ioctl()
Message-ID: <20261005083807.10967B78-hca@linux.ibm.com>
References: <20261005055825.20-1-shxzhaosr@163.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005055825.20-1-shxzhaosr@163.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAzNCBTYWx0ZWRfX9MfgY6EQ4Gnq
 5qdL7DYpE7ihPTOHsLZco4O3kIq++DRllas/KAWiXwJqV/xwkaiGXJwxnIxWG8ipcbC5N9KsL4M
 H073M3fQ0+1POWlA10spXo2R6aEI58A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAzNCBTYWx0ZWRfX95QBx1dDX5Yj
 ZMPG1mzQB4w3dKAWyRTqMg7DZ59NrBhPrn9jO0k7LQ6hBGwe48KZOrpJKOugoFOJIbA9pChw5l/
 l0U7LoGcGw1jWJxTET+G3EElmo0cSXir1qfGXKz1QAxCA0RVIoZBGF8DbxKDWmYtOE0bESxOm+/
 BbcGiOzwZo4npR2uQFrTYsobQzwc3mBoWWqAAjr77kPeKqreWZXE0CEJzqjOsVvIRdAwDWfSA10
 j2ZmA9klz/TpvXGU+tOFJ8pCiDgNvJg5dpReH5M9PIjjrh0/cFOO8a5GLCJEfMvv22/R7pYx10v
 Y0ucomL/NNNRXUpD8g0C6lC7Z3gJUAKEewzvYcBrEPAR/Mf0BUMWLT0MQ8HbI5TpgmlqnrmAFl4
 eNWzU3gPEo53N/Vw8xROuL/qUImp8p19TFEe6tFj1hXXrzuuYVL+zDEP1Aj9j6dGAL6/ePuCAVI
 GIikbCHGKrqlYfxyoJQ==
X-Proofpoint-GUID: i5hAnaDIxlYkquwfRHp4PgSt1Yq_rFhh
X-Proofpoint-ORIG-GUID: i5hAnaDIxlYkquwfRHp4PgSt1Yq_rFhh
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac361f5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=Byx-y9mGAAAA:8
 a=VA8bjJNaD9jrGwdzxFsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050034

On Mon, Oct 05, 2026 at 01:58:25PM +0800, Shirong Zhao wrote:
> fs3270_ioctl() initializes rc to 0 and its cmd switch has no default
> branch, so an unrecognized ioctl command returns success without doing
> anything. Follow the ioctl convention and reject unknown commands with
> -ENOTTY.
...
> Signed-off-by: Shirong Zhao <shxzhaosr@163.com>
> ---
>  drivers/s390/char/fs3270.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks!
