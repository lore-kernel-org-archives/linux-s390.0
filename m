Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBB3233722;
	Mon, 23 Jun 2025 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750670721; cv=none; b=qU3e9bD02K+oe7JUEzWxDixCHUnsj/XUuP/jU0fq42Ho1VTvM0Ditf1HIxgnTDV29+P72tTWNzT+6Wqq7ukmThjDmK/jRcT0nrQWVSOWm2jBUZNJgC6c7xE7WN189DGq7SjzY4OKepq5H+O5+KybpU8e3YWshl6OIU1/dGeUBoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750670721; c=relaxed/simple;
	bh=L8B2deKK+r2XqnIujSu5bNPd55wQpCODVj8yE59TsEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDu3D5IlStz8o4gqq0lbwAk6azJKsK/UH0fymppzwUV4jPXKiK5fgtjKvKtYfMIEs/SvQzjl+6rqkkUdIxaQm8c18YzKNTWR2x5WRzF4N1g4AMWlKzrK3qzuEdI3GLNSRUrmrfpM3fHPgYRox+bren7bxX3BzMqaM9lHPywANCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gtt2cQWL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gtt2cQWL"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55MKkf4v005257;
	Mon, 23 Jun 2025 09:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=kUZSBs68C3cRDU3YZNvVuoNImAjbZL
	hX1gVd6nuoMxo=; b=gtt2cQWLBwyuAkrnkv10RfTjnVsWlU+PyJZM2tsZ8/sQBi
	oQqa9G57VDkfMDVg+BP+CjX7HSnYaP/vewulagt3ZLGKAbfk/lUEw3E2VrfTsPdE
	t98Sg8tLC25u44+kwOoM25ryvWrqbmwvW2vaCoIJayx5MxkC2OififZxcCQIlFKn
	6z+BZPgnemuBn0FJbIJPnXvhBlZZFIMAvHsS32VBjvViLvEzlP5xndPwNrKKr7Ko
	QJ+qJs4PSDUfUZkDHj+999FVuR+vrO7+TqhWjYdUfXk2PvcVhlzTztcunTPgkcNk
	cQknQrrkOZxU5uVMKK97+wmsfOTYydh95oLJ4xzA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dk63gje9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 09:25:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55N8tUEu002908;
	Mon, 23 Jun 2025 09:25:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e8jkwcvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 09:25:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55N9PD6R20972004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 09:25:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04ECB20043;
	Mon, 23 Jun 2025 09:25:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85F2720040;
	Mon, 23 Jun 2025 09:25:12 +0000 (GMT)
Received: from osiris (unknown [9.111.67.237])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 23 Jun 2025 09:25:12 +0000 (GMT)
Date: Mon, 23 Jun 2025 11:25:10 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/boot: Use -D__DISABLE_EXPORTS
Message-ID: <20250623092510.11264A74-hca@linux.ibm.com>
References: <20250620154649.116068-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620154649.116068-1-petr.pavlu@suse.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA1NCBTYWx0ZWRfX0hCwXYP/xnfb VRhqqjhBGD7apAKH/x6YHM/SRZ3bIbffn61DQp+a+0jx0bwz7nC9ZDjDbjg9hov06nHFUHa/WmV f8uP2BkkYxbeAI4jN13jkg11M4yLKOOrrAcWKAp9SGXGTrx9TFNx2NfM0EpE0P+5nrPgp/Ld35+
 uWP6eHiZVPSC9jWvEHfkjfLaAQWjOnFohHE7PDbgat4kccI4Z2vdv/pEBWL0MSqgANXMKcWip7I 6baEJ3yWTEzC5ZqPgSUWicG5SMcVwfb5yd+cynxy+SNpq3wQUOQE8kny8/vYfKlwY5By7oqkkla vIL3ck6oJbBKotPfQQIth/AO9NFFBlIiZHAbH6Dn8jMlBLqEwSjJEzUfDkq7ZqFpQG+uH+qBr3O
 oA3Ra0kR91dlrMEk0MN5pg989SF2ATyEW0tiWaQ/+4SmH8zlHZgZ1pTTi3QA5zvfnlG8vjiy
X-Proofpoint-ORIG-GUID: 1U_k5faDoIYcw9BSwDhvnmXoNZYQR1Cn
X-Proofpoint-GUID: 1U_k5faDoIYcw9BSwDhvnmXoNZYQR1Cn
X-Authority-Analysis: v=2.4 cv=BfvY0qt2 c=1 sm=1 tr=0 ts=68591d7d cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=iox4zFpeAAAA:8 a=VnNF1IyMAAAA:8 a=Qwefet294171jl4ETmQA:9 a=CjuIK1q_8ugA:10
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 suspectscore=0 adultscore=0 spamscore=0
 impostorscore=0 mlxlogscore=655 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230054

On Fri, Jun 20, 2025 at 05:45:49PM +0200, Petr Pavlu wrote:
> Files in the arch/s390/boot directory reuse logic from the rest of the
> kernel by including certain C and assembly files from the kernel and lib
> directories. Some of these included files contain EXPORT_SYMBOL directives.
> For instance, arch/s390/boot/cmdline.c includes lib/cmdline.c, which
> exports the get_option() function.
> 
> This inclusion triggers genksyms processing for the files in
> arch/s390/boot, which is unnecessary and slows down the build.
> Additionally, when KBUILD_SYMTYPES=1 is set, the generated symtypes data
> contain exported symbols that are duplicated with the main kernel. This
> duplication can confuse external kABI tools that process the symtypes data.
> 
> Address this issue by compiling the files in arch/s390/boot with
> -D__DISABLE_EXPORTS.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  arch/s390/boot/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
