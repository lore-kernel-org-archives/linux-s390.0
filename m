Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247033E8337;
	Wed, 20 May 2026 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779286612; cv=none; b=kTKewC7xkuwgwVixlZ8HnlPglX1Px+aurOEw1jriLz4nbvmfCPtWJzThx29AzBYbLCRAWf5r3w1uPqbImissFvaQ1PJIxz3zlJSchLYXZihycOW9AI7zrCY8oBoKAphUYtf6YJy9p05ObSWRI1TnuxYY32PhGYX7GUf3JppWM+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779286612; c=relaxed/simple;
	bh=uaE/LRBFrXbYNBo5prqU3r+BaVLWTDwTY74nHUYAjpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHcZqEQVfkNVbI0+rcntrcwGynBWUlghpYesIJNBBHSTOkvlqjVia7aSU/YaIEk1Q/pv1Y6N/pxyDAHnURiFhij/Wzs+Gxj9OUsKIGjI1E3nbhd5BIdLqa7Hu8OWOzF51tkAfQagiT2fQNsnFSVjee2xeThMux26p9dt4AoqkYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HlUtuFnZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HlUtuFnZ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K4xnhe1734549;
	Wed, 20 May 2026 14:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=5F+XnN+6vkGbdP90Ilf2E4/hFCH3sP
	utFkeII5H0GuQ=; b=HlUtuFnZ00ZDkHscGAXBcXwiDXhcGDBkUko46KOXl4uZug
	527lZPJnnBIj8UE6V5IXqZPc1wsaL6XrIyzspl0obyo9rOBj7ugIo86Wu/Qxgf17
	QL/6VQP0Zy+p5topz6zX7vG2SoBS4ZvEg547ow7vzxXo+T0wHhF5jNmVRsdAM3zs
	gnrgC3v/+vNHjSbVzqV06Fb7JVlaC/Yi/q+TcbA7q31t5FAVJj14uJfxzQ0FNXF/
	A6HFTdeevk6KSEEMUClZl5ydl8mwbLX5TmTSrU+BnUkDbjGtKUTqDZWRd94/ghbY
	k0LkexFqOn/HbDqEyDFQBlBL3/ftAkHNsvlfLWpg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88hegw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 14:16:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KE9FdA012272;
	Wed, 20 May 2026 14:16:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhqkrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 14:16:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KEGc2n37683514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 14:16:38 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD2752004D;
	Wed, 20 May 2026 14:16:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B94920040;
	Wed, 20 May 2026 14:16:38 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 20 May 2026 14:16:38 +0000 (GMT)
Date: Wed, 20 May 2026 16:16:36 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: David Laight <david.laight.linux@gmail.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yang Shi <yang@os.amperecomputing.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 1/9] s390/alternatives: Add new ALT_TYPE_PERCPU type
Message-ID: <20260520141636.96889H12-hca@linux.ibm.com>
References: <20260520092243.264847-1-hca@linux.ibm.com>
 <20260520092243.264847-2-hca@linux.ibm.com>
 <20260520134317.778dc094@pumpkin>
 <20260520135045.96889G76-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520135045.96889G76-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: x2vZcLhMvCjOQdQP2UohOeXnI4Mx29Yx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEzNyBTYWx0ZWRfX/CzqL2xGRwqN
 4g/ojELQeP9+7DxE5b6Z1ASu55LanOCUrpCHRjnqvPWW2K6JPWc/QejDNffwJZHB4kzDsflMkgG
 C9JavqWzA2A/8OTxH5wQrAFQ1XRLMt3zVIcdaATesx6fPrjnx3QhYIS8mm56LboZx17tS4Q7yeO
 qjDb4+HMNl64xYQgjNr5pzWbtiYX94I1M4KqpgunTAsg9NOYeeyqmgp2ZNFwQbGx3mZXZlQTDpx
 FhLwX5xtJyfeiSrpPum6cEHglNhk01Nu5KIAKFFZrTdE45mJfp6DeU+MhcJBF0Uz9O3LQT1bTnW
 sJfv02CdSRkNFDDQPngAabt4dwX/W2U87GNuT/r8RqmSK5O9UCvOS3SimIkoXmbD5r7EO27+UNk
 2wAFEctjTXRtwi51Uc3V9Pbo/yjwbltaiXC8tZHCrGYjv7p8wC7+OsGpyi6CohywlLd3RuNaTC7
 3Svq7IhJiZsL+Q3U5CA==
X-Proofpoint-GUID: zszeP9tR26DFePi1e-h7YjYBs5YwtrW9
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0dc24b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=17dVQ0q0r4EXaETEuaIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200137

On Wed, May 20, 2026 at 03:50:45PM +0200, Heiko Carstens wrote:
> On Wed, May 20, 2026 at 01:43:17PM +0100, David Laight wrote:
> > On Wed, 20 May 2026 11:22:35 +0200
> > Heiko Carstens <hca@linux.ibm.com> wrote:
> > I'm sure it is possible get the preprocessor to extract the register number
> > for you.
> > The exception table logic almost certainly already does it.
> > (The x86 version certainly does - and that is far less trivial.)
> 
> That's true, the s390 extable logic is doing the same. However I failed to
> feed the extracted register number as constant into the same inline assembly
> it was extracted from.

Thinking about this again, I guess it should indeed be possible, and
my initial approach was wrong. Let me try again.
