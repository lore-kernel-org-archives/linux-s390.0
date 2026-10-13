Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84304EE845;
	Tue, 13 Oct 2026 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892537; cv=none; b=YpD8XMfI3x4CC+myUY5LvsdPxF9L95GfgIFO2Nj5SeirjX0NooBB0fvRocTmy8lDRj4PjmwJc04OOzb3N2foVVLF8cUn+LZ5VtOu2HFS4/hfnHmA2gI6CipsxGhhT6Jua0s+wduG3RUgLe/0DMF9BePxRqr7sd17BETthiyi4vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892537; c=relaxed/simple;
	bh=ltNcjI/cSNwQEUrbnq+NGwT1m9uRC9u9PKJCW8HormM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHbfYtmW4MLofggLlqRWhxQJMdT63ANEivb3GMbC3hsBHLDasJIQEfCwsrYmNjbwKpvFdsY3ywqd8ILnDsyAn2TIddmJlCnNFxc9WCRg/K+pP42kTIweellhpD9ulbAJqBXyO3jIGaK1divG7+8PJhxgERUbignV5TpT+IuMvhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j+EyxU37; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j+EyxU37"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D2ESAF725937;
	Tue, 13 Oct 2026 11:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=rQvODh5CwPy+m2RWnqb5bu/tJBciFz
	eAQPmXjPbdZ1E=; b=j+EyxU375d/FIh/R/oWnHj0Cqr51HCTx4A4IWiPWlyFEg9
	tfOeFaAEXYml0x0eCYJXnGdgsDS39S1DLvc/kFuA0eYQGsUqLwmgeWMcMqhzOFDP
	lQO5xrYJIGMDClIzR35FDM2eyVS7rkeFurTkc8/kTtNtHm8Jct3sblAJZzjmfjxf
	bmh0YXkA4w5jTYshhfSbTsslZo6jbblSuEk4Itjx6+MvSGPIqakQPe7mPFOA6HEu
	CbiVxuZzS6NaEjmBpTN1UPX3SzbvzUnM4pjiT3XXaiYg9SKy13tDf7iXFibgYEem
	mw8UNW0hIj5dOvbBzhVu0WxP4kNafFfMIZZfHVQA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv0dcxd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 11:55:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69D8Tnsv2709275;
	Tue, 13 Oct 2026 11:55:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816h1hw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 11:55:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DBtTaf52887954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 11:55:29 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACDD12004E;
	Tue, 13 Oct 2026 11:55:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F59A2004B;
	Tue, 13 Oct 2026 11:55:29 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 13 Oct 2026 11:55:29 +0000 (GMT)
Date: Tue, 13 Oct 2026 13:55:28 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/2] s390/entry: Save lowcore on invalid kernel stack
Message-ID: <0032a4a4-1a4f-4665-a3dd-5f388473bc2c-agordeev@linux.ibm.com>
References: <20261002152055.3305184-1-hca@linux.ibm.com>
 <20261002152055.3305184-3-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002152055.3305184-3-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0NiBTYWx0ZWRfXzvRdrmgg9hdb
 WiLPyg7rBMd7e4IH+o2wuP6FiimwSjMvIZPKldCw8aTYgtoCvWzgMuOFrEPXneOw+HctNihdQ/R
 q+A+JFrK1RLOExl2qa5PjisP4eYkOBf1RgJrNMLirgq87Ex3tcxW9R3j5rp+v108MHYQib4/H/m
 qDB5qFuZzwGhy4BmUoVxe3CwLGaVZIjvxwwnQYSLQpoOV589001wMPRB937Aex57Dujs/ta33Iu
 vjqywDpsYg3RAbu/jW+QI0sSHnxwFQspKlFRHv9l3VmovNqUxhFExOCjrCqfyjk8FKTHTKDISdW
 xu6Jq7YPhCmrPPoqf+UrR0d3J5YR+hxEkRh4kCRRUS8vDixGL6X2bI9wjvxQSLGKEyCTxzxk73S
 rYWfII3lxlcX23ICKW7omLK71WiaQtpk2wUR/J+opoMcZ5wom7w9RY84n/IpmrwILc5V/DNtsU+
 nuKbsdMSfNh+/+87uZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0NiBTYWx0ZWRfXxQmpI13cNuO/
 YiIST6943wgeUJbse6b8ffw8Gj8n9RRDXuxcHpVJnW8JZpAXkJGQXCWgX9M5HC1Z+jGfd3WqLPp
 b6NNv1ZYaqcNdYI3D3665GfkoJvN26M=
X-Proofpoint-ORIG-GUID: yGwdwn__FG5Aw5rXpLstx8_Eltm1t_xR
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6ace1c36 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=CK1eOIlrFaIt_kM6disA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: yGwdwn__FG5Aw5rXpLstx8_Eltm1t_xR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130046

On Fri, Oct 02, 2026 at 05:20:55PM +0200, Heiko Carstens wrote:
> In case of an invalid kernel stack copy the current CPU's lowcore to
> stack_invalid_lowcore, so it is available to debug tools after a crash.
> 
> The copy is helpful since the lowcore is modified e.g., when printing
> messages before a dump is taken. Keep it as unmodified as possible and
> as close to the event that caused register corruption.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/entry.S | 15 +++++++++++++++
>  arch/s390/kernel/entry.h |  4 ++++
>  arch/s390/kernel/traps.c |  6 ++++++
>  3 files changed, 25 insertions(+)

Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
