Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3906C3876A1;
	Thu,  8 Oct 2026 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791479316; cv=none; b=NQF4WK8Rt1XBaDqCxh177pE6kgrb8ZgVW9rCKV3NnImnqgnVNBdBiPxmOUYuJolDnMCJbg4D1eHbZUs2G/LpIdV0KJBly0JDv8gWDVZFZOvRhrT8b7O9d8WQtU8wpfrD3ly1e52nRzDMkFaOQ8fm+MIegqA4wGUtAkOQ6vdXOv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791479316; c=relaxed/simple;
	bh=uKhtdm15UpEJ6rf1smJSGQ/x5Ve0+w73qQ8J2jUc1/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NJ8Kaxs0NfFSVNP9rKp4CTa2Ra9nFUpl2uPU693CfCJfBi+2C8qsKztRBN6M/+oi5JEQCpFJK9lLkitBEYMS3fokDaVGkLAeRnu6G+UE29oDhrajN2DBN77MsmW9Fdlzxh50mLqC8p60pf/CyC7iEF/83hDlQLkuyqzrlwqJIvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S+toEffk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S+toEffk"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698EZOma3999550;
	Thu, 8 Oct 2026 17:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kNCkGa
	XGMDGePOlXzA3Oop1Xv/eT8titudFVmWUrDq4=; b=S+toEffkKMldoLRVoY8UHg
	KNt7i463vIzL9jMImhrg2f+lm3QQ4riWSwVkoseTLVydM/iZHZSisTiOg1T4yr5h
	7csaSV3YvRm2EOx92NNJZN844B9s+VvxHFYajka4+Ifs8Z9/S80tO9+d/9RUldS6
	38ZHM88ibYGg46/TYLW9vqUDI0yx1/ldn2DIl42idTlkHSvVLW2x08IOj+qUDanq
	1LcJn8LCLWRzuDkM2nMXMlDrSq+oex+MtreyXWoDzoP9YG7yyFxQHcVfd9AyzA+t
	XJzFHiZYFxD3u17CcU75guGYOPakATTh6DcoRsNCtcTFJap9uba2JBByik5RhlCA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw5bvh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 17:08:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 698EmXJf3594012;
	Thu, 8 Oct 2026 17:08:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h5s34w139-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 17:08:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 698H8TGd46465472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 17:08:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23E9A2004B;
	Thu,  8 Oct 2026 17:08:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA41D20043;
	Thu,  8 Oct 2026 17:08:28 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.224.89.120])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu,  8 Oct 2026 17:08:28 +0000 (GMT)
Date: Thu, 8 Oct 2026 19:08:27 +0200
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian
 Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 1/2] s390/appldata: Emulate virtual timer with
 delayed work
Message-ID: <20261008190827.1b9762c0@thinkpad-T15>
In-Reply-To: <20261006140113.3128582-2-hca@linux.ibm.com>
References: <20261006140113.3128582-1-hca@linux.ibm.com>
	<20261006140113.3128582-2-hca@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jmzUe_cXvLQQUTZfRN_oTTR6LKLEYkkf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA2OCBTYWx0ZWRfX6DA12v1f3E3m
 xQeLCXfe7pSkC08tko9xOF6pK2fAv5Em9kF7fp0kweaq8rxc0jKYBZIWkIVCORSa6lcaneFe0vJ
 5suI7/hHG5tE6Rjmlw/vY5RRlWyBLiCfu0aGvsYVjWWTaAPc3jLfGlrtq4TkMaxpzqCRQyKPyTf
 aMAZUuX0I7RoQ927h+bNasYZlyyfB/GQOB7jwjQvSSqmzCoT8Or1rzya3pOFsSLYzgMJBecpEBv
 OHQ9Yd3YR9D+mRk9ydeY6EzAtbkBVj2y1rTYFRtWiidIHcpwUtHx69/qJYi2cGLUOLpN4FypYui
 Xp/JcHPG2emKbdjwV5Lb7RZ42non+RGoeuI5Firu0mIIpRomd9MB6Qxibo3BqKkirprN6A0LrZz
 knyGwyD6Evc6FTu98sH1ToYFZ1jphoHAf5oKb36+VOKn5VeTFsv90lOoJgPVeiox3/P6j9rRHKe
 r/jSIl8/54HDSyDN/gA==
X-Authority-Analysis: v=2.4 cv=cIt1IVeN c=1 sm=1 tr=0 ts=6ac7ce12 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=h2POmDZ-lxQGII9KrcoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA2OCBTYWx0ZWRfX3XGnZGpAZSRc
 9lR9b9qR41y9Mrt8lO+Sf1g/cS82/rQ8iYQmnT1ZHIof3pIxLoNrnTKakjMKHYAs8a/3kSHWpWZ
 Xwga/P4IXmIMsZMo8IS0qtgqmJ/cV6c=
X-Proofpoint-ORIG-GUID: jmzUe_cXvLQQUTZfRN_oTTR6LKLEYkkf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_05,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080068

On Tue,  6 Oct 2026 16:01:12 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> Emulate the virtual timer in appldata using delayed work: the work is
> scheduled for the minimum possible wall-clock time until the
> configured CPU-time interval elapses (remaining CPU time / number of
> online CPUs), with a minimum delay of 100ms. The work then reads
> per-CPU statistics of all online CPUs to check whether enough CPU time
> has elapsed, and if so runs the registered callbacks.
> 
> This is slightly more expensive, but allows to subsequently remove the
> entire vtimer infrastructure.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/appldata/appldata_base.c | 171 ++++++++++++++++++-----------
>  1 file changed, 107 insertions(+), 64 deletions(-)

Nice improvement, with minimum wall-clock interval 100ms. Specifying a 1ms
CPU-time interval was possible, but did not make much sense in practice.
On very idle systems, the resulting wall-clock interval would also have
been around 100ms, but as soon as they do some work, it would have become
far too frequent.

Also tested it, and on a busy system there is now no noticeable difference
for interval values 1-100, while idle systems still behave like before.

Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Tested-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
