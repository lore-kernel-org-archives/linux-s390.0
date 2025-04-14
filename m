Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930CC19924E
	for <linux-s390@vger.kernel.org>; Mon, 14 Apr 2025 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642125; cv=none; b=MewwYVA44RW8WZ54kmmc5CDWGz8HAMIumfNv3VYJrxH9q69OCFwNvhHP6m0MtVMmpJN6+xF1g9X5Is3zE6wfMBhsuDKTLCzUlIHo8jrI8QQaEQilR+09fDPCarw4boLkiuB0QtlHHjiW3uOUI+91gxwLgSbBO6u5IBkOlIepfic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642125; c=relaxed/simple;
	bh=weVXpu4b/q99pTve9j4trrx9KqH6xxPKvq83G7t1hA0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fhRZujV3HiZqvJANIQAEnM/H+Nwox06siv57KsoKHHpm8FvuqbNKgqwgNcMXg6QK+zLpj6nqk0PNfpB3+bGnVbjF6C/r7i2CGG1JU7t1q2C5NRAbmMMMDmE52Bx9bBqwXC2cdojbYAALOi8TdHVHtSffrObZZefO601VpuO4/Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CO9S1Wzv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CO9S1Wzv"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EA3rVt026543;
	Mon, 14 Apr 2025 14:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=pL8xI4rAqU05li956K/tQ1xw5XwuPqHNaSEPMyfS/kQ=; b=CO9S1WzvUU1U
	Z44TXzLAaDFPqKSiwkqTY2wmtLMPozomPaTMn96Q0lYrNOodZl9odM1A72x1vaGW
	lFbkau8zkswnvCZxEKJX9yEI5EAdmdDZ19qB9n+tV6WXCz4aoHoyMVwFBzFaopcR
	1445v1gkm3LMW5ERO2K1mW9dSImlpkqrflQciDB5i5DHFJ+Pu3TKZqbu8/SJDFq2
	TNFZ+WYIvsynZ+cO6Q5JqiZbhQ5ojF2wYqHUrx46JSOxZu8zEKm3O2mVHHvlx45R
	T4mTjphyh5RitbGGhG41CjoJedglfVtN5Eq7TjQZgD1OGQXZKHRdDwJRK/uKgvdN
	BqgrNh4KCA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46109f1dmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 14:48:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53EEjYJ2024874;
	Mon, 14 Apr 2025 14:48:40 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4602gt7045-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 14:48:40 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53EEmdJm27329146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 14:48:39 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69C485805D;
	Mon, 14 Apr 2025 14:48:39 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DAD75805C;
	Mon, 14 Apr 2025 14:48:38 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Apr 2025 14:48:38 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Apr 2025 16:48:38 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: ifranzki@linux.ibm.com, fcallies@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, seiden@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v4 16/24] s390/zcrypt: Propagate xflags argument with
 cca_get_info()
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <00904381-9386-4cca-80be-29ccce2d85ec@linux.ibm.com>
References: <20250409140305.58900-1-freude@linux.ibm.com>
 <20250409140305.58900-17-freude@linux.ibm.com>
 <00904381-9386-4cca-80be-29ccce2d85ec@linux.ibm.com>
Message-ID: <c2c880766791cec011a7c7befd43825a@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2P_VlWnxyn8i1Srv_S1HPEYkoHK6PqDB
X-Proofpoint-ORIG-GUID: 2P_VlWnxyn8i1Srv_S1HPEYkoHK6PqDB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=621 malwarescore=0 clxscore=1015 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504140105

On 2025-04-11 16:25, Holger Dengler wrote:
> On 09/04/2025 16:02, Harald Freudenberger wrote:
>> Propagate the xflags argument from the cca_get_info()
>> caller down to the lower level functions for proper
>> memory allocation hints.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> 
> This patch will be affected by a rename of fetch_cca_info() to 
> cca_get_info().

applies perfectly with git am -3 ... :-)

> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
