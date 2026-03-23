Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E57390C95;
	Mon, 23 Mar 2026 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262821; cv=none; b=I9G2/B8XeHwhsE9baM7XDvqgGlhF8+HHSdjFhw9yNAbf1FgHYmNJxCivLNNgHboF1ElrfzHYPwxTwkDOlc3sLBdcRDhraLwm1Mv+S9i64hYXDP6Lr9zpFqolXv+WkqYytFyyPyLXs4fZdA4z56bHQTFHFec3HHuw2n+W3zqHjRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262821; c=relaxed/simple;
	bh=qsUN7QCw7R0XCOM69pjyWq466lTh5nO68hpnUm1CJos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mf3ublx68oBxPZiQtE5EGfalr5yJeKMn1i0tb9HoFC8Mgv9A5Vt4ZavertJJYU4UyL0mjZSVH3velgC8mvO+MnXH7Mk0Z5OsRyEu7R6J8wgmuEGUTo70a5rm3eVxiD/s8Hj1ftQh1yeNWlDLeJVz/uL6l9mBblNuSJbRV6PPbJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LXYcKpnH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LXYcKpnH"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MEExNp3819926;
	Mon, 23 Mar 2026 10:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=dJOMelWIRePSe2sXRZT+1ReqilcXc1
	tjhJ9JI7WM3Pg=; b=LXYcKpnHKJNQ0LwMFbf3zW0JQ/LcZVmu9HaJJ2ZFzwDpYt
	3FX8q2CpTDjzDixCoBrLp47YYF5G9tPvTLekUVM81Erhs29ETz9qAOE02TYRoK54
	BFwX52IBJPlWq7I94hETr4XT0UzlCmS/BmICTPquc6dbYBV+X0C7V0FJP+7ZyN7D
	0RhNMVsf60Qz4tJK/22MCegKrdFqfvvlKxtPn5Z8OubOzUZ4b0ojt80Q5dYq/DEN
	5FGUpI0S7DHp74fGQsBaIsgz5NqSmYURUkry3wT89mf/VZQ6uVPUnnUTkavcBrlO
	cc/crUQb5xlo8g4pmPPSy/h4h+UTSfirCvJ856Cg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktxpe41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 10:46:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62N6XsWP031583;
	Mon, 23 Mar 2026 10:46:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nsn5be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 10:46:56 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62NAkrTK13762994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 10:46:53 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 281B42005A;
	Mon, 23 Mar 2026 10:46:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A10E92004B;
	Mon, 23 Mar 2026 10:46:52 +0000 (GMT)
Received: from osiris (unknown [9.111.67.16])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 23 Mar 2026 10:46:52 +0000 (GMT)
Date: Mon, 23 Mar 2026 11:46:51 +0100
From: Steffen Eiden <seiden@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, nrb@linux.ibm.com, gra@linux.ibm.com,
        schlameuss@linux.ibm.com, hca@linux.ibm.com, david@kernel.org
Subject: Re: [PATCH v2 2/8] KVM: s390: Remove non-atomic dat_crstep_xchg()
Message-ID: <20260323104651.66303-B-seiden@linux.ibm.com>
References: <20260320161542.202913-1-imbrenda@linux.ibm.com>
 <20260320161542.202913-3-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320161542.202913-3-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqITsb/g c=1 sm=1 tr=0 ts=69c11a22 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=4MpGQi6Peogm6hhcHeQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4MCBTYWx0ZWRfX2swM5kjf35zM
 /xH+Iu6Fa7QmaedHAA6bw+U0OlhO8mea5yo4nXY3F0eIJvedxFC4Xs6kmMrWqdOSp5rA+Kf4gPt
 r/rvSI/jTwSnlvJFWF3B5xrIaD61LjC9vYVXsEKKVow5JI9R/3wpqg2Ir5zc5Nd/Dfod+gBvGEX
 tOs9D+ZDkb3MTn9f223bddSsmHrYQRoD90M4CPCROXXz7XlhqvEe5aR7prdboGD3TaO25oWIwjm
 Yus4J3rnMX8j7vRLmzpJJnD39PTy1zZes3QVp6dt1UOoP/dFybWJuE2XwYcRTzvYuuPVfTuHRYK
 avZhSHLbERKMp+kmr4eJ7ZxnlNvdi5rv1hP5nW4HJYYggyBlbVCrmCgfSzrIjw6YnUX2LL2uXNG
 Vry+kY91wmGcDDFVRywBg2c0ZLTkGnlgnTDbaTHepsiheqYST9Kl09FlDUvPUlKhU7SQO7PJ+QS
 Gh9KK0Wk+TD3Q8tWVUQ==
X-Proofpoint-GUID: sDTGbwmDFKcdlS8FPjoHsLTUCi15508D
X-Proofpoint-ORIG-GUID: sDTGbwmDFKcdlS8FPjoHsLTUCi15508D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230080

On Fri, Mar 20, 2026 at 05:15:36PM +0100, Claudio Imbrenda wrote:
> In practice dat_crstep_xchg() is racy and hard to use correctly. Simply
> remove it and replace its uses with dat_crstep_xchg_atomic().
> 
> This solves some actual races that lead to system hangs / crashes.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Fixes: 589071eaaa8f ("KVM: s390: KVM page table management functions: clear and replace")
> Fixes: 94fd9b16cc67 ("KVM: s390: KVM page table management functions: lifecycle management")

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>


