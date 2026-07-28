Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EDA3BF67A;
	Tue, 28 Jul 2026 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785242126; cv=none; b=frrz1K1OLOCxfDrM+RsGZlcidmOz3K/phJbLXZCDRPgivEoPqpa3tMcE99mCTdMnshWrN84W+SRqQ1ERpHMdCp+jUzdAldatWke8d4Frg5DXJ2LHMEWY0RHNBRgE3BsXLwBaz0jqyMXDY6dBxhuiNH7PV9cafPebCh17tlF4yXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785242126; c=relaxed/simple;
	bh=jSkOlShLkwdbOK35K3MXtJNt4F/3TX8RcZ/6F3kXuWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7CZ9ZuUtzpWv5bw53FVP5OyvdyofrHLb8KcGsRIPHuhHUPEoTFA02dKqHrx4XYlClLEj4ZIuo0kOB98flCHRRJHNlGlecyfN4QFRsAYSxDLsl7onaC4cWv7slX58JrcbTSmlEpLnYY8JA+P0h1BU/sI84LRlkmtje+D/mhGs0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S+IpwnEB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S+IpwnEB"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SBIOe4854591;
	Tue, 28 Jul 2026 12:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Am9FMJ+R33dyNjpCjRlDZVeme9X64L
	rZQW1cI3yuaDE=; b=S+IpwnEBnmnnrZPaEQCrtq3vydz0XXfJbxYDk7x/0a4cMi
	4XjXjmTsfsC760OwWRLBs7/+N+rLwgyng/1SHgN2OijQq7FwU9G2e1ecDhVwpdZ4
	vKTIYaJG8sU1Exe0CmGo3MRjInmX4tDaZweNSULJJUqd2PE+ha+p3lnqh2PGId/V
	cqWq8j0e+NEQXmzcDIj+krVl2dN31myHZ4Qa63EdOQ1iU19kVA7YL1NNRmrWu/SA
	ii9hqutxi7NbIN9iHbzL/59JWxM+NKeDcLZVKOf7GoZNPdufqL6Ot56PcSkGCdFz
	GfGGLSIJXxykcE1p+Zq4lMR/w0idU6azHkP2K8MA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nmgmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 12:35:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SCQF9O017532;
	Tue, 28 Jul 2026 12:35:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y1fr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 12:35:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SCZHvK25232102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 12:35:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1369120040;
	Tue, 28 Jul 2026 12:35:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB20C2004B;
	Tue, 28 Jul 2026 12:35:16 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 28 Jul 2026 12:35:16 +0000 (GMT)
Date: Tue, 28 Jul 2026 14:35:15 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: Re: [PATCH v3 09/10] KVM: s390: Fix ordering when adding to SCA
Message-ID: <20260728123515.385398-B-seiden@linux.ibm.com>
References: <20260727150254.236021-1-imbrenda@linux.ibm.com>
 <20260727150254.236021-10-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727150254.236021-10-imbrenda@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDEwOCBTYWx0ZWRfX84n0GFeai3LT
 2XKHbuWXvSrJ8KzRArWpyKSlFox2sZ1B/VrZOwjTW2fUODTBUqObEyXojT2omdOrZJKi/6z0/fv
 KwNMOl2feU3guuvEv+R7xhPZSxCYmRU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDEwOCBTYWx0ZWRfX/lGTZ0/Ero3f
 m4tceWUay+CUQ9hwnCBb9GAFLwRBN0RijidMDbBcWmvIgqzxR6yssDR4Xurhrl0xo2CZLf1tC+v
 O5nXFoF0Tio+IovGNWp4/kkwoXn4Tkb6tvKl90r5oY6DgOo8XlnXdA+IApldWWGn+mFyfev1AMW
 l70tydsEAEuby/0mlj0Etx9KIUHbYIpMr8Ol68tmcS1IyJT0RZ1nZbeu1inB1VoZOzxiXchow8y
 KDYf5L4zH572H3UGDK/otHW0TldNccB2kK2dsouV3B7dzhh7oBVByrpKwr5BUC/UxiNFin8Q+cU
 jPl3zCShK7wfTuvj4egV+jU7MlebqgxabTluytfJP53C0gr+JqgVocD2CMbxdKiXJM0EFGuCSoD
 bI435DMZ1SINCgnve+7SzAReE1/bdytYgroBbN806dTQl9+BeBR6SNCISM2C9Wt7f/w+M+Vw9ZD
 EI4vI+Et/A3ivCGTX3g==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a68a20a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=_LF6sWV_dHCqamZNFvUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 50bFlax2Tad0H6f-lfF3CWL-_PoJddpa
X-Proofpoint-ORIG-GUID: 50bFlax2Tad0H6f-lfF3CWL-_PoJddpa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_03,2026-07-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280108

On Mon, Jul 27, 2026 at 05:02:53PM +0200, Claudio Imbrenda wrote:
> When adding a new vCPU to the SCA area, the validity bit in the MCN was
> set before the pointer to the state description, potentially allowing
> for a race.
> 
> Fix by setting the pointer before setting the bit.
> 
> Fixes: 14542a0a54c5 ("KVM: S390: Remove sca_lock")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>

