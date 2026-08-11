Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7753426D09
	for <linux-s390@vger.kernel.org>; Tue, 11 Aug 2026 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786460274; cv=none; b=WOW9cEduiyyULhdALfxyPotrk5dRpa8hNEYi2Y7EYCshyjrLpsZ6CTJ5PYYNb9kPV8zc6XFTeQx7M1ZopqQA+CkoAsj8kgoc5beo/WNTQPsOXa9KBiJUqNZ3FxFYXMvm4j7YCPx5vsUVfMek0NiYY6XCrZtFEX7/0fiY6UDXOQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786460274; c=relaxed/simple;
	bh=LLsBJZ8zpHMgw34jFJfV9ICgPZSQ8owPqihpiN+dB6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skaGcXSZdQ8PiZh4uucBKyUT/6dU3Lhe7xSfOgngJsicWCqeUrX4dM4EufPJdruE8uQoNbzTdhQ2t3Fg45xwxyL7ChYoEHcqbjII8KcPt9j87ovEI5Xu7SUX+8R1VBIKlRvk62ZN5rJg0ueYplCO0GE9YYSKLMpW1BfrjOMO2Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oAVzBT6j; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oAVzBT6j"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWfKp492561
	for <linux-s390@vger.kernel.org>; Tue, 11 Aug 2026 14:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=KvoDZ6hh8wkA0BpCbnSI/23QS9a/2G
	FcRypNgh3DsY0=; b=oAVzBT6jAc4JLbYkHVr0kYLsNeHTUjUgl+ZnioEZbcqgL0
	pCE6WmTaASbkg+6Rbr72ozHWTvDH/Y9hKWGebHQQbF/WXO8i9pk0AeV4M+wt+x1a
	Dw9x0boFwqCgw+p6zRZ4NJ7+bu44JKML6oycBWFALDlljIhzEFYAtjaPqz1gaslc
	amaWXy4schI1ALyJbry1RWQdfBUZGnrR1V8JFoijdnZagJI1IxRORFkc3LEz0qci
	XjHn8VO6zhx6pFQIWr5WYIUufLKAyw+kDGRpFoVmOt74K7proyxXOHrVHn8g26TJ
	9GmALM3FPs2GXPL5A9Do4Dr2uJFU6P488Zgb0m8g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9dg9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 11 Aug 2026 14:57:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BEuTIu021850
	for <linux-s390@vger.kernel.org>; Tue, 11 Aug 2026 14:57:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g98hm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 11 Aug 2026 14:57:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BEvlOg33685950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 14:57:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A32982004B;
	Tue, 11 Aug 2026 14:57:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62FA420040;
	Tue, 11 Aug 2026 14:57:47 +0000 (GMT)
Received: from osiris (unknown [9.87.143.60])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 11 Aug 2026 14:57:47 +0000 (GMT)
Date: Tue, 11 Aug 2026 16:57:46 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH] s390/diag324: Preserve -EBUSY return code
Message-ID: <20260811145746.12308F67-hca@linux.ibm.com>
References: <20260811142306.4032721-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811142306.4032721-1-sumanthk@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aSGle3cRITonT6dPIdL8F7jqCXpMRFNW
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7b3870 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=KPRq9Xze4Kf-ZWUkMK4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEyMSBTYWx0ZWRfX609jBcOF5GST
 aLQJy4jVHXqOXlzvbtw+ljOk7H3wUGCC1rRkBO0Uc0uMcLrE0de3TNTIenP7Pkslj4rDK9gl4cv
 6z9bXEbBQO2QLShlnRTk+77ERZJCbcrAeVflyDA5zpwt8lEquygOciJ/Tjp7JaA8g2cX0t8Q7Zx
 jWVi64Y1zWyeumN7j3lxUffxQgVUX/R2uXQcP13N1OaNd3VG3p5h+14Ml28IWSy61gYOWAsPq7v
 PG2uOYQqLXXzwRI+J36r0IKbDMuFyHmWv0go22XN0/Lsz5bMwEXU8wRzbv8u8d8o4EAIt3c9jKi
 jvzOYfZ090gMSNmA40aj3XuZAE3qt42ChYTZ4JkGOb/wPy03kTAJMx7pFbgWwfyt+x5o5xsFkyE
 iI0RzUsy2DG2Zw0ElbqWrhVxjqXLzUJTy4RG2TdwXvOUqRO2UN50WmL6ULpGa7SlH11KuUTyydY
 nhk5zddN/YczgXcHhNw==
X-Proofpoint-ORIG-GUID: aSGle3cRITonT6dPIdL8F7jqCXpMRFNW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEyMSBTYWx0ZWRfX1l7cjNJSLRsZ
 HM9ryrMUUi1hCY5j0ESrsjgwnMonnhLmtqysaauYiPXhLoY6+GHyBX/U2adgfywS6ypO11Xb8e2
 GIfSYxODH1Meub7rXAYFcC9zDrKvu+U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110121

On Tue, Aug 11, 2026 at 04:23:06PM +0200, Sumanth Korikkar wrote:
> When diag324 reports -EBUSY, the error code is
> overwritten by the result of copy_to_user() and put_user(). As a result,
> the ioctl may incorrectly return success instead of -EBUSY.
> 
> Preserve the original diag324 return code and only return -EFAULT when
> copying data to userspace fails.
> 
> Fixes: 90e6f191e1ee ("s390/diag324: Retrieve power readings via diag 0x324")
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>  arch/s390/kernel/diag/diag324.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
