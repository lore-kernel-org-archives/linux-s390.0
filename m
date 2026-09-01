Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AF9372663;
	Tue,  1 Sep 2026 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272391; cv=none; b=JFv5z2nPw7g9bu7JJrwzBHQ64MLhzo0gmyYaPUDeWUplNFlbRUQduqpGJVBzoxdKMg3FnLh6IrY36JwByIvjlpmPNGWzSqGTNnnl2AvJWbb5xiCaMDjomy1QZVeeP9TguLKu5GNb9vk9jrCcxobm83WW5r2OOPHtgJlFndZIXbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272391; c=relaxed/simple;
	bh=rusOLnEsLiqR3y31U+4sihEV4zK8no7XXBSRzm4Sdqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sI54eO7baIY9Bswg4G3Gb81GGkwVUCj6oTU75uMPnkjHknmtQb7R5KS5mvI4GdBWEHf7VVuEIGYrWmzKFczM7CKQ9wguq8eewi2oMoTFrsXivtdvdoX2W6GiHnJHdmaa30HIKKTrQd1f/rZB0v5F/0Tp9qlNAlfLfn/VlAmLJlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JnL/8O1m; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JnL/8O1m"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681DVlcH1211140;
	Tue, 1 Sep 2026 14:19:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=XYB7bHl6s2XGn164sZUpLaHi1YfduC
	lHzFh2WenLQYc=; b=JnL/8O1m/BTAyf9bFN5jr3g/CVq7jDhLOLT8jG94OfVzg9
	17tu25yk6mPPT8a45sr2k7tpTpwtwzHzSuMWxI6rAGo1FRBiEXVehJiTvY5nctsc
	ZUEkT2A6N7HB/OdCbGUBCULQdII8HUglcAH2QqtkEad59dpnqpfCwGLZFofxRaSC
	aRnSvxJc9Cxh/eYfGsiSxBnL6c1LHcz77VJBuJtnvIo/m7AQfSCiON/4Ls+1WGwX
	PrbVbntvfcfnBGo/i5wuloQJYH5iaEhR3WcjAr1LHZvHHg+F4RqhsDidJh2y+sBQ
	n5cmo5pkEXxoAsCUzMpWX4RNzmdBhauJ/FFJvXEA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhrbs9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 14:19:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 681EBkhH008599;
	Tue, 1 Sep 2026 14:19:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hc2my-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 14:19:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 681EJiMJ48300490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 14:19:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73F6020040;
	Tue,  1 Sep 2026 14:19:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 330922004B;
	Tue,  1 Sep 2026 14:19:44 +0000 (GMT)
Received: from osiris (unknown [9.111.45.16])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  1 Sep 2026 14:19:44 +0000 (GMT)
Date: Tue, 1 Sep 2026 16:19:42 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, stable@vger.kernel.org,
        Jan Polensky <japo@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v9 3/3] s390/pai: Support CPU hotplug for PMU PAI
Message-ID: <20260901141942.14482E83-hca@linux.ibm.com>
References: <20260901123320.670897-1-tmricht@linux.ibm.com>
 <20260901123320.670897-4-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901123320.670897-4-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FcZFoD3DWFk8V5zTmnnLKnFYdbkuagG0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEyNCBTYWx0ZWRfXw4spItg0XpqC
 hFcfwr23YMyncrHBTdiPh1CIY7C8nsKyDJlR8UngCvrLTro3zJnPA5CfZ29hdAAQry2ybimN5Sk
 plDf+1sIoKHO/miWRxRX7+fHPuhhrCu0rLPv576A/0ZG3Fp7J6ZQzkjtcMuEcXmgMafrnzYumpp
 mCUjI7bWPZqo21YO5lGPiDd+1xIVKwayTEd8Z4y+7Br880oSqMdiNgATG1S2/+tuEMFf6VSPPmV
 N08FAbz7PUroRpEdBxbaoPGCjEQZChIog48rIKO1Jz5SFiH4k3x1ZGvpY8MMaqjtvvoSAmlK4rz
 jg1eEreKMgqlLbf5K3t3pckVMf+tTvJS7spXHdFytB9DPxSAqqkRAgkH5CTD0qbDEz9bk33+K4K
 MPrM0O4aklxMuNL23S1mO1RPprxQEeybSG9dc95/7LEP+EEdzlUa0R0xhlK8FCG1C5sJU9t4xbg
 s4QqzC9aaBIwPmVdSVw==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a96df05 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=7esPzKam_6P6qcTX8tEA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEyNCBTYWx0ZWRfX1jNY0F9Mxrdz
 4HKKz99N70jIAqctCQtdj2TxNexgmMB/44Qnhw9M5ZWKHmZ1K2KJzUev7KxHePTRp+42qdgSiyz
 zNxhiU7mwgSiGwFqCV0M9lWgWAhm54o=
X-Proofpoint-ORIG-GUID: FcZFoD3DWFk8V5zTmnnLKnFYdbkuagG0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010124

On Tue, Sep 01, 2026 at 02:33:20PM +0200, Thomas Richter wrote:
> +	/* CPUHP_BP_PREPARE_DYN --> before CPU is brought online */
> +	rc = cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "perf/pai:prepare",
> +			       pai_online_cpu, pai_offline_cpu);
> +	if (rc < 0)
> +		goto out_debug;
> +
>  	if (!paipmu_setup()) {
>  		/* No PMU registration, no need for debug buffer */
> -		debug_unregister_view(paidbg, &debug_sprintf_view);
> -		debug_unregister(paidbg);
> -		return -ENODEV;
> +		rc = -ENODEV;
> +		goto out_cpuhp;
>  	}
>  	return 0;
> +
> +out_cpuhp:
> +	cpuhp_remove_state(rc);

This would now use "-ENODEV" as state for cpuhp_remove_state. I fixed
it up since I suggested this code, so you can blame me in any case.
