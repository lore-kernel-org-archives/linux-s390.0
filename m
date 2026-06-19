Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AED0294A10
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781876968; cv=none; b=KPsv592j4mywbivfWsI+Ta/lfFkp3RMd5zfVcNjTGXDZe5f44Pthj0CT+QVCqRkUEJuslQ2vUBIHX31CSw84zvWBjNUQbCmJJu7wDL2nAFzeQ5p7Ypa0ZB2aZ2bKRxKcT+zKorZOvwSFtZtAXr/UXFjLVRUE5lDW9neT4PfdVOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781876968; c=relaxed/simple;
	bh=VJx+VQrZLXghk2TTLKUX8gkgMASZDW4oktgWY8nw2sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/z0LVe3DjZU2jOg4dA1r9w8EOPAsPFPXPkhSC9JoPERVEEYA2AfNz2DNZVxZAufK7rvzQQpz5lMXW+3eHP1RmgZNBNeW6B5QKPRygt0P1JRIxDTPs/NvN2Ykwaizmch62BHbph/ioPihFMID/x4+QTeaxZQsoohhD79XrGtg4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S4BZ6VrX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S4BZ6VrX"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JDIGGG2543036
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 13:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=sQ1GeQaE5I5eBNHNF2SBVVwhMY/pTI
	e0yE9wAufYmqw=; b=S4BZ6VrXoLFSJSfnxqA6PhYOkANA955XTnUusbTVcMnqwm
	wPBQgK+rL/0d7aNGV1sgFAcaPQXaQnt80tcMVXDpTXwPZZTPA7yQMKULvj5sJo0D
	FlF+O0H6q7mZrOjYV880mspCoFuRJzYVeqqoqh1oWnPEqcwqOw4pIpCsBaNdb4+0
	rcGoevO54fCXoTFbfZ2K3cH/aM6vX5rr5lxn2tX2zKTM3lWXMxLhoZQZJZMBCLm0
	epTSKZj5HnuEWNmbJUBKBUgc2y4jsQADa6DjnRdrbT/B45Gts6U/3c0KKOtOhfFH
	YDOdULM/2pec52X7zj4Laox9Z5wh0fg/ISigtcJg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequdw7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 13:49:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JDYcr4028888
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 13:49:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev17293m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 13:49:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JDnMVa7209394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 13:49:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6301F20043;
	Fri, 19 Jun 2026 13:49:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E1E320040;
	Fri, 19 Jun 2026 13:49:22 +0000 (GMT)
Received: from osiris (unknown [9.111.29.105])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 19 Jun 2026 13:49:21 +0000 (GMT)
Date: Fri, 19 Jun 2026 15:49:20 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Ciunas Bennett <ciunas@linux.ibm.com>, linux-s390@vger.kernel.org,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH 1/2] s390/kvm: Refactor __diag_time_slice_end_directed
 for single exit point
Message-ID: <20260619134920.18590Ec9-hca@linux.ibm.com>
References: <20260619101349.162430-1-ciunas@linux.ibm.com>
 <20260619101349.162430-2-ciunas@linux.ibm.com>
 <5811d93c-0f04-46ce-9578-9845db4399d1@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5811d93c-0f04-46ce-9578-9845db4399d1@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDEzMCBTYWx0ZWRfX6yta/oXI+lHn
 o2mKYxJ0bu8kzvoPJ4wt5HSzHd6CrH8njp7chLDRUHHPLgQuzaELN/wgsjEwDq8pscrk1e62uR3
 +H5vmPbkfpvuzctT5wiWXOl3CoHwlnE=
X-Proofpoint-ORIG-GUID: bKH8mJPgggig4dtEKKpLKyPj6hd_F2rb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDEzMCBTYWx0ZWRfXzGGGuSwHkKjy
 BLQX7xVu9yEkKByZteG/812TL208SF6MYMfsdHzXWWrmALkeZCbwzij9dwWeAobsZAYhyQzrByM
 x+9xLbKDSS8V1eUCRfAe9zLybkK2GBD5rQJ0Om2vBCGj/ZrHIiD+7Vo1BZZihPWjOxzi4aXEhne
 OOqv4U493wY5pPkcSZw6MSqsRFVlR7do2ag3brsMi8oxV/CkqTAER3CBiJEtLJ7vl39/7mBHXxV
 MLN1LbeQg3zAe6oBkRbvDNt5hWKOPaecx7C0tOPHC90Mdw5j4TYcfE8DsvCba/LFc/TqANwYa6P
 IEsYmzBu+/9Xti12/UF4l5pcxy553h0o9C+merPnzetKCdQxNvUI35Kn+LEnFwhmYwj72Q5+cGO
 91fnZpY/dPdrw7vzBhsswlPr69A+/lFmcuP1tsrwMkyK/zbKrnrz5QloRYysrWv7P0a9sNkcIMb
 xOGQFio7dfkxMCP8uIg==
X-Proofpoint-GUID: bKH8mJPgggig4dtEKKpLKyPj6hd_F2rb
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a3548e6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=AvJLDL10UPZCwvpG5MoA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190130

On Fri, Jun 19, 2026 at 12:27:56PM +0200, Christian Borntraeger wrote:
> > +	const char *result;
...
> > +	result = "ignored";
> > +out:
> > +	VCPU_EVENT(vcpu, 5, "diag time slice end directed to %d: %s", tid,
> > +		   result);
> 
> result is a local variable that will go out of scope. You can not reference those
> in the s390dbf feature as it will only store the string pointer and it will not
> resolve the %s. So this wont work.

Why should this not work? The life time of result doesn't matter. The
_content_ of 'result', which is a pointer to ro.data section, where
the strings reside, is passed to the debug feature call. 'result' is
not required to resolve "%s" later.

But maybe I miss your point?
