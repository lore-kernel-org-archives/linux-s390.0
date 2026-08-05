Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12705480DF0;
	Wed,  5 Aug 2026 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945059; cv=none; b=EWUiuF1zLdSXe5VPC2QuAlGbwIbDnYEn7RS5if3lA+Q9HwsKB1mXqraA/sK4r7Vt1k1yhhn6ziThjSgLB8dd7Uc0H6Mz2pHG1giR4rq2dNWtkT03SvdR0AFRD7PD6ZKemTdVrr4QoJf79L8IbZuY4r+jJW+gtF9MiQephqT2iyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945059; c=relaxed/simple;
	bh=T71dU0Pf1E3mV2ot5oMDFULKlJ+UP7HO41aS2E7VY/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FS0qJNag0vQI/cBge8oONsDcnNF2mCAneIKY7lzn7txIfCO2hrLgLhPyVMIHpeB5hvtcb7Jphds6AgdT6nJn6x8hyOvx60+3MuI5wtvJUnLyqnJrzpzoUCFvA7K68fuFIq4gELLpaSarS7KdqNV6MZFgEuHvrz+3umuLLNoYpxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LvKQ7UuV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LvKQ7UuV"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675Flio0137773;
	Wed, 5 Aug 2026 15:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pdL/87
	HbrXT57ShNxBphfnUqFHx4yweJgwBFBnb8xP8=; b=LvKQ7UuVGE8i6Q9an6JWfF
	waDX2rfRyRoo+xcL1Xnl7vgJ9tXyFpDZOUxXXiRwlNNfYlF37ayHFkjPP/cQOWdo
	5lSj/tndUgCXkDtumBIKoPzGPTql2/AqQx6ELVffVbGV2P45zYL7K6Bk1KBRcPcP
	+nIsJa7X/nZEHWMXtHW3XL+mCp/X551ifQCUvRbNZSPeHmYdh+mF1Mf9vq6cC7Fb
	O9ATNk9GjpPikDlRMHyDaL/H44GxuLon/Xcb/ny/Pnb4SSAceNM/AEFZsPwkdLa2
	NB6k7dGrVUdEWRRgUbTZxaZpedjD850THLrqE+iYEKkJuXXSvX6NJ1qde7z3rJhQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8euu9t2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 15:50:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675Ffc5D002350;
	Wed, 5 Aug 2026 15:50:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qqb9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 15:50:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675Foc9516253272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 15:50:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCBA12004B;
	Wed,  5 Aug 2026 15:50:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D74B20040;
	Wed,  5 Aug 2026 15:50:38 +0000 (GMT)
Received: from [9.111.207.139] (unknown [9.111.207.139])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 15:50:38 +0000 (GMT)
Message-ID: <510a8130-847d-46dd-bc64-6b42279d2af3@linux.ibm.com>
Date: Wed, 5 Aug 2026 17:50:38 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] drivers/s390/net: Enable CONTEXT_ANALYSIS
To: Heiko Carstens <hca@linux.ibm.com>, Aswin Karuvally
 <aswin@linux.ibm.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20260805145032.1409325-1-hca@linux.ibm.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260805145032.1409325-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: An2SqaTKnpreczmCTaO798ZFAZcfkOJx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEyOCBTYWx0ZWRfXxgxQi1ingLRK
 UmwQWCXZCIJycTEq1+iMI6TJIldfsKukn2LAj1wx5pQ1cID4H2UCT/HXS//MvMDoZmtQTHhXLfH
 kMA7d9d2d2pbo6VI29lA1BWw9J1xocU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEyOCBTYWx0ZWRfX/ccjv9HLa7oV
 AQqvX0znMlgzTYs2KAOz8iQ8JuimetZvGH5KNB8PyCdk+Ott1/jpikoxGecjAsZwJaTwAo21ehj
 wYy/rpYxqvpnx4S9ajpVqrAM7R/myxpGE9m4uLZshdf5a/s9c+fFdS01khKN0UVUoa9uummt/qg
 r+M1vwpWJ33QOS4+IGtJF08UpID/FpH3tD371+DexpiK9g3TRiZaZjqo+2LngeYX0ong2dMhxD3
 6YKl/tXhFQWjgK4jsZtEK5mTUlDH+t73cIyivjMxyTB7XaSdTwEzAXDXQMRbo6kjC0FwL3mGtFn
 U7lf8KMUfKybE0iloM9/slyBrvcc91df5r7hlOqnKNpS4Gz+i9yXScXTGE8zsuZcYdghoFj718W
 NseuDebeixf+BiYN9RD6IoXpbO+4SwfKDSQeKROo/S8Mbl8LFObJ/RDhpvkZCJncUxzdG2pozGA
 nw2C64hRda1XRa4SHeg==
X-Proofpoint-GUID: qBNsiRKXO1j-VnDQpgTizEgZo7nYg_4j
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a735bd4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=gP54STInbiGPwzblvxgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050128



On 05.08.26 16:50, Heiko Carstens wrote:
> Enable CONTEXT_ANALYSYS for drivers/s390/net.
> 
> Static code checking for acquiring and releasing locks used to be done
> with sparse. That was removed with [1] and replaced with a clang based
> approach [2]. The new approach requires that each subsystem needs to be
> explicitly enabled for checking.
> 
> Do that for drivers/s390/net. In order to avoid false positives due to
> conditional locking, disable context analysis for specific functions of
> the ctcm driver. All comments in ctcm indicate that the code should stay
> as it is, and that such warnings should be ignored.
> 
> Disabling context analysis for specific functions keeps analysis enabled
> for the rest of a file.
> 
> [1] 5b63d0ae94cc ("compiler-context-analysis: Remove Sparse support")
> [2] 3269701cb256 ("compiler-context-analysis: Add infrastructure for Context Analysis with Clang")
> 
> Heiko Carstens (2):
>   s390/ctcm: Add __context_unsafe() attribute to various functions
>   drivers/s390/net: Enable CONTEXT_ANALYSIS
> 
>  drivers/s390/net/Makefile    |  2 ++
>  drivers/s390/net/ctcm_fsms.c | 20 +++++++-------------
>  drivers/s390/net/ctcm_mpc.c  |  6 ++----
>  3 files changed, 11 insertions(+), 17 deletions(-)
> 

Acked-by: Alexandra Winter <wintera@linux.ibm.com>

