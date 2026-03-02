Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A3241B376;
	Mon,  2 Mar 2026 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466109; cv=none; b=TzJwMWIq8lfTi/4YcVTjHZ1D5U7v/rqqHWDvcXnFuXiwnIUdljX0tC334voQ7pWFVdoAfiY+ulpkZ4oEbA7dc8jU+WBOPmmhgIS0ogtb1s02P7OPe38I/VJlmzL3RkOUUZe/Kjahr0At6sbAGEiJcZQ53RU3LRkfSUPI43h5vwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466109; c=relaxed/simple;
	bh=Vf33eJvyiCs1rTC777QG0IMhCXghZhqvO77TEb514Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMHM0/cSbNqC6zBWpZGtMzZuJ4g39+ZxRnfCSAXafUE2udm8as7nS+aW+cwOdgtwMrDfDW88Ohq8pVdYrv9dCR2H+hcnDuKyfSu1/vUddO/USquPOxhnRW70Bv1vVmEONEptxxEDxt5j+AimzIYHjMkNaZ76cMap8q8DQtQe/Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oXNQgyJ/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oXNQgyJ/"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622EOuSx1985083;
	Mon, 2 Mar 2026 15:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=1iU3kaTtBgZdjDYqNo47ugvac7n0L4
	+IaV1PHKjvO+g=; b=oXNQgyJ/JcLzKQY7P64+WsoFoHIXjatS0ElfW0lfBmUZhx
	xwV+cENg8gcjSsr32mN7arAIO3otzTZ1bPBtFHP0iNw3hpmapKB0w8UdPdTm9r+8
	aOLNgyv3RxGSuOJKaYBvgy/cggI0kBXWwPbi1b/9X8EQr1fhIxD+9hF3FsCgdscH
	/zzWmAM04oEtrWy8GHfOIqw/UvN7tDTKNlzBwNyWTjCV7Ow9oZyIhVbKTm1oGl8y
	S9dP2ecArRnkX9OsLHu3XYeQD/+9GPKZlJ7mqfRUrGJ+JrIcdXVsyYRP4WV8kctF
	RmdRRTCdaLA4r4GiPkqgt3yGtBKD2M3TkA0VmHoQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksjd7bbf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 15:41:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 622EFEv9008782;
	Mon, 2 Mar 2026 15:41:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmdd16dvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 15:41:43 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 622Ffdwg53281162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 15:41:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9F3420040;
	Mon,  2 Mar 2026 15:41:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 317582004B;
	Mon,  2 Mar 2026 15:41:39 +0000 (GMT)
Received: from localhost (unknown [9.111.42.248])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  2 Mar 2026 15:41:39 +0000 (GMT)
Date: Mon, 2 Mar 2026 16:41:37 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/3] s390/xor: Fix xor_xc_2() inline assembly constraints
Message-ID: <your-ad-here.call-01772466097-ext-7496@work.hours>
References: <20260302133500.1560531-1-hca@linux.ibm.com>
 <20260302133500.1560531-2-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260302133500.1560531-2-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M9BA6iws c=1 sm=1 tr=0 ts=69a5afb8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=I-hCE_8guc2hzVsXgW8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -0ZrWxnu7oB1YM9BdLZeM1rjiSR7Tpam
X-Proofpoint-GUID: -0ZrWxnu7oB1YM9BdLZeM1rjiSR7Tpam
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEzMSBTYWx0ZWRfX8ybvMsId9SAw
 04mGqFCReWd6Ei8nP42cb58bERD9iJU65TTlPgNQ5YgbLgkqbHC0kPnVs8jjO3PMnE35V1YmQGD
 okO6J1Da+hvhZA0VzBQTGkS5Ga7vCm0jiY40cbAJGlGavbXFXyQ9orLKExP6NdRDuXRHjwc26Wm
 ul7HMjDmjh6KXNuQPFmQf3gzc/IjJAWzK3tr8Mz23r9klcFz7LQ3tvsjglnqB2ISCLpAEH98A+J
 4gfwDEnlor4h7W+NC1QcXi80uPqz1LcAvQ7zgvVBXyzraNcvPYD5FZpoZ+Xprjif6hWQv4gGjGM
 AV0/dWIgiq1L3I2OENLEPbNNso6CBA40U2QlJHa362maawEFpxH7FSJqYAMqbO9mDOmy4u5rH3D
 /rpve0d/ScVadZEuIlEp3Dc6VCtsMCrQuelVzinJeu2KMjLcvoduYBTLk/h2k4n1yaIZ3ug+86d
 FnPQF0Kzj9GFyFa5JuQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020131

On Mon, Mar 02, 2026 at 02:34:58PM +0100, Heiko Carstens wrote:
> The inline assembly constraints for xor_xc_2() are incorrect. "bytes",
> "p1", and "p2" are input operands, while all three of them are modified
> within the inline assembly. Given that the function consists only of this
> inline assembly it seems unlikely that this may cause any problems, however
> fix this in any case.
> 
> Fixes: 2cfc5f9ce7f5 ("s390/xor: optimized xor routing using the XC instruction")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/lib/xor.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
