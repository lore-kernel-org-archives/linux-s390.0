Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4439A937;
	Mon, 23 Jun 2025 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750693179; cv=none; b=d+sTFV35ptfmOVX0Eo1Iq0Nv623CN3UP/Orebe0u48pkly4VMfk1kqTBNZbjBff7uIGNr+uPxFMKvIQQuEer/+UVmF/l9b9awSKVZad6n8Ba7U8R2IRo0BjTMrYON8cdUjFMRj3LGGe+3jyALdi4As6y7nTDtg6PqlBGaODICtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750693179; c=relaxed/simple;
	bh=Agb4s8yFfOc4EUdCKON5wzhzGt5/IWxyJQUTOetmPeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRKevVU8uy2nUOMqvtACupBAxTdmcoMoJ6PeYkeg3FGkb/lZiDtBGnx+aye5LOAXuVsuLJjEcJet8kwq7scN4iUWDMvCKe7Aye8SSLAL+Fuf7i6o/hwsFdvhTX5EWZAGKy0O3RFUmedllZhyYViNdm9s0H72Kq1To+eCR09gQak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GjiKbONO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GjiKbONO"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NAI8jL031109;
	Mon, 23 Jun 2025 15:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Nx/ahc6Pz+bp64mF9iOFx7uxMl9Opg
	Y/wT7kWk7dD5g=; b=GjiKbONOG49OGAfgywyQNLj2Zg493IF5aqFeLu9vn0O5rT
	QImKIQPYIwLpEm7E+fdVV1B6iZie+8OmHz2Ez9jnE59aKWAgF57w7V2YRsEA0ZSM
	atzf/TjxosG2aT/omXqEOQfCZpR2wMkWkueBmrah65Bk2vNz9kK6IgJeLBczg/i4
	fkaIOL2yPG+ac4kRoHOzoZQr0HJX3JCdsCZ7KuLQ0ubizreI5bj6NcOSOdnsNUKF
	tsNLZe85K6mVSLvOK07lWJmm0V0Uo4A0beTlnQY3iH//iOL6+Usc6pXM7fj3SUVN
	IL9IEJytnLLjD16btBBV3EypWFDkIAGl4sLgAtnw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8j340q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 15:39:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55NEvPU1004643;
	Mon, 23 Jun 2025 15:39:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e99kf9uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 15:39:34 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55NFdUkd19071366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 15:39:30 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA7482004E;
	Mon, 23 Jun 2025 15:39:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F4242004B;
	Mon, 23 Jun 2025 15:39:30 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 23 Jun 2025 15:39:30 +0000 (GMT)
Date: Mon, 23 Jun 2025 17:39:29 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/boot: Use -D__DISABLE_EXPORTS
Message-ID: <aFl1MU8RBymnFTso@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA5MiBTYWx0ZWRfX/HtxD0ioiQMp ZSpEYx2AC8dcppBmNtgjAmxCkBhPUgEygpMxKlAg4dMcpM73qYBq846HK8Zyt3kmIs3ggcsGcbu 4JaqX/GrFo/w3QLqOvwajX69m7YDjvfcNWS9pDU5frQIRBxwOrGt+HHav5ldhtNX0lteF3/OlfO
 6IZilBXhb/GyXHFM+Hc8a5N9cZfu6hRLAbI4cl3Ha28SS7e1PSaOZqxUtkCwBVkg3d8C9ifF/5R pAMqFhlvmXaH1RXx9Tu3TnjqaEDgiFzPeLh32zSrrj5dFy8TwBpx2ty609ZpiXsTVuL7iqnWla7 P/9q1yU+dozMoyiZsMTVbmA/5sJyG6chQ3xJwiCVw8Gw5xv7pGyVfuN/VE39HlqQZE9dnUZHnV0
 nA5gU1U0wXxUJxpRD86E4TEdkF3Dr+OoY6/3K65tEPfNM1S/JV2HbTp7w6YPWxT0cgMuBbhI
X-Proofpoint-GUID: c_v-99qjdliSBGbtzNcGCrE35ZVuGdom
X-Proofpoint-ORIG-GUID: c_v-99qjdliSBGbtzNcGCrE35ZVuGdom
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=68597537 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=iox4zFpeAAAA:8 a=Qwefet294171jl4ETmQA:9 a=CjuIK1q_8ugA:10
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_06,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=699 clxscore=1011
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230092

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

Applied, thanks!
