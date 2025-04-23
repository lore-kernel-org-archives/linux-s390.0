Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA92E28BABA
	for <linux-s390@vger.kernel.org>; Wed, 23 Apr 2025 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421343; cv=none; b=fN4Yz2jhyDU5MGC6onLw30AinTXRNLwH4o4iXrb3rhWRcf8YFrUD4Qt/o2o7THz1zK1jLdmMXvmyKJIngGqmx/MraSNQ9RfH5ausoznMyDXqtYe4USwZIzqn7OVg0sEeDQB4UCGaSvFCsfjax0KB/VrjJEDnZSZ7T9pctBLhsfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421343; c=relaxed/simple;
	bh=1iQeyM+VQC7uKkqq5Qga+595s9w0PbyBFV+ZFlvttOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNzw2Z1X83ohBedWm/cKw18+VzIuDhaPjhhl0jnBEt4AQV+FYUVzjqqg91Rmsp9eRakfn2ykczKoG82WnNDROxy/Bw8bZ8gY8K5x6BbINPun9+QJNYLFOQRgrJk67HclkKfm5DX7lPCbH3sKIM5Pn4p1GUG5V4DCQGeGJtNf50s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qdpo8RIl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qdpo8RIl"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6fi36002071;
	Wed, 23 Apr 2025 15:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=eUiL8x/KGhogYUTbAYKq3ydN++yxcz
	ErPDW4JsKqiT8=; b=Qdpo8RIlyixl2MwYvdPBCshFQT7TxAigHVQvRE8rpxhWfW
	L5lRxDWmw4+H/BewHCYMUBrVLaZ9d/ICNwiGaujUdMSjyhOIEnOe1xhrCdp2a4tC
	h+jHWRwbeIyPiYsYml+vTNmN9TnNjaZVNF0P3oRiOpoigSA6xJmn6vCvN6+7gLrh
	6lMWzmb+uknnbVnMyUMwLea7qClsnVh71Fljmo7efhcjb0JhtPXPJxNYFdKtRfSq
	i564idXyjyVfQ/U7COjXLPaK01QtUU5aponKCNa3jjLiuBUbw1DHDlbfCK7FrEfN
	ozrq+hJaxOS71IOhs2GVyEy4SFsXNCAO8mNvkOdA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466jpt4492-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 15:15:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53NEbvDZ022271;
	Wed, 23 Apr 2025 15:15:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfxbkqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 15:15:38 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53NFFZMs60293592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 15:15:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A40720043;
	Wed, 23 Apr 2025 15:15:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A295A20040;
	Wed, 23 Apr 2025 15:15:34 +0000 (GMT)
Received: from osiris (unknown [9.111.5.231])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 23 Apr 2025 15:15:34 +0000 (GMT)
Date: Wed, 23 Apr 2025 17:15:33 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com
Subject: Re: [PATCH v7 00/25] AP bus/zcrypt/pkey/paes no-mem-alloc patches
Message-ID: <20250423151533.8450C0c-hca@linux.ibm.com>
References: <20250423101535.143137-1-freude@linux.ibm.com>
 <20250423104045.8056D38-hca@linux.ibm.com>
 <774884ded8d56683d65e5978fbea1dc7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <774884ded8d56683d65e5978fbea1dc7@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WodWnwfAuLxT01orJWprL4LpecyrtWbl
X-Proofpoint-ORIG-GUID: WodWnwfAuLxT01orJWprL4LpecyrtWbl
X-Authority-Analysis: v=2.4 cv=a/Qw9VSF c=1 sm=1 tr=0 ts=6809041b cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=XYWq_d7s1KxiK7gPMPwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDEwMyBTYWx0ZWRfX7rHddeOohOYe 3cbUvXy2l8gi0ACQyVhi2VlVyMeVkjTFCW9zwVPTrqWUuFG9GmKB6z/CrZBgGTH6URWdnTJ35KS nSCMwg9OhJXmVjAsLJSPJRtsYw8zydtwcC5OWSBTBqvMJhbEym6EBAX7Hr4PVor2isoSaA3Jvja
 d1V26Gp9gQyxDkKSJP+OIVM+eQ3XKhOaaxB/n/9yRYXKqSttp5OMN5Y0mhvCYW7hv/N9hJbvc9x d/v/PuiK3fPxdPtYvInKXDtK8MBYieuwrYFymZ2cbzkTT7SLBlhnKgix5iqDcyHBapdAFs0mXRn zVMWfns89zhhifrmNMJ+xrJWTTBok0y6mdJpf9SB0UscAD7JeN2oqK3NTm8gzWZdPmKD3iSNBZZ
 f9GSSvJ6qfQoDC9zbd/pq+tX2s+C6oXiy0FnL6ScHyjYBezHDa692dpqfctsmZAEnc32abqP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_08,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=962
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230103

On Wed, Apr 23, 2025 at 05:07:52PM +0200, Harald Freudenberger wrote:
> On 2025-04-23 12:40, Heiko Carstens wrote:
> > Hi Harald,
> > 
> > On Wed, Apr 23, 2025 at 12:15:09PM +0200, Harald Freudenberger wrote:
> > > The patch series starts bottom (AP bus) and goes up the call
> > > chain (PKEY). At any time in the patch stack it should compile.
> > > For easier review I tried to have one logic code change by
> > > each patch and thus keep the patches "small". For the upstream
> > > version I intend to fold them together into only a few commits.
> > 
> > What about the statement about "only a few commits"? I asked the same
> > question
> > also for the previous series, but didn't get an answer, instead v7
> > appeared.
> 
> I talked with Holger about this last week and he thinks this should
> go as is - so everybody can see how this patch series is constructed.
> You know when in 10 years someone wants to know the details ... :-)

Sure, I was just asking. Series applied, thank you!
